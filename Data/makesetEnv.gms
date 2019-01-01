* ----------------------------------------------------------------------------------------
*
*  Put in additional dimensions for Envisage
*
* ----------------------------------------------------------------------------------------

put 'set gy(is) "Government revenue streams" /' / ;
put '   itax        "Indirect taxes"' / ;
put '   ptax        "Production taxes"' / ;
put '   vtax        "Factor taxes"' / ;
put '   mtax        "Import taxes"' / ;
put '   etax        "Export taxes"' / ;
put '   wtax        "Waste taxes"' / ;
put '   ctax        "Carbon taxes"' / ;
put '   dtax        "Direct taxes"' / ;
put '/ ;' / / ;

put 'set itx(gy) / itax / ;' / ;
put 'set ptx(gy) / ptax / ;' / ;
put 'set vtx(gy) / vtax / ;' / ;
put 'set mtx(gy) / mtax / ;' / ;
put 'set etx(gy) / etax / ;' / ;
put 'set wtx(gy) / wtax / ;' / ;
put 'set ctx(gy) / ctax / ;' / ;
put 'set dtx(gy) / dtax / ;' / / ;

put 'set tot(is) "Total" /' / ;
put '   tot         "Total for row/column sums"' / ;
put '/ ;' / /;

put 'set acr(a) "Crop activities" /' / ;
loop(actf$acr(actf),
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set alv(a) "Livestock activities" /' / ;
loop(actf$alv(actf),
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set ax(a) "All other activities" /' / ;
loop(actf$(not (acr(actf) or alv(actf))),
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set agr(a) "Agricultural activities" /' / ;
loop(actf$agr(actf),
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set man(a) "Manufacturing activities" /' / ;
loop(actf$man(actf),
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set srv(a) "Service activities" /' / ;
loop(actf$(not (agr(actf) or man(actf))),
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set aenergy(a) "Energy activities" /' / ;
loop(actf$aenergy(actf),
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set affl(a) "Fossil fuel activities" /' / ;
loop(actf$affl(actf),
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set aw(a) "Water services activities" /' / ;
loop(actf$aw(actf),
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set z "Labor market zones" /' / ;
loop(z,
   strlen = card(z.tl) ;
   put '   ', z.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', z.te(z), '"' / ;
) ;
put '/ ;' / / ;

put 'set rur(z) "Rural zone" /' / ;
loop(z$rur(z),
   strlen = card(z.tl) ;
   put '   ', z.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', z.te(z), '"' / ;
) ;
put '/ ;' / / ;

put 'set urb(z) "Urban zone" /' / ;
loop(z$urb(z),
   strlen = card(z.tl) ;
   put '   ', z.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', z.te(z), '"' / ;
) ;
put '/ ;' / / ;

put 'set nsg(z) "Both zones" /' / ;
loop(z$nsg(z),
   strlen = card(z.tl) ;
   put '   ', z.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', z.te(z), '"' / ;
) ;
put '/ ;' / / ;

maxcol1 = smax(z, card(z.tl)) ;
put 'set mapz(z,a) "Mapping of activities to zones" /' / ;
loop(mapzf(z,actf)$(not nsg(z)),
   strlen = card(actf.tl) ;
   put '   ', z.tl:<maxcol1, '.', actf.tl:<strlen, '-a' / ;
) ;
put '/ ;' / / ;

put 'mapz("nsg", a) = yes ;' / / ;

*  >>>>> Commodity sets and subsets

put 'set frt(i) "Fertilizer commodities" /' / ;
loop(commf$frt(commf),
   strlen = card(commf.tl) ;
   put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+5), '"', commf.te(commf), '"' / ;
) ;
put '/ ;' / / ;

put 'set feed(i) "Feed commodities" /' / ;
loop(commf$feed(commf),
   strlen = card(commf.tl) ;
   put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+5), '"', commf.te(commf), '"' / ;
) ;
put '/ ;' / / ;

put 'set iw(i) "Water services commodities" /' / ;
loop(commf$iw(commf),
   strlen = card(commf.tl) ;
   put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+5), '"', commf.te(commf), '"' / ;
) ;
put '/ ;' / / ;

put 'set e(i) "Energy commodities" /' / ;
loop(commf$e(commf),
   strlen = card(commf.tl) ;
   put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+5), '"', commf.te(commf), '"' / ;
) ;
put '/ ;' / / ;

put 'set elyc(i) "Electricity commodities" /' / ;
loop(commf$elyc(commf),
   strlen = card(commf.tl) ;
   put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+5), '"', commf.te(commf), '"' / ;
) ;
put '/ ;' / / ;

put 'set fuel(e) "Fuel commodities" /' / ;
loop(e$f(e),
   strlen = card(e.tl) ;
   put '   ', e.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+5), '"', e.te(e), '"' / ;
) ;
put '/ ;' / / ;

set imga(commf) ;
loop(mapa(img0,i),
   imga(commf)$mapif(i,commf) = yes ;
) ;

put 'set img(i) "Margin commodities" /' / ;
loop(commf$imga(commf),
   strlen = card(commf.tl) ;
   put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+5), '"', commf.te(commf), '"' / ;
) ;
put '/ ;' / / ;

put 'set k "Household commodities" /' / ;
loop(k,
   strlen = card(k.tl) ;
   put '   ', k.tl:<strlen, '-k', ' ':(maxstrlen-(strlen+2)+5), '"', k.te(k), '"' / ;
) ;
put '/ ;' / / ;

put 'set fud(k) "Household food commodities" /' / ;
loop(k$fud(k),
   strlen = card(k.tl) ;
   put '   ', k.tl:<strlen, '-k', ' ':(maxstrlen-(strlen+2)+5), '"', k.te(k), '"' / ;
) ;
put '/ ;' / / ;

put 'set mapk(i,k) "Mapping from i to k" /' / ;
loop(mapk(commf,k),
   strlen = card(commf.tl) ;
   put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+1), '.', k.tl:card(k.tl), '-k' / ;
) ;
put '/ ;' / / ;

put 'set elya(a) "Power activities" /' / ;
loop(actf$elya(actf),
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set etd(a) "Electricity transmission and distribution activities" /' / ;
loop(actf$etd(actf),
   strlen = card(actf.tl) ;
   put '   ', actf.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', actf.te(actf), '"' / ;
) ;
put '/ ;' / / ;

put 'set primElya(a) "Primary power activities" /' / ;
loop(elya$primElya(elya),
   strlen = card(elya.tl) ;
   put '   ', elya.tl:<strlen, '-a', ' ':(maxstrlen-(strlen+2)+5), '"', elya.te(elya), '"' / ;
) ;
put '/ ;' / / ;

put 'set pb "Power bundles in power aggregation" /' / ;
loop(pb,
   strlen = card(pb.tl) ;
   put '   ', pb.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', pb.te(pb), '"' / ;
) ;
put '/ ;' / / ;

put 'set mappow(pb,elya) "Mapping of power activities to power bundles" /' / ;
loop(mappow(pb,elya),
   strlen = card(pb.tl) ;
   put '   ', pb.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', elya.tl:card(elya.tl), '-a' / ;
) ;
put '/ ;' / / ;

put 'set lb "Land bundles" /' / ;
loop(lb,
   strlen = card(lb.tl) ;
   put '   ', lb.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', lb.te(lb), '"' / ;
) ;
put '/ ;' / / ;

put 'set lb1(lb) "First land bundle" /' / ;
loop(lb$lb1(lb),
   strlen = card(lb.tl) ;
   put '   ', lb.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', lb.te(lb), '"' / ;
) ;
put '/ ;' / / ;

put 'set maplb(lb,a) "Mapping of activities to land bundles" /' / ;
loop(maplb(lb,actf),
   strlen = card(lb.tl) ;
   put '   ', lb.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', actf.tl:card(actf.tl), '-a' / ;
) ;
put '/ ;' / / ;

put 'set lh "Market condition flags" /' / ;
put '   lo    "Market downswing"' / ;
put '   hi    "Market upswing"' / ;
put '/ ;' / / ;

put 'set wbnd "Aggregate water markets" /' / ;
loop(wbnd,
   strlen = card(wbnd.tl) ;
   put '   ', wbnd.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', wbnd.te(wbnd), '"' / ;
) ;
put '/ ;' / / ;

put 'set wbnd1(wbnd) "Top level water markets" /' / ;
loop(wbnd$wbnd1(wbnd),
   strlen = card(wbnd.tl) ;
   put '   ', wbnd.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', wbnd.te(wbnd), '"' / ;
) ;
put '/ ;' / / ;

put 'set wbnd2(wbnd) "Second level water markets" /' / ;
loop(wbnd$wbnd2(wbnd),
   strlen = card(wbnd.tl) ;
   put '   ', wbnd.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', wbnd.te(wbnd), '"' / ;
) ;
put '/ ;' / / ;

put 'set wbndex(wbnd) "Second level water markets" /' / ;
loop(wbnd$wbndex(wbnd),
   strlen = card(wbnd.tl) ;
   put '   ', wbnd.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', wbnd.te(wbnd), '"' / ;
) ;
put '/ ;' / / ;

put 'set mapw1(wbnd,wbnd) "Mapping of first level water bundles" /' / ;
loop(mapw1(wbnd1,wbnd2),
   strlen = card(wbnd1.tl) ;
   put '   ', wbnd1.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', wbnd2.tl / ;
) ;
put '/ ;' / / ;

put 'set mapw2(wbnd,a) "Mapping of second level water bundle" /' / ;
loop(mapw2(wbnd2,actf),
   strlen = card(wbnd2.tl) ;
   put '   ', wbnd2.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', actf.tl:card(actf.tl), '-a' / ;
) ;
put '/ ;' / / ;

put 'set wbnda(wbnd) "Water bundles mapped one-to-one to activities" /' / ;
loop(wbnd$wbnda(wbnd),
   strlen = card(wbnd.tl) ;
   put '   ', wbnd.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', wbnd.te(wbnd), '"' / ;
) ;
put '/ ;' / / ;

put 'set wbndi(wbnd) "Water bundles mapped to aggregate output" /' / ;
loop(wbnd$wbndi(wbnd),
   strlen = card(wbnd.tl) ;
   put '   ', wbnd.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', wbnd.te(wbnd), '"' / ;
) ;
put '/ ;' / / ;

put 'set NRG "Energy bundles used in model" /' / ;
loop(NRG,
   strlen = card(nrg.tl) ;
   put '   ', NRG.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', NRG.te(NRG), '"' / ;
) ;
put '/ ;' / / ;

put 'set coa(NRG) "Coal bundle used in model" /' / ;
loop(nrg$coa(NRG),
   strlen = card(nrg.tl) ;
   put '   ', NRG.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', NRG.te(NRG), '"' / ;
) ;
put '/ ;' / / ;

put 'set oil(NRG) "Oil bundle used in model" /' / ;
loop(nrg$oil(NRG),
   strlen = card(nrg.tl) ;
   put '   ', NRG.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', NRG.te(NRG), '"' / ;
) ;
put '/ ;' / / ;

put 'set gas(NRG) "Gas bundle used in model" /' / ;
loop(nrg$gas(NRG),
   strlen = card(nrg.tl) ;
   put '   ', NRG.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', NRG.te(NRG), '"' / ;
) ;
put '/ ;' / / ;

put 'set ely(NRG) "Electricity bundle used in model" /' / ;
loop(nrg$ely(NRG),
   strlen = card(nrg.tl) ;
   put '   ', NRG.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', NRG.te(NRG), '"' / ;
) ;
put '/ ;' / / ;

put 'set mape(NRG,e) "Mapping of energy commodities to energy bundles" /' / ;
loop(mape(nrg,e),
   strlen = card(nrg.tl) ;
   put '   ', nrg.tl:<strlen, ' ':(maxstrlen-(strlen)+1), '.', e.tl:card(e.tl), '-c' / ;
) ;
put '/ ;' / / ;

put 'set em "Emission types" /' / ;
loop(em,
   strlen = card(em.tl) ;
   put '   ', em.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', em.te(em), '"' / ;
) ;
put '/ ;' / / ;

put 'set emn(em) "Non-CO2 emission types" /' / ;
loop(em$emn(em),
   strlen = card(em.tl) ;
   put '   ', em.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', em.te(em), '"' / ;
) ;
put '/ ;' / / ;

put 'set ghg(em) "Greenhouse gas emission types" /' / ;
loop(em$ghg(em),
   strlen = card(em.tl) ;
   put '   ', em.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', em.te(em), '"' / ;
) ;
put '/ ;' / / ;

put 'set nghg(em) "Non greenhouse gas emission types" /' / ;
loop(em$nghg(em),
   strlen = card(em.tl) ;
   put '   ', em.tl:<strlen, ' ':(maxstrlen-(strlen)+5), '"', em.te(em), '"' / ;
) ;
put '/ ;' / / ;

put 'set emq "Emission quantities" /' / ;
put '   gt          "Gigatons"' / ;
put '   ceq         "Carbon equivalent"' / ;
put '   co2eq       "CO2 equivalent"' / ;
put '/ ;' / / ;

put 'set mapi1(i,a) "Mapping of commodities to ND1 bundle" /' / ;
loop(actf$acr(actf),
   loop(commf$(not frt(commf) and not e(commf) and not iw(commf)),
      strlen = card(commf.tl) ;
      put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+1), '.', actf.tl:card(actf.tl), '-a' / ;
   ) ;
) ;
loop(actf$alv(actf),
   loop(commf$(not feed(commf) and not e(commf) and not iw(commf)),
      strlen = card(commf.tl) ;
      put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+1), '.', actf.tl:card(actf.tl), '-a' / ;
   ) ;
) ;
loop(actf$(not acr(actf) and not alv(actf)),
   loop(commf$(not e(commf) and not iw(commf)),
      strlen = card(commf.tl) ;
      put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+1), '.', actf.tl:card(actf.tl), '-a' / ;
   ) ;
) ;
put '/ ;' / / ;

put 'set mapi2(i,a) "Mapping of commodities to ND2 bundle" /' / ;
loop(actf$acr(actf),
   loop(commf$frt(commf),
      strlen = card(commf.tl) ;
      put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+1), '.', actf.tl:card(actf.tl), '-a' / ;
   ) ;
) ;
loop(actf$alv(actf),
   loop(commf$feed(commf),
      strlen = card(commf.tl) ;
      put '   ', commf.tl:<strlen, '-c', ' ':(maxstrlen-(strlen+2)+1), '.', actf.tl:card(actf.tl), '-a' / ;
   ) ;
) ;
put '/ ;' / / ;

$ontext
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

put 'set nsk(l) "Unskilled types for labor growth assumptions" /' / /;
loop(l$(not skl(l)),
   put '   ', l.tl:<maxstrlen, '     "', l.te(l), '"' / ;
) ;
put '/ ;' / / ;

put 'set skl(l)  "Skill types for labor growth assumptions" /' / /;
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
$offtext

*  Initialize carbon coalitions

put 'set rq(ra) "Regions submitted to an emissions cap" ;' / ;
put 'rq(ra) = no ;' / / ;
