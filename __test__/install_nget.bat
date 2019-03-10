@echo off

set base_path=C:\.workspace

set PATH=%~dp0..\bin;%base_path%\.bin;%PATH%

call npm-global "@warren-bank/node-request-cli"

call nget --help >"%~dp0.\nget-help.log"
