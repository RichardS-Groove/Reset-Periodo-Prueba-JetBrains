# 🌟 JetBrains Trial Reset Script 🌟

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

REM Eliminar carpetas de configuración de WebStorm
for %%I in ("WebStorm", "IntelliJ", "CLion", "Rider", "GoLand", "PhpStorm", "Resharper", "PyCharm") do (
    for /d %%a in ("%USERPROFILE%\.%%I*") do (
        rd /s /q "%%a/config/eval"
        del /q "%%a\config\options\other.xml"
    )
)

REM Eliminar clave de registro y carpeta de JetBrains (opcional)
rmdir /s /q "%APPDATA%\JetBrains"
reg delete "HKEY_CURRENT_USER\Software\JavaSoft" /f

echo Proceso completado. Reinicia WebStorm para ver si el periodo de prueba se ha restablecido.
pause
