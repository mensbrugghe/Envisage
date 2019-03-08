*  Load the model
$include "%baseName%Opt.gms"
*  Read the user options
$include "%baseName%Tab.gms"
*  Create the tables
$include "maktab.gms"

*  Setup the pivot command

file fcmd / %basename%pivot.cmd / ;

if(not %ifAppend%,

   put fcmd ;

   put '@echo off' / ;
   put 'setlocal enableDelayedExpansion' / ;
   put 'set odir=%odir%' / ;
   put 'set modDir=%modDir%' / / ;

   loop(ifTab(tables),

      if(sameas(tables,"kappah"),
         $$batinclude "setupPivot" kappah VarbyRegion kappah
      ) ;

      if(sameas(tables,"rgovshr"),
         $$batinclude "setupPivot" rgovshr VarbyRegion rgovshr
      ) ;

      if(sameas(tables,"savinv"),
         $$batinclude "setupPivot" rgovshr VarbyRegion rinvshr
      ) ;

      if(sameas(tables,"gdppop"),
         $$batinclude "setupPivot" gdppop VarbyRegion rgdpmp
      ) ;

      if(sameas(tables,"factp"),
         $$batinclude "setupPivot" factp VarbyRegion trent
      ) ;

      if(sameas(tables,"lab"),
         $$batinclude "setupPivot" factp VarbyZone ls
      ) ;

      if(sameas(tables,"pow"),
         $$batinclude "setupPivot" Power VarbyPower xp
      ) ;

      if(sameas(tables,"trade"),
         $$batinclude "setupPivot" Trade VarByCommodity exp
      ) ;

      if(sameas(tables,"ydecomp"),
         $$batinclude "setupPivot" YDecomp VarByFactor rgdpfc
      ) ;

      if(sameas(tables,"cost"),
         $$batinclude "setupPivot" Cost VarByCost delpx
      ) ;

      if(sameas(tables,"emi"),
         $$batinclude "setupPivot" Emi VarByEmi Emi
      ) ;

      if(sameas(tables,"inv"),
         $$batinclude "setupPivot" Inv VarByActivity invd_sec
      ) ;

      if(sameas(tables,"va"),
         $$batinclude "setupPivot" VA VarByFactor va
      ) ;

      if(sameas(tables,"xp"),
         $$batinclude "setupPivot" Output VarByActivity xp
      ) ;

      if(sameas(tables,"NRG"),
         $$batinclude "setupPivot" NRG VarByNRG NRG
      ) ;

      if(sameas(tables,"bilat"),
         $$batinclude "setupPivot" Bilat VarByBilat xwS
      ) ;

      if(sameas(tables,"depl"),
         $$batinclude "setupPivot" depl VarByReserve res
      ) ;
   ) ;

*  Finish up

   put 'goto endCMD' / / ;

   put ':refreshErr' / ;
   put 'echo.Unable to refresh file' / ;
   put 'set ifError=1' / ;
   put 'goto endCMD' / / ;

   put ':createPivotErr' / ;
   put 'echo.Unable to create xlsx file' / ;
   put 'set ifError=1' / ;
   put 'goto endCMD' / / ;

   put ':endCmd' / ;
   put 'if %ifError%==0 (' / ;
   put '   echo.Successful conclusion...' / ;
   put '   exit /b 0' / ;
   put ') else (' / ;
   put '   echo.Maktab failed...' / ;
   put '   exit /b 1' / ;
   put ')' / ;
) ;
