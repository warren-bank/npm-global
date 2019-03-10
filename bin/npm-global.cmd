@echo off
setlocal enabledelayedexpansion

set NODE_ENV=production

if not defined base_path (
  set base_path=C:\PortableApps
)

set module_uuid=%~1
set module_name=%module_uuid:*/=%

set module_path=!base_path!\%module_name%

rem :: ===========================================
rem :: install module

if not exist "!base_path!" (
  echo "base_path" directory does not exist: "!base_path!"
  goto :skip
)

if exist "%module_path%" (
  echo "%module_name%" is already installed in: "!base_path!"
  goto :skip
)

mkdir "%module_path%"
pushd "%module_path%"

call npm init --yes --scope="npm-global" >NUL 2>&1
call npm install --only=production --save "%module_uuid%" >"%module_path%\.npm-install.log" 2>&1

rem :: ===========================================
rem :: add an alias to each of the .bin scripts

set global_bin_path=!base_path!\.bin
if not exist "%global_bin_path%" mkdir "%global_bin_path%"

set local_bin_path=%module_path%\node_modules\.bin

for /F "usebackq tokens=* delims=" %%F IN (`dir /B "%local_bin_path%\*.cmd"`) do (
  set cmd_name=%%F
  set global_cmd=%global_bin_path%\!cmd_name!
  set local_cmd=%local_bin_path%\!cmd_name!

  echo @echo off>"!global_cmd!"
  echo call "!local_cmd!" %%*>>"!global_cmd!"
)

:done
popd
echo "%module_name%" has successfully been installed in: "!base_path!"

:skip
endlocal
