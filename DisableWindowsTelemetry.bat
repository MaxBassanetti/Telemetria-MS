@echo off
setlocal

:start
cls
echo.
echo *********************************
echo ***                           ***
echo *** Disable Windows Telemetry ***
echo ***                           ***
echo ***    Versione 1.0 - 2021    ***
echo ***                           ***
echo *********************************
echo.
echo Verifica del servizio sul sistema
sc query diagtrack
echo.
for /f "tokens=2*" %%a in ('reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\diagtrack /v Start') do set 'var=%%b'
if "%var%'=="0x2" echo Avvio automatico abilitato
if "%var%"=="0x3" echo Avvio manuale richiesto
if "%var%"=="0x4" echo Avvio automatico disabilitato
echo.
echo Selezionare voce
echo     D - Disabilita il servizio
echo     A - Abilita il servizio
echo.
SET /P SCELTA="Seleziona opzione (d/a), 0 per uscire : "
if errorlevel 1 set "SCELTA=" & verify>nul & goto start
if /i %SCELTA% EQU d goto disable
if /i %SCELTA% EQU a goto enable
goto start

:disable
echo.
echo Stop del servizio di telemetria e blocco avvio automatico...
sc stop diagtrack
sc config diagtrack start=disabled
echo.
for /f "tokens=2*" %%a in ('reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\diagtrack /v Start') do set "var=%%b"
if "%var%"=="0x4" echo Avvio automatico disabilitato
goto end

:enable
echo.
echo Avvio del servizio di Telemetria e impostazione avvio automatico ...
sc config diagtrack start=auto
sc start diagtrack
echo.
for /f "tokens=2*" %%a in ('reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\diagtrack /v Start') do set "var=%%b"
if "%var%"=="0x2" echo Automatic Start Enabled
goto end

:end 
echo.
echo Premere qualsiasi tasto per terminare  questo programma
pause > NUL

