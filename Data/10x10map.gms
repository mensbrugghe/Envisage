$include "GTAPSets9_2F.gms"

$setGlobal gtpDir    "V:/GTAP9/V9_2/"
$setGlobal GTAPBASE  "GSDF"
$setGlobal SSPFile   "../satAcct/sspScenV9.gdx"
$setGLobal AEZFile   "V:/GTAP9/SatAccounts/gtapaez18v9p2.gdx"
$setGlobal giddLab   "../SatAcct/giddLab.gdx"
$setGlobal giddProj  "../SatAcct/giddProj.gdx"
$setGlobal EnvElast  "../satAcct/EnvLinkElast.gdx"

$setGlobal DYN       ON
$setGlobal ifPower   OFF
$setGlobal ifWater   OFF
$setGlobal NCO2      ON
$setGlobal ELAST     OFF
$setGlobal LAB       OFF
$setGlobal BoP       ON
$setGlobal LU        OFF
$setGlobal SAVEMAP   LATEX
$setGlobal ifMRIO    OFF

*  Only used to override GTAP parameters for Env model

$setGlobal OVRRIDEGTAPARM 0
$setGlobal OVRRIDEGTAPINC 0

*  Select a labor option
*  Valid options are:
*     noLab  -- ignore employment volumes (all wages are set to 1)
*     agLab  -- calculate ag and non-ag employment (wages uniform within zones)
*     allLab -- assume employment data is correct for each sector (wages differ for each sector)
*     giddLab -- Use the GIDD labor data

$macro IFLABOR noLab

$onempty

sets

   i  "Commodities"   /
      GrainsCrops    "Grains and Crops"
      MeatLstk       "Livestock and Meat Products"
      Extraction     "Mining and Extraction"
      ProcFood       "Processed Food"
      TextWapp       "Textiles and Clothing"
      LightMnfc      "Light Manufacturing"
      HeavyMnfc      "Heavy Manufacturing"
      Util_Cons      "Utilities and Construction"
      TransComm      "Transport and Communication"
      OthServices    "Other Services"
      /

   r  "Regions" /
      Oceania        "Australia, New Zealand"
      EastAsia       "East Asia"
      SEAsia         "Southeast Asia"
      SouthAsia      "South Asia"
      NAmerica       "North America"
      LatinAmer      "Latin America"
      EU_28          "European Union 28"
      MENA           "Middle East and North Africa"
      SSA            "Sub-Saharan Africa"
      RestofWorld    "Rest of World"
      /

   fp  "Factors of production"  /
      UnSkLab        "Unskilled labor"
      SkLab          "Skilled labor"
      Capital        "Capital"
      Land           "Land"
      NatRes         "Natural resource"
      /

   l(fp)  "Labor factors" /
      UnSkLab        "Unskilled labor"
      SkLab          "Skilled labor"
      /
   ul(l) "Unksilled labor" /
      UnSkLab        "Unskilled labor"
      SkLab          "Skilled labor"
      /
   lr(l) "Reference labor for skill premium" /
      SkLab          "Skilled labor"
      /
   cap(fp) "Capital" /
      Capital        "Capital"
      /
   lnd(fp) "Land endowment" /
      Land           "Land"
      /
   nrs(fp) "Natural resource" /
      NatRes         "Natural resource"
      /
   wat(fp) "Water resource" /
      /

   ra "Aggregate regions for emission regimes and model output" /
      hic   "High-income countries"
      lmy   "Developing countries"
      wld   "World Total"
      /
   ia "Aggregate commodities for model output" /
      tagr-c      "Agriculture"
      tman-c      "Manufacturing"
      tsrv-c      "Services"
      toth-c      "Other"
      ttot-c      "Total"
      /
   aga  "Aggregate activities for model output" /
      tagr-a      "Agriculture"
      tman-a      "Manufacturing"
      tsrv-a      "Services"
      toth-a      "Other"
      ttot-a      "Total"
      /
   lagg "Aggregate labor for model output" /
      tot         "Total labor"
      /
;

*  !!!! Explicit assumption about diagonality

alias(i,a) ;

alias(m,i) ;

*  User defined parameters (i.e. not aggregated by aggregation facility)
*  NEW -- New region specific

Parameter
   etrae1(fp,r) "CET transformation elasticities for factor allocation"
;

parameter etrae0(fp) "CET transformation elasticities for factor allocation" /
   UnSkLab   inf
   SkLab     inf
   Capital   inf
   Land     1.00
   NatRes   0.001
/ ;

etrae1(fp,r) = etrae0(fp) ;

*  NEW -- MAKE ELASTICITIES

Parameter
   etraq1(a,r)       "MAKE CET Elasticity"
   esubq1(i,r)       "MAKE CES Elasticity"
;
etraq1(a,r) = 5 ;
esubq1(i,r) = inf ;

*  NEW -- EXPENDITURE ELASTICITIES

Parameter
   esubg1(r)         "Government expenditure CES elasticity"
   esubi1(r)         "Investment expenditure CES elasticity"
   esubs1(m)         "Transport margins CES elasticity"
;

esubg1(r) = 1 ;
esubi1(r) = 0 ;
esubs1(m) = 1 ;

*  This zonal mapping is for labor/volume splits between agriculture and other

set mapz(z,a)  "Mapping of activities to zones" /
   rur.(GrainsCrops,MeatLstk)
/ ;

mapz("urb",a) = not mapz("rur",a) ;
mapz("nsg",a) = yes ;

* >>>> MUST INSERT RESIDUAL REGION (ONLY ONE)

set rres(r) "Residual region" /

   NAmerica

/ ;

* >>>> MUST INSERT MUV REGIONS (ONE OR MORE)

set rmuv(r) "MUV regions" /

   Oceania
   EastAsia
   NAmerica
   EU_28

/ ;

set mapt(a) "Merge land and capital payments in the following sectors" /

/ ;

set mapn(a) "Merge natl. res. and capital payments in the following sectors" /

/ ;

*  MAPPINGS TO GTAP

set mapa(acts,a) /
   pdr . GrainsCrops
   wht . GrainsCrops
   gro . GrainsCrops
   v_f . GrainsCrops
   osd . GrainsCrops
   c_b . GrainsCrops
   pfb . GrainsCrops
   ocr . GrainsCrops
   ctl . MeatLstk
   oap . MeatLstk
   rmk . MeatLstk
   wol . MeatLstk
   frs . Extraction
   fsh . Extraction
   coa . Extraction
   oil . Extraction
   gas . Extraction
   omn . Extraction
   cmt . MeatLstk
   omt . MeatLstk
   vol . ProcFood
   mil . ProcFood
   pcr . GrainsCrops
   sgr . ProcFood
   ofd . ProcFood
   b_t . ProcFood
   tex . TextWapp
   wap . TextWapp
   lea . LightMnfc
   lum . LightMnfc
   ppp . LightMnfc
   p_c . HeavyMnfc
   crp . HeavyMnfc
   nmm . HeavyMnfc
   i_s . HeavyMnfc
   nfm . HeavyMnfc
   fmp . LightMnfc
   mvh . LightMnfc
   otn . LightMnfc
   ele . HeavyMnfc
   ome . HeavyMnfc
   omf . LightMnfc
   ely . Util_Cons
   gdt . Util_Cons
   wtr . Util_Cons
   cns . Util_Cons
   trd . TransComm
   otp . TransComm
   wtp . TransComm
   atp . TransComm
   cmn . TransComm
   ofi . OthServices
   isr . OthServices
   obs . OthServices
   ros . OthServices
   osg . OthServices
   dwe . OthServices
/ ;

set mapr(reg,r) /
   aus . Oceania
   nzl . Oceania
   xoc . Oceania
   chn . EastAsia
   hkg . EastAsia
   jpn . EastAsia
   kor . EastAsia
   mng . EastAsia
   twn . EastAsia
   xea . EastAsia
   brn . EastAsia
   khm . SEAsia
   idn . SEAsia
   lao . SEAsia
   mys . SEAsia
   phl . SEAsia
   sgp . SEAsia
   tha . SEAsia
   vnm . SEAsia
   xse . SEAsia
   bgd . SouthAsia
   ind . SouthAsia
   npl . SouthAsia
   pak . SouthAsia
   lka . SouthAsia
   xsa . SouthAsia
   can . NAmerica
   usa . NAmerica
   mex . NAmerica
   xna . NAmerica
   arg . LatinAmer
   bol . LatinAmer
   bra . LatinAmer
   chl . LatinAmer
   col . LatinAmer
   ecu . LatinAmer
   pry . LatinAmer
   per . LatinAmer
   ury . LatinAmer
   ven . LatinAmer
   xsm . LatinAmer
   cri . LatinAmer
   gtm . LatinAmer
   hnd . LatinAmer
   nic . LatinAmer
   pan . LatinAmer
   slv . LatinAmer
   xca . LatinAmer
   dom . LatinAmer
   jam . LatinAmer
   pri . LatinAmer
   tto . LatinAmer
   xcb . LatinAmer
   aut . EU_28
   bel . EU_28
   cyp . EU_28
   cze . EU_28
   dnk . EU_28
   est . EU_28
   fin . EU_28
   fra . EU_28
   deu . EU_28
   grc . EU_28
   hun . EU_28
   irl . EU_28
   ita . EU_28
   lva . EU_28
   ltu . EU_28
   lux . EU_28
   mlt . EU_28
   nld . EU_28
   pol . EU_28
   prt . EU_28
   svk . EU_28
   svn . EU_28
   esp . EU_28
   swe . EU_28
   gbr . EU_28
   che . RestofWorld
   nor . RestofWorld
   xef . RestofWorld
   alb . RestofWorld
   bgr . EU_28
   blr . RestofWorld
   hrv . EU_28
   rou . EU_28
   rus . RestofWorld
   ukr . RestofWorld
   xee . RestofWorld
   xer . RestofWorld
   kaz . RestofWorld
   kgz . RestofWorld
   tjk . RestofWorld
   xsu . RestofWorld
   arm . RestofWorld
   aze . RestofWorld
   geo . RestofWorld
   bhr . MENA
   irn . MENA
   isr . MENA
   jor . MENA
   kwt . MENA
   omn . MENA
   qat . MENA
   sau . MENA
   tur . MENA
   are . MENA
   xws . MENA
   egy . MENA
   mar . MENA
   tun . MENA
   xnf . MENA
   ben . SSA
   bfa . SSA
   cmr . SSA
   civ . SSA
   gha . SSA
   gin . SSA
   nga . SSA
   sen . SSA
   tgo . SSA
   xwf . SSA
   xcf . SSA
   xac . SSA
   eth . SSA
   ken . SSA
   mdg . SSA
   mwi . SSA
   mus . SSA
   moz . SSA
   rwa . SSA
   tza . SSA
   uga . SSA
   zmb . SSA
   zwe . SSA
   xec . SSA
   bwa . SSA
   nam . SSA
   zaf . SSA
   xsc . SSA
   xtw . RestofWorld
/ ;

set mapf(endw, fp) /
   ag_othlowsk  . UnSkLab
   service_shop . UnSkLab
   clerks       . UnSkLab
   tech_aspros  . SkLab
   off_mgr_pros . SkLab
   Capital      . Capital
   Land         . Land
   NatlRes      . NatRes
/ ;

set mapl(lg, l) "Mapping to GIDD labor database" /
   nsk.UnSkLab
   skl.SkLab
/ ;

* ----------------------------------------------------------------------------------------
*
*     Section dealing with model aggregations (to handle non-diagonal make matrix)
*
* ----------------------------------------------------------------------------------------

*  Model aggregation(s)

set actf "Model activities" /
      Agriculture    "Agriculture"
      Extraction     "Mining and Extraction"
      ProcFood       "Processed Food"
      TextWapp       "Textiles and Clothing"
      LightMnfc      "Light Manufacturing"
      HeavyMnfc      "Heavy Manufacturing"
      Util_Cons      "Utilities and Construction"
      TransComm      "Transport and Communication"
      OthServices    "Other Services"
/ ;

set commf "Model commodities" /
      GrainsCrops    "Grains and Crops"
      MeatLstk       "Livestock and Meat Products"
      Extraction     "Mining and Extraction"
      ProcFood       "Processed Food"
      TextWapp       "Textiles and Clothing"
      LightMnfc      "Light Manufacturing"
      HeavyMnfc      "Heavy Manufacturing"
      Util_Cons      "Utilities and Construction"
      TransComm      "Transport and Communication"
      OthServices    "Other Services"
/ ;

set mapaf(i, actf) "Mapping from original to modeled activities" /
      GrainsCrops  .Agriculture
      MeatLstk     .Agriculture
      Extraction   .Extraction
      ProcFood     .ProcFood
      TextWapp     .TextWapp
      LightMnfc    .LightMnfc
      HeavyMnfc    .HeavyMnfc
      Util_Cons    .Util_Cons
      TransComm    .TransComm
      OthServices  .OthServices
/ ;

set mapif(i, commf) "Mapping from original to modeled commodities" /
      GrainsCrops  .GrainsCrops
      MeatLstk     .MeatLstk
      Extraction   .Extraction
      ProcFood     .ProcFood
      TextWapp     .TextWapp
      LightMnfc    .LightMnfc
      HeavyMnfc    .HeavyMnfc
      Util_Cons    .Util_Cons
      TransComm    .TransComm
      OthServices  .OthServices
/ ;

* >>>> MUST INSERT MUV COMMODITIES (ONE OR MORE)
*      !!!! Be careful of compatibility with modeled imuv
*           This one is intended for AlterTax

set imuvf(commf) "MUV commodities" /

   ProcFood
   TextWapp
   LightMnfc
   HeavyMnfc

/ ;

*  >>>> Aggregation of modeled sectors and regions

set mapia(ia,commf)"mapping of individual comm to aggregate comm" /
   tagr-c.GrainsCrops
   tagr-c.MeatLstk
   tman-c.ProcFood
   tman-c.TextWapp
   tman-c.LightMnfc
   tman-c.HeavyMnfc
   toth-c.Extraction
   tsrv-c.Util_Cons
   tsrv-c.TransComm
   tsrv-c.OthServices
/ ;
mapia("ttot-c",commf) = yes ;

set mapaga(aga,actf)"mapping of individual comm to aggregate comm" /
   tagr-a.Agriculture
   tman-a.ProcFood
   tman-a.TextWapp
   tman-a.LightMnfc
   tman-a.HeavyMnfc
   toth-a.Extraction
   tsrv-a.Util_Cons
   tsrv-a.TransComm
   tsrv-a.OthServices
/ ;
mapaga("ttot-a",actf) = yes ;

set mapra(ra,r) "Mapping of model regions to aggregate regions" /
   hic.(Oceania, NAmerica, EU_28)
/ ;
mapra("lmy", r)$(not mapra("hic",r)) = yes ;
mapra("wld", r) = yes ;

set maplagg(lagg,l) "Mapping of model labor to aggregate labor" ;
maplagg("Tot",l) = yes ;

set sortOrder / sort1*sort500 / ;
set mapRegSort(sortOrder,r) /

   sort1 .  Oceania
   sort2 .  EastAsia
   sort3 .  SEAsia
   sort4 .  SouthAsia
   sort5 .  NAmerica
   sort6 .  LatinAmer
   sort7 .  EU_28
   sort8 .  MENA
   sort9 .  SSA
   sort10.  RestofWorld

/ ;

set mapActSort(sortOrder,actf) /

   sort1   .Agriculture
   sort2   .Extraction
   sort3   .ProcFood
   sort4   .TextWapp
   sort5   .LightMnfc
   sort6   .HeavyMnfc
   sort7   .Util_Cons
   sort8   .TransComm
   sort9   .OthServices

/ ;

set mapCommSort(sortOrder,commf) /
   sort1   .GrainsCrops
   sort2   .MeatLstk
   sort3   .Extraction
   sort4   .ProcFood
   sort5   .TextWapp
   sort6   .LightMnfc
   sort7   .HeavyMnfc
   sort8   .Util_Cons
   sort9   .TransComm
   sort10  .OthServices
/ ;

* ----------------------------------------------------------------------------------------
*
*     Envisage section
*
* ----------------------------------------------------------------------------------------

*  >>>> Activity related sets and subsets

set acr(actf)  "Crop activities" /
/ ;

set alv(actf)  "Livestock activities" /
/ ;

set agr(actf)  "Agricultural activities" /
      Agriculture    "Agriculture"
/ ;

set man(actf)  "Manufacturing activities" /
      Extraction     "Mining and Extraction"
      ProcFood       "Processed Food"
      TextWapp       "Textiles and Clothing"
      LightMnfc      "Light Manufacturing"
      HeavyMnfc      "Heavy Manufacturing"
/ ;

set aenergy(actf) "Energy activities" /
      Extraction     "Mining and Extraction"
      Util_Cons      "Utilities and Construction"
/ ;

set affl(actf) "Fossil fuel activities" /
      Extraction     "Mining and Extraction"
/ ;

set aw(actf)   "Water services activities" /
/ ;

set elya(actf) "Power activities" /
/ ;

set etd(actf)  "Electricity transmission and distribution activities" /
/ ;

set primElya(actf) "Primary power activities" /
/ ;

set pb   "Power bundles" /
   othp     "Other power"
/ ;

set mappow(pb,elya) "Mapping of power activities to power bundles" /
/ ;

*  >>>> Commodity sets and subsets

set frt(commf) "Fertilizer commodities" /
/ ;

set feed(commf) "Feed commodities" /
/ ;

set iw(commf) "Water services commodities" /
/ ;

set e(commf) "Energy commodities" /
$ontext
      Extraction     "Mining and Extraction"
      Util_Cons      "Utilities and Construction"
$offtext
/ ;

set elyc(commf) "Electricity commodities" /
      Util_Cons      "Utilities and Construction"
/ ;

set f(commf) "Fuel commodities" /
*     Extraction     "Mining and Extraction"
/ ;

*  This zonal mapping is for labor market segmentation in final model

set mapzf(z,actf)  "Mapping of activities to zones" /
   rur.Agriculture
/ ;

mapzf("urb",actf) = not mapzf("rur",actf) ;
mapzf("nsg",actf) = yes ;

* >>>> Household commodity section

set k "Household commodities" /
      GrainsCrops    "Grains and Crops"
      MeatLstk       "Livestock and Meat Products"
      ProcFood       "Processed Food"
      TextWapp       "Textiles and Clothing"
      LightMnfc      "Light Manufacturing"
      HeavyMnfc      "Heavy Manufacturing"
      TransComm      "Transport and Communication"
      OthServices    "Other Services"
      Energy         "Energy"
/ ;

set fud(k) "Household food commodities" /
      GrainsCrops    "Grains and Crops"
      MeatLstk       "Livestock and Meat Products"
      ProcFood       "Processed Food"
/ ;

set mapk(commf,k) "Mapping from i to k" /
      GrainsCrops  .GrainsCrops
      MeatLstk     .MeatLstk
      Extraction   .Energy
      ProcFood     .ProcFood
      TextWapp     .TextWapp
      LightMnfc    .LightMnfc
      HeavyMnfc    .HeavyMnfc
      Util_Cons    .Energy
      TransComm    .TransComm
      OthServices  .OthServices
/ ;

set lb "Land bundles" /
   agr         "Agriculture"
/ ;

set lb1(lb) "First land bundle" /
   agr         "Livestock"
/ ;

set maplb(lb,actf) "Mapping of activities to land bundles" /
   agr         .Agriculture
/ ;

*  !!!! TO BE REVIEWED

set lb0   "Default land bundles" / lb1*lb1 / ;
set maplb0(lb, lb0) "Mapping of land bundles to original" /
   agr.lb1
/ ;

set wbnd "Aggregate water markets" /
   N_A         "N_A"
/ ;

set wbnd1(wbnd) "Top level water markets" /
/ ;

set wbnd2(wbnd) "Second level water markets" /
/ ;

set wbndEx(wbnd) "Exogenous water markets" /
/ ;

set mapw1(wbnd,wbnd) "Mapping of first level water bundles" /
/ ;

set mapw2(wbnd,actf) "Mapping of second level water bundle" /
/ ;

set wbnda(wbnd) "Water bundles mapped one-to-one to activities" /
/ ;

set wbndi(wbnd) "Water bundles mapped to aggregate output" /
/ ;

set NRG "Energy bundles used in model" /
   coa         "Coal"
   oil         "Oil"
   gas         "Gas"
   ely         "Electricity"
/ ;

set coa(NRG) "Coal bundle used in model" /
   coa         "Coal"
/ ;

set oil(NRG) "Oil bundle used in model" /
   oil         "Oil"
/ ;

set gas(NRG) "Gas bundle used in model" /
   gas         "Gas"
/ ;

set ely(NRG) "Electricity bundle used in model" /
   ely         "Electricity"
/ ;

set mape(NRG,e) "Mapping of energy commodities to energy bundles" /
*  oil         .Extraction
*  ely         .Util_Cons
/ ;

*  >>>> Sets required for 'growing' labor by skill

set skl(l)  "Skill types for labor growth assumptions" /
   SkLab
/ ;

set elev / elev0*elev3 / ;

set educMap(r,l,elev) "Mapping of skills to education levels" ;

*  Use GIDD definitions (i.e. "elev3" has no meaning)

educMap(r,"UnSkLab","elev0")$mapra("lmy",r) = yes ;
educMap(r,"SkLab","elev1")$mapra("lmy",r)   = yes ;
educMap(r,"SkLab","elev2")$mapra("lmy",r)   = yes ;

educMap(r,"UnSkLab","elev0")$mapra("hic",r) = yes ;
educMap(r,"UnSkLab","elev1")$mapra("hic",r) = yes ;
educMap(r,"SkLab","elev2")$mapra("hic",r)   = yes ;

$iftheni "%LU%" == "ON"


$endif

$offempty
