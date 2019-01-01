* ----------------------------------------------------------------------------------------
*
*  Create 'dimension' file for models
*  The code herein is valid for Altertax, GTAP and Envisage
*
* ----------------------------------------------------------------------------------------

put '$onempty' / / ;

parameter
   strlen
   maxstrlen
   maxcol1
;

maxstrlen = smax(a, card(a.tl))+2 ;
maxstrlen = max(maxstrlen, smax(i, card(i.tl))+2) ;
maxstrlen = max(maxstrlen, smax(fp, card(fp.tl))) ;
maxstrlen = max(maxstrlen, smax(r, card(r.tl))) ;
maxstrlen = max(maxstrlen, smax(stdlab, card(stdlab.tl))) ;
maxstrlen = max(maxstrlen, smax(actf, card(actf.tl))+2) ;
maxstrlen = max(maxstrlen, smax(commf, card(commf.tl))+2) ;

put 'set a0 "Original activities" /' / ;
loop(a,
   put '   ', a.tl:<maxstrlen, '     "', a.te(a), '"' / ;
) ;
put '/ ;' / / ;

put 'set i0(a0) "Original commodities" /' / ;
loop(i,
   put '   ', i.tl:<maxstrlen, '     "', i.te(i), '"' / ;
) ;
put '/ ;' / / ;

put '* --------------------------------------------------------------------' / ;
put '*' / ;
put '*   USER CAN MODIFY ACTIVITY/COMMODITY AGGREGATION' / ;
put '*   USER MUST FILL IN SUBSETS WHERE NEEDED' / ;
put '*' / ;
put '* --------------------------------------------------------------------' / /;

put / '* >>>> PLACE TO CHANGE ACTIVITIES, i.e. model activities' / / ;

put 'set act "Modeled activities" /' / ;
if(%1 eq AlterTax,
*  AlterTax assumes diagonality
   loop(a,
      strlen = card(a.tl) ;
      put '   ', a.tl:<strlen, '-a', '':(maxstrlen-strlen-2), '     "', a.te(a), '"' / ;
   ) ;
else
*  Use the model aggregation
   loop(mapActSort(sortOrder,actf),
      strlen = card(actf.tl) ;
      put '   ', actf.tl:<strlen, '-a', '':(maxstrlen-strlen-2), '     "', actf.te(actf), '"' / ;
   ) ;
) ;
put '/ ;' / / ;

put '* >>>> PLACE TO CHANGE COMMODITIES, i.e. model commodities' / / ;

put 'set comm "Modeled commodities" /' / ;
if(%1 eq AlterTax,
*  AlterTax assumes diagonality
   loop(i,
      strlen = card(i.tl) ;
      put '   ', i.tl:<strlen, '-c', '':(maxstrlen-strlen-2), '     "', i.te(i), '"' / ;
   ) ;
else
*  Use the model aggregation
   loop(mapCommSort(sortOrder,commf),
      strlen = card(commf.tl) ;
      put '   ', commf.tl:<strlen, '-c', '':(maxstrlen-strlen-2), '     "', commf.te(commf), '"' / ;
   ) ;
) ;
put '/ ;' / / ;

put 'set endw "Modeled production factors" /' / ;
loop(fp$((ifWater=OFF and not Wat(fp)) or ifWater=ON),
   put '   ', fp.tl:<maxstrlen, '     "', fp.te(fp), '"' / ;
) ;
put '/ ;' / / ;

put 'set stdlab "Standard SAM labels" /' / ;
loop(stdlab,
   put '   ', stdlab.tl:<maxstrlen, '     "', stdlab.te(stdlab), '"' / ;
) ;
put '/ ;' / / ;

put 'set findem(stdlab) "Final demand accounts" /' / ;
loop(stdlab$fd(stdlab),
   put '   ', stdlab.tl:<maxstrlen, '     "', stdlab.te(stdlab), '"' / ;
) ;
put '/ ;' / / ;

put 'set reg "Modeled regions" /' / ;
loop(mapRegSort(sortOrder,r),
   put '   ', r.tl:<maxstrlen, '     "', r.te(r), '"' / ;
) ;
put '/ ;' / / ;

put 'set is "SAM accounts for aggregated SAM" /' / /;

put '*  User-defined activities' / /;

put '   set.act' / / ;

put '*  User-defined commodities' / / ;

put '   set.comm' / / ;

put '*  User-defined factors' / / ;

put '   set.endw' / / ;

put '*  Standard SAM accounts' / / ;

put '   set.stdlab' / / ;

put '*  User-defined regions' / / ;

put '   set.reg' / / ;

put '/ ;' / / ;

put 'alias(is, js) ;' / / ;

put 'set aa(is) "Armington agents" /' / /;

put '   set.act' / / ;

put '   set.findem' / / ;

put '/ ;' / / ;

put 'set a(aa) "Activities" /' / /;

put '   set.act' / / ;

put '/ ;' / / ;

put 'set i(is) "Commodities" /' / /;

put '   set.comm' / / ;

put '/ ;' / / ;

put 'alias(i, j) ;' / / ;

put 'set fp(is) "Factors of production" /' / /;

put '   set.endw' / / ;

put '/ ;' / / ;

put 'set l(fp) "Labor factors" /' / /;
loop(fp$l(fp),
   put '   ', fp.tl:<maxstrlen, '     "', fp.te(fp), '"' / ;
) ;
put '/ ;' / / ;

put 'set ul(l) "Unskilled labor" /' / /;
loop(l$ul(l),
   put '   ', l.tl:<maxstrlen, '     "', l.te(l), '"' / ;
) ;
put '/ ;' / / ;

put 'set sl(l) "Skilled labor" /' / /;
loop(l$(not ul(l)),
   put '   ', l.tl:<maxstrlen, '     "', l.te(l), '"' / ;
) ;
put '/ ;' / / ;

put 'set lr(l) "Reference labor for skill premium" /' / /;
loop(l$(lr(l)),
   put '   ', l.tl:<maxstrlen, '     "', l.te(l), '"' / ;
) ;
put '/ ;' / / ;

put 'set cap(fp) "Capital" /' / /;
loop(fp$cap(fp),
   put '   ', fp.tl:<maxstrlen, '     "', fp.te(fp), '"' / ;
) ;
put '/ ;' / / ;

put 'set lnd(fp) "Land endowment" /' / / ;
loop(fp$lnd(fp),
   put '   ', fp.tl:<maxstrlen, '     "', fp.te(fp), '"' / ;
) ;
put '/ ;' / / ;

put 'set nrs(fp) "Natural resource" /' / /;
loop(fp$nrs(fp),
   put '   ', fp.tl:<maxstrlen, '     "', fp.te(fp), '"' / ;
) ;
put '/ ;' / / ;

if(%1=Env,
   put 'set wat(fp) "Water resource" /' / /;
   loop(fp$wat(fp),
      put '   ', fp.tl:<maxstrlen, '     "', fp.te(fp), '"' / ;
   ) ;
   put '/ ;' / / ;
) ;

put '* >>>> CAN MODIFY MOBILE VS. NON-MOBILE FACTORS' / / ;

put 'set fm(fp) "Mobile factors" /' / / ;

loop(fp,
   put '   ', fp.tl:<maxstrlen, '     "', fp.te(fp), '"' / ;
) ;
put '/ ;' / / ;

put 'set fnm(fp) "Non-mobile factors" /' / / ;

put '/ ;' / / ;

put 'set fd(aa) "Domestic final demand agents" /' / / ;
if(%1 = Env,
   loop(fd$(not tmg(fd)),
      put '   ', fd.tl:<maxstrlen, '     "', fd.te(fd), '"' / ;
   ) ;
else
   put '   set.findem' / / ;
) ;
put '/ ;' / / ;

put 'set h(fd) "Households" /' / ;
loop(fd$h(fd),
   put '   ', fd.tl:<maxstrlen, '     "', fd.te(fd), '"' / ;
) ;
put '/ ;' / / ;

put 'set gov(fd) "Government" /' / ;
loop(fd$gov(fd),
   put '   ', fd.tl:<maxstrlen, '     "', fd.te(fd), '"' / ;
) ;
put '/ ;' / / ;

put 'set inv(fd) "Investment" /' / ;
loop(fd$inv(fd),
   put '   ', fd.tl:<maxstrlen, '     "', fd.te(fd), '"' / ;
) ;
put '/ ;' / / ;

put 'set fdc(fd) "Final demand accounts with CES expenditure function" /' / ;
loop(fd$(gov(fd) or inv(fd)),
   put '   ', fd.tl:<maxstrlen, '     "', fd.te(fd), '"' / ;
) ;
put '/ ;' / / ;

if(%1 ne Env,
   put 'set tmg(fd) "Domestic supply of trade margins services" /' / ;
   loop(fd$tmg(fd),
      put '   ', fd.tl:<maxstrlen, '     "', fd.te(fd), '"' / ;
   ) ;
   put '/ ;' / / ;
) ;

put 'set r(is) "Regions" /' / /;

put '   set.reg' / / ;

put '/ ;' / / ;

put 'alias(r, rp) ; alias(r, s) ; alias(r, d) ;' / / ;

put '* >>>> MUST INSERT RESIDUAL REGION (ONLY ONE)' / / ;

put 'set rres(r) "Residual region" /' / ;
loop(r$rres(r),
   put '   ', r.tl:<maxstrlen, '     "', r.te(r), '"' / ;
) ;
put '/ ;' / / ;

put '* >>>> MUST INSERT MUV REGIONS (ONE OR MORE)' / / ;

put 'set rmuv(r) "MUV regions" /' / ;
loop(r$rmuv(r),
   put '   ', r.tl:<maxstrlen, '     "', r.te(r), '"' / ;
) ;
put '/ ;' / / ;

put '* >>>> MUST INSERT MUV COMMODITIES (ONE OR MORE)' / / ;

put 'set imuv(i) "MUV commodities" /' / ;
if(%1 eq AlterTax,

*  Make all commodities MUV

   put '   set.comm' / / ;

else

   loop(commf$imuvf(commf),
      strlen = card(commf.tl) ;
      put '   ', commf.tl:<strlen, '-c' / ;
   ) ;
) ;
put '/ ;' / / ;

*  Emission sets

if(%1 ne Env,
   put 'set em "Emissions" /' / ;
   loop(em,
      put '   ', em.tl:<maxstrlen, '     "', em.te(em), '"' / ;
   ) ;
   put '/ ;' / / ;

   put 'set emn(em) "Non-CO2 emissions" /' / ;
   loop(em$emn(em),
      put '   ', em.tl:<maxstrlen, '     "', em.te(em), '"' / ;
   ) ;
   put '/ ;' / / ;

   put 'alias(emn, nco2) ;' / / ;
) ;

*  Aggregation sets

put 'set ia "Aggregate commodities for model output" /' / ;
if(%1 ne Altertax,
   loop(commf,
      strlen = card(commf.tl) ;
      put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+5), '"', commf.te(commf), '"' / ;
   ) ;
   put / ;
   loop(ia,
      strlen = card(ia.tl) ;
      put '   ', ia.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', ia.te(ia), '"' / ;
   ) ;
else
   strlen = 5 ;
   put '   ', 'Total':<strlen, ' ':(maxstrlen-(strlen)+5), '"Aggregation of all commodities"' / ;
) ;
put '/ ;' / / ;

if(%1 ne Altertax,
   put 'set mapi(ia,i) "Mapping for aggregate commodities" /' / ;
   loop(commf,
      strlen = card(commf.tl) ;
      put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+1), '.', commf.tl:card(commf.tl), '-c' / ;
   ) ;
   put / ;
   loop(mapia(ia,commf),
      strlen = card(ia.tl) ;
      put '   ', ia.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', commf.tl:card(commf.tl), '-c' / ;
   ) ;
   put '/ ;' / / ;
else
   put 'set mapi(ia,i) "Mapping for aggregate commodities" ;' / ;
   put 'mapi("Total",i) = yes ;' / / ;
) ;

put 'set iaa(ia) "Aggregate commodities only" ;' / ;
put 'loop((i,ia)$(not sameas(i,ia)), iaa(ia) = yes ; ) ;' / / ;

put 'set aga "Aggregate activities for model output" /' / ;
if(%1 ne Altertax,
   loop(actf,
      strlen = card(actf.tl) ;
      put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
   ) ;
   put / ;
   loop(aga,
      strlen = card(aga.tl) ;
      put '   ', aga.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', aga.te(aga), '"' / ;
   ) ;
else
   strlen = 5 ;
   put '   ', 'Total':<strlen, ' ':(maxstrlen-(strlen)+5), '"Aggregation of all activities"' / ;
) ;
put '/ ;' / / ;

if(%1 ne Altertax,
   put 'set mapaga(aga,a) "Mapping for aggregate activities" /' / ;
   loop(actf,
      strlen = card(actf.tl) ;
      put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+1), '.', actf.tl:card(actf.tl), '-a' / ;
   ) ;
   put / ;
   loop(mapaga(aga,actf),
      strlen = card(aga.tl) ;
      put '   ', aga.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', actf.tl:card(actf.tl), '-a' / ;
   ) ;
   put '/ ;' / / ;
else
   put 'set mapaga(aga,a) "Mapping for aggregate activities" ;' / ;
   put 'mapaga("Total",a) = yes ;' / / ;
) ;

put 'set agaa(aga) "Aggregate activities only" ;' / ;
put 'loop((a,aga)$(not sameas(a,aga)), agaa(aga) = yes ; ) ;' / / ;

put 'set ra "Aggregate regions for emission regimes and model output" /' / ;
loop(r,
   strlen = card(r.tl) ;
   put '   ', r.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', r.te(r), '"' / ;
) ;
put / ;
loop(ra,
   strlen = card(ra.tl) ;
   put '   ', ra.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', ra.te(ra), '"' / ;
) ;
put '/ ;' / / ;

put 'set mapr(ra,r) "Mapping for aggregate regions" /' / ;
loop(r,
   strlen = card(r.tl) ;
   put '   ', r.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', r.tl:card(r.tl) / ;
) ;
put / ;
loop(mapra(ra,r),
   strlen = card(ra.tl) ;
   put '   ', ra.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', r.tl:card(r.tl) / ;
) ;
put '/ ;' / / ;

put 'set rra(ra) "Aggregate regions only" ;' / ;
put 'loop((r,ra)$(not sameas(r,ra)), rra(ra) = yes ; ) ;' / / ;

put 'set lagg "Aggregate labor for output" /' / ;
loop(l,
   strlen = card(l.tl) ;
   put '   ', l.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', l.te(l), '"' / ;
) ;
put / ;
loop(lagg,
   strlen = card(lagg.tl) ;
   put '   ', lagg.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', lagg.te(lagg), '"' / ;
) ;
put '/ ;' / / ;

put 'set mapl(lagg,l) "Mapping for aggregate regions" /' / ;
loop(l,
   strlen = card(l.tl) ;
   put '   ', l.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', l.tl:card(l.tl) / ;
) ;
put / ;
loop(maplagg(lagg,l),
   strlen = card(lagg.tl) ;
   put '   ', lagg.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', l.tl:card(l.tl) / ;
) ;
put '/ ;' / / ;

put '* >>>> CAN CHANGE ACTIVITY MAPPING' / / ;

*  !!!! FOR ALTERTAX -- ONE-TO-ONE MAPPING

put 'set mapa0(a0, a) "Mapping from original activities to new activities" /' / ;
if(%1 eq AlterTax,
   loop(a,
      strlen = card(a.tl) ;
      put '   ', a.tl:<maxstrlen, '.', a.tl:<strlen, '-a' / ;
   ) ;
else
   loop(mapaf(i,actf),
      strlen = card(i.tl) ;
      put '   ', i.tl:<maxstrlen, '.', actf.tl:<card(actf.tl), '-a' / ;
   ) ;
) ;
put '/ ;' / / ;

put '* >>>> CAN CHANGE COMMODITY MAPPING' / / ;

*  !!!! FOR ALTERTAX -- ONE-TO-ONE MAPPING

put 'set mapi0(i0, i) "Mapping from original commodities to new commodities" /' / ;
if(%1 eq AlterTax,
   loop(i,
      strlen = card(i.tl) ;
      put '   ', i.tl:<maxstrlen, '.', i.tl:<strlen, '-c' / ;
   ) ;
else
   loop(mapif(i,commf),
      strlen = card(i.tl) ;
      put '   ', i.tl:<maxstrlen, '.', commf.tl:<card(commf.tl), '-c' / ;
   ) ;
) ;
put '/ ;' / / ;

$iftheni.DYNPUT "%DYN%" == "ON"

put 'set var "GDP variables" /' / ;
loop(var,
   strlen = card(var.tl) ;
   put '   ', var.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', var.te(var), '"' / ;
) ;
put '/ ;' / / ;

put 'set scen "Scenarios" /' / ;
loop(scen,
   strlen = card(scen.tl) ;
   put '   ', scen.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', scen.te(scen), '"' / ;
) ;
put '/ ;' / / ;

put 'set ssp(scen) "SSP Scenarios" /' / ;
loop(scen$ssp(scen),
   strlen = card(scen.tl) ;
   put '   ', scen.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', scen.te(scen), '"' / ;
) ;
put '/ ;' / / ;

put 'set mod "Models" /' / ;
loop(mod,
   strlen = card(mod.tl) ;
   put '   ', mod.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', mod.te(mod), '"' / ;
) ;
put '/ ;' / / ;

put 'set tranche "Population cohorts" /' / ;
loop(tranche,
   strlen = card(tranche.tl) ;
   put '   ', tranche.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', tranche.te(tranche), '"' / ;
) ;
put '/ ;' / / ;

put 'set trs(tranche) "Population cohorts" /' / ;
loop(tranche$trs(tranche),
   strlen = card(tranche.tl) ;
   put '   ', tranche.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', tranche.te(tranche), '"' / ;
) ;
put '/ ;' / / ;

put 'set sex   "Gender categories" /' / ;
loop(sex,
   strlen = card(sex.tl) ;
   put '   ', sex.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', sex.te(sex), '"' / ;
) ;
put '/ ;' / / ;

put 'set sexx(sex) "Gender categories excl total" /' / ;
loop(sex$sexx(sex),
   strlen = card(sex.tl) ;
   put '   ', sex.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', sex.te(sex), '"' / ;
) ;
put '/ ;' / / ;

put 'set ed "Combined SSP/GIDD education levels" /' / ;
loop(edj,
   strlen = card(edj.tl) ;
   put '   ', edj.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', edj.te(edj), '"' / ;
) ;
put '/ ;' / / ;

put 'set edx(ed) "Education levels excluding totals" /' / ;
loop(edj$(not sameas("elevt", edj)),
   strlen = card(edj.tl) ;
   put '   ', edj.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', edj.te(edj), '"' / ;
) ;
put '/ ;' / / ;

*  Labor growth assumptions

put 'set nsk(l) "Unskilled types for labor growth assumptions" /' / ;
loop(l$(not skl(l)),
   put '   ', l.tl:<maxstrlen, '     "', l.te(l), '"' / ;
) ;
put '/ ;' / / ;

put 'set skl(l)  "Skill types for labor growth assumptions" /' / ;
loop(l$skl(l),
   put '   ', l.tl:<maxstrlen, '     "', l.te(l), '"' / ;
) ;
put '/ ;' / / ;

put 'set educMap(r,l,ed) "Mapping of skills to education levels" /' / ;
loop(educMap(r,l,elev),
   strlen = card(r.tl) ;
   put '   ', r.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', l.tl:<maxstrlen, '.', elev.tl / ;
) ;
put '/ ;' / / ;

$endif.DYNPUT

*  Create sort for SAM and other purposes

if(%1 eq AlterTax,
*  !!!! No longer need to substract 1 for CGDS
   order = card(a) + card(a) + card(fp) + card(stdlab) + card(r) ;
else
   order = card(actf) + card(commf) + card(fp) + card(stdlab) + card(r) ;
) ;

put 'set sortOrder / sort1*sort', order:0:0, ' / ;' / / ;

put 'set mapOrder(sortOrder,is) / ' / ;

order = 0 ;

if(%1 eq AlterTax,
*  AlterTax assumes diagonality and we'll forego putting a sort order for this
   loop(a,
      order = order + 1 ;
      put 'sort', order:0:0, '.', a.tl:card(a.tl), '-a' / ;
   ) ;
else
*  Use the model aggregation
   loop(mapActSort(sortOrder,actf),
      order = order + 1 ;
      put 'sort', order:0:0, '.', actf.tl:card(actf.tl), '-a' / ;
   ) ;
) ;

if(%1 eq AlterTax,
*  AlterTax assumes diagonality and we'll forego putting a sort order for this
   loop(a,
      order = order + 1 ;
      put 'sort', order:0:0, '.', a.tl:card(a.tl), '-c' / ;
   ) ;
else
*  Use the model aggregation
   loop(mapCommSort(sortOrder,commf),
      order = order + 1 ;
      put 'sort', order:0:0, '.', commf.tl:card(commf.tl), '-c' / ;
   ) ;
) ;

loop(fp,
   order = order + 1 ;
   put 'sort', order:0:0, '.', fp.tl:card(fp.tl) / ;
) ;

loop(stdlab,
   order = order + 1 ;
   put 'sort', order:0:0, '.', stdlab.tl:card(stdlab.tl) / ;
) ;

loop(mapRegSort(sortOrder,r),
   order = order + 1 ;
   put 'sort', order:0:0, '.', r.tl:card(r.tl) / ;
) ;

put '/ ;' / / ;
