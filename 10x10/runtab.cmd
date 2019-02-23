@echo off
setlocal enableDelayedExpansion
set baseName=10x10
set oDir=z:\Output\Env10\10x10
set modDir=..\Model

set ifError=0
call gams makCSV --simname=BaU --BaUName=BaU --simType=RcvDyn --ifCal=1 --ifAppend=0 --BaseName=%baseName% --odir=%oDir% -idir=%modDir% -pw=140 -errmsg=1
echo.ErrorLevel = !errorlevel!
if %errorlevel% NEQ 0 (
   goto makError
)

set ifError=0
call gams makCSV --simname=noShk --BaUName=BaU --simType=RcvDyn --ifCal=0 --ifAppend=1 --BaseName=%baseName% --odir=%oDir% -idir=%modDir% -pw=140 -errmsg=1
echo.ErrorLevel = !errorlevel!
if %errorlevel% NEQ 0 (
   goto makError
)

:pivot

set ifError=0
call %baseName%pivot.cmd
echo.ErrorLevel = !errorlevel!
if %errorlevel% NEQ 0 (
   goto PivotErr
)

goto endcmd

:makError
echo.Make table failed, check listing file (makCSV.lst)
set ifError=1
goto endCMD

:PivotErr
echo.Error while creating or refreshing a pivot table
set ifError=1
goto endCMD

:Usage
echo.Usage:  runtab
set ifError=1
goto endCmd

:endCmd
if %ifError%==0 (
   echo.Successful conclusion...
   exit /b 0
) else (
   echo.Maktab failed...
   exit /b 1
)
