* ------------------------------------------------------------------------------
*
*     Options for creating CSV cubes
*
*     Users typically select years to output and CSV cubes to create
*
* ------------------------------------------------------------------------------

*  Set folder for Excel files

$setGlobal xclDir "v:\env10\10x10\doc\"

*  Options for CreatePivot file

$setGlobal indir     %oDir%
$setGlobal wdir      %system.fp%
$setGlobal modDir    "..\Model"
$setGlobal simTgt    BaU
$setGlobal regTgt    EastAsia
$setGlobal timeTgt   2011
$setGlobal actTgt    Agriculture-a

*  Select report years

$iftheni "%simType%" == "compStat"

   set tr(t) "Reporting years" / base, check, shock / ;

$elseifi "%simType%" == "RcvDyn"

   set tr(t) "Reporting years" / 2011, 2014, 2017, 2020, 2025, 2030 / ;

$endif

*  Select reporting activities (a subset of aga -- activities + aggregate activities

set aggaga(aga) "Activities to report" ;

*  Report all

aggaga(aga) = yes ;

scalar elyPrmNrgConv "Primary electric conversion factor" / 3 / ;

*  Pivot tables to create

*  List of tables

set tables /
   gdppop      "Macro data"
   factp       "Factor prices"
   kappah      "Household direct tax rate"
   rgovshr     "Government expenditures"
   savinv      "Savings investment balance"
   xp          "Output by activity"
   va          "Value added by activity and factor"
   inv         "Investment"
   emi         "Emissions"
   cost        "Production costs"
   ydecomp     "Growth decomposition"
   trade       "Trade by sector"
   bilat       "Bilateral trade"
   lab         "Labor demand"
   pow         "Power module"
   tot         "Terms of trade module"
   nrg         "Energy module"
   depl        "Depletion variables"
   shock       "For future use"
/ ;

*  Selected tables

set ifTab(tables) /
   gdppop      "Macro data"
   factp       "Factor prices"
*  kappah      "Household direct tax rate"
*  rgovshr     "Government expenditures"
   savinv      "Savings investment balance"
   xp          "Output by activity"
   va          "Value added by activity and factor"
   inv         "Investment"
*  emi         "Emissions"
   cost        "Production costs"
   ydecomp     "Growth decomposition"
   tot         "Terms of trade"
   trade       "Trade by sector"
   bilat       "Bilateral trade"
*  lab         "Labor demand"
*  pow         "Power sector variables"
*  nrg         "Energy module"
*  depl        "Depletion variables"
*  shock       "For future use"
/ ;
