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
