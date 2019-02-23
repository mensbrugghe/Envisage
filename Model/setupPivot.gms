$setargs tableName tableGeom target

put 'set ifError=0' / ;
put 'IF EXIST "%xclDir%%tableName%.xlsx" (' / ;
put '   echo.Refreshing %tableName%.xlsx file...' / ;
put '   cscript %modDir%\refresh.vbs "%xclDir%" "%tableName%"  //NoLogo' / ;
put '   echo.ErrorLevel = !errorlevel!' / ;
put '   if !errorlevel! NEQ 0 (' / ;
put '      goto refreshErr' / ;
put '   )' / ;
put ') ELSE (' / ;
put '   echo.Creating %tableName%.xlsx file...' / ;
put '   call gams createPivot --GEOM=%tableGeom% --fileName=%tableName% --target=%target% --basename=%baseName% --odir=%odir% -idir=%modDir%' / ;
put '   echo.ErrorLevel = !errorlevel!' / ;
put '   if !errorlevel! NEQ 0 (' / ;
put '      goto createPivotErr' / ;
put '   )' / ;
put ')' / ;
put 'set ifError=0' / / ;
