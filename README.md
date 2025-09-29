# Desactivación Masiva de Cuentas Inactivas en Microsoft 365 / Azure AD

Este script de PowerShell automatiza la **identificación y desactivación de cuentas inactivas** en Microsoft 365 (Azure Active Directory), exportando un reporte detallado y permitiendo la desactivación masiva de usuarios bajo criterios personalizables de fecha y lista blanca.

## 🚩 **Características**

- **Filtra usuarios** creados antes o igual a una fecha límite configurable.
- Identifica **usuarios inactivos** (que no han iniciado sesión después de la fecha indicada o nunca han iniciado sesión).
- Permite **excluir usuarios específicos** por correo institucional (lista blanca).
- Exporta un reporte CSV con datos clave: nombre, apellido, correo, tipo de usuario, fechas de actividad, etc.
- **Desactiva** automáticamente las cuentas identificadas (opcional, solo al ejecutar la última sección).
- Seguro para ambientes con miles de cuentas.

---

## ⚠️ Advertencias

- **No elimina usuarios** ni sus datos, sólo deshabilita el acceso (AccountEnabled = $false).
- **NO quita licencias asignadas**. Las licencias seguirán ocupadas hasta que se remuevan manualmente.
- El script requiere permisos de administrador global o roles suficientes para leer y modificar usuarios en Azure AD.
- **Prueba primero el reporte** antes de desactivar usuarios masivamente.

---

## 📝 **Requisitos Previos**

- PowerShell 7+ recomendado.
- Permisos administrativos sobre Azure AD.
- [Microsoft.Graph](https://learn.microsoft.com/powershell/microsoftgraph/overview) PowerShell Module.

Instala el módulo (solo la primera vez):

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser -Force
