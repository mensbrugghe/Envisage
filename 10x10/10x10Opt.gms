* --------------------------------------------------------------------------------------------------
*
*  Define a first set of global options
*
*     wdir        Active directory (normally not changed)
*     SSPMOD      Either OECD or IIASA
*     SSPSCEN     SSP1, SSP2, SSP3, SSP4, or SSP5
*     LABSCEN     SSP1, SSP2, SSP3, SSP4, or SSP5
*     POPSCEN     SSP1, SSP2, SSP3, SSP4, SSP5, UNMED2010, UNMED2012, UNMED2015, GIDD
*     OVERLAYPOP  0=keep GTAP base year pop level, 1=use SSP pop level for 2011
*     TASS        Aggregate land supply function: KELAS, LOGIST, HYPERB, INFTY
*     WASS        Aggregate water supply function: KELAS, LOGIST, HYPERB, INFTY
*     utility     CD, LES, ELES, AIDADS, CDE
*     NRITER      Best to keep 0 for the moment
*     savfFlag    Set to capFix for fixed foreign savings, set to capFlexGTAP for endogenous savf
*     NTMFlag     Set to 1 (for use of NTM) or 0
*
* --------------------------------------------------------------------------------------------------

$setGlobal wdir         %system.fp%
$setGlobal SSPMOD       OECD
$setGlobal SSPSCEN      SSP2
$setGlobal LABSCEN      SSP2
$setGlobal POPSCEN      SSP2
$setGlobal OVERLAYPOP   0
$setGlobal TASS         LOGIST
$setGlobal WASS         LOGIST
$setGlobal utility      CDE
$setGlobal NRITER       0
$setGlobal savfFlag     capFix
$setGlobal intRate      0.05
$setGlobal costCurve    HYPERB
$setGlobal NTMFlag      0

$iftheni "%simType%" == "compStat"

*  Define dynamic setup for a comparative static simulation

$macro PUTYEAR t.tl

sets
   tt       "Full time horizon"        / base, check, shock /
   t(tt)    "Simulation time horizon"  / base, check, shock /
   t0(t)    "Base year"                / base /
   v        "Vintages"                 / Old /
   vOld(v)  "Old vintage"              / Old /
   vNew(v)  "New vintage"              / Old /
;

parameters
   years(tt)      "Contains years in value (dynamic)"
   firstYear      "First year of full time horizon"
   baseYear       "Simulation base year"
   finalYear      "Simulation final year"
   gap(t)         "Time-step"
;

years(tt) = ord(tt) ;
gap(t)    = 1 ;
firstYear = smin(tt,years(tt)) ;
loop(t0, baseYear = years(t0) ; ) ;
finalYear = smax(t,years(t)) ;

Scalars
   ifDyn       Set to 1 for dynamic simulation         / 0 /
   ifCal       Set to 1 for dynamic calibration        / 0 /
   ifVint      Set to 1 for vintage capital spec       / 0 /
;

$elseifi "%simType%" == "RcvDyn"

*  Define dynamic setup for a dynamic simulation
*  tt must start in 2007 because of scenario file

$macro PUTYEAR years(t):4:0
sets
   tt       "Full time horizon"                / 1960*2100 /
   t(tt)    "Simulation time horizon"          / 2011, 2014, 2017, 2020, 2025, 2030 /
*  t(tt)    "Simulation time horizon"          / 2011*2050 /
   t0(t)    "Base year"                        / 2011 /
   tf0(t)   "Year for starting savf phaseout"  / 2030 /
   tfT(t)   "Year for finishing savf phaseout" / 2030 /
   v        "Vintages"                         / Old, New /
   vOld(v)  "Old vintage"                      / Old /
   vNew(v)  "New vintage"                      / New /
;

parameters
   years(tt)      "Contains years in value (dynamic)"
   firstYear      "First year of full time horizon"
   baseYear       "Simulation base year"
   finalYear      "Simulation final year"
   gap(t)         "Time-step"
;

firstYear = smin(tt, tt.val) ;
years(tt) = firstYear - 1 + ord(tt) ;
gap(t)    = 1$t0(t) + (years(t) - years(t-1))$(not t0(t)) ;
loop(t0, baseYear = years(t0) ; ) ;
finalYear = smax(t,years(t)) ;

Scalars
   ifVint      Set to 1 for vintage capital spec       / 1 /
   ifDyn       Set to 1 for dynamic simulation         / 1 /
   ifCal       Set to 1 for dynamic calibration        / %ifCal% /
;

$else

   Display "Wrong simulation type" ;
   Abort "Check listing file" ;

$endif

sets
   sim      / %SIMNAME% /
   ts(t)
;

alias(t,tsim) ;
alias(v,vp) ;
scalar nriter / %NRITER% / ;

Parameters
   riter
   iter
   nSubs
;

*  A number of other global options

scalars
   inScale     "Scale factor for input data"             / 1e-6 /
   outScale    "Scale factor for output data"            / 1e6 /
   popScale    "Scale factor for population"             / 1e-6 /
   lScale      "Scale factor for labor volumes"          / 1e-9 /
   eScale      "Scale factor for energy"                 / 1e-3 /
   watScale    "Scale factor for water"                  / 1e-12 /
   cScale      "Scale factor for emissions"              / 1e-3 /
   ifCEQ       "Convert emissions to CEq"                / 0 /
   ArmFlag     "Set to 1 for agent-based Armington"      / 1 /
   MRIO        "Set to 1 for MRIO model"                 / 0 /
   ifNRG       "Set to 1 to use energy volumes"          / 1 /
   intRate     "Interest rate"                           / %intRate% /
   ifNRGNest   "Set to 1 for energy nesting"             / 0 /
   ifMCP       "Set to 1 for MCP"                        / 1 /
   ifLandCET   "Set to 1 to use CET for land allocation" / 0 /
   ifSUB       "Set to 1 to substitute out equations"    / 1 /
   IFPOWER     "Set to 1 for power module"               / 0 /
   IFWATER     "Set to 1 for water module"               / 0 /
   ifAggTrade  "Set to 1 to aggregate trade in SAM"      / 0 /
   skLabgrwgt  "Set to between 0 and 1"                  / 0 /
;

*  CSV results go to this file

file
   fsam   / %odir%\%SIMNAME%SAM.csv /
   screen / con /
;

*  This file is optional--sometimes useful to debug model

file debug / %odir%\%SIMNAME%DBG.csv / ;
if(0,
   put debug ;
   put "Var,Region,Sector,Qual,Year,Value" / ;
   debug.pc=5 ;
   debug.nd=9 ;
) ;

*  CSV output options

scalars
   ifSAM "Flag for SAM CSV file" / 1 /
   ifSAMAppend "Flag to append to existing SAM CSV file" / 0 /
;

*  Start initializing the model--read the dimensions, parameters and the model specification

$include "%BASENAME%Sets.gms"
$include "%BASENAME%Prm.gms"
$include "model.gms"

savfFlag = %savfFlag% ;

*  Load the generic scenario initialization files

$iftheni "%simType%" == "compStat"

$include "compScen.gms"

$elseifi "%simType%" == "RcvDyn"

$include "initScen.gms"

$endif

*  Initialize and calibrate the model, implement the closure rules

$include "getData.gms"
$include "init.gms"
$include "cal.gms"

file emicsv / emi.csv / ;

if(0,
   put emicsv ;
   put "When,Emi,Input,Agent,Region,Level" / ;
   emicsv.pc=5 ;
   emicsv.nd=9 ;
   loop((em,r)$emn(em),
      loop(a0$nc_qo(em, a0, r),
         put "BeforeCAL", em.tl, "Tot", a0.tl, r.tl, nc_qo(em,a0,r) / ;
      ) ;
      loop((i0,a0)$nc_trad(em, i0, a0, r),
         put "BeforeCAL", em.tl, i0.tl, a0.tl, r.tl, nc_trad(em, i0, a0, r) / ;
      ) ;
      loop((fp,a0)$nc_endw(em, fp, a0, r),
         put "BeforeCAL", em.tl, fp.tl, a0.tl, r.tl, nc_endw(em, fp, a0, r) / ;
      ) ;

      loop((i0)$nc_hh(em, i0, r),
         put "BeforeCAL", em.tl, i0.tl, "hhd", r.tl, nc_hh(em, i0, r) / ;
      ) ;
   ) ;
   abort "Temp" ;
) ;

$include "closure.gms"

$iftheni.loadBaU "%simType%" == "CompStat"

   $$if exist "%odir%\%startNAME%.gdx" execute_loadpoint "%odir%\%startNAME%.gdx" ;
   $$if exist "%odir%\%startNAME%.gdx" ifInitFlag = 1 ;
   $$if exist "%odir%\%startNAME%.gdx" startYear = %startYear% ;

$elseifi.loadBaU "%simType%" == "RcvDyn"

*  Let's test the twist--the preference parameters are only calibrated in the BaU and thus need
*  to be read in for shock simulations (as they get crushed in the calibration)

   twt1("EastAsia",i,t)$(years(t) ge 2012)   = 0.02 ;
   tw1("EastAsia",i,aa,t)$(years(t) ge 2012) = 0.02 ;
   tw2("EastAsia",i,t)$(years(t) ge 2012)    = 0.02 ;

*  Load a baseline, if it exists

   if(ifDyn,

      if(ifCal eq 0,

*        Load the reference data

         execute_load "%odir%\%BaUName%.gdx", gl, xfd ;

         glBaU(r,t)       = gl.l(r,t) ;
         xfdBaU(r,fd,t)   = xfd.l(r,fd,t) ;

         xfd.lo(r,fd,t)   = -inf ;
         xfd.up(r,fd,t)   = +inf ;

*        Re-read the preference parameters -- testing of the twist

         execute_load "%odir%\%BaUName%.gdx", alphadt, alphamt, alphad, alpham, alphaw ;
      ) ;

*     Let's test the twist

*     Load values from the baseline if it exists

      $$if exist "%odir%\%startNAME%.gdx" execute_loadpoint "%odir%\%startNAME%.gdx" ;
      $$if exist "%odir%\%startNAME%.gdx" ifInitFlag = 1 ;
      $$if exist "%odir%\%startNAME%.gdx" startYear = %startYear% ;

   ) ;

*  Initialize the investment target assumptions

   $$if exist "%BaseName%InvTgt.gms" $$include "%BaseName%InvTgt.gms"

   set tint(r,t) Investment target intervals ;
   tint(r,t0) = yes ;
   tint(r,t)$(invTarget0(r,t) > 0) = yes ;
   display tint ;

   Parameter
      invTargetT(r,t)
   ;
   invTargetT(r,t) = na ;

   Parameter
      year0    "Start year of an interval"
      tgt0     "Ratio at beginning of an interval"
      tgt1     "Ratio at end of an interval"
      delT     "Year-gap of an interval"
   ;

   loop((r,t0,tsim)$tint(r,tsim),

      if(years(tsim) eq years(t0),

*        Beginning of time, initialize

         year0 = years(t0) ;
         tgt0  = 100*sum(inv, yfd.l(r,inv,t0)/gdpmp.l(r,t0)*(yfd0(r,inv)/gdpmp0(r))) ;

      else

*        tsim is the upper end of an interval

         delT = (years(tsim) - year0) ;
         tgt1 = invTarget0(r,tsim) ;

         loop(t$(years(t) > year0),

            if(years(t) <= years(tsim),
               invTargetT(r,t) = tgt1*(years(t) - year0)/delT
                               + tgt0*(years(tsim) - years(t))/delT
                               ;
            else
*              invTargetT(r,t) = tgt1 ;
            ) ;
         ) ;

*        Reset for next interval

         year0 = years(tsim) ;
         tgt0  = tgt1 ;
      ) ;
   ) ;

   display invTargetT ;

*  invTargetT(r,t) = na ;

*  Abort "temp" ;

*  Override foreign saving

   parameter savfT(t,r) "Capital account assumption" ;
   parameter rgdpT(r,t) "GDP scenario" ;
   rgdpT(r,t0) = rgdpmp0(r)*rgdpmp.l(r,t0) ;
   loop((t0,t)$(years(t) gt years(t0)),
      rgdpT(r,t) = rgdpT(r,t-1)*(rgdppcT(r,t)/rgdppcT(r,t-1))*(popT(r,"PTOTL",t)/popT(r,"PTOTL",t-1)) ;
      year0 = years(t0) ;
   ) ;
   savfT(t0,r) = savf.l(r,t0) ;
   loop((r,t0),
      if(abs(100*savfT(t0,r)/rgdpT(r,t0)) > 5,
*        Capital flows are greater than 5 percent of GDP, lower it to 5 by year 2030, and then to 0 by 2050
         loop(t$(years(t) gt years(t0)),
            if(years(t) le 2030,
               savfT(t,r) = rgdpT(r,t)*(savfT(t0,r)/rgdpT(r,t0) + (years(t) - years(t0))
                  * (sign(savfT(t0,r))*0.05 - savfT(t0,r)/rgdpT(r,t0))/(2030 - year0)) ;
            elseif (years(t) le 2050),
               savfT(t,r) = rgdpT(r,t)*(sign(savfT(t0,r))*0.05 + (years(t) - years("2030"))
                  * (0 - sign(savfT(t0,r))*0.05)/(2050 - 2030)) ;
            elseif (years(t) gt 2050),
               savfT(t,r) = 0 ;
            ) ;
         ) ;
      else
*        Capital flows are less than 5 percent of GDP, lower it to 0 by year 2050
         loop(t$(years(t) gt years(t0)),
            if (years(t) le 2050,
               savfT(t,r) = rgdpT(r,t)*(savfT(t0,r)/rgdpT(r,t0) + (years(t) - years(t0))
                  * (0 - savfT(t0,r)/rgdpT(r,t0))/(2050 - year0)) ;
            elseif (years(t) gt 2050),
               savfT(t,r) = 0 ;
            ) ;
         ) ;
      ) ;
   ) ;
   display rgdpT, savfT ;
*  Abort "Temp" ;

$endif.LoadBaU

*  Define cost curve assumptions

Parameters
   costTgt(r,a)      "Cost reduction target for each activity"
   costMin(r,a)      "Long-term cost minimum--costMin < costTgt"
   costTgtYear(r,a)  "Target year"
   ifCostCurve(r,a)  "Cost curve flag"
;

costTgt(r,a)     = na ;
costMin(r,a)     = na ;
costTgtYear(r,a) = na ;
ifCostCurve(r,a) = 0 ;

*  Set the solution options

options limrow=3, limcol=3, iterlim=1000, solprint=off ;
core.tolinfrep    = 1e-5 ;
coreBaU.tolinfrep = 1e-5 ;
coreDyn.tolinfrep = 1e-5 ;
