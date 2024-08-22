@echo off

:: Elevating (getting admin permissions)
ver |>NUL find /v "5." && if "%~1"=="" (
  Echo CreateObject^("Shell.Application"^).ShellExecute WScript.Arguments^(0^),"1","","runas",1 >"%~dp0Elevating.vbs"
  cscript.exe //nologo "%~dp0Elevating.vbs" "%~f0"& goto :eof
)

:: In command prompt run "call set:it\to\path\to\this\file :skipadmintest" to skip elevating process
:skipadmintest

:: Used to go to C:\ folder (so archive unzips here)
cd C:\Windows
cd..

echo -------------------------------
echo Android Cmdline Tools Installer
echo -------------------------------
echo.

pause

:: Checks if it alerady installed, if it is just a folder then its deleted and the installation starts
if exist "C:\platform-tools" (
echo Alerady installed. If not, press any key.
pause > nul
taskkill /f /im adb.exe
rmdir /s C:\platform-tools
)

:: Downloading Android Cmdline Tools from original site (https://dl.google.com/android/repository/platform-tools-latest-windows.zip) and saving it in C:\Temp\
echo Downloading Android Cmdline tools 
if exist "C:\temp\platform-tools.zip" del /q C:\temp\platform-tools.zip > NUL
powershell -c "Invoke-WebRequest -Uri 'https://dl.google.com/android/repository/platform-tools-latest-windows.zip' -OutFile 'c:\Temp\platform-tools.zip'"

:: Unzipping archive in C:\
echo Unzipping archive
tar -xf C:\temp\platform-tools.zip

:: Sorry, you have to add C:\platform-tools to path mannually (Search "enviroment" in Start menu and add C:\platform-tools), because there we're problems with setx.

echo.
echo Android Cmdline tools are ready to use!
echo They are located at C:\platform-tools.
echo You can add them to path! Search "enviroment" in Start menu and add C:\platform-tools.
echo Just launch Command Prompt and type any command, like "adb -d reboot"!
pause > nul