@echo off
setlocal
set VERSION=8.13
if "%GRADLE_USER_HOME%"=="" set GRADLE_USER_HOME=%USERPROFILE%\.gradle
set BASE=%GRADLE_USER_HOME%\jarvis-bootstrap
set GRADLE=%BASE%\gradle-%VERSION%\bin\gradle.bat
if not exist "%GRADLE%" (
  if not exist "%BASE%" mkdir "%BASE%"
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest 'https://services.gradle.org/distributions/gradle-%VERSION%-bin.zip' -OutFile '%BASE%\gradle-%VERSION%-bin.zip'; Expand-Archive -Force '%BASE%\gradle-%VERSION%-bin.zip' '%BASE%'"
  if errorlevel 1 exit /b 1
)
call "%GRADLE%" %*
endlocal
