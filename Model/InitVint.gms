work = 0.01 ;

loop((vOld, vNew),
   xpx.l(r,a,vNew,tsim)   = work*xpx.l(r,a,vOld,tsim) ;
   xghg.l(r,a,vNew,tsim)  = work*xghg.l(r,a,vOld,tsim) ;
   va.l(r,a,vNew,tsim)    = work*va.l(r,a,vOld,tsim) ;
   kef.l(r,a,vNew,tsim)   = work*kef.l(r,a,vOld,tsim) ;
   va1.l(r,a,vNew,tsim)   = work*va1.l(r,a,vOld,tsim) ;
   va2.l(r,a,vNew,tsim)   = work*va2.l(r,a,vOld,tsim) ;
   kf.l(r,a,vNew,tsim)    = work*kf.l(r,a,vOld,tsim) ;
   xnrg.l(r,a,vNew,tsim)  = work*xnrg.l(r,a,vOld,tsim) ;
   ksw.l(r,a,vNew,tsim)   = work*ksw.l(r,a,vOld,tsim) ;
   ks.l(r,a,vNew,tsim)    = work*ks.l(r,a,vOld,tsim) ;
   kv.l(r,a,vNew,tsim)    = work*kv.l(r,a,vOld,tsim) ;
   xpv.l(r,a,vNew,tsim)   = work*xpv.l(r,a,vOld,tsim) ;
   kxrat.l(r,a,vNew,tsim) = kxRat.l(r,a,vOld,tsim) ;
   if(ifNRGNest,
      xnely.l(r,a,vNew,tsim)     = work*xnely.l(r,a,vOld,tsim) ;
      xolg.l(r,a,vNew,tsim)      = work*xolg.l(r,a,vOld,tsim) ;
      xaNRG.l(r,a,NRG,vNew,tsim) = work*xaNRG.l(r,a,NRG,vOld,tsim) ;
   ) ;
) ;
