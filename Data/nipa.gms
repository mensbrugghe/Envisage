* ----------------------------------------------------------------------------------------
*
*  NIPA accounts -- before aggregation
*
* ----------------------------------------------------------------------------------------

set n / gdp, cons, govt, invt, expt, impt, ittm / ;

Parameters
   nipa(n, r0)
;

Parameter weight(n) /
   gdp    0
   cons   1
   govt   1
   invt   1
   expt   1
   impt  -1
   ittm   1
/ ;

nipa("cons", r0) = sum(comm, vdpp(comm, r0) + vmpp(comm, r0)) ;
nipa("govt", r0) = sum(comm, vdgp(comm, r0) + vmgp(comm, r0)) ;
nipa("invt", r0) = sum(comm, vdip(comm, r0) + vmip(comm, r0)) ;
nipa("expt", r0) = sum((comm, rp0), vfob(comm, r0, rp0)) ;
nipa("impt", r0) = sum((comm, rp0), vcif(comm, rp0, r0)) ;
nipa("ittm", r0) = sum(img0, vst(img0, r0)) ;
nipa("gdp", r0)  = sum(n, weight(n)*nipa(n,r0)) ;

file nipacsv / nipa.csv / ;
put nipacsv ;
put "Var,Region,Value" / ;
nipacsv.pc=5 ;
nipacsv.nd=9 ;

loop((n,r0),
   put n.tl, r0.tl, nipa(n, r0) / ;
) ;
loop(r0,
   put "Pop", r0.tl, pop(r0) / ;
) ;

file ncsv / nrgsubs.csv / ;
put ncsv ;
put "Var,Region,NRG,Agent,Value" / ;
ncsv.pc=5 ;
ncsv.nd=9 ;

$iftheni.POW %IFPOWER% == "ON"
set ea(i0) / coa, oil, gas, p_c,
             TND, NUCLEARBL, COALBL, GASBL, WINDBL, HYDROBL, OILBL, OTHERBL, GASP, HYDROP, OILP, SOLARP,
             gdt / ;
set es(i0) / coa, oil, gas, p_c,
             TND, NUCLEARBL, COALBL, GASBL, WINDBL, HYDROBL, OILBL, OTHERBL, GASP, HYDROP, OILP, SOLARP,
             gdt / ;
$else.POW
set ea(i0) / coa, oil, gas, p_c, ely, gdt / ;
set es(i0) / coa, oil, gas, p_c, ely, gdt / ;
$endif.POW

loop((r0,ea),
   if(ptax(ea,ea,r0) lt 0, put "PTAX", r0.tl, ea.tl, ea.tl, (-ptax(ea,ea,r0)) / ; ) ;
   if((evfp("capital",ea,r0)-evfb("capital",ea,r0)) lt 0, put "KTAX", r0.tl, "", ea.tl, (-(evfp("capital",ea,r0)-evfb("capital",ea,r0))) / ; ) ;
   if((evfp("NatlRes",ea,r0)-evfb("NatlRes",ea,r0)) lt 0, put "NTAX", r0.tl, "", ea.tl, (-(evfp("NatlRes",ea,r0)-evfb("NatlRes",ea,r0))) / ; ) ;
) ;
loop((r0,es),
   loop(i0,
      if((vdfp(es,i0,r0)-vdfb(es,i0,r0)) lt 0, put "DTAX", r0.tl, es.tl, i0.tl, (-(vdfp(es,i0,r0)-vdfb(es,i0,r0))) / ; ) ;
      if((vmfp(es,i0,r0)-vmfb(es,i0,r0)) lt 0, put "MTAX", r0.tl, es.tl, i0.tl, (-(vmfp(es,i0,r0)-vmfb(es,i0,r0))) / ; ) ;
   ) ;
   if((vdpp(es,r0)-vdpb(es,r0)) lt 0, put "DTAX", r0.tl, es.tl, "HH",  (-(vdpp(es,r0)-vdpb(es,r0))) / ; ) ;
   if((vdgp(es,r0)-vdgb(es,r0)) lt 0, put "DTAX", r0.tl, es.tl, "GOV", (-(vdgp(es,r0)-vdgb(es,r0))) / ; ) ;
   if((vdip(es,r0)-vdib(es,r0)) lt 0, put "DTAX", r0.tl, es.tl, "INV", (-(vdip(es,r0)-vdib(es,r0))) / ; ) ;
   if((vmpp(es,r0)-vmpb(es,r0)) lt 0, put "MTAX", r0.tl, es.tl, "HH",  (-(vmpp(es,r0)-vmpb(es,r0))) / ; ) ;
   if((vmgp(es,r0)-vmgb(es,r0)) lt 0, put "MTAX", r0.tl, es.tl, "GOV", (-(vmgp(es,r0)-vmgb(es,r0))) / ; ) ;
   if((vmip(es,r0)-vmib(es,r0)) lt 0, put "MTAX", r0.tl, es.tl, "GOV", (-(vmip(es,r0)-vmib(es,r0))) / ; ) ;
) ;

putclose nipacsv ;
putclose ncsv ;

* ----------------------------------------------------------------------------------------
*
*  NIPA accounts -- after aggregation
*
* ----------------------------------------------------------------------------------------

Parameters
   nipa1(n, r)
;

nipa1("cons", r) = sum(i, vdpp1(i,r) + vmpp1(i, r)) ;
nipa1("govt", r) = sum(i, vdgp1(i, r) + vmgp1(i, r)) ;
nipa1("invt", r) = sum(i, vdip1(i, r) + vmip1(i, r)) ;
nipa1("expt", r) = sum((i, rp), vfob1(i, r, rp)) ;
nipa1("impt", r) = sum((i, rp), vcif1(i, rp, r)) ;
nipa1("ittm", r) = sum(i, vst1(i, r)) ;
nipa1("gdp", r)  = sum(n, weight(n)*nipa1(n,r)) ;

file nipa1csv / nipa1.csv / ;
put nipa1csv ;
put "Var,Region,Value" / ;
nipa1csv.pc=5 ;
nipa1csv.nd=9 ;

loop((n,r),
   put n.tl, r.tl, nipa1(n, r) / ;
) ;
loop(r,
   put "Pop", r.tl, pop1(r) / ;
) ;
putclose nipa1csv ;

$ontext
*  Special section for energy subsidies information--linked to specific aggregations

file ncsv1 / nrg1subs.csv / ;
put ncsv1 ;
put "Var,Region,NRG,Agent,Value" / ;
ncsv1.pc=5 ;
ncsv1.nd=9 ;

set ea1(i) / coa, oil, gas, p_c, ely / ;
set es1(i) / coa, oil, gas, p_c, ely / ;

* scalar ssign / -1 / ;

loop((r,ea1),
   if(osep1(ea1,r) gt 0, put "OSEP", r.tl, "", ea1.tl, (-ssign*osep1(ea1,r)) / ; ) ;
   if((evfa1("cap",ea1,r)-vfm1("cap",ea1,r)) lt 0, put "KTAX", r.tl, "", ea1.tl, (ssign*(evfa1("cap",ea1,r)-vfm1("cap",ea1,r))) / ; ) ;
   if((evfa1("nrs",ea1,r)-vfm1("nrs",ea1,r)) lt 0, put "NTAX", r.tl, "", ea1.tl, (ssign*(evfa1("nrs",ea1,r)-vfm1("nrs",ea1,r))) / ; ) ;
) ;
loop((r,es1),
   loop(i,
      if((vdfa1(es1,i,r)-vdfm1(es1,i,r)) lt 0, put "DTAX", r.tl, es1.tl, i.tl, (ssign*(vdfa1(es1,i,r)-vdfm1(es1,i,r))) / ; ) ;
      if((vifa1(es1,i,r)-vifm1(es1,i,r)) lt 0, put "MTAX", r.tl, es1.tl, i.tl, (ssign*(vifa1(es1,i,r)-vifm1(es1,i,r))) / ; ) ;
   ) ;
   if((vdpp1(es1,r)-vdpm1(es1,r)) lt 0, put "DTAX", r.tl, es1.tl, "HH",  (ssign*(vdpp1(es1,r)-vdpm1(es1,r))) / ; ) ;
   if((vdgp1(es1,r)-vdgm1(es1,r)) lt 0, put "DTAX", r.tl, es1.tl, "GOV", (ssign*(vdgp1(es1,r)-vdgm1(es1,r))) / ; ) ;
   if((vdfa1(es1,"CGDS",r)-vdfm1(es1,"CGDS",r)) lt 0, put "DTAX", r.tl, es1.tl, "INV", (ssign*(vdfa1(es1,"CGDS",r)-vdfm1(es1,"CGDS",r))) / ; ) ;
   if((vmpp1(es1,r)-vipm1(es1,r)) lt 0, put "MTAX", r.tl, es1.tl, "HH",  (ssign*(vmpp1(es1,r)-vipm1(es1,r))) / ; ) ;
   if((vmgp1(es1,r)-vigm1(es1,r)) lt 0, put "MTAX", r.tl, es1.tl, "GOV", (ssign*(vmgp1(es1,r)-vigm1(es1,r))) / ; ) ;
   if((vifa1(es1,"CGDS",r)-vifm1(es1,"CGDS",r)) lt 0, put "MTAX", r.tl, es1.tl, "INV", (ssign*(vifa1(es1,"CGDS",r)-vifm1(es1,"CGDS",r))) / ; ) ;
) ;
putclose ncsv1 ;
$offtext
