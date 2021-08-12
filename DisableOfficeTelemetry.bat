@echo off
setlocal

:start
cls
echo.
echo ********************************
echo ***                          ***
echo *** Disable Office Telemetry ***
echo ***                          ***
echo ***   Versione 1.0 - 2021    ***
echo ***                          ***
echo ********************************
echo.
echo Selezionare voce
echo      D - Disabilita telemetria di Office
echo      A - Abilita telemetria di Office
echo.
SET /P SCELTA="Seleziona opzione (d/a), 0 per uscire : "

if errorlevel 1 set "SCELTA=" & verify>nul & goto start
IF /i %SCELTA% EQU d goto disable
IF /i %SCELTA% EQU a goto enable
IF /i %SCELTA% EQU 0 goto end
goto start

:disable
echo.
echo Disabilito il job di Telemetria di Office ...
for /f "tokens=1*" %%a in ('schtasks /query ^| findstr /i officetelemetry') do (schtasks /Change /TN "\Microsoft\Office\%%a" /DISABLE)
goto end

:enable
echo.
echo Abilito il job di Telemetria di Office ...
for /f "tokens=1*" %%a in ('schtasks /query ^| findstr /i officetelemetry') do (schtasks /Change /TN "\Microsoft\Office\%%a" /ENABLE)
goto end

:end
echo.
echo Premi un qualsiasi tasto per terminare questo programma.
pause > NUL
