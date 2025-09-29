# Instala el módulo Graph si no lo tienes (solo la primera vez)
Install-Module Microsoft.Graph -Scope CurrentUser -Force

# Conéctate a Microsoft Graph (te pedirá inicio de sesión admin)
Connect-MgGraph -Scopes "User.Read.All","User.ReadWrite.All"

# ==== CONFIGURACIÓN ====
# Fecha límite (solo usuarios creados antes o igual a esta fecha)
$FechaLimite = Get-Date "2022-12-31"

# Lista de correos a ignorar (todos en minúsculas)
$CorreosIgnorados = @(
   
)

Write-Host "Obteniendo usuarios de Azure AD, esto puede tardar..."

# Obtén los usuarios con los campos necesarios
$usuarios = Get-MgUser -All -Property "id,displayName,userPrincipalName,mail,otherMails,accountEnabled,signInActivity,createdDateTime,givenName,surname"

# Solo usuarios creados antes o igual a la fecha límite
$usuariosFiltrados = $usuarios | Where-Object { $_.CreatedDateTime -le $FechaLimite }

# De esos, solo los que NO han iniciado sesión después de la fecha límite
$usuariosInactivos = $usuariosFiltrados | Where-Object {
    -not $_.signInActivity.lastSignInDateTime -or
    ($_.signInActivity.lastSignInDateTime -lt $FechaLimite)
}

# Excluye los correos en la lista
$usuariosInactivos = $usuariosInactivos | Where-Object {
    $CorreosIgnorados -notcontains $_.UserPrincipalName.ToLower()
}

# Procesar propiedades extra para cada usuario
foreach ($usuario in $usuariosInactivos) {
    if ($usuario.UserPrincipalName -match "^(\d+)_") {
        $usuario | Add-Member -NotePropertyName Cedula -NotePropertyValue $matches[1]
    } else {
        $usuario | Add-Member -NotePropertyName Cedula -NotePropertyValue ""
    }
    if ($usuario.OtherMails -and $usuario.OtherMails.Count -gt 0) {
        $usuario | Add-Member -NotePropertyName MailReal -NotePropertyValue ($usuario.OtherMails[0])
    } else {
        $usuario | Add-Member -NotePropertyName MailReal -NotePropertyValue $usuario.Mail
    }
    if ($usuario.UserPrincipalName -like "*#EXT#*") {
        $usuario | Add-Member -NotePropertyName TipoUsuario -NotePropertyValue "Invitado/Externo"
    } else {
        $usuario | Add-Member -NotePropertyName TipoUsuario -NotePropertyValue "Interno"
    }
}

# Ordena para exportar (opcional, por último inicio)
$usuariosOrdenados = $usuariosInactivos | Sort-Object { $_.signInActivity.lastSignInDateTime } -Descending

# Exporta con nombre, apellido y demás
$usuariosExportar = $usuariosOrdenados | Select-Object Cedula,GivenName,Surname,DisplayName,UserPrincipalName,TipoUsuario,Mail,MailReal,AccountEnabled,
    @{Name="LastSignIn";Expression={ $_.signInActivity.lastSignInDateTime }},
    @{Name="CreatedDateTime";Expression={ $_.CreatedDateTime }}

$RutaCSV = "C:\Temp\Usuarios_Inactivos_ConCorreos.csv"
$usuariosExportar | Export-Csv $RutaCSV -NoTypeInformation -Encoding UTF8

Write-Host "Reporte generado en: $RutaCSV"
Write-Host "Usuarios a desactivar: $($usuariosExportar.Count)"

#==== DESACTIVAR USUARIOS ====
# **DESCOMENTA el bloque abajo SOLO cuando estés seguro**

foreach ($usuario in $usuariosInactivos) {
    if (![string]::IsNullOrWhiteSpace($usuario.UserPrincipalName)) {
        try {
            Update-MgUser -UserId $usuario.Id -AccountEnabled:$false
            Write-Host "Usuario desactivado: $($usuario.DisplayName) <$($usuario.UserPrincipalName)>"
        } catch {
            Write-Warning "No se pudo desactivar: $($usuario.UserPrincipalName) - $($_.Exception.Message)"
        }
    }
    else {
        Write-Warning "Saltado: Registro sin UserPrincipalName (vacío)."
    }
}
