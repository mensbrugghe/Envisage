sam(r,i,aa,t)      = (gammaeda(r,i,aa)*pat.l(r,i,t)*xa.l(r,i,aa,t)*(pat0(r,i)*xa0(r,i,aa)))$(ArmFlag eq 0)
                   + (gammaedd(r,i,aa)*pdt.l(r,i,t)*xd.l(r,i,aa,t)*(pdt0(r,i)*xd0(r,i,aa))
                   +  gammaedm(r,i,aa)*((pmt0(r,i)*pmt.l(r,i,t))$(not MRIO) + (pma0(r,i,aa)*pma.l(r,i,aa,t))$MRIO)
                   *    xm.l(r,i,aa,t)*xm0(r,i,aa))$(ArmFlag)
                   ;

sam(r,"itax",aa,t) = sum(i,
     (paTax.l(r,i,aa,t)*gammaeda(r,i,aa)*pat.l(r,i,t)*xa.l(r,i,aa,t)*(pat0(r,i)*xa0(r,i,aa)))$(ArmFlag eq 0)
   + (pdTax.l(r,i,aa,t)*gammaedd(r,i,aa)*pdt.l(r,i,t)*xd.l(r,i,aa,t)*(pdt0(r,i)*xd0(r,i,aa))
   +  pmTax.l(r,i,aa,t)*gammaedm(r,i,aa)
   *     ((pmt0(r,i)*pmt.l(r,i,t))$(not MRIO) + (pma0(r,i,aa)*pma.l(r,i,aa,t))$MRIO)
   *     xm.l(r,i,aa,t)*xm0(r,i,aa))$(ArmFlag)
   ) ;
sam(r,"itax",fd,t) = sam(r,"itax",fd,t) ;

sam(r,"wtax",h,t)  = sum(i$hWasteFlag(r,i,h), (xawc0(r,i,h)*xawc.l(r,i,h,t))*(pa0(r,i,h)*pa.l(r,i,h,t)*wtaxh.l(r,i,h,t)
                   +    wtaxhx.l(r,i,h,t)*pfd0(r,h)*pfd.l(r,h,t))) ;

sam(r,"ctax",aa,t) = sum((i,em),
     (chiEmi.l(em,t)*emir(r,em,i,aa)*part(r,em,i,aa)*emiTax.l(r,em,t)*xa.l(r,i,aa,t)*xa0(r,i,aa))$(ArmFlag eq 0)
   + (chiEmi.l(em,t)*emird(r,em,i,aa)*part(r,em,i,aa)*emiTax.l(r,em,t)*xd.l(r,i,aa,t)*xd0(r,i,aa)
   +  chiEmi.l(em,t)*emirm(r,em,i,aa)*part(r,em,i,aa)*emiTax.l(r,em,t)*xm.l(r,i,aa,t)*xm0(r,i,aa))$ArmFlag
   ) ;

sam(r,"ctax",fd,t) = sam(r,"ctax",fd,t) ;
sam(r,"ptax",i,t)  = sum(a,ptax.l(r,a,i,t)*p.l(r,a,i,t)*p0(r,a,i)*x.l(r,a,i,t)*x0(r,a,i)) ;
sam(r,"ptax",a,t)  = sum(v, uc.l(r,a,v,t)*uctax.l(r,a,v,t)*xpv.l(r,a,v,t)*(uc0(r,a)*xpv0(r,a))) ;

sam(r,f,a,t) = pf.l(r,f,a,t)*xf.l(r,f,a,t)*pf0(r,f,a)*xf0(r,f,a) ;
sam(r,"vtax",a,t) = sum(f, pfTax.l(r,f,a,t)*pf.l(r,f,a,t)*xf.l(r,f,a,t)*pf0(r,f,a)*xf0(r,f,a)) ;

loop(gov,
   sam(r,gov,gy,t) = ygov.l(r,gy,t)*ygov0(r,gy) ;
) ;

sam(r,a,i,t) = p.l(r,a,i,t)*x.l(r,a,i,t)*p0(r,a,i)*x0(r,a,i) ;

loop(h,

   sam(r,h,f,t) =
      sum(a, (1-kappaf.l(r,f,a,t))*pf.l(r,f,a,t)*xf.l(r,f,a,t)*pf0(r,f,a)*xf0(r,f,a)) ;
   sam(r,h,l,t) = sam(r,h,l,t) - (sum(rp, remit.l(rp,l,r,t)*remit0(rp,l,r))) ;
   sam(r,"dtax",f,t) =
      sum(a, kappaf.l(r,f,a,t)*pf.l(r,f,a,t)*xf.l(r,f,a,t)*pf0(r,f,a)*xf0(r,f,a)) ;
   sam(r,"bop",l,t) = sum(rp, remit.l(rp,l,r,t)*remit0(rp,l,r)) ;
   sam(r,h,"bop",t) = sum((rp,l), remit.l(r,l,rp,t)*remit0(r,l,rp)) ;

   loop(cap,
      sam(r,h,cap,t)     = sam(r,h,cap,t) - yqtf.l(r,t)*yqtf0(r) ;
      sam(r,"bop",cap,t) = yqtf.l(r,t)*yqtf0(r) ;
      sam(r,h,"bop",t)   = sam(r,h,"bop",t) + yqht.l(r,t)*yqht0(r) ;
   ) ;
   sam(r,"deprY",h,t) = deprY.l(r,t)*deprY0(r) ;

) ;

loop(h,
   sam(r,"dtax",h,t)  = kappah.l(r,t)*yh.l(r,t)*yh0(r) ;
   loop(inv,
      sam(r,inv,h,t)  = savh.l(r,h,t)*savh0(r,h) ;
   ) ;
) ;
loop(gov,
   loop(inv,
      sam(r,inv,gov,t) = savg.l(r,t) ;
   ) ;
   sam(r,gov,"bop",t) = sum(em,emiQuotaY.l(r,em,t)) ;
   sam(r,gov,"BoP",t) = ODAIn.l(r,t)*ODAIn0(r) ;
   sam(r,"BoP",gov,t) = ODAOut.l(r,t)*ODAOut0(r) ;
) ;
loop(inv,
   sam(r,inv,"deprY",t) = deprY.l(r,t)*deprY0(r) ;
   sam(r,inv,"bop",t)   = pwsav.l(t)*savf.l(r,t) ;
) ;

loop(i,
   sam(r,i,"tmg",t)  = pdt.l(r,i,t)*xtt.l(r,i,t)*(pdt0(r,i)*xtt0(r,i)) ;
   if(ifaggTrade,
*     Aggregate exports at FOB prices
      sam(r,i,"trd",t)  = sum(rp, pwe.l(r,i,rp,t)*xw.l(r,i,rp,t)*pwe0(r,i,rp)*xw0(r,i,rp)) ;
*     Aggregate imports at FOB prices
      sam(r,"trd",i,t)  = sum(rp, pwe.l(rp,i,r,t)*xw.l(rp,i,r,t)*pwe0(rp,i,r)*xw0(rp,i,r)) ;
   else
*     Exports at FOB prices
      sam(r,i,d,t)      = pwe.l(r,i,d,t)*xw.l(r,i,d,t)*pwe0(r,i,d)*xw0(r,i,d) ;
*     Imports at FOB prices
      sam(r,s,i,t)      = pwe.l(s,i,r,t)*xw.l(s,i,r,t)*pwe0(s,i,r)*xw0(s,i,r) ;
   ) ;

*  'Imports' of trade margin services

   sam(r,"tmg",i,t)  = sum(s, (pwm.l(s,i,r,t)*lambdaw(s,i,r,t)*pwm0(s,i,r)
                     -     pwe.l(s,i,r,t)*pwe0(s,i,r))*xw.l(s,i,r,t)*xw0(s,i,r)) ;

*  Import tariff revenue

   sam(r,"mtax",i,t) = (sum(s, mtax.l(s,i,r,t)*pwm.l(s,i,r,t)*lambdaw(s,i,r,t)*xw.l(s,i,r,t)
                     *     (pwm0(s,i,r)*xw0(s,i,r))))$(not MRIO)
                     + (sum((s,aa), mtaxa.l(s,i,r,aa,t)*pwm0(s,i,r)*pwm.l(s,i,r,t)*xwa0(s,i,r,aa)*xwa.l(s,i,r,aa,t)))$MRIO ;

*  NTM revenue

   sam(r,"ntmY",i,t) = (sum(s, ntmAVE.l(s,i,r,t)*pwm.l(s,i,r,t)*lambdaw(s,i,r,t)*xw.l(s,i,r,t)
                     *     (pwm0(s,i,r)*xw0(s,i,r))))$(not MRIO)
                     + (sum((s,aa), mtaxa.l(s,i,r,aa,t)*pwm0(s,i,r)*pwm.l(s,i,r,t)*xwa0(s,i,r,aa)*xwa.l(s,i,r,aa,t)))$MRIO ;

   sam(r,gov,"ntmY",t) = sum(s, chigNTM(s,r,t)*ntmY.l(r,t)*ntmY0(r)) ;
   sam(r,h,"ntmY",t)   = sum(s, chihNTM(s,r,t)*ntmY.l(r,t)*ntmY0(r)) ;

*  Export tax revenue

   sam(r,"etax",i,t) = sum(rp, (pwe.l(r,i,rp,t)*pwe0(r,i,rp)
                     -     pe.l(r,i,rp,t)*pe0(r,i,rp))*xw.l(r,i,rp,t)*xw0(r,i,rp)) ;
) ;

sam(r, "tmg", "bop", t) = sum(i,pdt.l(r,i,t)*xtt.l(r,i,t)*(pdt0(r,i)*xtt0(r,i)))
                        - sum(i, sam(r,"tmg",i,t)) ;

if(ifaggTrade,
   sam(r, "trd", "bop", t) = sum((i,rp), pwe.l(r,i,rp,t)*pwe0(r,i,rp)*xw.l(r,i,rp,t)*xw0(r,i,rp)) ;
   sam(r, "bop", "trd", t) = sum((i,rp), pwe.l(rp,i,r,t)*pwe0(rp,i,r)*xw.l(rp,i,r,t)*xw0(rp,i,r)) ;
else
   loop(rp,
      sam(r, rp, "bop", t) = sum(i, pwe.l(r,i,rp,t)*pwe0(r,i,rp)*xw.l(r,i,rp,t)*xw0(r,i,rp)) ;
      sam(r, "bop", rp, t) = sum(i, pwe.l(rp,i,r,t)*pwe0(rp,i,r)*xw.l(rp,i,r,t)*xw0(rp,i,r)) ;
   ) ;
) ;
