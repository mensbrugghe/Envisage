@echo off
setlocal enableDelayedExpansion

:: Define the option names along with default values, using a <space>
:: delimiter between options. I'm using some generic option names, but
:: normally each option would have a meaningful name.
::
:: Each option has the format -name:[default]
::
:: The option names are NOT case sensitive.
::
:: Options that have a default value expect the subsequent command line
:: argument to contain the value. If the option is not provided then the
:: option is set to the default. If the default contains spaces, contains
:: special characters, or starts with a colon, then it should be enclosed
:: within double quotes. The default can be undefined by specifying the
:: default as empty quotes "".
:: NOTE - defaults cannot contain * or ? with this solution.
::
:: Options that are specified without any default value are simply flags
:: that are either defined or undefined. All flags start out undefined by
:: default and become defined if the option is supplied.
::
:: The order of the definitions is not important.
::
set "options=-ifFilter: -ifAlt: -ifEnv: -flag1: -flag2: -flag3:"

:: Set the default option values
for %%O in (%options%) do for /f "tokens=1,* delims=:" %%A in ("%%O") do set "%%A=%%~B"

:loop
:: Validate and store the options, one at a time, using a loop.
:: Options start at arg 3 in this example. Each SHIFT is done starting at
:: the first option so required args are preserved.
::
if not "%~2"=="" (
  set "test=!options:*%~2:=! "
  if "!test!"=="!options! " (
    rem No substitution was made so this is an invalid option.
    rem Error handling goes here.
    rem I will simply echo an error message.
    echo Error: Invalid option %~2
    set ifError=1
    goto Usage
  ) else if "!test:~0,1!"==" " (
    rem Set the flag option using the option name.
    rem The value doesn't matter, it just needs to be defined.
    set "%~2=1"
  ) else (
    rem Set the option value using the option as the name.
    rem and the next arg as the value
    set "%~2=%~3"
    shift /2
  )
  shift /2
  goto :loop
)

:: Now all supplied options are stored in variables whose names are the
:: option names. Missing options have the default value, or are undefined if
:: there is no default.
:: The required arg is still available in %1 (and %0 is also preserved)
:: For this example I will simply echo all the option values,
:: assuming any variable starting with - is an option.
::

set baseName=%1
if "!baseName!" == "" (
   echo Error: No basename for aggregation routine...
   goto Usage
)
if !-ifFilter! == 1 (
   set ifFilter=1
) else (
   set ifFilter=0
)
if !-ifAlt! == 1 (
   set ifAlt=1
) else (
   set ifAlt=0
)
if !-ifEnv! == 1 (
   set ifEnv=1
   set Model=Env
) else (
   set ifEnv=0
   set Model=GTAP
)

if 1 == 1 (
echo The value of the baseName is: %baseName%
echo The value of ifFilter is: %ifFilter%
echo The value of ifAlt is: %ifAlt%
echo The target model is: %Model%
set ifError=0
)

:: Create the directories
if not exist %baseName% mkdir %baseName%
if not exist %baseName%\agg mkdir %baseName%\agg
if not exist %baseName%\flt mkdir %baseName%\flt
if not exist %baseName%\alt mkdir %baseName%\alt
if not exist %baseName%\fnl mkdir %baseName%\fnl

goto AggGTAP
::goto Filter
::goto AlterTax

:AggGTAP

:: Aggregate GTAP data -- USER needs to prepare the map file (BaseNameMap.gms) and modify options on command line below

if not exist %baseName%Map.gms goto noMapFile
if %ifAlt% == 1 (
   call gams aggGTAP --basename=%baseName% --ifAlt=ON --model=%Model% --ifCSV=1 --ifAggTrade=1 -pw=150 -ps=9999
   echo.ErrorLevel = !errorlevel!
) else (
   call gams aggGTAP --basename=%baseName% --ifAlt=OFF --model=%Model% --ifCSV=1 --ifAggTrade=1 -pw=150 -ps=9999
   echo.ErrorLevel = !errorlevel!
)
if %errorlevel% NEQ 0 (
   goto BadAggregation
)

rem Conversion should be executed from within aggGTAP program

goto skipConversion

:: Need to clean up the final lables for the Env model
if !Model! == Env (
   call gams convertLabel --baseName=%baseName% -pw=150 -ps=9999
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto BadConversion
   ) else (
      call del tmpSets.gms
   )
)
if %errorlevel% NEQ 0 (
   goto BadConversion
)

:skipConversion
set ifError=0

:Filter
:: Filter the aggregate database -- USER needs to prepare options for filter routine (BaseNameFlt.gms) and modify options on command line below
if not exist %baseName%Flt.gms (
   rem Did we set the ifFlt flag?
   if %ifFilter% == 1 (
      echo Requested filtering, but there is no 'filter' option file: %baseName%Flt.gms
      set ifError=1
      goto endCmd
   )
)
rem echo Filter flag is: %ifFilter%

if %ifFilter% == 0 (
   :: Move files from Agg to Flt
   copy %baseName%\agg\*.gdx %baseName%\flt\
) else (
   :: Perform the filter
   :: Copy non-filter files to FLT
   if exist %baseName%\Agg\%baseName%Elast.gdx copy %baseName%\Agg\%baseName%Elast.gdx %baseName%\Flt
   if exist %baseName%\Agg\%baseName%par.gdx copy %baseName%\Agg\%baseName%par.gdx %baseName%\Flt
   if exist %baseName%\Agg\%baseName%prm.gdx copy %baseName%\Agg\%baseName%prm.gdx %baseName%\Flt
   if exist %baseName%\Agg\%baseName%BoP.gdx copy %baseName%\Agg\%baseName%BoP.gdx %baseName%\Flt
   if exist %baseName%\Agg\%baseName%Sat.gdx copy %baseName%\Agg\%baseName%Sat.gdx %baseName%\Flt
   if exist %baseName%\Agg\%baseName%MRIO.gdx copy %baseName%\Agg\%baseName%MRIO.gdx %baseName%\Flt
   if exist %baseName%\Agg\%baseName%Scn.gdx copy %baseName%\Agg\%baseName%Scn.gdx %baseName%\Flt
   :: Run the filter routine
   call gams filter --BaseName=%baseName% --ifCSV=1 --ifAggTrade=1 -pw=150 -ps=9999
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto BadFilter
   )
)
set ifError=0

:AlterTax
:: Impose pre-simulation changes -- USER needs to prepare options for Altertax routine (BaseNameAlt.gms) and modify options on command line below

if not exist %baseName%Alt.gms (
   rem Did we set the ifAlt flag?
   if %ifAlt% == 1 (
      echo Requested running AlterTax, but there is no 'AlterTax' option file: %baseName%Alt.gms
      set ifError=1
      goto endCmd
   )
)
if %ifAlt% == 0 (
   :: Move files from Flt to Alt
   copy %baseName%\Flt\*.gdx %baseName%\Alt\
) else (
   :: Invoke alterTax
   :: Copy non-AlterTax files to Alt
   if exist %baseName%\Flt\%baseName%Elast.gdx copy %baseName%\Flt\%baseName%Elast.gdx %baseName%\Alt
   if exist %baseName%\Flt\%baseName%par.gdx copy %baseName%\Flt\%baseName%par.gdx %baseName%\Alt
   if exist %baseName%\Flt\%baseName%prm.gdx copy %baseName%\Flt\%baseName%prm.gdx %baseName%\Alt
   if exist %baseName%\Flt\%baseName%BoP.gdx copy %baseName%\Flt\%baseName%BoP.gdx %baseName%\Alt
   if exist %baseName%\Flt\%baseName%Sat.gdx copy %baseName%\Flt\%baseName%Sat.gdx %baseName%\Alt
   if exist %baseName%\Flt\%baseName%MRIO.gdx copy %baseName%\Flt\%baseName%MRIO.gdx %baseName%\Alt
   if exist %baseName%\Flt\%baseName%Scn.gdx copy %baseName%\Flt\%baseName%Scn.gdx %baseName%\Alt
   :: Run Altertax
   call gams AlterTax --BaseName=%baseName% --niter=1 --ifCSV=1 -pw=150 -idir=GTAPModel
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto BadAlterTax
   )
)
rem Copy all of the 'alt' files to 'fnl'
copy %baseName%\Alt\%baseName%*.gdx %baseName%\Fnl\
set ifError=0
goto endCmd

:noMapFile
echo.%baseName%Map.gms does not exist...
echo.Check file and option names
set ifError=1
goto endCmd

:BadAggregation
echo.Aggregation routine failed, check 'aggGTAP.lst' file
set ifError=1
goto endCMD

:BadConversion
echo.Conversion of labels for ENV model failed, check 'convertLable.lst' file
set ifError=1
goto endCMD

:BadFilter
echo.Filter routine failed, check 'filter.lst' file
set ifError=1
goto endCMD

:BadAltertax
echo.AlterTax routine failed, check 'AlterTax.lst' file
set ifError=1
goto endCMD

:Usage
echo Usage:  makeData baseName [-ifFilter] [-ifAlt] [-ifEnv]
echo Note:      Aggregation facility requires a file named 'baseNameMap.gms'
echo Option: Enter '-ifFilter' on the command line to run the Rutherford/Britz filtering algorithm
echo Note:      Filtering algorithm requires file baseNameFlt.gms
echo Option: Enter '-ifAlt' on the command line to run the GTAP-inspired 'AlterTax' routine
echo Note:      AlterTax routine requires file 'baseNameAlt.gms'
echo Option: Enter '-ifEnv' to aggregate parameters for 'Env' type model
set ifError=1
goto endCmd

:endCmd
if %ifError%==0 (
   echo.Successful conclusion...
   exit /b 0
) else (
   echo.Makedata failed...
   exit /b 1
)
