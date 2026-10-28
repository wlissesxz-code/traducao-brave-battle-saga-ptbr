@echo off
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Aplicar-Traducao.ps1" -Restaurar %*
pause
