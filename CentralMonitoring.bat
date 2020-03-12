@echo off
setlocal
:PROMPT

title Installation by Jeremy

echo        dP                                               
echo        88                                               
echo        88 .d8888b. 88d888b. .d8888b. 88d8b.d8b. dP    dP
echo        88 88ooood8 88'  `88 88ooood8 88'`88'`88 88    88
echo 88.  .d8P 88.  ... 88       88.  ... 88  88  88 88.  .88
echo  `Y8888'  `88888P' dP       `88888P' dP  dP  dP `8888P88
echo                                                      .88
echo                                                  d8888P 
echo ________________________________________________________________

SET /P AREYOUSURE=Formater le fichier de config pour se retrouver sans config ([O]/[N])?
IF /I "%AREYOUSURE%" NEQ "O" GOTO EtapeReconfig

copy development.ini.default development.ini

:EtapeReconfig
SET /P AREYOUSURE=Changer les valeurs du fichier de config ([O]/[N])?
IF /I "%AREYOUSURE%" NEQ "O" GOTO EtapeInstall

powershell -Command "$SQL_INSTANCE_NAME = Read-Host -Prompt 'Nom pour Instance SQL (ex: LAPTOP-EO6NIUU0\SSQL) ';$DB_NAME = Read-Host -Prompt 'Nom de la bdd de la console admin (ex: CONSOLEADMIN) ';$DB_USER = Read-Host -Prompt 'Nom du user la base de donnee de la console admin (ex: Ns..) ';$DB_PWD = Read-Host -Prompt 'Mot de passe de ce user (ex: Fu..) ';$PORT = Read-Host -Prompt 'Port pour l application (ex: 6546) ';$PORTAL_TOKEN = Read-Host -Prompt 'Token (jwtauth.master_secret dans le development.ini du back du portail) ';$file = \"development.ini\";$text = (Get-Content -Path $file -ReadCount 0) -join \"`n\";$text -replace \"#SQL_INSTANCE_NAME#\", $SQL_INSTANCE_NAME | Set-Content -Path $file;$text = (Get-Content -Path $file -ReadCount 0) -join \"`n\";$text -replace \"#PORTAL_TOKEN#\", $PORTAL_TOKEN | Set-Content -Path $file;$text = (Get-Content -Path $file -ReadCount 0) -join \"`n\";$text -replace \"#DB_NAME#\", $DB_NAME | Set-Content -Path $file;$text = (Get-Content -Path $file -ReadCount 0) -join \"`n\";$text -replace \"#DB_USER#\", $DB_USER | Set-Content -Path $file;$text = (Get-Content -Path $file -ReadCount 0) -join \"`n\";$text -replace \"#DB_PWD#\", $DB_PWD | Set-Content -Path $file;$text = (Get-Content -Path $file -ReadCount 0) -join \"`n\";$text -replace \"#PORT#\", $PORT | Set-Content -Path $file;"

:EtapeInstall
SET /P AREYOUSURE=Installer l'environnement et l'application ([O]/[N])?
IF /I "%AREYOUSURE%" NEQ "O" GOTO END

CALL python -m pip install --user virtualenv
CALL python -m venv ./dcvenv
CALL dcvenv/Scripts/activate
CALL python -m pip install --upgrade pip
CALL python -m pip install --upgrade setuptools
CALL python setup.py develop

:END
echo Fini !

pause
endlocal