*$macro PUTYEAR years(t):4:0
$macro PUTYEAR t.tl
$setGlobal SIMNAME "AlterTax"
$setGlobal wDir  %baseName%/flt
$setGlobal inDir %baseName%/flt
$setGlobal oDir  %baseName%/alt

sets
   tt       "Time framework"       / base, check, shock /
   t(tt)    "Model time framework" / base, check, shock /
   t0(t)    "Initial year"         / base /
   ts(t)    "Simulation years"
;

alias(tsim,t) ;

parameters
   year0       "Base year (in value)"
   FirstYear   "First year (in value)"
   years(tt)   "Vector of years in value"
   gap(tt)     "Gap between model years"
   ifSUB       "Set to 1 to substitute equations" / 1 /
   ifMCP       "Set to 1 to solve using MCP"      / 1 /
   inScale     "Scale for input data"             / 1e-6 /
   xpScale     "Scale factor for output"          / 1 /
   ifCal       "For dynamic version of model"     / 0 /
   ifDyn       "For dynamic version of model"     / 0 /
   ifDebug     "To debug model"                   / 0 /
   ifCSV       "To save CSV cube"                 / %ifCSV% /
   niter(t)    "Number of iterations for solve"
   iter        "Iteration counter"
;

years(tt) = ord(tt) + 0 ;
loop(t0, year0 = years(t0) ; ) ;
FirstYear = year0 ;
gap(tt)   = 1 ;

niter(t) = 1 ;
niter(t)$sameas("shock",t) = %niter% ;

file screen / con / ;
put screen ;

$include "AlterTax/AlterTaxPrm.gms"
$include "model.gms"

* ------------------------------------------------------------------------------
*
*  OVERRIDE GTAP ELASTICITIES
*
* ------------------------------------------------------------------------------

work = 1.06 ;

sigmap(r,a)    = work ;
sigmav(r,a)    = work ;
sigmand(r,a)   = work ;
sigmai(r)      = work ;
sigmam(r,i,aa) = work ;
sigmaw(r,i)    = work ;
RoRFlag        = capFix ;

*  >>>>> Utility is set to CD in *Prm.gms file

$include "getData.gms"
$include "cal.gms"

*  Special for AFR

$iftheni %baseName% == "AFR"
   Parameter
      ave0(s,i,d)
      ave_wgt0(s,i,d)
   ;
   execute_load "AFRAVE.gdx", ave0, ave_wgt0 ;
$endif

options limrow = 3, limcol = 3, solprint=off ;
*options iterlim = 100 ;
gtap.scaleopt   = 1 ;
gtap.tolinfrep  = 1e-5 ;

loop(tsim,

   $$include "iterloop.gms"

   rs(r)    = yes ;
   ts(t)    = no ;
   ts(tsim) = yes ;

   if(sameas(tsim,"shock"),

*  -----------------------------------------------------------------------------
*
*  IMPOSE SHOCK(S)
*
*  -----------------------------------------------------------------------------

      $$include "%BaseName%Alt.gms"

   ) ;

   if(years(tsim) gt year0,

      $$batinclude "solve.gms" gtap

   ) ;

   put screen ;
   put / ;
   put "Walras: ", (walras.l/inScale):15:6 / ;
   putclose screen ;

) ;

file csv / "%baseName%/alt/%baseName%Alt.csv" / ;

if(%ifCSV%,
   put csv ;
   put "Variable,Region,Sector,Qualifier,Year,Value" / ;
   csv.pc=5 ;
   csv.nd=9 ;
   $$include    "postsim.gms"
) ;

$batinclude "saveData" shock

Execute_Unload "%oDir%/AlterTax.gdx" ;
