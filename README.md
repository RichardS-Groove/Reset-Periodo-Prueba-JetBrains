# 🌟 JetBrains Trial Reset 🌟

¡Bienvenido! Este script mágico ✨ está diseñado para restablecer el periodo de prueba de tus IDEs favoritos de JetBrains, como WebStorm, IntelliJ IDEA, PyCharm y más. Es rápido, fácil de usar, y todo lo que necesitas para volver a empezar. 🌈

---

## 🎯 **¿Qué hace este script?**

🧹 **Limpia carpetas y archivos de configuración:**  
Elimina los datos de evaluación (`eval`) de los IDEs para que puedas restablecer el periodo de prueba.

🔑 **Borra claves de registro opcionales:**  
Limpia las entradas del registro de Windows relacionadas con JetBrains.

🚀 **Listo para usar:**  
Después de ejecutarlo, simplemente reinicia tu IDE y comienza de nuevo.

---

## 📦 **IDEs compatibles**

Este script funciona con los siguientes productos de JetBrains:  
- 💡 **WebStorm**  
- 🚀 **IntelliJ IDEA**  
- 🛠️ **CLion**  
- 🖋️ **Rider**  
- 🐍 **PyCharm**  
- 🌐 **PhpStorm**  
- 🏗️ **GoLand**  
- 🔄 **ReSharper**

---

## 🛠️ **Requisitos**

1. 🖥️ **Sistema Operativo:** Windows.  
2. ⚡ **Permisos de Administrador:** Necesarios para modificar claves de registro y carpetas protegidas.  

---

## 📝 **Cómo usar el script**

1. **Descarga** el archivo `reset_trial.bat` desde este repositorio.  
2. Haz clic derecho en el archivo y selecciona **"Ejecutar como administrador"**.  
3. Sigue las instrucciones que aparecen en la consola.  

   - Se eliminarán las carpetas de configuración de evaluación y las claves de registro asociadas.
   - Al finalizar, verás un mensaje de éxito. 🎉  

4. **Reinicia** tu IDE JetBrains y disfruta. 🌟

---

## 💻 **Código del Script**

```batch
@echo off
setlocal enabledelayedexpansion

REM ------------------------------------------
REM Script para restablecer periodo de prueba
REM Compatible con varios productos de JetBrains
REM ------------------------------------------

REM Listado de productos JetBrains
set "products=WebStorm IntelliJ CLion Rider GoLand PhpStorm Resharper PyCharm"

REM Mensaje inicial
echo =====================================================
echo       Restablecer Periodo de Prueba - JetBrains
echo =====================================================
echo.
echo Este script eliminara las configuraciones de prueba.
echo Por favor, asegurate de cerrar los IDEs antes de continuar.
echo.

REM Pausa para confirmacion del usuario
set /p confirm="¿Deseas continuar? (S/N): "
if /i not "!confirm!"=="S" (
    echo Operacion cancelada por el usuario.
    exit /b
)

REM Bucle para eliminar configuraciones de evaluacion
echo Eliminando configuraciones de evaluacion...
for %%I in (%products%) do (
    for /d %%a in ("%USERPROFILE%\.%%I*") do (
        if exist "%%a\config\eval" (
            rd /s /q "%%a\config\eval" 2>nul
            echo [✓] Eliminado: %%a\config\eval
        ) else (
            echo [!] No se encontro: %%a\config\eval
        )
        if exist "%%a\config\options\other.xml" (
            del /q "%%a\config\options\other.xml" 2>nul
            echo [✓] Eliminado: %%a\config\options\other.xml
        ) else (
            echo [!] No se encontro: %%a\config\options\other.xml
        )
    )
)

REM Eliminar carpetas globales de JetBrains en AppData
echo.
echo Eliminando configuraciones globales...
if exist "%APPDATA%\JetBrains" (
    rmdir /s /q "%APPDATA%\JetBrains" 2>nul
    echo [✓] Carpeta %APPDATA%\JetBrains eliminada.
) else (
    echo [!] Carpeta %APPDATA%\JetBrains no encontrada.
)

REM Eliminar claves de registro asociadas
echo.
echo Eliminando claves de registro...
reg delete "HKEY_CURRENT_USER\Software\JavaSoft" /f >nul 2>&1
if %errorlevel% equ 0 (
    echo [✓] Clave "HKEY_CURRENT_USER\Software\JavaSoft" eliminada.
) else (
    echo [!] Clave "HKEY_CURRENT_USER\Software\JavaSoft" no encontrada o error al eliminar.
)

REM Mensaje final
echo.
echo =====================================================
echo Operacion completada. Reinicia tu IDE para confirmar.
echo =====================================================
pause
