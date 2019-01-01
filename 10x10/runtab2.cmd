@echo off
setlocal enableDelayedExpansion
set baseName=10x10
set oDir=v:\Env10\%baseName%\Doc\

::goto pivot

set ifError=0
call gams maktab2 --simname=BaU --BaUName=BaU --simType=RcvDyn --ifCal=1 --ifAppend=0 --BaseName=%baseName% --odir=z:\Output\Env10\%baseName% -idir=..\Model
echo.ErrorLevel = !errorlevel!
if %errorlevel% NEQ 0 (
   goto makError
)

goto pivot
set ifError=0
call gams maktab2 --simname=10x10 --BaUName=BaU --simType=RcvDyn --ifCal=0 --ifAppend=1 --BaseName=%baseName% --odir=z:\Output\Env10\%baseName% -idir=..\Model
echo.ErrorLevel = !errorlevel!
if %errorlevel% NEQ 0 (
   goto makError
)

:pivot

::goto bilat

set ifError=0
IF EXIST "%oDir%kappah.xlsx" (
   echo.Refreshing kappah.xlsx file...
   cscript refresh.vbs "%oDir%" "kappah"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating kappah.xlsx file...
   call gams createPivot --GEOM=VarByRegion --fileName=kappah  --target=kappah   --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%rgovshr.xlsx" (
   echo.Refreshing rgovshr.xlsx file...
   cscript refresh.vbs "%oDir%" "rgovshr"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating rgovshr.xlsx file...
   call gams createPivot --GEOM=VarByRegion    --fileName=rgovshr --target=rgovshr  --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%savinv.xlsx" (
   echo.Refreshing savinv.xlsx file...
   cscript refresh.vbs "%oDir%" "savinv"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating savinv.xlsx file...
   call gams createPivot --GEOM=VarByRegion    --fileName=savinv  --target=rinvshr  --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%gdppop.xlsx" (
   echo.Refreshing gdppop.xlsx file...
   cscript refresh.vbs "%oDir%" "gdppop"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating gdppop.xlsx file...
   call gams createPivot --GEOM=VarByRegion    --fileName=gdppop  --target=rgdpmp   --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%factp.xlsx" (
   echo.Refreshing factp.xlsx file...
   cscript refresh.vbs "%oDir%" "factp"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating factp.xlsx file...
   call gams createPivot --GEOM=VarByRegion    --fileName=factp   --target=trent    --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%Lab.xlsx" (
   echo.Refreshing Lab.xlsx file...
   cscript refresh.vbs "%oDir%" "Lab"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating Lab.xlsx file...
   call gams createPivot --GEOM=VarByZone      --fileName=Lab     --target=ls       --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%Power.xlsx" (
   echo.Refreshing Power.xlsx file...
   cscript refresh.vbs "%oDir%" "Power"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating Power.xlsx file...
   call gams createPivot --GEOM=VarByPower     --fileName=Power   --target=xp       --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%Trade.xlsx" (
   echo.Refreshing Trade.xlsx file...
   cscript refresh.vbs "%oDir%" "Trade"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating Trade.xlsx file...
   call gams createPivot --GEOM=VarByCommodity --fileName=Trade   --target=exp      --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%YDecomp.xlsx" (
   echo.Refreshing YDecomp.xlsx file...
   cscript refresh.vbs "%oDir%" "YDecomp"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating YDecomp.xlsx file...
   call gams createPivot --GEOM=VarByFactor    --fileName=YDecomp --target=rgdpfc   --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%Cost.xlsx" (
   echo.Refreshing Cost.xlsx file...
   cscript refresh.vbs "%oDir%" "Cost"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating Cost.xlsx file...
   call gams createPivot --GEOM=VarByCost      --fileName=Cost    --target=delpx    --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%Emi.xlsx" (
   echo.Refreshing Emi.xlsx file...
   cscript refresh.vbs "%oDir%" "Emi"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating Emi.xlsx file...
   call gams createPivot --GEOM=VarByEmi       --fileName=Emi     --target=Emi      --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%INV.xlsx" (
   echo.Refreshing INV.xlsx file...
   cscript refresh.vbs "%oDir%" "INV"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating INV.xlsx file...
   call gams createPivot --GEOM=VarByActivity  --fileName=INV     --target=invd_sec --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%VA.xlsx" (
   echo.Refreshing VA.xlsx file...
   cscript refresh.vbs "%oDir%" "VA"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating VA.xlsx file...
   call gams createPivot --GEOM=VarByFactor    --fileName=VA      --target=va       --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

set ifError=0
IF EXIST "%oDir%Output.xlsx" (
   echo.Refreshing Output.xlsx file...
   cscript refresh.vbs "%oDir%" "Output"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating Output.xlsx file...
   call gams createPivot --GEOM=VarByActivity  --fileName=Output  --target=xp       --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

:bilat
set ifError=0
IF EXIST "%oDir%Bilat.xlsx" (
   echo.Refreshing Bilat.xlsx file...
   cscript refresh.vbs "%oDir%" "Bilat"  //NoLogo
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto refreshErr
   )
) ELSE (
   echo.Creating Bilat.xlsx file...
   call gams createPivot --GEOM=VarByBilat --fileName=Bilat  --target=xwS --basename=%baseName%
   echo.ErrorLevel = !errorlevel!
   if !errorlevel! NEQ 0 (
      goto createPivotErr
   )
)
set ifError=0

goto endCmd

:makError
echo.Make table failed, check listing file (makTab2.lst)
set ifError=1
goto endCMD

:refreshErr
echo.Unable to refresh file
set ifError=1
goto endCMD

:createPivotErr
echo.Unable to create xlsx file
set ifError=1
goto endCMD

:Usage
echo.Usage:  runtab2 refreshOption
echo.Note:      To create new worksheets, use 0, to refresh existing worksheets, use 1
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
