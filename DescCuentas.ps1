# Instala el módulo Graph si no lo tienes (solo la primera vez)
Install-Module Microsoft.Graph -Scope CurrentUser -Force

# Conéctate a Microsoft Graph (te pedirá inicio de sesión admin)
Connect-MgGraph -Scopes "User.Read.All","User.ReadWrite.All"

# ==== CONFIGURACIÓN ====
# Fecha límite (solo usuarios creados antes o igual a esta fecha)
$FechaLimite = Get-Date "2022-12-31"

# Lista de correos a ignorar (todos en minúsculas)
$CorreosIgnorados = @(
    "grettel.valverde@udelascienciasyelarte.ac.cr",
    "luis.aguilar.q@udelascienciasyelarte.ac.cr",
    "andrea.bonilla.s@udelascienciasyelarte.ac.cr",
    "marianella.rodriguez@udelascienciasyelarte.ac.cr",
    "susana.jimenez@udelascienciasyelarte.ac.cr",
    "andrey.quesada@udelascienciasyelarte.ac.cr",
    "cinthya.mendoza@udelascienciasyelarte.ac.cr",
    "erick.fernandez.g@udelascienciasyelarte.ac.cr",
    "leidy.campos@udelascienciasyelarte.ac.cr",
    "susane.loria@udelascienciasyelarte.ac.cr",
    "marlen.morales@udelascienciasyelarte.ac.cr",
    "deily.cordero@udelascienciasyelarte.ac.cr",
    "irene.jimenez@udelascienciasyelarte.ac.cr",
    "luis.sancho.a@udelascienciasyelarte.ac.cr",
    "karen.flores@udelascienciasyelarte.ac.cr",
    "jacqueline.lopez.o@udelascienciasyelarte.ac.cr",
    "yuliana.quesada@udelascienciasyelarte.ac.cr",
    "tatiana.cerdas.s@udelascienciasyelarte.ac.cr",
    "graciela.gonzalez@udelascienciasyelarte.ac.cr",
    "xiomara.quesada@udelascienciasyelarte.ac.cr",
    "veronica.solano.d@udelascienciasyelarte.ac.cr",
    "tatina.corrales@udelascienciasyelarte.ac.cr",
    "rodolfo.brenes@udelascienciasyelarte.ac.cr",
    "joselyn.montero@udelascienciasyelarte.ac.cr",
    "melissa.fernandez@udelascienciasyelarte.ac.cr",
    "adriana.martinez@udelascienciasyelarte.ac.cr",
    "brayner.sanabria@udelascienciasyelarte.ac.cr",
    "carolina.jimenez@udelascienciasyelarte.ac.cr",
    "anthony.ortega@udelascienciasyelarte.ac.cr",
    "david.perez@udelascienciasyelarte.ac.cr",
    "cindy.novo@udelascienciasyelarte.ac.cr",
    "diego.urena@udelascienciasyelarte.ac.cr",
    "adriana.madrigal@udelascienciasyelarte.ac.cr",
    "ethel.espino@udelascienciasyelarte.ac.cr",
    "randall.espinoza@udelascienciasyelarte.ac.cr",
    "eimy.solano@udelascienciasyelarte.ac.cr",
    "seiris.herrera@udelascienciasyelarte.ac.cr",
    "katherine.ortiz@udelascienciasyelarte.ac.cr",
    "monica.abarca@udelascienciasyelarte.ac.cr",
    "daniela.hidalgo@udelascienciasyelarte.ac.cr",
    "ariana.alvarado@udelascienciasyelarte.ac.cr",
    "evelyn.mora@udelascienciasyelarte.ac.cr",
    "cherry.barzallo@udelascienciasyelarte.ac.cr",
    "natalia.prado@udelascienciasyelarte.ac.cr",
    "laura.alfaro@udelascienciasyelarte.ac.cr",
    "gerlin.solis@udelascienciasyelarte.ac.cr",
    "hannia.recio@udelascienciasyelarte.ac.cr",
    "marcos.arias@udelascienciasyelarte.ac.cr",
    "stephanie.fiellan@udelascienciasyelarte.ac.cr",
    "gabriela.rojas@udelascienciasyelarte.ac.cr",
    "irina.vargas@udelascienciasyelarte.ac.cr",
    "marilyn.lopez@udelascienciasyelarte.ac.cr",
    "moises.fallas@udelascienciasyelarte.ac.cr",
    "pamela.montoya@udelascienciasyelarte.ac.cr",
    "sharon.piedra@udelascienciasyelarte.ac.cr",
    "edwin.cruz@udelascienciasyelarte.ac.cr",
    "maria.gonzalez@udelascienciasyelarte.ac.cr",
    "diana.corrales@udelascienciasyelarte.ac.cr",
    "eliecer.calderon@udelascienciasyelarte.ac.cr",
    "irene.aguilar@udelascienciasyelarte.ac.cr",
    "kimberly.masis@udelascienciasyelarte.ac.cr",
    "luis.burgos@udelascienciasyelarte.ac.cr",
    "yuliana.gamboa@udelascienciasyelarte.ac.cr",
    "suzanne.hidalgo@udelascienciasyelarte.ac.cr",
    "ixel.ramirez@udelascienciasyelarte.ac.cr",
    "celeste.arce@udelascienciasyelarte.ac.cr",
    "mariafernanda.jinesta@udelascienciasyelarte.ac.cr",
    "alvaro.mora@udelascienciasyelarte.ac.cr",
    "nicole.angulo@udelascienciasyelarte.ac.cr",
    "maritza.segura@udelascienciasyelarte.ac.cr",
    "keilyn.salazar@udelascienciasyelarte.ac.cr",
    "byron.diaz@udelascienciasyelarte.ac.cr",
    "francini.prendas@udelascienciasyelarte.ac.cr",
    "tracy.urena@udelascienciasyelarte.ac.cr",
    "kattia.anchia@udelascienciasyelarte.ac.cr",
    "josette.cordero@udelascienciasyelarte.ac.cr",
    "jose.morales.a@udelascienciasyelarte.ac.cr",
    "m.fabiola.loria@udelascienciasyelarte.ac.cr",
    "michelle.calvo@udelascienciasyelarte.ac.cr",
    "debora.vargas@udelascienciasyelarte.ac.cr",
    "cesia.esquivel@udelascienciasyelarte.ac.cr",
    "melanie.vargas@udelascienciasyelarte.ac.cr",
    "cinthya.soto@udelascienciasyelarte.ac.cr",
    "monserrat.acuna@udelascienciasyelarte.ac.cr",
    "paula.jimenez.c@udelascienciasyelarte.ac.cr",
    "kendall.arrieta@udelascienciasyelarte.ac.cr",
    "liriany.marin@udelascienciasyelarte.ac.cr",
    "arturo.sanchez@udelascienciasyelarte.ac.cr",
    "reychel.camacho@udelascienciasyelarte.ac.cr",
    "priscilla.villares@udelascienciasyelarte.ac.cr",
    "ivannia.arias@udelascienciasyelarte.ac.cr",
    "aaron.ortiz@udelascienciasyelarte.ac.cr",
    "randall.romero@udelascienciasyelarte.ac.cr",
    "justin.obando@udelascienciasyelarte.ac.cr",
    "joshua.salazar@udelascienciasyelarte.ac.cr",
    "veronica.jimenez@udelascienciasyelarte.ac.cr",
    "patricia.carmona.r@udelascienciasyelarte.ac.cr",
    "grace.ramirez@udelascienciasyelarte.ac.cr",
    "marinet.cordero@udelascienciasyelarte.ac.cr",
    "jonathan.camacho@udelascienciasyelarte.ac.cr",
    "jose.mejia@udelascienciasyelarte.ac.cr",
    "cristal.lopez@udelascienciasyelarte.ac.cr",
    "alexis.aguilar@udelascienciasyelarte.ac.cr",
    "raquel.alvarado@udelascienciasyelarte.ac.cr",
    "luis.andre@udelascienciasyelarte.ac.cr",
    "yoselyn.vasquez@udelascienciasyelarte.ac.cr",
    "fabiola.jimenez@udelascienciasyelarte.ac.cr",
    "luis.cedeno@udelascienciasyelarte.ac.cr",
    "andreina.chaves@udelascienciasyelarte.ac.cr",
    "lisa.hidalgo@udelascienciasyelarte.ac.cr",
    "fabiana.esquivel@udelascienciasyelarte.ac.cr",
    "jorgeandres.vargas@udelascienciasyelarte.ac.cr",
    "brandon.rojas@udelascienciasyelarte.ac.cr",
    "luis.chacon.r@udelascienciasyelarte.ac.cr",
    "lester.romero@udelascienciasyelarte.ac.cr",
    "maria.redondo@udelascienciasyelarte.ac.cr",
    "gabriela.coto@udelascienciasyelarte.ac.cr",
    "adriana.valerio@udelascienciasyelarte.ac.cr",
    "soledad.gomez@udelascienciasyelarte.ac.cr",
    "billy.rodriguez@udelascienciasyelarte.ac.cr",
    "ileana.chaves@udelascienciasyelarte.ac.cr",
    "reina.acosta@udelascienciasyelarte.ac.cr",
    "giovanni.naranjo@udelascienciasyelarte.ac.cr",
    "maria.fonseca@udelascienciasyelarte.ac.cr",
    "priscila.zuniga@udelascienciasyelarte.ac.cr",
    "yenny.mendez@udelascienciasyelarte.ac.cr",
    "daniel.rojas@udelascienciasyelarte.ac.cr",
    "yilceth.brenes@udelascienciasyelarte.ac.cr",
    "estefanny.martinez@udelascienciasyelarte.ac.cr",
    "yendri.zuniga@udelascienciasyelarte.ac.cr",
    "katerin.mora@udelascienciasyelarte.ac.cr",
    "noily.cortes@udelascienciasyelarte.ac.cr",
    "felicia.salazar@udelascienciasyelarte.ac.cr",
    "fanny.vargas.b@udelascienciasyelarte.ac.cr",
    "jorge.retana@udelascienciasyelarte.ac.cr",
    "ericka.herrera@udelascienciasyelarte.ac.cr",
    "laura.nunez@udelascienciasyelarte.ac.cr",
    "vanessa.montalban@udelascienciasyelarte.ac.cr",
    "carolina.campos@udelascienciasyelarte.ac.cr",
    "laura.mendez@udelascienciasyelarte.ac.cr",
    "dayana.ugalde@udelascienciasyelarte.ac.cr",
    "gustavo.badilla.r@udelascienciasyelarte.ac.cr",
    "diana.salas@udelascienciasyelarte.ac.cr",
    "daniela.castro@udelascienciasyelarte.ac.cr",
    "michelle.campos@udelascienciasyelarte.ac.cr",
    "maria.sanchez@udelascienciasyelarte.ac.cr",
    "ana.vargas@udelascienciasyelarte.ac.cr",
    "maria.carranza@udelascienciasyelarte.ac.cr",
    "teresa.rosales@udelascienciasyelarte.ac.cr",
    "marlen.guevara@udelascienciasyelarte.ac.cr",
    "leobeita@gmail.com",
    "melissa.vallejos.leal@udelascienciasyelarte.ac.cr",
    "yeimy.jimenez.a@udelascienciasyelarte.ac.cr",
    "ana.sanchez.m@udelascienciasyelarte.ac.cr",
    "marlen.cortes@udelascienciasyelarte.ac.cr",
    "jeimy.mendez@udelascienciasyelarte.ac.cr",
    "diego.i.fernandez@udelascienciasyelarte.ac.cr",
    "yolanda.cubillo@udelascienciasyelarte.ac.cr",
    "jelizondocr@gmail.com",
    "kenya.villalta@udelascienciasyelarte.ac.cr",
    "einstein.perez@udelascienciasyelarte.ac.cr",
    "denisse.gomez@udelascienciasyelarte.ac.cr",
    "maria.garcia.j@udelascienciasyelarte.ac.cr",
    "fabian.morales@udelascienciasyelarte.ac.cr",
    "jaikel.aguilar@udelascienciasyelarte.ac.cr",
    "eduard.rojas@udelascienciasyelarte.ac.cr",
    "yisel.morier@udelascienciasyelarte.ac.cr",
    "kevin.aguero@udelascienciasyelarte.ac.cr",
    "diana.umana@udelascienciasyelarte.ac.cr",
    "jefferson.robles@udelascienciasyelarte.ac.cr",
    "margie.chamorro@udelascienciasyelarte.ac.cr",
    "manrique.carranza@udelascienciasyelarte.ac.cr",
    "gerardo.bolivar@udelascienciasyelarte.ac.cr",
    "maura.hall@udelascienciasyelarte.ac.cr",
    "randall.gallardo@udelascienciasyelarte.ac.cr",
    "candy.warren@udelascienciasyelarte.ac.cr",
    "hubert.brenes@udelascienciasyelarte.ac.cr",
    "zaray.perez@udelascienciasyelarte.ac.cr",
    "elsie.hernandez@udelascienciasyelarte.ac.cr",
    "chemikel.ramirez@udelascienciasyelarte.ac.cr",
    "luis.alberto.granados@udelascienciasyelarte.ac.cr",
    "joselin.ruiz@udelascienciasyelarte.ac.cr",
    "randal.carranza.j@udelascienciasyelarte.ac.cr",
    "kristin.diaz@udelascienciasyelarte.ac.cr",
    "jennifer.guerrero@udelascienciasyelarte.ac.cr",
    "crisnell.cabraca@udelascienciasyelarte.ac.cr",
    "neftali.granda@udelascienciasyelarte.ac.cr"
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
