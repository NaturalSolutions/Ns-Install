@echo off
title eCollection Veterinary DEV full install
echo ###############################################
echo ##  eCollection Veterinary DEV full install  ##
echo ###############################################
cd %~dp0

REM eCollection veterinary repository creation
mkdir eCollection-veto-dev & echo Repository eCollection-veto-dev [32mcreated[0m.
cd eCollection-veto-dev

REM Creating Files repository
mkdir Files & echo Repository Files [32mcreated[0m.
cd Files
mkdir Import_Files & echo Subfolder 'Import_Files' [32mcreated[0m.
mkdir Templates & echo Subfolder 'Templates' [32mcreated[0m.
mkdir Uploaded_Files & echo Subfolder 'Uploaded_Files' [32mcreated[0m.

cd ..
echo.

REM Frontend download
git clone https://github.com/NaturalSolutions/eCollection-vetofront.git
cd eCollection-vetofront
echo Checkout to master-dev
git checkout master-dev
CALL .\install.bat

cd ..
echo.

REM Backend download
git clone https://github.com/NaturalSolutions/eCollection-vetoback.git
cd eCollection-vetoback
echo Checkout to master-dev
git checkout master-dev
CALL .\install.bat

cd ..
echo.

echo [32mInstall done ![0m 
echo [32m/!\ Don't forget to complete front and back parameters files:[0m 
echo %TAB% - eCollection-vetofront\src\environments\conf.ts
echo %TAB% - eCollection-vetoback\development.ini
