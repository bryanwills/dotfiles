@echo off
Powershell Expand-Archive -Force EncoreRMMInstaller.zip C:\Temp
pause
Call C:\Temp\installNinja.exe
DEL C:\Temp\installNinja.exe
echo Installation Exit Code %ERRORLEVEL%
pause
