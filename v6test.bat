@echo off
title DarkHacker Multi-Tool

:menu
echo 1. Spam a webhook
echo 2. Generate a password
echo 3. Get IP location
echo 4. Exit

set /p choice=Enter your choice:

if "%choice%"=="1" (
    call :webhook_spam
    goto menu
)

if "%choice%"=="2" (
    call :password_generator
    goto menu
)

if "%choice%"=="3" (
    call :ip_location
    goto menu
)

if "%choice%"=="4" (
    echo Exiting DarkHacker Multi-Tool. Stay rebellious, my friend!
    exit /b
)

goto menu

:webhook_spam
echo Enter the webhook URL:
set /p webhook=Webhook URL:
echo Enter the message to spam:
set /p message=Message:
echo Starting webhook spam...
echo Press Ctrl+C to stop.
pause

:spam
echo Spamming the webhook...

:loop
curl -H "Content-Type: application/json" -X POST -d "{\"content\":\"%message%\"}" "%webhook%"
goto loop

:password_generator
echo How many characters do you want the password to be?
set /p length=Enter the desired length:
echo Do you want numbers included? (Y/N)
set /p includeNumbers=Enter Y for Yes or N for No:
echo Do you want symbols included? (Y/N)
set /p includeSymbols=Enter Y for Yes or N for No:
echo Generating the password...

setlocal EnableDelayedExpansion
set "chars=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
set "numbers=0123456789"
set "symbols=!@#$%%^&*()_+-="

set "password="

:generate
set /a index=!random! %% 52
for /f %%a in ("!index!") do set "password=!password!!chars:~%%a,1!"
set /a length-=1
if %length% GTR 0 goto generate

if /i "%includeNumbers%"=="Y" (
    set "password=!password!!numbers:~%random% %% 10,1!"
)

if /i "%includeSymbols%"=="Y" (
    set "password=!password!!symbols:~%random% %% 18,1!"
)

echo Your generated password is: !password!
pause
goto menu

:ip_location
echo Enter the IP address:
set /p ip=IP Address:
echo Fetching location information for IP: %ip%...

curl -s http://ip-api.com/json/%ip% > ip_location.json

echo Location Information for IP %ip%:
type ip_location.json
pause
goto menu
