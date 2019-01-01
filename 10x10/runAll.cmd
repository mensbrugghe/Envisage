@echo off
setlocal enableDelayedExpansion
set baseName=10x10
set oDir=z:\Output\Env10\%baseName%

goto BaU

:BaU

set ifError=0
copy runsim.gms runBaU.gms
call gams runBaU --simName=BaU --BauName=BaU --startName=XXX --startYear=2030 --simType=RcvDyn --ifCal=1 --baseName=%baseName% --odir=%oDir% -idir=..\model -scrdir=%oDir% -ps=99999 -pw=150 -errmsg=1
echo.ErrorLevel = !errorlevel!
if %errorlevel% NEQ 0 (
   goto simError
)

:noshk

set ifError=0
copy runsim.gms runnoShk.gms
call gams runnoShk --simName=noShk --BaUName=BaU --startName=BaU --startYear=2030 --simType=RcvDyn --ifCal=0 --baseName=%baseName% --odir=%oDir% -idir=..\model -scrdir=%oDir% -ps=99999 -pw=150 -errmsg=1
echo.ErrorLevel = !errorlevel!
if %errorlevel% NEQ 0 (
   goto simError
)

goto endCMD

:simError
echo.Simulation failed, check listing file
set ifError=1
goto endCMD

:endCMD
if %ifError%==0 (
   echo.Successful conclusion...
   exit /b 0
) else (
   echo.Runsim failed...
   exit /b 1
)
