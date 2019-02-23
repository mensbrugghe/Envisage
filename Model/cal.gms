* --------------------------------------------------------------------------------------------------
*
*  Calibrate the production CES nests
*
* --------------------------------------------------------------------------------------------------

loop(vOld,
   axp(r,a,v,t)$xpFlag(r,a)  = (xpx.l(r,a,vOld,t)/xpv.l(r,a,vOld,t))
                * (pxp.l(r,a,vOld,t)/uc.l(r,a,vOld,t))**sigmaxp(r,a,v) ;
   aghg(r,a,v,t)$xpFlag(r,a) = (xghg.l(r,a,vOld,t)/xpv.l(r,a,vOld,t))
                * (pxghg.l(r,a,vOld,t)/uc.l(r,a,vOld,t))**sigmaxp(r,a,v) ;

   and1(r,a,v,t)$xpFlag(r,a)  = (nd1.l(r,a,t)/xpx.l(r,a,vOld,t))
                * (pnd1.l(r,a,t)/pxp.l(r,a,vOld,t))**sigmap(r,a,v) ;
   ava(r,a,v,t)$xpFlag(r,a)  = (va.l(r,a,vOld,t)/xpx.l(r,a,vOld,t))
                * (pva.l(r,a,vOld,t)/pxp.l(r,a,vOld,t))**sigmap(r,a,v) ;

   alab1(r,a,v,t)$xpFlag(r,a)
      = ((lab1.l(r,a,t)/va.l(r,a,vOld,t))*(plab1.l(r,a,t)/pva.l(r,a,vOld,t))**sigmav(r,a,v))
      $acr(a)
      + ((lab1.l(r,a,t)/va1.l(r,a,vOld,t))*(plab1.l(r,a,t)/pva1.l(r,a,vOld,t))**sigmav1(r,a,v))
      $alv(a)
      + ((lab1.l(r,a,t)/va.l(r,a,vOld,t))*(plab1.l(r,a,t)/pva.l(r,a,vOld,t))**sigmav(r,a,v))
      $ax(a)
      ;

   akef(r,a,v,t)$kefFlag(r,a)
      = ((kef.l(r,a,vOld,t)/va2.l(r,a,vOld,t))*(pkef.l(r,a,vOld,t)/pva2.l(r,a,vOld,t))
      **sigmav2(r,a,v))$acr(a)
      + ((kef.l(r,a,vOld,t)/va1.l(r,a,vOld,t))*(pkef.l(r,a,vOld,t)/pva1.l(r,a,vOld,t))
      **sigmav1(r,a,v))$alv(a)
      + ((kef.l(r,a,vOld,t)/va1.l(r,a,vOld,t))*(pkef.l(r,a,vOld,t)/pva1.l(r,a,vOld,t))
      **sigmav1(r,a,v))$ax(a)
      ;

   and2(r,a,v,t)$nd2Flag(r,a)
      = ((nd2.l(r,a,t)/va1.l(r,a,vOld,t))*(pnd2.l(r,a,t)/pva1.l(r,a,vOld,t))
      **sigmav1(r,a,v))$acr(a)
      + ((nd2.l(r,a,t)/va2.l(r,a,vOld,t))*(pnd2.l(r,a,t)/pva2.l(r,a,vOld,t))
      **sigmav2(r,a,v))$alv(a)
      ;

   ava1(r,a,v,t)$va1Flag(r,a)
      = ((va1.l(r,a,vOld,t)/va.l(r,a,vOld,t))*(pva1.l(r,a,vOld,t)/pva.l(r,a,vOld,t))
      **sigmav(r,a,v))$acr(a)
      + ((va1.l(r,a,vOld,t)/va.l(r,a,vOld,t))*(pva1.l(r,a,vOld,t)/pva.l(r,a,vOld,t))
      **sigmav(r,a,v))$alv(a)
      + ((va1.l(r,a,vOld,t)/va.l(r,a,vOld,t))*(pva1.l(r,a,vOld,t)/pva.l(r,a,vOld,t))
      **sigmav(r,a,v))$ax(a)
      ;

   ava2(r,a,v,t)$va2Flag(r,a)
      = ((va2.l(r,a,vOld,t)/va1.l(r,a,vOld,t))*(pva2.l(r,a,vOld,t)/pva1.l(r,a,vOld,t))
      **sigmav1(r,a,v))$acr(a)
      + ((va2.l(r,a,vOld,t)/va.l(r,a,vOld,t))*(pva2.l(r,a,vOld,t)/pva.l(r,a,vOld,t))
      **sigmav(r,a,v))$alv(a)
      ;

   loop(lnd,
      aland(r,a,v,t)$xfFlag(r,lnd,a) =
           ((xf.l(r,lnd,a,t)/va2.l(r,a,vOld,t))*(pfp.l(r,lnd,a,t)/pva2.l(r,a,vOld,t))
         **sigmav2(r,a,v))$(acr(a) or alv(a))
         + ((xf.l(r,lnd,a,t)/va1.l(r,a,vOld,t))*(pfp.l(r,lnd,a,t)/pva1.l(r,a,vOld,t))
         **sigmav1(r,a,v))$ax(a)
         ;
   ) ;

   akf(r,a,v,t)$kfFlag(r,a)  = (kf.l(r,a,vOld,t)/kef.l(r,a,vOld,t))
                             * (pkf.l(r,a,vOld,t)/pkef.l(r,a,vOld,t))**sigmakef(r,a,v) ;
   ae(r,a,v,t)$kfFlag(r,a)   = (xnrg.l(r,a,vOld,t)/kef.l(r,a,vOld,t))
                             * (pnrg.l(r,a,vOld,t)/pkef.l(r,a,vOld,t))**sigmakef(r,a,v) ;

   aksw(r,a,v,t)$kFlag(r,a)   = (ksw.l(r,a,vOld,t)/kf.l(r,a,vOld,t))
                              * (pksw.l(r,a,vOld,t)/pkf.l(r,a,vOld,t))**sigmakf(r,a,v) ;
   loop(nrs,
      anrs(r,a,v,t)$xfFlag(r,nrs,a) = (xf.l(r,nrs,a,t)/kf.l(r,a,vOld,t))
                                    * (pfp.l(r,nrs,a,t)/pkf.l(r,a,vOld,t))**sigmakf(r,a,v) ;
   ) ;

   aks(r,a,v,t)$kFlag(r,a)    = (ks.l(r,a,vOld,t)/ksw.l(r,a,vOld,t))
                              * (pks.l(r,a,vOld,t)/pksw.l(r,a,vOld,t))**sigmakw(r,a,v) ;
   awat(r,a,v,t)$watFlag(r,a) = (xwat.l(r,a,t)/ksw.l(r,a,vOld,t))
                              * (pwat.l(r,a,t)/pksw.l(r,a,vOld,t))**sigmakw(r,a,v) ;

   loop(wat,
      af(r,wat,a,t)$xfFlag(r,wat,a) = (xf.l(r,wat,a,t)/xwat.l(r,a,t))
                                    * (pf.l(r,wat,a,t)/pwat.l(r,a,t))**sigmawat(r,a) ;
   ) ;

   ak(r,a,v,t)$kFlag(r,a)       = (kv.l(r,a,vOld,t)/ks.l(r,a,vOld,t))
                                * (pkp.l(r,a,vOld,t)/pks.l(r,a,vOld,t))**sigmak(r,a,v) ;
   alab2(r,a,v,t)$lab2Flag(r,a) = (lab2.l(r,a,t)/ks.l(r,a,vOld,t))
                                * (plab2.l(r,a,t)/pks.l(r,a,vOld,t))**sigmak(r,a,v) ;

   af(r,l,a,t)$xfFlag(r,l,a)
      = ((xf.l(r,l,a,t)/lab1.l(r,a,t))*(pfp.l(r,l,a,t)/plab1.l(r,a,t))**sigmaul(r,a))$ul(l)
      + ((xf.l(r,l,a,t)/lab2.l(r,a,t))*(pfp.l(r,l,a,t)/plab2.l(r,a,t))**sigmasl(r,a))$sl(l)
      ;

   aio(r,i,a,t)$xaFlag(r,i,a)
      = ((xa.l(r,i,a,t)/nd1.l(r,a,t))*(pa.l(r,i,a,t)/pnd1.l(r,a,t))**sigman1(r,a))$mapi1(i,a)
      + ((xa.l(r,i,a,t)/nd2.l(r,a,t))*(pa.l(r,i,a,t)/pnd2.l(r,a,t))**sigman2(r,a))$mapi2(i,a)
      + ((xa.l(r,i,a,t)/xwat.l(r,a,t))*(pa.l(r,i,a,t)/pwat.l(r,a,t))**sigmawat(r,a))$iw(i)
      ;

*  NRG bundle -- !!!! needs to be refined

   if(ifNRGNest,

      anely(r,a,v,t)$xnrgFlag(r,a)       = (xnely.l(r,a,vOld,t)/xnrg.l(r,a,vOld,t))
         *(pnely.l(r,a,vOld,t)/pnrg.l(r,a,vOld,t))**sigmae(r,a,v) ;
      aNRG(r,a,"ELY",v,t)$xnrgFlag(r,a)  = (xaNRG.l(r,a,"ELY",vOld,t)/xnrg.l(r,a,vOld,t))
         *(paNRG.l(r,a,"ELY",vOld,t)/pnrg.l(r,a,vOld,t))**sigmae(r,a,v) ;
      aolg(r,a,v,t)$xnelyFlag(r,a)       = (xolg.l(r,a,vOld,t)/xnely.l(r,a,vOld,t))
         *(polg.l(r,a,vOld,t)/pnely.l(r,a,vOld,t))**sigmanely(r,a,v) ;
      aNRG(r,a,"COA",v,t)$xnelyFlag(r,a) = (xaNRG.l(r,a,"COA",vOld,t)/xnely.l(r,a,vOld,t))
         *(paNRG.l(r,a,"COA",vOld,t)/pnely.l(r,a,vOld,t))**sigmanely(r,a,v) ;
      aNRG(r,a,"GAS",v,t)$xolgFlag(r,a)  = (xaNRG.l(r,a,"GAS",vOld,t)/xolg.l(r,a,vOld,t))
         *(paNRG.l(r,a,"GAS",vOld,t)/polg.l(r,a,vOld,t))**sigmaOLG(r,a,v) ;
      aNRG(r,a,"OIL",v,t)$xolgFlag(r,a)  = (xaNRG.l(r,a,"OIL",vOld,t)/xolg.l(r,a,vOld,t))
         *(paNRG.l(r,a,"OIL",vOld,t)/polg.l(r,a,vOld,t))**sigmaOLG(r,a,v) ;

      aeio(r,e,a,v,t)$xaFlag(r,e,a)
         = sum(NRG$mape(NRG,e), (xa.l(r,e,a,t)/xaNRG.l(r,a,NRG,vOld,t))
               *(pa.l(r,e,a,t)/paNRG.l(r,a,NRG,vOld,t))**sigmaNRG(r,a,NRG,v)) ;

   else

      aeio(r,e,a,v,t)$xaFlag(r,e,a)
         = (xa.l(r,e,a,t)/xnrg.l(r,a,vOld,t))*(pa.l(r,e,a,t)/pnrg.l(r,a,vOld,t))**sigmae(r,a,v) ;

   ) ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Calibrate the 'make/use' module
*
* --------------------------------------------------------------------------------------------------

loop(t0,
   gp(r,a,i)$xpFlag(r,a) = ((x.l(r,a,i,t0)/xp.l(r,a,t0))*(px.l(r,a,t0)/p.l(r,a,i,t0))**omegas(r,a))
                         $(omegas(r,a) ne inf)
                         + ((p.l(r,a,i,t0)*x.l(r,a,i,t0))/(px.l(r,a,t0)*xp.l(r,a,t0)))
                         $(omegas(r,a) eq inf)
                         ;
   as(r,a,i)$xsFlag(r,i) = ((x.l(r,a,i,t0)/xs.l(r,i,t0))*(pp.l(r,a,i,t0)/ps.l(r,i,t0))**sigmas(r,i))
                         $(sigmas(r,i) ne inf)
                         + ((pp.l(r,a,i,t0)*x.l(r,a,i,t0))
                         /    (ps.l(r,i,t0)*xs.l(r,i,t0)))
                         $(sigmas(r,i) eq inf)
                         ;

*  Calibrate power module

   if(IFPOWER,

      loop((r,elya,pb,elyc)$(mappow(pb,elya) and x.l(r,elya,elyc,t0)),
         as(r,elya,elyc)$xpb.l(r,pb,elyc,t0)
                     = (x.l(r,elya,elyc,t0)/xpb.l(r,pb,elyc,t0))
                     * (pp.l(r,elya,elyc,t0)/ppbndx.l(r,pb,elyc,t0))
                     **sigmapb(r,pb,elyc) ;
      ) ;

      apb(r,pb,elyc)$xpow.l(r,elyc,t0)
                     = (xpb.l(r,pb,elyc,t0)/xpow.l(r,elyc,t0))
                     * (ppb.l(r,pb,elyc,t0)/ppowndx.l(r,elyc,t0))**sigmapow(r,elyc) ;

      as(r,etd,elyc)$xs.l(r,elyc,t0)
                     = (x.l(r,etd,elyc,t0)/xs.l(r,elyc,t0))
                     * (pp.l(r,etd,elyc,t0)/ps.l(r,elyc,t0))**sigmael(r,elyc) ;
      apow(r,elyc)$xs.l(r,elyc,t0)
                     = (xpow.l(r,elyc,t0)/xs.l(r,elyc,t0))
                     * (ppow.l(r,elyc,t0)/ps.l(r,elyc,t0))**sigmael(r,elyc) ;

   else
      apb(r,pb,elyc) = 0 ;
      apow(r,elyc)   = 0 ;
   ) ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Calibrate income distribution parameters
*
* --------------------------------------------------------------------------------------------------

*  Capital income allocation parameters

ydistf(r,t) = sum((a,cap), (1 - kappaf.l(r,cap,a,t))*pf.l(r,cap,a,t)*xf.l(r,cap,a,t)) ;
ydistf(r,t)$ydistf(r,t)   = yqtf.l(r,t) / ydistf(r,t) ;
chiTrust(r,t)$trustY.l(t) = yqht.l(r,t)/trustY.l(t) ;

*  Remittance parameters

*  Calculated pre-tax

chiRemit(rp,l,r,t)$remit.l(rp,l,r,t)
   = remit.l(rp,l,r,t)/sum(a, (1-kappaf.l(r,l,a,t))*pf.l(r,l,a,t)*xf.l(r,l,a,t)) ;

*  ODA parameters

loop(t0,
   chiODAOut(r,t) = (OdaOut.l(r,t0)/GDPMP.l(r,t0)) ;
   chiOdaIn(r,t)$ODAGbl.l(t0) = ODAin.l(r,t0)/ODAGbl.l(t0) ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Calibrate final demand
*
* --------------------------------------------------------------------------------------------------

etah.fx(r,k,h,t) = incElas(k,r) ;

yd0(r)        = 1 ;
zcons0(r,k,h) = 1 ;
xc0(r,k,h)    = 1 ;
hshr0(r,k,h)  = 1 ;
pc0(r,k,h)    = 1 ;
supy0(r,h)    = 1 ;
pop0(r)       = 1 ;
savh0(r,h)    = 1 ;
muc0(r,k,h)   = 1 ;

*  Define the ELES calibration model

model elescal / supyeq, xceq / ;
elescal.holdfixed = 1 ;

if(%utility% = ELES,

*  ELES parameters

   loop(h,
      muc.fx(r,k,h,t) = etah.l(r,k,h,t)*pc.l(r,k,h,t)*xc.l(r,k,h,t)/yd.l(r,t) ;
      mus.fx(r,h,t)   = 1 - sum(k, muc.l(r,k,h,t)) ;
   ) ;

*  Initialize the gamma parameters and supy

   loop(h,
      gammac.l(r,k,h,t) = 0.1*xc.l(r,k,h,t)/pop.l(r,t) ;
      supy.l(r,h,t)  = yd.l(r,t)/pop.l(r,t) - sum(k, pc.l(r,k,h,t)*gammac.l(r,k,h,t)) ;
   ) ;

   betac.fx(r,h,t) = 1 ;

*  Fix temporarily the other variables

   yd.fx(r,t)        = yd.l(r,t) ;
   pc.fx(r,k,h,t)    = pc.l(r,k,h,t) ;
   xc.fx(r,k,h,t)    = xc.l(r,k,h,t) ;

   ts(t) = no ; ts(t0) = yes ;

*  Solve for the subsistence minima

   options limcol=0, limrow=0 ;
   options solprint=off ;
   solve elescal using mcp ;

*  Re-endogenize variables

   yd.lo(r,t)      = -inf  ; yd.up(r,t)     = +inf ;
   pc.lo(r,k,h,t)  = -inf  ; pc.up(r,k,h,t) = +inf ;
   xc.lo(r,k,h,t)  = -inf  ; xc.up(r,k,h,t) = +inf ;
   muc.lo(r,k,h,t) = -inf  ; muc.up(r,k,h,t) = +inf ;
   etah.lo(r,k,h,t) = -inf ; etah.up(r,k,h,t) = +inf ;

   loop(t0,
      gammac.l(r,k,h,t) = gammac.l(r,k,h,t0) ;
      supy.l(r,h,t)     = supy.l(r,h,t0) ;
   ) ;

   ts(t) = no ;

*  !!!! if uFlag = 0, the input data should be fixed

   loop(t0,
      uFlag(r,h)$(supy.l(r,h,t0) gt 0 and mus.l(r,h,t0) gt 0) = 1 ;
   ) ;
   u.l(r,h,t)$uFlag(r,h) = supy.l(r,h,t)
                    / (prod(k$xcFlag(r,k,h), (pc.l(r,k,h,t)/muc.l(r,k,h,t))**muc.l(r,k,h,t))
                    * ((pfd.l(r,h,t)/mus.l(r,h,t))**mus.l(r,h,t))) ;
   u.l(r,h,t)$(not uFlag(r,h)) = 1 ;

   loop(t0,
      aad.fx(r,h,t) = exp(sum(k$xcFlag(r,k,h),
                               muc.l(r,k,h,t0)*log(xc.l(r,k,h,t0)/pop.l(r,t0) - gammac.l(r,k,h,t0)))
                    +         (mus.l(r,h,t0)*log(savh.l(r,h,t0)/pop.l(r,t0)))$(savh.l(r,h,t0) > 0)
                    - u.l(r,h,t0) - 1) ;
   ) ;

   etah.l(r,k,h,t)$xcFlag(r,k,h) = muc.l(r,k,h,t)/((pc.l(r,k,h,t)*xc.l(r,k,h,t))/yd.l(r,t)) ;

   epsh.l(r,k,kp,h,t)$(xcFlag(r,k,h) and xcFlag(r,kp,h))
      = -muc.l(r,k,h,t)*pc.l(r,kp,h,t)*pop.l(r,t)*gammac.l(r,kp,h,t)/(pc.l(r,k,h,t)*xc.l(r,k,h,t))
      -  kron(k,kp)*(1 - pop.l(r,t)*gammac.l(r,k,h,t)/xc.l(r,k,h,t)) ;

elseif(%utility% = CD),

*  Cobb-Douglas

   betac.fx(r,h,t)   = 1 ;
   muc.l(r,k,h,t)$xcFlag(r,k,h)   = pc.l(r,k,h,t)*xc.l(r,k,h,t)
                                  / (yd.l(r,t) - savh.l(r,h,t)) ;
   gammac.l(r,k,h,t) = 0 ;
   supy.l(r,h,t) = (yd.l(r,t)-savh.l(r,h,t))/pop.l(r,t)
                 -  sum(k, pc.l(r,k,h,t)*gammac.l(r,k,h,t)) ;

   alphaad.fx(r,k,h,t) = muc.l(r,k,h,t) ;
   betaad.fx(r,k,h,t)  = muc.l(r,k,h,t) ;

   u.l(r,h,t) = 1 ;

   loop(t0,
      aad.fx(r,h,t) = exp(sum(k$xcFlag(r,k,h),
                              muc.l(r,k,h,t0)*log(xc.l(r,k,h,t0)/pop.l(r,t0) - gammac.l(r,k,h,t0)))
                    - u.l(r,h,t0) - 1) ;
   ) ;

   etah.l(r,k,h,t)$xcFlag(r,k,h) = 1 ;

   epsh.l(r,k,kp,h,t)$(xcFlag(r,k,h) and xcFlag(r,kp,h))
      = -1$(ord(k) eq ord(kp))
      +  0$(ord(k) ne ord(kp))
      ;

elseif(%utility% = LES or %utility% = AIDADS),

*  LES parameters

*  !!!! Needs to be replaced
*  Function calibrated to frisch(500) = -4, frisch(40000) = -1.10  with pc incomes in '000

   loop(t0,
      frisch(r,h,t) = -1.0/(1 - 0.770304*exp(-0.053423*rgdppc.l(r,t)*0.001*popScale/inScale)) ;
   ) ;

   display frisch ;

   betac.fx(r,h,t)   = 1 ;
   muc.l(r,k,h,t)$xcFlag(r,k,h)   = etah.l(r,k,h,t)*pc.l(r,k,h,t)*xc.l(r,k,h,t)
                                  / (yd.l(r,t) - savh.l(r,h,t)) ;
   gammac.l(r,k,h,t)$xcFlag(r,k,h) = (yd.l(r,t) - savh.l(r,h,t))*(hshr.l(r,k,h,t)
                                   + muc.l(r,k,h,t)/frisch(r,h,t))/pc.l(r,k,h,t) ;
   gammac.l(r,k,h,t) = gammac.l(r,k,h,t) / pop.l(r,t) ;
   supy.l(r,h,t) = (yd.l(r,t)-savh.l(r,h,t))/pop.l(r,t)
                 -  sum(k, pc.l(r,k,h,t)*gammac.l(r,k,h,t)) ;

   alphaad.fx(r,k,h,t) = muc.l(r,k,h,t) ;
   betaad.fx(r,k,h,t)  = muc.l(r,k,h,t) ;

   u.l(r,h,t) = 1 ;

   loop(t0,
      aad.fx(r,h,t) = exp(sum(k$xcFlag(r,k,h),
                              muc.l(r,k,h,t0)*log(xc.l(r,k,h,t0)/pop.l(r,t0) - gammac.l(r,k,h,t0)))
                    - u.l(r,h,t0) - 1) ;
   ) ;

   loop(t$t0(t),
      omegaad.fx(r,h)
         = sum(k$xcFlag(r,k,h), (betaad.l(r,k,h,t)-alphaad.l(r,k,h,t))
         *     log(xc.l(r,k,h,t)/pop.l(r,t) - gammac.l(r,k,h,t)))
         - power(1+exp(u.l(r,h,t)),2)*exp(-u.l(r,h,t)) ;
   ) ;
   omegaad.fx(r,h) = 1/omegaad.l(r,h) ;

   etah.l(r,k,h,t)$xcFlag(r,k,h) = (muc.l(r,k,h,t)
      - (betaad.l(r,k,h,t)-alphaad.l(r,k,h,t))*omegaad.l(r,h)) / hshr.l(r,k,h,t) ;

   epsh.l(r,k,kp,h,t)$(xcFlag(r,k,h) and xcFlag(r,kp,h))
      = (muc.l(r,kp,h,t)-kron(k,kp))
      * (muc.l(r,k,h,t)*supy.l(r,h,t))
      / (hshr.l(r,k,h,t)*((yd.l(r,t)-(savh.l(r,h,t)))/pop.l(r,t)))
      - (hshr.l(r,kp,h,t)*etah.l(r,k,h,t)) ;

elseif (%utility% = CDE),

*  !!!! TO BE REVIEWED

   u.l(r,h,t)     = 1 ;
   eh.fx(r,k,h,t) = eh0(k,r) ;
   bh.fx(r,k,h,t) = bh0(k,r) ;
   alphah.fx(r,k,h,t)$xcFlag(r,k,h) = (hshr.l(r,k,h,t)/bh.l(r,k,h,t))
      * (((yfd.l(r,h,t)/pop.l(r,t))/pc.l(r,k,h,t))**bh.l(r,k,h,t))
      * (u.l(r,h,t)**(-bh.l(r,k,h,t)*eh.l(r,k,h,t)))
      / sum(kp$xcFlag(r,kp,h), hshr.l(r,kp,h,t)/bh.l(r,kp,h,t)) ;

   zcons.l(r,k,h,t) = alphah.l(r,k,h,t)*bh.l(r,k,h,t)*(u.l(r,h,t)**(eh.l(r,k,h,t)*bh.l(r,k,h,t)))
                    *  (pc.l(r,k,h,t)/(yfd.l(r,h,t)/pop.l(r,t)))**bh.l(r,k,h,t) ;

   etah.l(r,k,h,t)$xcFlag(r,k,h) =
      (eh.l(r,k,h,t)*bh.l(r,k,h,t) - sum(kp$xcFlag(r,kp,h),
         hshr.l(r,kp,h,t)*eh.l(r,kp,h,t)*bh.l(r,kp,h,t)))
      / sum(kp$xcFlag(r,kp,h), hshr.l(r,kp,h,t)*eh.l(r,kp,h,t)) - (bh.l(r,k,h,t)-1)
      + sum(kp$xcFlag(r,kp,h), hshr.l(r,kp,h,t)*bh.l(r,kp,h,t)) ;

   epsh.l(r,k,kp,h,t)$(xcFlag(r,k,h) and xcFlag(r,kp,h)) =
      (hshr.l(r,kp,h,t)*(-bh.l(r,kp,h,t)
       - (eh.l(r,k,h,t)*bh.l(r,k,h,t) - sum(k1$xcFlag(r,k1,h),
          hshr.l(r,k1,h,t)*eh.l(r,k1,h,t)*bh.l(r,k1,h,t)))
       /  sum(k1$xcFlag(r,k1,h), hshr.l(r,k1,h,t)*eh.l(r,k1,h,t))) + kron(k,kp)*(bh.l(r,k,h,t)-1)) ;

*  Initialize the BaU levels to base year

   ehBaU(r,k,h,t) = eh.l(r,k,h,t) ;
   bhBaU(r,k,h,t) = bh.l(r,k,h,t) ;
) ;

*  Calibrate the rest of the consumer demand nesting

loop(t0,
   acxnnrg(r,k,h)$xcnnrgFlag(r,k,h)
      = (xcnnrg.l(r,k,h,t0)/xc.l(r,k,h,t0))
      * (pcnnrg.l(r,k,h,t0)/pc.l(r,k,h,t0))**nu(r,k,h) ;
   acxnrg(r,k,h)$xcnrgFlag(r,k,h)
      = (xcnrg.l(r,k,h,t0)/xc.l(r,k,h,t0))
      * (pcnrg.l(r,k,h,t0)/pc.l(r,k,h,t0))**nu(r,k,h) ;
   ac(r,i,k,h)$(xcnnrgFlag(r,k,h) and not e(i))
      = ((cmat(i,k,r)/pa.l(r,i,h,t0))/xcnnrg.l(r,k,h,t0))
      * (pa.l(r,i,h,t0)/pcnnrg.l(r,k,h,t0))**nunnrg(r,k,h) ;
   acnely(r,k,h,t)$xcnelyFlag(r,k,h)
      = (xcnely.l(r,k,h,t)/xcnrg.l(r,k,h,t0))
      * (pcnely.l(r,k,h,t0)/pcnrg.l(r,k,h,t0))**nue(r,k,h) ;
   acolg(r,k,h,t)$xcolgFlag(r,k,h)
      = (xcolg.l(r,k,h,t)/xcnely.l(r,k,h,t0))
      * (pcolg.l(r,k,h,t0)/pcnely.l(r,k,h,t0))**nunely(r,k,h) ;
   acNRG(r,k,h,NRG,t)$(xacNRGFlag(r,k,h,NRG) and ifNRGNest)
      = ((xacNRG.l(r,k,h,NRG,t0)/xcnrg.l(r,k,h,t0))*(pacNRG.l(r,k,h,NRG,t0)/pcnrg.l(r,k,h,t0))
      **nue(r,k,h))$ely(nrg)
      + ((xacNRG.l(r,k,h,NRG,t0)/xcnely.l(r,k,h,t0))*(pacNRG.l(r,k,h,NRG,t0)/pcnely.l(r,k,h,t0))
      **nunely(r,k,h))$coa(nrg)
      + ((xacNRG.l(r,k,h,NRG,t0)/xcolg.l(r,k,h,t0))*(pacNRG.l(r,k,h,NRG,t0)/pcolg.l(r,k,h,t0))
      **nuolg(r,k,h))$gas(nrg)
      + ((xacNRG.l(r,k,h,NRG,t0)/xcolg.l(r,k,h,t0))*(pacNRG.l(r,k,h,NRG,t0)/pcolg.l(r,k,h,t0))
      **nuolg(r,k,h))$oil(nrg)
   if(ifNRGNest,
     loop(mape(NRG,e),
        ac(r,e,k,h)$xacNRG.l(r,k,h,NRG,t0)
            = ((cmat(e,k,r)/pa.l(r,e,h,t0))/xacNRG.l(r,k,h,NRG,t0))
            * (pa.l(r,e,h,t0)/pacNRG.l(r,k,h,NRG,t0))**nuNRG(r,k,h,NRG) ;
     ) ;
   else
      ac(r,e,k,h)$xcnrg.l(r,k,h,t0)
            = ((cmat(e,k,r)/pa.l(r,e,h,t0))/xcnrg.l(r,k,h,t0))
            * (pa.l(r,e,h,t0)/pcnrg.l(r,k,h,t0))**nue(r,k,h) ;

   ) ;
) ;

*  Other final demand

sigmafd(r,fdc)$(sigmafd(r,fdc) eq 1) = 1.01 ;
alphafd(r,i,fdc,t)$fdflag(r,fdc)
   = (xa.l(r,i,fdc,t)/xfd.l(r,fdc,t))
   * (pa.l(r,i,fdc,t)/pfd.l(r,fdc,t))**sigmafd(r,fdc) ;

* --------------------------------------------------------------------------------------------------
*
*  Calibrate trade module
*
* --------------------------------------------------------------------------------------------------

sigmamt(r,i)$(sigmamt(r,i) eq 1.0) = 1.01 ;
sigmaw(r,i)$(sigmaw(r,i) eq 1.0)   = 1.01 ;

alphadt(r,i,t)$xddFlag(r,i) = ((xdt.l(r,i,t) - xtt.l(r,i,t))/xat.l(r,i,t))
                            *  (pdt.l(r,i,t)/pat.l(r,i,t))**sigmamt(r,i) ;
alphamt(r,i,t)$xmtFlag(r,i) = (xmt.l(r,i,t)/xat.l(r,i,t))
                            * (pmt.l(r,i,t)/pat.l(r,i,t))**sigmamt(r,i) ;

alphad(r,i,aa,t)$xdFlag(r,i,aa) = (xd.l(r,i,aa,t)/xa.l(r,i,aa,t))
                                * (pd.l(r,i,aa,t)/pa.l(r,i,aa,t))**sigmam(r,i,aa) ;
alpham(r,i,aa,t)$xmFlag(r,i,aa) = (xm.l(r,i,aa,t)/xa.l(r,i,aa,t))
                                * (pm.l(r,i,aa,t)/pa.l(r,i,aa,t))**sigmam(r,i,aa) ;

*  Second level Armington

lambdaw(r,i,rp,t) = 1 ;

if(not MRIO,
   sigmaw(r,i)$(sigmaw(r,i) eq 1) = 1.01 ;
   alphaw(rp,i,r,t)$xwFlag(rp,i,r) = (xw.l(rp,i,r,t)/xmt.l(r,i,t))
                                   * (pdm.l(rp,i,r,t)/pmt.l(r,i,t))**sigmaw(r,i) ;
else
   sigmaw(r,i)$(sigmaw(r,i) eq 1) = 1.01 ;
   sigmawa(r,i,aa) = sigmaw(r,i) ;
   alphawa(s,i,r,aa,t)$xwaFlag(s,i,r,aa) = (xwa.l(s,i,r,aa,t)/xm.l(r,i,aa,t))
                                         * (pdma.l(s,i,r,aa,t)/pma.l(r,i,aa,t))**sigmawa(r,i,aa) ;
) ;

*  Top level CET

gammad(r,i,t)$xdtFlag(r,i) = ((xdt.l(r,i,t)/xs.l(r,i,t))
                           *  (gammaesd(r,i)**(1+omegax(r,i)))
                           *  (ps.l(r,i,t)/pdt.l(r,i,t))**omegax(r,i))
                           $(omegax(r,i) ne inf)
                           + (pdt.l(r,i,t)*xdt.l(r,i,t) /(ps.l(r,i,t)*xs.l(r,i,t)))
                           $(omegax(r,i) eq inf) ;
gammae(r,i,t)$xetFlag(r,i) = ((xet.l(r,i,t)/xs.l(r,i,t))
                           *   (gammaese(r,i)**(1+omegax(r,i)))
                           *   (ps.l(r,i,t)/pet.l(r,i,t))**omegax(r,i))
                           $(omegax(r,i) ne inf)
                           + ((pet.l(r,i,t)*xet.l(r,i,t)/(ps.l(r,i,t)*xs.l(r,i,t))))
                           $(omegax(r,i) eq inf) ;

gammaw(r,i,rp,t)$xwFlag(r,i,rp) = ((xw.l(r,i,rp,t)/xet.l(r,i,t))
                                *  (gammaew(r,i,rp)**(1+omegaw(r,i)))
                                *  (pet.l(r,i,t)/pe.l(r,i,rp,t))**omegaw(r,i))
                                $(omegaw(r,i) ne inf)
                                + (pe.l(r,i,rp,t)*xw.l(r,i,rp,t)/(pet.l(r,i,t)*xet.l(r,i,t)))
                                $(omegaw(r,i) eq inf) ;

put screen ; put / ;
loop(t0,
   loop((img,r,i,rp),
      if(tmgFlag(r,i,rp) and xwmg.l(r,i,rp,t0) eq 0,
         put img.tl, r.tl, i.tl, rp.tl / ;
      ) ;
   ) ;
   amgm(img,r,i,rp)$tmgFlag(r,i,rp) = xmgm.l(img,r,i,rp,t0)/xwmg.l(r,i,rp,t0) ;
) ;

sigmamg(img)$(sigmamg(img) eq 1) = 1.01 ;
alphatt(r,img,t)$xttFlag(r,img)  = (xtt.l(r,img,t)/xtmg.l(img,t))
                                 * (pdt.l(r,img,t)/ptmg.l(img,t))**sigmamg(img) ;

* --------------------------------------------------------------------------------------------------
*
*  Calibration of factor supplies
*
* --------------------------------------------------------------------------------------------------

kronm(rur) = -1 ;
kronm(urb) = +1 ;

chim(r,l,t)$migrFlag(r,l) = migr.l(r,l,t)*urbPrem.l(r,l,t)**(-omegam(r,l)) ;

gammak(r,a,v,t) = ((kv.l(r,a,v,t)/tkaps.l(r,t))*(trent.l(r,t)/pk.l(r,a,v,t))**omegak(r))
                $(omegak(r) ne inf)
                + ((pk.l(r,a,v,t)*kv.l(r,a,v,t))/(trent.l(r,t)*tkaps.l(r,t)))
                $(omegak(r) eq inf)
                ;
if(sum((r,t0), tland.l(r,t0)) ne 0,
   loop(t0,

*     Curvature parameter in land supply function

      gammatl(r,t) = (etat(r))$(%TASS% eq KELAS)
                   + (etat(r)*(pgdpmp.l(r,t0)/ptland.l(r,t0))*(landmax.l(r,t0)
                   / (landmax.l(r,t0) - tland.l(r,t0))))$(%TASS% eq LOGIST)
                   + (etat(r)*tland.l(r,t0)/(landmax.l(r,t0) - tland.l(r,t0)))$(%TASS% eq HYPERB)
                   + (0)$(%TASS% eq INFTY)
                   ;

*     Shift parameter in land supply function

      chiLand(r,t) = (tland.l(r,t0)*(pgdpmp.l(r,t0)/ptland.l(r,t0))**etat(r))$(%TASS% eq KELAS)
                   + (exp(gammatl(r,t0)*(ptland.l(r,t0)/pgdpmp.l(r,t0)))
                   * ((landmax.l(r,t0) - tland.l(r,t0))/tland.l(r,t0)))$(%TASS% eq LOGIST)
                   + ((landmax.l(r,t0) - tland.l(r,t0))
                   * (ptland.l(r,t0)/pgdpmp.l(r,t0))**gammatl(r,t0))$(%TASS% eq HYPERB)
                   + (0)$(%TASS% eq INFTY)
                   ;
   ) ;

   loop(lb$lb1(lb),
      gamlb(r,lb,t)$tland.l(r,t) = ((xlb.l(r,lb,t)/tland.l(r,t))
                                 * (ptland.l(r,t)/plb.l(r,lb,t))**omegat(r))$(omegat(r) ne inf)
                                 + ((plb.l(r,lb,t)*xlb.l(r,lb,t))/(ptland.l(r,t)*tland.l(r,t)))
                                 $(omegat(r) eq inf)
                                 ;
   ) ;

*  display tland.l, xnlb.l, ptland.l, pnlb.l ;

   gamnlb(r,t)$tland.l(r,t) = ((xnlb.l(r,t)/tland.l(r,t))
                            *  (ptland.l(r,t)/pnlb.l(r,t))**omegat(r))$(omegat(r) ne inf)
                            + ((pnlb.l(r,t)*xnlb.l(r,t))
                            / (ptland.l(r,t)*tland.l(r,t)))$(omegat(r) eq inf)
                            ;

   loop(lb$(not lb1(lb)),
      gamlb(r,lb,t)$xnlb.l(r,t) = ((xlb.l(r,lb,t)/xnlb.l(r,t))
                                *  (pnlb.l(r,t)/plb.l(r,lb,t))**omeganlb(r))$(omeganlb(r) ne inf)
                                + ((plb.l(r,lb,t)*xlb.l(r,lb,t))/(pnlb.l(r,t)*xnlb.l(r,t)))
                                $(omeganlb(r) eq inf)
                                ;
   ) ;

   loop(maplb(lb,a),
      loop(lnd,
         gammat(r,a,t)$xlb.l(r,lb,t) = ((xf.l(r,lnd,a,t)/xlb.l(r,lb,t))
                                     *  (plb.l(r,lb,t)/pf.l(r,lnd,a,t))**omegalb(r,lb))
                                     $(omegalb(r,lb) ne inf)
                                     + ((pf.l(r,lnd,a,t)*xf.l(r,lnd,a,t))
                                     /  (plb.l(r,lb,t)*xlb.l(r,lb,t)))
                                     $(omegalb(r,lb) eq inf)
                                     ;
      ) ;
   ) ;
) ;

*  Natural resource supply

loop(nrs,

*  Set flag to infinity if either of the elasticities is infinite

   xfFlag(r,nrs,a)$(xfFlag(r,nrs,a) and (etanrsx(r,a,"lo") = inf or etanrsx(r,a,"hi") = inf)) = inf ;
   xnrsFlag(r,a) = xfFlag(r,nrs,a) ;

   etanrs.l(r,a,t)$(xfFlag(r,nrs,a) and xfFlag(r,nrs,a) ne inf)
      = etanrsx(r,a,"lo") + 0.5*(etanrsx(r,a,"hi") - etanrsx(r,a,"lo")) ;

   loop(t0,
      chinrsp(r,a)$xfFlag(r,nrs,a) = (pgdpmp.l(r,t0)/pf.l(r,nrs,a,t0))$(xfFlag(r,nrs,a) eq inf)
                                   + (1)$(xfFlag(r,nrs,a) ne inf) ;
   ) ;

   display  chinrsp ;

   wchinrs.fx(a,t)                  = 1 ;
   chinrs.fx(r,a,t)$xfFlag(r,nrs,a) = 1 ;
) ;


*  Water supply

if(IFWATER,
   loop(t0,

*     Curvature parameter in land supply function

      gammatw(r,t) = (etaw(r))$(%WASS% eq KELAS)
                   + (etaw(r)*(pgdpmp.l(r,t0)/pth2o.l(r,t0))*(H2OMax.l(r,t0)
                   / (H2OMax.l(r,t0) - th2o.l(r,t0))))$(%WASS% eq LOGIST)
                   + (etaw(r)*th2o.l(r,t0)/(H2OMax.l(r,t0) - th2o.l(r,t0)))$(%WASS% eq HYPERB)
                   + (0)$(%WASS% eq INFTY)
                   ;

*     Shift parameter in land supply function

      chiH2O(r,t)  = (th2o.l(r,t0)*(pgdpmp.l(r,t0)/pth2o.l(r,t0))**etaw(r))$(%WASS% eq KELAS)
                   + (exp(gammatw(r,t0)*(pth2o.l(r,t0)/pgdpmp.l(r,t0)))
                   *  ((H2OMax.l(r,t0) - th2o.l(r,t0))/th2o.l(r,t0)))$(%WASS% eq LOGIST)
                   + ((H2OMax.l(r,t0) - th2o.l(r,t0))
                   *  (pth2o.l(r,t0)/pgdpmp.l(r,t0))**gammatw(r,t0))$(%WASS% eq HYPERB)
                   + (0)$(%WASS% eq INFTY)
                   ;
   ) ;
) ;


loop(t0,

*  Land CET -- top level

   gam1h2o(r,wbnd1,t)$th2om.l(r,t)
       = ((h2obnd.l(r,wbnd1,t)/th2om.l(r,t))
       *  (pth2ondx.l(r,t)/ph2obnd.l(r,wbnd1,t))**omegaw1(r))$(omegaw1(r) ne inf)
       + (h2obnd.l(r,wbnd1,t)*h2obnd.l(r,wbnd1,t)/(pth2o.l(r,t)*th2om.l(r,t)))$(omegaw1(r) eq inf)
       ;

*  Second level CET

   loop(wbnd1,
      gam2h2o(r,wbnd2,t)$(mapw1(wbnd1,wbnd2) and h2obnd.l(r,wbnd1,t))
         = ((h2obnd.l(r,wbnd2,t)/h2obnd.l(r,wbnd1,t))
         *  (ph2obndndx.l(r,wbnd1,t)/ph2obnd.l(r,wbnd2,t))**omegaw2(r,wbnd1))
         $(omegaw2(r,wbnd1) ne inf)
         + ((ph2obnd.l(r,wbnd2,t)*h2obnd.l(r,wbnd2,t))*(ph2obnd.l(r,wbnd1,t)*h2obnd.l(r,wbnd1,t)))
         $(omegaw2(r,wbnd1) eq inf) ;
   ) ;

*  Activity level CET

   loop(wat,
      loop(wbnd2$wbnda(wbnd2),
         gam3h2o(r,a,t)$h2obnd.l(r,wbnd2,t)
            = ((xf.l(r,wat,a,t)/h2obnd.l(r,wbnd2,t))
            *  (ph2obndndx.l(r,wbnd2,t)/pf.l(r,wat,a,t))**omegaw2(r,wbnd2))$(omegaw2(r,wbnd2) ne inf)
            + ((pf.l(r,wat,a,t)*xf.l(r,wat,a,t))*(ph2obnd.l(r,wbnd2,t)*h2obnd.l(r,wbnd2,t)))
            $(omegaw2(r,wbnd2) eq inf) ;

      ) ;
   ) ;

*  Aggregate demand shifter

   loop(wbnd2$wbndi(wbnd2),
      ah2obnd(r,wbnd2,t)$h2obnd.l(r,wbnd2,t) = h2obnd.l(r,wbnd2,t)
         * (ph2obnd.l(r,wbnd2,t) / pgdpmp.l(r,t))**epsh2obnd(r,wbnd2) ;
   ) ;
) ;


* --------------------------------------------------------------------------------------------------
*
*  Miscellaneous calibration
*
* --------------------------------------------------------------------------------------------------

* --------------------------------------------------------------------------------------------------
*
*  Normalize variables
*
* --------------------------------------------------------------------------------------------------

$setGlobal IFNORM    1

$ifthen "%IFNORM%" == "1"

*  Turn on normalization

$macro normg0(varName,suffix) &varName&suffix = &varName.l(t0) ; varName.l(t) = 0 + 1$varName.l(t) ;
$macro normg1(varName,i__1,suffix) &varName&suffix(i__1) = &varName.l(i__1,t0) ; varName.l(i__1,t) = 0 + 1$varName.l(i__1,t) ;
$macro normg4(varName,i__1,i__2,i__3,i__4,suffix) &varName&suffix(i__1,i__2,i__3,i__4) = &varName.l(i__1,i__2,i__3,i__4,t0) ; varName.l(i__1,i__2,i__3,i__4,t) = 0 + 1$varName.l(i__1,i__2,i__3,i__4,t) ;
$macro norm0(varName,suffix) &varName&suffix(r) = &varName.l(r,t0) ; varName.l(r,t) = 0 + 1$varName.l(r,t) ;
$macro norm1(varName,i__1,suffix) &varName&suffix(r,i__1) = &varName.l(r,i__1,t0) ; varName.l(r,i__1,t) = 0 + 1$varName.l(r,i__1,t) ;
$macro norm2(varName,i__1,i__2,suffix) &varName&suffix(r,i__1,i__2) = &varName.l(r,i__1,i__2,t0) ; varName.l(r,i__1,i__2,t) = 0 + 1$varName.l(r,i__1,i__2,t) ;
$macro norm3(varName,i__1,i__2,i__3,suffix) &varName&suffix(r,i__1,i__2,i__3) = &varName.l(r,i__1,i__2,i__3,t0) ; varName.l(r,i__1,i__2,i__3,t) = 0 + 1$varName.l(r,i__1,i__2,i__3,t) ;
$macro norm1v(varName,i__1,suffix) loop(vOld, &varName&suffix(r,i__1) = &varName.l(r,i__1,vOld,t0) ; varName.l(r,i__1,vOld,t) = 0 + 1$varName.l(r,i__1,vOld,t) ; ) ;
$macro norm2v(varName,i__1,i__2,suffix) loop(vOld, &varName&suffix(r,i__1,i__2) = &varName.l(r,i__1,i__2,vOld,t0) ; varName.l(r,i__1,i__2,vOld,t) = 0 + 1$varName.l(r,i__1,i__2,vOld,t) ; ) ;
$macro norm1vp(varName,i__1,suffix) loop(vOld, &varName&suffix(r,i__1) = &varName.l(r,i__1,vOld,t0) ; varName.l(r,i__1,v,t) = 0 + 1$varName.l(r,i__1,v,t) ; ) ;
$macro norm2vp(varName,i__1,i__2,suffix) loop(vOld, &varName&suffix(r,i__1,i__2) = &varName.l(r,i__1,i__2,vOld,t0) ; varName.l(r,i__1,i__2,v,t) = 0 + 1$varName.l(r,i__1,i__2,v,t) ; ) ;

$else

*  Turn off normalization

$macro normg0(varName,suffix) &varName&suffix = 1 ;
$macro normg1(varName,i__1,suffix) &varName&suffix(i__1) = 1 ;
$macro normg4(varName,i__1,i__2,i__3,i__4,suffix) &varName&suffix(i__1,i__2,i__3,i__4) = 1 ;
$macro norm0(varName,suffix) &varName&suffix(r) = 1 ;
$macro norm1(varName,i__1,suffix) &varName&suffix(r,i__1) = 1 ;
$macro norm2(varName,i__1,i__2,suffix) &varName&suffix(r,i__1,i__2) = 1 ;
$macro norm3(varName,i__1,i__2,i__3,suffix) &varName&suffix(r,i__1,i__2,i__3) = 1 ;
$macro norm1v(varName,i__1,suffix) loop(vOld, &varName&suffix(r,i__1) = 1 ; ) ;
$macro norm2v(varName,i__1,i__2,suffix) loop(vOld, &varName&suffix(r,i__1,i__2) = 1 ; ) ;
$macro norm1vp(varName,i__1,suffix) loop(vOld, &varName&suffix(r,i__1) = 1 ; ) ;
$macro norm2vp(varName,i__1,i__2,suffix) loop(vOld, &varName&suffix(r,i__1,i__2) = 1 ; ) ;

$endif

loop(t0,
   norm1(xdt, i, 0)
   norm1(xs, i, 0)
   norm1(xet, i, 0)
   norm1(xtt, i, 0)
   norm1(pdt, i, 0)
   norm1(ps, i, 0)
   norm1(pet, i, 0)
   norm2(xw, i, rp, 0)
   norm2(pe, i, rp, 0)
   norm2(pwe, i, rp, 0)
   norm2(pwm, i, rp, 0)
   norm2(pdm, i, rp, 0)
   norm3(xwa, i, rp, aa, 0)
   norm3(pdma, i, rp, aa, 0)
   norm2(pma, i, aa, 0)
   norm2(xwmg, i, rp, 0)
   norm2(pwmg, i, rp, 0)
   norm1(xmt, i, 0)
   norm1(pmt, i, 0)
   norm1(xat, i, 0)
   norm1(pat, i, 0)
   norm2(xa, i, aa, 0)
   norm2(xd, i, aa, 0)
   norm2(xm, i, aa, 0)
   norm1(nd1, a, 0)
   norm1(nd2, a, 0)
   norm1(pnd1, a, 0)
   norm1(pnd2, a, 0)
   norm1(xp, a, 0)
   norm1(px, a, 0)
   norm2(x, a, i, 0)
   norm2(p, a, i, 0)
   norm2(pp, a, i, 0)
   norm1v(xpv, a, 0)
   norm1vp(kxRat, a, 0)
   norm1vp(pxv, a, 0)
   norm1vp(uc, a, 0)
   norm1v(xpx, a, 0)
   norm1vp(pxp, a, 0)
   norm1v(va, a, 0)
   norm1vp(pva, a, 0)
   norm1v(va1, a, 0)
   norm1vp(pva1, a, 0)
   norm1v(va2, a, 0)
   norm1vp(pva2, a, 0)
   norm1v(kef, a, 0)
   norm1vp(pkef, a, 0)
   norm1v(kf, a, 0)
   norm1vp(pkf, a, 0)
   norm1v(ksw, a, 0)
   norm1vp(pksw, a, 0)
   norm1v(ks, a, 0)
   norm1vp(pks, a, 0)
   norm1v(kv, a, 0)
   norm1vp(pk, a, 0)
   norm1vp(pkp, a, 0)
   norm1v(xnrg, a, 0)
   norm1vp(pnrg, a, 0)
   norm1v(xnely, a, 0)
   norm1vp(pnely, a, 0)
   norm1v(xolg, a, 0)
   norm1vp(polg, a, 0)
   norm2v(xaNRG, a, NRG, 0)
   norm2vp(paNRG, a, NRG, 0)
   norm1(lab1, a, 0)
   norm1(lab2, a, 0)
   norm1(plab1, a, 0)
   norm1(plab2, a, 0)
   norm2(xf, f, a, 0)
   norm2(pf, f, a, 0)
   norm2(pfp, f, a, 0)
   norm1(xwat, a, 0)
   norm1(pwat, a, 0)
   norm2(pa, i, aa, 0)
   norm2(pd, i, aa, 0)
   norm2(pm, i, aa, 0)
   norm1(xpow, elyc, 0)
   norm1(ppow, elyc, 0)
   norm1(ppowndx, elyc, 0)
   norm2(xpb, pb, elyc, 0)
   norm2(ppb, pb, elyc, 0)
   norm2(ppbndx, pb, elyc, 0)
   norm1(xfd, fd, 0)
   norm1(yfd, fd, 0)
   norm1(pfd, fd, 0)
   norm1(ev, h, 0)
   norm1(evf, fdc, 0)
   norm0(kstock, 0)
   norm0(deprY, 0)
   norm0(yqtf, 0)
   norm0(yqht, 0)
   normg0(trustY, 0)
   norm0(ODAIn, 0)
   norm0(ODAOut, 0)
   normg0(ODAGbl, 0)
   norm2(remit, l, rp, 0)
   norm0(yh, 0)
   norm0(yd, 0)
   norm1(ygov, gy, 0)
   norm0(ntmY, 0)
*  Initialize zero government revenues in the base year to 1
   ygov0(r,gy)$(ygov0(r,gy) eq 0) = 1 ;
   ntmY0(r)$(ntmY0(r) eq 0) = 1 ;
   norm2(zcons, k, h, 0)
   norm2(muc, k, h, 0)
$ifthen "%IFNORM%" == "1"
   if(%utility%=ELES or %utility%=LES or %utility%=AIDADS,
      gammac.fx(r,k,h,t) = gammac.l(r,k,h,t) ;
      muc.fx(r,k,h,t)   = 1 ;
$endif
   ) ;
   norm2(hshr, k, h, 0)
   norm2(xc, k, h, 0)
   norm2(pc, k, h, 0)
   norm2(xcnnrg, k, h, 0)
   norm2(pcnnrg, k, h, 0)
   norm2(xcnrg, k, h, 0)
   norm2(pcnrg, k, h, 0)
   norm2(xcnely, k, h, 0)
   norm2(pcnely, k, h, 0)
   norm2(xcolg, k, h, 0)
   norm2(pcolg, k, h, 0)
   norm3(xacNRG, k, h, NRG, 0)
   norm3(pacNRG, k, h, NRG, 0)
   norm2(xaac, i, h, 0)
   norm2(xawc, i, h, 0)
   norm2(paacc, i, h, 0)
   norm2(paac, i, h, 0)
   norm2(pawc, i, h, 0)
*  !!!! Exceptional
   pah.l(r,i,h,t) = 1 ;
   norm1(u, h, 0)
   norm1(savh, h, 0)
   norm1(supy, h, 0)
   norm1(aps, h, 0)
   normg1(xtmg, img, 0)
   normg1(ptmg, img, 0)
   normg4(xmgm, img, r, i, rp, 0)
   norm2(reswage, l, z, 0)
   norm2(ewagez, l, z, 0)
   norm2(lsz, l, z, 0)
   norm2(ldz, l, z, 0)
   norm2(awagez, l, z, 0)
   norm1(twage, l, 0)
   norm1(ls, l, 0)
   norm1(migr, l, 0)
   norm1(urbprem, l, 0)
   norm0(tls, 0)
   norm0(tkaps, 0)
   norm0(trent, 0)
   norm1(k0, a, 0)
   norm0(tland, 0)
   norm0(ptland, 0)
   norm0(pgdpmp, 0)
   norm1(xlb, lb, 0)
   norm1(plb, lb, 0)
   norm1(plbndx, lb, 0)
   norm0(ptlandndx, 0)
   norm0(xnlb, 0)
   norm0(pnlb, 0)
   norm0(pnlbndx, 0)
   norm0(th2o, 0)
   norm0(th2om, 0)
   norm0(pth2o, 0)
   norm0(pth2ondx, 0)
   norm1(h2obnd, wbnd, 0)
   norm1(ph2obnd, wbnd, 0)
   norm1(ph2obndndx, wbnd, 0)
   norm0(gdpmp, 0)
   norm0(rgdpmp, 0)
   norm0(rgdppc, 0)
   norm0(pfact, 0)
   normg0(pwfact, 0)
   norm0(klrat, 0)
   norm3(emi, em, is, aa, 0)
   norm1(emiTot, em, 0)
   normg1(emiGbl, em, 0)

   norm0(ror, 0)
   norm0(rorc, 0)
   norm0(rore, 0)
   normg0(rorg, 0)

   normg0(sw, 0)
   normg0(swt, 0)

*  !!!!! Exceptional
   kstocke.l(r,t) = kstocke.l(r,t) / kstock0(r) ;
   rorg0$(savfFlag eq capFlexUSAGE) = 1 ;

* !!!! NEED TO WORK ON THIS
   norm0(pop, 0)
*  pop0(r) = 1 ;
   xghg0(r,a) = 1 ;
   pxghg0(r,a) = 1 ;
   ygov0(r,gy)$(ygov0(r,gy) eq 0) = 1 ;
) ;
