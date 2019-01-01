if(sameas(tsim,"shock"),
   loop(t0,
      pnum.fx(tsim) = 1.5*pnum.l(t0) ;
      mtax.fx(r,i,rp,tsim) = 1.0*mtax.l(r,i,rp,t0) ;
      mtaxa.fx(r,i,rp,aa,tsim) = 1.0*mtaxa.l(r,i,rp,aa,t0) ;
      lambdaw(r,i,"SSA",tsim) = 1.0*lambdaw(r,i,"SSA",t0) ;
   ) ;

$ontext
   ntmFlag = 1 ;
   ntmY.lo(r,tsim) = -inf ;
   ntmY.up(r,tsim) = +inf ;
   ntmAVE.fx(r,"TextWapp-c",s,tsim) = 0.05 ;
   chigNTM(r,r,tsim) = 1 ;
$offtext

*  kappak.fx("Oceania",a,tsim) = 0*kappak.l("Oceania",a,tsim) ;

$ontext
   ifEmiCap = 1 ;
   emFlag("CO2") = 1 ;
   rq("hic")     = yes ;

   emicap.fx("hic","co2",tsim) =
        0.90*EmiTot0("Oceania","CO2")*EmiTot.l("Oceania","CO2",tsim-1)
      + 0.83*EmiTot0("NAmerica","CO2")*EmiTot.l("NAmerica","CO2",tsim-1)
      + 0.83*EmiTot0("EU_28","CO2")*EmiTot.l("EU_28","CO2",tsim-1) ;

   emiRegTax.lo(rq,"CO2",tsim) = -inf ;
   emiRegTax.up(rq,"CO2",tsim) = +inf ;
   loop(r$mapr("hic",r),
      emiTax.lo(r,"CO2",tsim) = -inf ;
      emiTax.up(r,"CO2",tsim) = +inf ;
   ) ;
$offtext

$ontext
   ifEmiCap = 1 ;
   emFlag("CO2") = 1 ;
   rq("Oceania")     = yes ;
   rq("NAmerica")    = yes ;
   rq("EU_28")       = yes ;

   emiCap.fx("Oceania","CO2",tsim)     = 0.90*EmiTot0("Oceania","CO2")*EmiTot.l("Oceania","CO2",tsim-1) ;
   emiCap.fx("NAmerica","CO2",tsim)    = 0.83*EmiTot0("NAmerica","CO2")*EmiTot.l("NAmerica","CO2",tsim-1) ;
   emiCap.fx("EU_28","CO2",tsim)       = 0.83*EmiTot0("EU_28","CO2")*EmiTot.l("EU_28","CO2",tsim-1) ;

   loop(rq$(sameas(rq,"Oceania") or sameas(rq,"NAmerica") or sameas(rq,"EU_28")),
      emiRegTax.lo(rq,"CO2",tsim) = -inf ;
      emiRegTax.up(rq,"CO2",tsim) = +inf ;
      emiTax.lo(r,"CO2",tsim)$mapr(rq,r) = -inf ;
      emiTax.up(r,"CO2",tsim)$mapr(rq,r) = +inf ;
   ) ;
$offtext

$ontext
   ifEmiCap      = 1 ;
   emFlag("CO2") = 1 ;
   rq("wld") = yes ;
   emiCap.fx(rq,"CO2",tsim) = 0.90*emiGbl.l("CO2", tsim-1)*emiGbl0("CO2") ;
   emiRegTax.lo(rq,"CO2",tsim) = -inf ;
   emiRegTax.up(rq,"CO2",tsim) = +inf ;
   emiTax.lo(r,"CO2",tsim) = -inf ;
   emiTax.up(r,"CO2",tsim) = +inf ;
   emiRegTax.l(rq,"CO2",tsim) = 0.001*40 ;
   emiTax.l(r,"CO2",tsim)     = emiRegTax.l("wld","CO2",tsim) ;
$offtext
*  emiTax.fx(r,"CO2",tsim) = 0.001*40 ;
) ;
