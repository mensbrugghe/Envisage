$onempty

set a0 "Original activities" /
   GrainsCrops       "Grains and Crops"
   MeatLstk          "Livestock and Meat Products"
   Extraction        "Mining and Extraction"
   ProcFood          "Processed Food"
   TextWapp          "Textiles and Clothing"
   LightMnfc         "Light Manufacturing"
   HeavyMnfc         "Heavy Manufacturing"
   Util_Cons         "Utilities and Construction"
   TransComm         "Transport and Communication"
   OthServices       "Other Services"
/ ;

set i0(a0) "Original commodities" /
   GrainsCrops       "Grains and Crops"
   MeatLstk          "Livestock and Meat Products"
   Extraction        "Mining and Extraction"
   ProcFood          "Processed Food"
   TextWapp          "Textiles and Clothing"
   LightMnfc         "Light Manufacturing"
   HeavyMnfc         "Heavy Manufacturing"
   Util_Cons         "Utilities and Construction"
   TransComm         "Transport and Communication"
   OthServices       "Other Services"
/ ;

* --------------------------------------------------------------------
*
*   USER CAN MODIFY ACTIVITY/COMMODITY AGGREGATION
*   USER MUST FILL IN SUBSETS WHERE NEEDED
*
* --------------------------------------------------------------------


* >>>> PLACE TO CHANGE ACTIVITIES, i.e. model activities

set act "Modeled activities" /
   Agriculture-a     "Agriculture"
   Extraction-a      "Mining and Extraction"
   ProcFood-a        "Processed Food"
   TextWapp-a        "Textiles and Clothing"
   LightMnfc-a       "Light Manufacturing"
   HeavyMnfc-a       "Heavy Manufacturing"
   Util_Cons-a       "Utilities and Construction"
   TransComm-a       "Transport and Communication"
   OthServices-a     "Other Services"
/ ;

* >>>> PLACE TO CHANGE COMMODITIES, i.e. model commodities

set comm "Modeled commodities" /
   GrainsCrops-c     "Grains and Crops"
   MeatLstk-c        "Livestock and Meat Products"
   Extraction-c      "Mining and Extraction"
   ProcFood-c        "Processed Food"
   TextWapp-c        "Textiles and Clothing"
   LightMnfc-c       "Light Manufacturing"
   HeavyMnfc-c       "Heavy Manufacturing"
   Util_Cons-c       "Utilities and Construction"
   TransComm-c       "Transport and Communication"
   OthServices-c     "Other Services"
/ ;

set endw "Modeled production factors" /
   Land              "Land"
   Capital           "Capital"
   unSkLab           "Unskilled labor"
   SkLab             "Skilled labor"
   NatRes            "Natural resource"
/ ;

set stdlab "Standard SAM labels" /
   TRD               "Trade account"
   hhd               "Household"
   gov               "Government"
   inv               "Investment"
   deprY             "Depreciation"
   tmg               "Trade margins"
   itax              "Indirect tax"
   ptax              "Production tax"
   mtax              "Import tax"
   etax              "Export tax"
   vtax              "Taxes on factors of production"
   vsub              "Subsidies on factors of production"
   wtax              "Waste tax"
   ntmY              "NTM revenue"
   dtax              "Direct taxation"
   ctax              "Carbon tax"
   bop               "Balance of payments account"
   tot               "Total for row/column sums"
/ ;

set findem(stdlab) "Final demand accounts" /
   hhd               "Household"
   gov               "Government"
   inv               "Investment"
   tmg               "Trade margins"
/ ;

set reg "Modeled regions" /
   Oceania           "Australia, New Zealand"
   EastAsia          "East Asia"
   SEAsia            "Southeast Asia"
   SouthAsia         "South Asia"
   NAmerica          "North America"
   LatinAmer         "Latin America"
   EU_28             "European Union 28"
   MENA              "Middle East and North Africa"
   SSA               "Sub-Saharan Africa"
   RestofWorld       "Rest of World"
/ ;

set is "SAM accounts for aggregated SAM" /

*  User-defined activities

   set.act

*  User-defined commodities

   set.comm

*  User-defined factors

   set.endw

*  Standard SAM accounts

   set.stdlab

*  User-defined regions

   set.reg

/ ;

alias(is, js) ;

set aa(is) "Armington agents" /

   set.act

   set.findem

/ ;

set a(aa) "Activities" /

   set.act

/ ;

set i(is) "Commodities" /

   set.comm

/ ;

alias(i, j) ;

set fp(is) "Factors of production" /

   set.endw

/ ;

set l(fp) "Labor factors" /

   unSkLab           "Unskilled labor"
   SkLab             "Skilled labor"
/ ;

set ul(l) "Unskilled labor" /

   unSkLab           "Unskilled labor"
   SkLab             "Skilled labor"
/ ;

set sl(l) "Skilled labor" /

/ ;

set lr(l) "Reference labor for skill premium" /

   SkLab             "Skilled labor"
/ ;

set cap(fp) "Capital" /

   Capital           "Capital"
/ ;

set lnd(fp) "Land endowment" /

   Land              "Land"
/ ;

set nrs(fp) "Natural resource" /

   NatRes            "Natural resource"
/ ;

set wat(fp) "Water resource" /

/ ;

* >>>> CAN MODIFY MOBILE VS. NON-MOBILE FACTORS

set fm(fp) "Mobile factors" /

   Land              "Land"
   Capital           "Capital"
   unSkLab           "Unskilled labor"
   SkLab             "Skilled labor"
   NatRes            "Natural resource"
/ ;

set fnm(fp) "Non-mobile factors" /

/ ;

set fd(aa) "Domestic final demand agents" /

   hhd               "Household"
   gov               "Government"
   inv               "Investment"
/ ;

set h(fd) "Households" /
   hhd               "Household"
/ ;

set gov(fd) "Government" /
   gov               "Government"
/ ;

set inv(fd) "Investment" /
   inv               "Investment"
/ ;

set fdc(fd) "Final demand accounts with CES expenditure function" /
   gov               "Government"
   inv               "Investment"
/ ;

set r(is) "Regions" /

   set.reg

/ ;

alias(r, rp) ; alias(r, s) ; alias(r, d) ;

* >>>> MUST INSERT RESIDUAL REGION (ONLY ONE)

set rres(r) "Residual region" /
   NAmerica          "North America"
/ ;

* >>>> MUST INSERT MUV REGIONS (ONE OR MORE)

set rmuv(r) "MUV regions" /
   Oceania           "Australia, New Zealand"
   EastAsia          "East Asia"
   NAmerica          "North America"
   EU_28             "European Union 28"
/ ;

* >>>> MUST INSERT MUV COMMODITIES (ONE OR MORE)

set imuv(i) "MUV commodities" /
   ProcFood-c
   TextWapp-c
   LightMnfc-c
   HeavyMnfc-c
/ ;

set ia "Aggregate commodities for model output" /
   GrainsCrops-c     "Grains and Crops"
   MeatLstk-c        "Livestock and Meat Products"
   Extraction-c      "Mining and Extraction"
   ProcFood-c        "Processed Food"
   TextWapp-c        "Textiles and Clothing"
   LightMnfc-c       "Light Manufacturing"
   HeavyMnfc-c       "Heavy Manufacturing"
   Util_Cons-c       "Utilities and Construction"
   TransComm-c       "Transport and Communication"
   OthServices-c     "Other Services"

   tagr-c            "Agriculture"
   tman-c            "Manufacturing"
   tsrv-c            "Services"
   toth-c            "Other"
   ttot-c            "Total"
/ ;

set mapi(ia,i) "Mapping for aggregate commodities" /
   GrainsCrops-c .GrainsCrops-c
   MeatLstk-c    .MeatLstk-c
   Extraction-c  .Extraction-c
   ProcFood-c    .ProcFood-c
   TextWapp-c    .TextWapp-c
   LightMnfc-c   .LightMnfc-c
   HeavyMnfc-c   .HeavyMnfc-c
   Util_Cons-c   .Util_Cons-c
   TransComm-c   .TransComm-c
   OthServices-c .OthServices-c

   tagr-c        .GrainsCrops-c
   tagr-c        .MeatLstk-c
   tman-c        .ProcFood-c
   tman-c        .TextWapp-c
   tman-c        .LightMnfc-c
   tman-c        .HeavyMnfc-c
   tsrv-c        .Util_Cons-c
   tsrv-c        .TransComm-c
   tsrv-c        .OthServices-c
   toth-c        .Extraction-c
   ttot-c        .GrainsCrops-c
   ttot-c        .MeatLstk-c
   ttot-c        .Extraction-c
   ttot-c        .ProcFood-c
   ttot-c        .TextWapp-c
   ttot-c        .LightMnfc-c
   ttot-c        .HeavyMnfc-c
   ttot-c        .Util_Cons-c
   ttot-c        .TransComm-c
   ttot-c        .OthServices-c
/ ;

set iaa(ia) "Aggregate commodities only" ;
loop((i,ia)$(not sameas(i,ia)), iaa(ia) = yes ; ) ;

set aga "Aggregate activities for model output" /
   Extraction-a      "Mining and Extraction"
   ProcFood-a        "Processed Food"
   TextWapp-a        "Textiles and Clothing"
   LightMnfc-a       "Light Manufacturing"
   HeavyMnfc-a       "Heavy Manufacturing"
   Util_Cons-a       "Utilities and Construction"
   TransComm-a       "Transport and Communication"
   OthServices-a     "Other Services"
   Agriculture-a     "Agriculture"

   tagr-a            "Agriculture"
   tman-a            "Manufacturing"
   tsrv-a            "Services"
   toth-a            "Other"
   ttot-a            "Total"
/ ;

set mapaga(aga,a) "Mapping for aggregate activities" /
   Extraction-a  .Extraction-a
   ProcFood-a    .ProcFood-a
   TextWapp-a    .TextWapp-a
   LightMnfc-a   .LightMnfc-a
   HeavyMnfc-a   .HeavyMnfc-a
   Util_Cons-a   .Util_Cons-a
   TransComm-a   .TransComm-a
   OthServices-a .OthServices-a
   Agriculture-a .Agriculture-a

   tagr-a        .Agriculture-a
   tman-a        .ProcFood-a
   tman-a        .TextWapp-a
   tman-a        .LightMnfc-a
   tman-a        .HeavyMnfc-a
   tsrv-a        .Util_Cons-a
   tsrv-a        .TransComm-a
   tsrv-a        .OthServices-a
   toth-a        .Extraction-a
   ttot-a        .Extraction-a
   ttot-a        .ProcFood-a
   ttot-a        .TextWapp-a
   ttot-a        .LightMnfc-a
   ttot-a        .HeavyMnfc-a
   ttot-a        .Util_Cons-a
   ttot-a        .TransComm-a
   ttot-a        .OthServices-a
   ttot-a        .Agriculture-a
/ ;

set agaa(aga) "Aggregate activities only" ;
loop((a,aga)$(not sameas(a,aga)), agaa(aga) = yes ; ) ;

set ra "Aggregate regions for emission regimes and model output" /
   Oceania           "Australia, New Zealand"
   EastAsia          "East Asia"
   SEAsia            "Southeast Asia"
   SouthAsia         "South Asia"
   NAmerica          "North America"
   LatinAmer         "Latin America"
   EU_28             "European Union 28"
   MENA              "Middle East and North Africa"
   SSA               "Sub-Saharan Africa"
   RestofWorld       "Rest of World"

   hic               "High-income countries"
   lmy               "Developing countries"
   wld               "World Total"
/ ;

set mapr(ra,r) "Mapping for aggregate regions" /
   Oceania       .Oceania
   EastAsia      .EastAsia
   SEAsia        .SEAsia
   SouthAsia     .SouthAsia
   NAmerica      .NAmerica
   LatinAmer     .LatinAmer
   EU_28         .EU_28
   MENA          .MENA
   SSA           .SSA
   RestofWorld   .RestofWorld

   hic           .Oceania
   hic           .NAmerica
   hic           .EU_28
   lmy           .EastAsia
   lmy           .SEAsia
   lmy           .SouthAsia
   lmy           .LatinAmer
   lmy           .MENA
   lmy           .SSA
   lmy           .RestofWorld
   wld           .Oceania
   wld           .EastAsia
   wld           .SEAsia
   wld           .SouthAsia
   wld           .NAmerica
   wld           .LatinAmer
   wld           .EU_28
   wld           .MENA
   wld           .SSA
   wld           .RestofWorld
/ ;

set rra(ra) "Aggregate regions only" ;
loop((r,ra)$(not sameas(r,ra)), rra(ra) = yes ; ) ;

set lagg "Aggregate labor for output" /
   unSkLab           "Unskilled labor"
   SkLab             "Skilled labor"

   tot               "Total labor"
/ ;

set mapl(lagg,l) "Mapping for aggregate regions" /
   unSkLab       .unSkLab
   SkLab         .SkLab

   tot           .unSkLab
   tot           .SkLab
/ ;

* >>>> CAN CHANGE ACTIVITY MAPPING

set mapa0(a0, a) "Mapping from original activities to new activities" /
   GrainsCrops  .Agriculture-a
   MeatLstk     .Agriculture-a
   Extraction   .Extraction-a
   ProcFood     .ProcFood-a
   TextWapp     .TextWapp-a
   LightMnfc    .LightMnfc-a
   HeavyMnfc    .HeavyMnfc-a
   Util_Cons    .Util_Cons-a
   TransComm    .TransComm-a
   OthServices  .OthServices-a
/ ;

* >>>> CAN CHANGE COMMODITY MAPPING

set mapi0(i0, i) "Mapping from original commodities to new commodities" /
   GrainsCrops  .GrainsCrops-c
   MeatLstk     .MeatLstk-c
   Extraction   .Extraction-c
   ProcFood     .ProcFood-c
   TextWapp     .TextWapp-c
   LightMnfc    .LightMnfc-c
   HeavyMnfc    .HeavyMnfc-c
   Util_Cons    .Util_Cons-c
   TransComm    .TransComm-c
   OthServices  .OthServices-c
/ ;

set var "GDP variables" /
   gdp               "GDP in million $2007 MER"
   GDPpc             "GDP per capita in $2007 MER"
   gdpppp05          "GDP in $2005 PPP"
   gdppcppp05        "GDP per capita in $2005"
/ ;

set scen "Scenarios" /
   SSP1              "Sustainable development"
   SSP2              "Middle of the road"
   SSP3              "Regional rivalry"
   SSP4              "Inequality"
   SSP5              "Fossil-fueled development"
   UNMED2010         "UN Population Division Medium Variant 2010 revision"
   UNMED2012         "UN Population Division Medium Variant 2012 revision"
   UNMED2015         "UN Population Division Medium Variant 2015 revision"
   UNMED2017         "UN Population Division Medium Variant 2017 revision"
   GIDD              "GIDD population projection"
/ ;

set ssp(scen) "SSP Scenarios" /
   SSP1              "Sustainable development"
   SSP2              "Middle of the road"
   SSP3              "Regional rivalry"
   SSP4              "Inequality"
   SSP5              "Fossil-fueled development"
/ ;

set mod "Models" /
   OECD              "OECD-based SSPs"
   IIASA             "IIASA-based SSPs"
/ ;

set tranche "Population cohorts" /
   PLT15             "Population less than 15"
   P1564             "Population aged 15 to 64"
   P65UP             "Population 65 and over"
   PTOTL             "Total population"
/ ;

set trs(tranche) "Population cohorts" /
   PLT15             "Population less than 15"
   P1564             "Population aged 15 to 64"
   P65UP             "Population 65 and over"
/ ;

set sex   "Gender categories" /
   MAL               "Male"
   FEM               "Female"
   BOTH              "M+F"
/ ;

set sexx(sex) "Gender categories excl total" /
   MAL               "Male"
   FEM               "Female"
/ ;

set ed "Combined SSP/GIDD education levels" /
   elev0             "ENONE/EDUC0_6"
   elev1             "EPRIM/EDUC6_9"
   elev2             "ESECN/EDUC9UP"
   elev3             "ETERT"
   elevt             "Total"
/ ;

set edx(ed) "Education levels excluding totals" /
   elev0             "ENONE/EDUC0_6"
   elev1             "EPRIM/EDUC6_9"
   elev2             "ESECN/EDUC9UP"
   elev3             "ETERT"
/ ;

set nsk(l) "Unskilled types for labor growth assumptions" /
   unSkLab           "Unskilled labor"
/ ;

set skl(l)  "Skill types for labor growth assumptions" /
   SkLab             "Skilled labor"
/ ;

set educMap(r,l,ed) "Mapping of skills to education levels" /
   Oceania       .unSkLab      .elev0
   Oceania       .unSkLab      .elev1
   Oceania       .SkLab        .elev2
   EastAsia      .unSkLab      .elev0
   EastAsia      .SkLab        .elev1
   EastAsia      .SkLab        .elev2
   SEAsia        .unSkLab      .elev0
   SEAsia        .SkLab        .elev1
   SEAsia        .SkLab        .elev2
   SouthAsia     .unSkLab      .elev0
   SouthAsia     .SkLab        .elev1
   SouthAsia     .SkLab        .elev2
   NAmerica      .unSkLab      .elev0
   NAmerica      .unSkLab      .elev1
   NAmerica      .SkLab        .elev2
   LatinAmer     .unSkLab      .elev0
   LatinAmer     .SkLab        .elev1
   LatinAmer     .SkLab        .elev2
   EU_28         .unSkLab      .elev0
   EU_28         .unSkLab      .elev1
   EU_28         .SkLab        .elev2
   MENA          .unSkLab      .elev0
   MENA          .SkLab        .elev1
   MENA          .SkLab        .elev2
   SSA           .unSkLab      .elev0
   SSA           .SkLab        .elev1
   SSA           .SkLab        .elev2
   RestofWorld   .unSkLab      .elev0
   RestofWorld   .SkLab        .elev1
   RestofWorld   .SkLab        .elev2
/ ;

set sortOrder / sort1*sort52 / ;

set mapOrder(sortOrder,is) /
sort1.Agriculture-a
sort2.Extraction-a
sort3.ProcFood-a
sort4.TextWapp-a
sort5.LightMnfc-a
sort6.HeavyMnfc-a
sort7.Util_Cons-a
sort8.TransComm-a
sort9.OthServices-a
sort10.GrainsCrops-c
sort11.MeatLstk-c
sort12.Extraction-c
sort13.ProcFood-c
sort14.TextWapp-c
sort15.LightMnfc-c
sort16.HeavyMnfc-c
sort17.Util_Cons-c
sort18.TransComm-c
sort19.OthServices-c
sort20.Land
sort21.Capital
sort22.unSkLab
sort23.SkLab
sort24.NatRes
sort25.TRD
sort26.hhd
sort27.gov
sort28.inv
sort29.deprY
sort30.tmg
sort31.itax
sort32.ptax
sort33.mtax
sort34.etax
sort35.vtax
sort36.vsub
sort37.wtax
sort38.ntmY
sort39.dtax
sort40.ctax
sort41.bop
sort42.tot
sort43.Oceania
sort44.EastAsia
sort45.SEAsia
sort46.SouthAsia
sort47.NAmerica
sort48.LatinAmer
sort49.EU_28
sort50.MENA
sort51.SSA
sort52.RestofWorld
/ ;

set gy(is) "Government revenue streams" /
   itax        "Indirect taxes"
   ptax        "Production taxes"
   vtax        "Factor taxes"
   mtax        "Import taxes"
   etax        "Export taxes"
   wtax        "Waste taxes"
   ctax        "Carbon taxes"
   dtax        "Direct taxes"
/ ;

set itx(gy) / itax / ;
set ptx(gy) / ptax / ;
set vtx(gy) / vtax / ;
set mtx(gy) / mtax / ;
set etx(gy) / etax / ;
set wtx(gy) / wtax / ;
set ctx(gy) / ctax / ;
set dtx(gy) / dtax / ;

set tot(is) "Total" /
   tot         "Total for row/column sums"
/ ;

set acr(a) "Crop activities" /
/ ;

set alv(a) "Livestock activities" /
/ ;

set ax(a) "All other activities" /
   Extraction-a      "Mining and Extraction"
   ProcFood-a        "Processed Food"
   TextWapp-a        "Textiles and Clothing"
   LightMnfc-a       "Light Manufacturing"
   HeavyMnfc-a       "Heavy Manufacturing"
   Util_Cons-a       "Utilities and Construction"
   TransComm-a       "Transport and Communication"
   OthServices-a     "Other Services"
   Agriculture-a     "Agriculture"
/ ;

set agr(a) "Agricultural activities" /
   Agriculture-a     "Agriculture"
/ ;

set man(a) "Manufacturing activities" /
   Extraction-a      "Mining and Extraction"
   ProcFood-a        "Processed Food"
   TextWapp-a        "Textiles and Clothing"
   LightMnfc-a       "Light Manufacturing"
   HeavyMnfc-a       "Heavy Manufacturing"
/ ;

set srv(a) "Service activities" /
   Util_Cons-a       "Utilities and Construction"
   TransComm-a       "Transport and Communication"
   OthServices-a     "Other Services"
/ ;

set aenergy(a) "Energy activities" /
   Extraction-a      "Mining and Extraction"
   Util_Cons-a       "Utilities and Construction"
/ ;

set affl(a) "Fossil fuel activities" /
   Extraction-a      "Mining and Extraction"
/ ;

set aw(a) "Water services activities" /
/ ;

set z "Labor market zones" /
   rur               "Agricultural sectors"
   urb               "Non-agricultural sectors"
   nsg               "Non-segmented labor markets"
/ ;

set rur(z) "Rural zone" /
   rur               "Agricultural sectors"
/ ;

set urb(z) "Urban zone" /
   urb               "Non-agricultural sectors"
/ ;

set nsg(z) "Both zones" /
   nsg               "Non-segmented labor markets"
/ ;

set mapz(z,a) "Mapping of activities to zones" /
   rur.Agriculture-a
   urb.Extraction-a
   urb.ProcFood-a
   urb.TextWapp-a
   urb.LightMnfc-a
   urb.HeavyMnfc-a
   urb.Util_Cons-a
   urb.TransComm-a
   urb.OthServices-a
/ ;

mapz("nsg", a) = yes ;

set frt(i) "Fertilizer commodities" /
/ ;

set feed(i) "Feed commodities" /
/ ;

set iw(i) "Water services commodities" /
/ ;

set e(i) "Energy commodities" /
/ ;

set elyc(i) "Electricity commodities" /
   Util_Cons-c       "Utilities and Construction"
/ ;

set fuel(e) "Fuel commodities" /
/ ;

set img(i) "Margin commodities" /
   TransComm-c       "Transport and Communication"
/ ;

set k "Household commodities" /
   GrainsCrops-k     "Grains and Crops"
   MeatLstk-k        "Livestock and Meat Products"
   ProcFood-k        "Processed Food"
   TextWapp-k        "Textiles and Clothing"
   LightMnfc-k       "Light Manufacturing"
   HeavyMnfc-k       "Heavy Manufacturing"
   TransComm-k       "Transport and Communication"
   OthServices-k     "Other Services"
   Energy-k          "Energy"
/ ;

set fud(k) "Household food commodities" /
   GrainsCrops-k     "Grains and Crops"
   MeatLstk-k        "Livestock and Meat Products"
   ProcFood-k        "Processed Food"
/ ;

set mapk(i,k) "Mapping from i to k" /
   GrainsCrops-c .GrainsCrops-k
   MeatLstk-c    .MeatLstk-k
   Extraction-c  .Energy-k
   ProcFood-c    .ProcFood-k
   TextWapp-c    .TextWapp-k
   LightMnfc-c   .LightMnfc-k
   HeavyMnfc-c   .HeavyMnfc-k
   Util_Cons-c   .Energy-k
   TransComm-c   .TransComm-k
   OthServices-c .OthServices-k
/ ;

set elya(a) "Power activities" /
/ ;

set etd(a) "Electricity transmission and distribution activities" /
/ ;

set primElya(a) "Primary power activities" /
/ ;

set pb "Power bundles in power aggregation" /
   othp              "Other power"
/ ;

set mappow(pb,elya) "Mapping of power activities to power bundles" /
/ ;

set lb "Land bundles" /
   agr               "Agriculture"
/ ;

set lb1(lb) "First land bundle" /
   agr               "Agriculture"
/ ;

set maplb(lb,a) "Mapping of activities to land bundles" /
   agr           .Agriculture-a
/ ;

set lh "Market condition flags" /
   lo    "Market downswing"
   hi    "Market upswing"
/ ;

set wbnd "Aggregate water markets" /
   N_A               "N_A"
/ ;

set wbnd1(wbnd) "Top level water markets" /
/ ;

set wbnd2(wbnd) "Second level water markets" /
/ ;

set wbndex(wbnd) "Second level water markets" /
/ ;

set mapw1(wbnd,wbnd) "Mapping of first level water bundles" /
/ ;

set mapw2(wbnd,a) "Mapping of second level water bundle" /
/ ;

set wbnda(wbnd) "Water bundles mapped one-to-one to activities" /
/ ;

set wbndi(wbnd) "Water bundles mapped to aggregate output" /
/ ;

set NRG "Energy bundles used in model" /
   COA               "Coal"
   OIL               "Oil"
   GAS               "Gas"
   ELY               "Electricity"
/ ;

set coa(NRG) "Coal bundle used in model" /
   COA               "Coal"
/ ;

set oil(NRG) "Oil bundle used in model" /
   OIL               "Oil"
/ ;

set gas(NRG) "Gas bundle used in model" /
   GAS               "Gas"
/ ;

set ely(NRG) "Electricity bundle used in model" /
   ELY               "Electricity"
/ ;

set mape(NRG,e) "Mapping of energy commodities to energy bundles" /
/ ;

set em "Emission types" /
   co2               "Carbon emissions"
   n2o               "N2O emissions"
   ch4               "Methane emissions"
   fgas              "Emissions of fluoridated gases"
   bc                "Black carbon (Gg)"
   co                "Carbon monoxide (Gg)"
   nh3               "Ammonia (Gg)"
   nmvb              "Non-methane volatile organic compounds (Gg)"
   nmvf              "Non-methane volatile organic compounds (Gg)"
   nox               "Nitrogen oxides (Gg)"
   oc                "Organic carbon (Gg)"
   pm10              "Particulate matter 10 (Gg)"
   pm2_5             "Particulate matter 2.5 (Gg)"
   so2               "Sulfur dioxide (Gg)"
/ ;

set emn(em) "Non-CO2 emission types" /
   n2o               "N2O emissions"
   ch4               "Methane emissions"
   fgas              "Emissions of fluoridated gases"
   bc                "Black carbon (Gg)"
   co                "Carbon monoxide (Gg)"
   nh3               "Ammonia (Gg)"
   nmvb              "Non-methane volatile organic compounds (Gg)"
   nmvf              "Non-methane volatile organic compounds (Gg)"
   nox               "Nitrogen oxides (Gg)"
   oc                "Organic carbon (Gg)"
   pm10              "Particulate matter 10 (Gg)"
   pm2_5             "Particulate matter 2.5 (Gg)"
   so2               "Sulfur dioxide (Gg)"
/ ;

set ghg(em) "Greenhouse gas emission types" /
   co2               "Carbon emissions"
   n2o               "N2O emissions"
   ch4               "Methane emissions"
   fgas              "Emissions of fluoridated gases"
/ ;

set nghg(em) "Non greenhouse gas emission types" /
   bc                "Black carbon (Gg)"
   co                "Carbon monoxide (Gg)"
   nh3               "Ammonia (Gg)"
   nmvb              "Non-methane volatile organic compounds (Gg)"
   nmvf              "Non-methane volatile organic compounds (Gg)"
   nox               "Nitrogen oxides (Gg)"
   oc                "Organic carbon (Gg)"
   pm10              "Particulate matter 10 (Gg)"
   pm2_5             "Particulate matter 2.5 (Gg)"
   so2               "Sulfur dioxide (Gg)"
/ ;

set emq "Emission quantities" /
   gt          "Gigatons"
   ceq         "Carbon equivalent"
   co2eq       "CO2 equivalent"
/ ;

set mapi1(i,a) "Mapping of commodities to ND1 bundle" /
   GrainsCrops-c .Extraction-a
   MeatLstk-c    .Extraction-a
   Extraction-c  .Extraction-a
   ProcFood-c    .Extraction-a
   TextWapp-c    .Extraction-a
   LightMnfc-c   .Extraction-a
   HeavyMnfc-c   .Extraction-a
   Util_Cons-c   .Extraction-a
   TransComm-c   .Extraction-a
   OthServices-c .Extraction-a
   GrainsCrops-c .ProcFood-a
   MeatLstk-c    .ProcFood-a
   Extraction-c  .ProcFood-a
   ProcFood-c    .ProcFood-a
   TextWapp-c    .ProcFood-a
   LightMnfc-c   .ProcFood-a
   HeavyMnfc-c   .ProcFood-a
   Util_Cons-c   .ProcFood-a
   TransComm-c   .ProcFood-a
   OthServices-c .ProcFood-a
   GrainsCrops-c .TextWapp-a
   MeatLstk-c    .TextWapp-a
   Extraction-c  .TextWapp-a
   ProcFood-c    .TextWapp-a
   TextWapp-c    .TextWapp-a
   LightMnfc-c   .TextWapp-a
   HeavyMnfc-c   .TextWapp-a
   Util_Cons-c   .TextWapp-a
   TransComm-c   .TextWapp-a
   OthServices-c .TextWapp-a
   GrainsCrops-c .LightMnfc-a
   MeatLstk-c    .LightMnfc-a
   Extraction-c  .LightMnfc-a
   ProcFood-c    .LightMnfc-a
   TextWapp-c    .LightMnfc-a
   LightMnfc-c   .LightMnfc-a
   HeavyMnfc-c   .LightMnfc-a
   Util_Cons-c   .LightMnfc-a
   TransComm-c   .LightMnfc-a
   OthServices-c .LightMnfc-a
   GrainsCrops-c .HeavyMnfc-a
   MeatLstk-c    .HeavyMnfc-a
   Extraction-c  .HeavyMnfc-a
   ProcFood-c    .HeavyMnfc-a
   TextWapp-c    .HeavyMnfc-a
   LightMnfc-c   .HeavyMnfc-a
   HeavyMnfc-c   .HeavyMnfc-a
   Util_Cons-c   .HeavyMnfc-a
   TransComm-c   .HeavyMnfc-a
   OthServices-c .HeavyMnfc-a
   GrainsCrops-c .Util_Cons-a
   MeatLstk-c    .Util_Cons-a
   Extraction-c  .Util_Cons-a
   ProcFood-c    .Util_Cons-a
   TextWapp-c    .Util_Cons-a
   LightMnfc-c   .Util_Cons-a
   HeavyMnfc-c   .Util_Cons-a
   Util_Cons-c   .Util_Cons-a
   TransComm-c   .Util_Cons-a
   OthServices-c .Util_Cons-a
   GrainsCrops-c .TransComm-a
   MeatLstk-c    .TransComm-a
   Extraction-c  .TransComm-a
   ProcFood-c    .TransComm-a
   TextWapp-c    .TransComm-a
   LightMnfc-c   .TransComm-a
   HeavyMnfc-c   .TransComm-a
   Util_Cons-c   .TransComm-a
   TransComm-c   .TransComm-a
   OthServices-c .TransComm-a
   GrainsCrops-c .OthServices-a
   MeatLstk-c    .OthServices-a
   Extraction-c  .OthServices-a
   ProcFood-c    .OthServices-a
   TextWapp-c    .OthServices-a
   LightMnfc-c   .OthServices-a
   HeavyMnfc-c   .OthServices-a
   Util_Cons-c   .OthServices-a
   TransComm-c   .OthServices-a
   OthServices-c .OthServices-a
   GrainsCrops-c .Agriculture-a
   MeatLstk-c    .Agriculture-a
   Extraction-c  .Agriculture-a
   ProcFood-c    .Agriculture-a
   TextWapp-c    .Agriculture-a
   LightMnfc-c   .Agriculture-a
   HeavyMnfc-c   .Agriculture-a
   Util_Cons-c   .Agriculture-a
   TransComm-c   .Agriculture-a
   OthServices-c .Agriculture-a
/ ;

set mapi2(i,a) "Mapping of commodities to ND2 bundle" /
/ ;

set rq(ra) "Regions submitted to an emissions cap" ;
rq(ra) = no ;

