rs(rr) = no ;

ifGbl = 0 ;

for(riter=1 to nriter by 1, loop(rr,

*  Loop over region rr

   rs(rr) = yes ;
*
*  Fix PE prices and update import prices
*
   pe.fx(r,i,rp,tsim)  = pe.l(r,i,rp,tsim) ;

*  Fix global flows

   xw.fx(r,i,rp,tsim)  = xw.l(r,i,rp,tsim) ;
   xtt.fx(r,img,tsim)  = xtt.l(r,img,tsim) ;
   pdt.fx(r,img,tsim)  = pdt.l(r,img,tsim) ;

*  Exogenize global trust

   trustY.fx(tsim) = trustY.l(tsim) ;

*  Exogenize remittance inflows

   remit.fx(r,l,rp,tsim)$(not rs(rp)) = remit.l(r,l,rp,tsim) ;

*  Endogenize imports

   xw.lo(rp,i,r,tsim)$(xwFlag(rp,i,r) and rs(r)) = -inf ;
   xw.up(rp,i,r,tsim)$(xwFlag(rp,i,r) and rs(r)) = +inf ;

*  Endogenize exports

   xw.lo(r,i,rp,tsim)$(xwFlag(r,i,rp) and rs(r) and omegaw(r,i) ne inf) = -inf ;
   xw.up(r,i,rp,tsim)$(xwFlag(r,i,rp) and rs(r) and omegaw(r,i) ne inf) = +inf ;

*  Endogenize pd and xtt

   pdt.lo(r,i,tsim)$(rs(r) and xdtFlag(r,i) ne 0) = -inf ;
   pdt.up(r,i,tsim)$(rs(r) and xdtFlag(r,i) ne 0) = +inf ;
   xtt.lo(r,img,tsim)$(rs(r) and xttFlag(r,img) ne 0) = -inf ;
   xtt.up(r,img,tsim)$(rs(r) and xttFlag(r,img) ne 0) = +inf ;

*  solve

*  !!!! Need to change this so that is solves using NLP

   solve %1 using mcp ;

   put screen ;
   if (%1.solvestat eq 1,
      put // "Solved iteration ", riter:<2:0, " out of ", nriter:2:0,
             " iteration(s) for region ", rr.tl, " in year ", years(tsim):4:0 // ;
   else
      execute_unload "%odir%\%SIMNAME%.gdx" ; ;
      put // "Failed to solve for iteration ", riter:<2:0, " out of ", nriter:2:0,
             " iteration(s) for region ", rr.tl, " in year ", years(tsim):4:0 // ;
      Abort$(1) "Solution failure" ;
   ) ;
   putclose screen ;

   rs(r) = no ;

)) ;
*
*  --- include all regions again
*
rs(r) = yes ;
ifGbl = 1 ;
*
*  --- release bounds on variables fixed in individual solves
*      and introduce original lower bounds
*
pe.lo(r,i,rp,tsim)$xwFlag(r,i,rp) = 0.001*pe.l(r,i,rp,tsim) ;
pe.up(r,i,rp,tsim)$xwFlag(r,i,rp) = +inf ;

xw.lo(rp,i,r,tsim)$xwFlag(r,i,rp) = -inf;
xw.up(rp,i,r,tsim)$xwFlag(r,i,rp) = +inf;

pdt.lo(r,i,tsim)$xdtFlag(r,i) = -inf ;
pdt.up(r,i,tsim)$xdtFlag(r,i) = +inf ;

xtt.lo(r,img,tsim)$xttFlag(r,img) = -inf ;
xtt.up(r,img,tsim)$xttFlag(r,img) = +inf ;

trustY.lo(tsim)$trustY0 = -inf ;
trustY.up(tsim)$trustY0 = +inf ;

remit.lo(r,l,rp,tsim)$remit0(r,l,rp) = -inf ;
remit.up(r,l,rp,tsim)$remit0(r,l,rp) = +inf ;

if(ifMCP,
   solve %1 using mcp ;
else
   solve %1 using nlp maximizing obj ;
) ;

put screen ;
if (%1.solvestat eq 1,
   put // "Solved global model in year ", years(tsim):4:0 // ;
else
   execute_unload "%odir%\%SIMNAME%.gdx" ; ;
   put // "Failed to solve global model in year ", years(tsim):4:0 // ;
   Abort$(1) "Solution failure" ;
) ;
putclose screen ;

*  Update substituted out variables

if(ifSUB,
   $$onDotL

   pp.l(r,a,i,tsim)   = PP_SUB(r,a,i,tsim) ;

   pa.l(r,i,aa,tsim)  = PA_SUB(r,i,aa,tsim) ;
   pd.l(r,i,aa,tsim)  = PD_SUB(r,i,aa,tsim) ;
   pm.l(r,i,aa,tsim)  = PM_SUB(r,i,aa,tsim) ;

   pwe.l(r,i,rp,tsim) = PWE_SUB(r,i,rp,tsim) ;
   pwm.l(r,i,rp,tsim) = PWM_SUB(r,i,rp,tsim) ;
   pdm.l(r,i,rp,tsim) = PDM_SUB(r,i,rp,tsim) ;

   if(MRIO,
      pdma.l(s,i,r,aa,tsim) = PDMA_SUB(s,i,r,aa,tsim) ;
   ) ;

   pwmg.l(r,i,rp,tsim) = PWMG_SUB(r,i,rp,tsim) ;
   xwmg.l(r,i,rp,tsim)$xwmg0(r,i,rp) = XWMG_SUB(r,i,rp,tsim) ;
   xmgm.l(img,r,i,rp,tsim)$xmgm0(img,r,i,rp) = XMGM_SUB(img,r,i,rp,tsim) ;

   pfp.l(r,f,a,tsim) = PFP_SUB(r,f,a,tsim) ;

   $$offDotL
) ;

*  Update income and price elasticities

omegaad.fx(r,h)
      = (sum(k$xcFlag(r,k,h), (betaad.l(r,k,h,tsim)-alphaad.l(r,k,h,tsim))
      *     log(xc.l(r,k,h,tsim)*xc0(r,k,h)/(pop0(r)*pop.l(r,tsim)) - gammac.l(r,k,h,tsim)))
      - power(1+exp(u.l(r,h,tsim)*u0(r,h)),2)*exp(-u.l(r,h,tsim)*u0(r,h)))
      $(%utility% eq AIDADS)

      + 1$(%utility% ne AIDADS)
      ;

omegaad.fx(r,h) = 1/omegaad.l(r,h) ;

etah.l(r,k,h,tsim)$xcFlag(r,k,h)

   = (muc0(r,k,h)*muc.l(r,k,h,tsim)/((pc.l(r,k,h,tsim)*xc.l(r,k,h,tsim)
   *                      pc0(r,k,h)*xc0(r,k,h))/(yd.l(r,tsim)*yd0(r))))$(%utility% eq ELES)

   + ((muc.l(r,k,h,tsim)*muc0(r,k,h) - (betaad.l(r,k,h,tsim)-alphaad.l(r,k,h,tsim))*omegaad.l(r,h))
   / (hshr0(r,k,h)*hshr.l(r,k,h,tsim)))$(%utility% eq AIDADS or %utility% eq LES)

   + ((eh.l(r,k,h,tsim)*bh.l(r,k,h,tsim)
   - sum(kp$xcFlag(r,kp,h), hshr0(r,kp,h)*hshr.l(r,kp,h,tsim)*eh.l(r,kp,h,tsim)*bh.l(r,kp,h,tsim)))
   / sum(kp$xcFlag(r,kp,h), hshr0(r,kp,h)*hshr.l(r,kp,h,tsim)*eh.l(r,kp,h,tsim))
   - (bh.l(r,k,h,tsim)-1)
   + sum(kp$xcFlag(r,kp,h), hshr0(r,kp,h)*hshr.l(r,kp,h,tsim)*bh.l(r,kp,h,tsim)))$(%utility% eq CDE)
   ;

epsh.l(r,k,kp,h,tsim)$(xcFlag(r,k,h) and xcFlag(r,kp,h))

   = (-muc0(r,k,h)*muc.l(r,k,h,tsim)*pc.l(r,kp,h,tsim)*pop.l(r,tsim)*gammac.l(r,kp,h,tsim)
   *  pc0(r,kp,h)/(pc.l(r,k,h,tsim)*xc.l(r,k,h,tsim)*pc0(r,k,h)*xc0(r,k,h))
   - kron(k,kp)*(1 - pop.l(r,tsim)*gammac.l(r,k,h,tsim)*pop0(r)
   / (xc.l(r,k,h,tsim)*xc0(r,k,h))))$(%utility% eq ELES)

   + ((muc.l(r,kp,h,tsim)*muc0(r,kp,h)-kron(k,kp))
   *  (muc.l(r,k,h,tsim)*muc0(r,k,h)*supy0(r,h)*supy.l(r,h,tsim))
   /  (hshr0(r,k,h)*hshr.l(r,k,h,tsim)*((yd.l(r,tsim)-(savh.l(r,h,tsim)*(savh0(r,h)/yd0(r))))/pop.l(r,tsim))
   *  (yd0(r)/pop0(r))) - (hshr0(r,kp,h)*hshr.l(r,kp,h,tsim)*etah.l(r,k,h,tsim)))
   $(%utility% eq AIDADS or %utility% eq LES)

   + (hshr0(r,kp,h)*hshr.l(r,kp,h,tsim)*(-bh.l(r,kp,h,tsim)
   - (eh.l(r,k,h,tsim)*bh.l(r,k,h,tsim)
   - sum(k1$xcFlag(r,k1,h), hshr0(r,k1,h)*hshr.l(r,k1,h,tsim)*eh.l(r,k1,h,tsim)*bh.l(r,k1,h,tsim)))
   /  sum(k1$xcFlag(r,k1,h), hshr0(r,k1,h)*hshr.l(r,k1,h,tsim)*eh.l(r,k1,h,tsim)))
   + kron(k,kp)*(bh.l(r,k,h,tsim)-1))$(%utility% eq CDE)
   ;

* display epsh.l ;
