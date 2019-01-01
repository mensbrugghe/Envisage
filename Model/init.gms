$macro defaultInit 1
* $macro defaultInit (0.5+uniform(0,1)) ;

$macro Agg3(mat3,i,mapi,a,mapa)  sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), mat3(i0,a0,r))
$macro Agg2(mat2,i,mapi)         sum(i0$mapi0(i0,i), mat2(i0,r))

* --------------------------------------------------------------------------------------------------
*
*  Initialize prices
*
* --------------------------------------------------------------------------------------------------

loop((t0,vOld),
   pat.l(r,i,t0)            = defaultInit ;     pat.l(r,i,t)         = pat.l(r,i,t0) ;

   pxghg.l(r,a,vOld,t0)     = defaultInit ;     pxghg.l(r,a,v,t)     = pxghg.l(r,a,vOld,t0) ;
   pxp.l(r,a,vOld,t0)       = defaultInit ;     pxp.l(r,a,v,t)       = pxp.l(r,a,vOld,t0) ;
   uc.l(r,a,vOld,t0)        = defaultInit ;     uc.l(r,a,v,t)        = uc.l(r,a,vOld,t0) ;

   trent.l(r,t0)            = defaultInit ;     trent.l(r,t)         = trent.l(r,t0) ;
   ptland.l(r,t0)           = defaultInit ;     ptland.l(r,t)        = ptland.l(r,t0) ;
   pf.l(r,f,a,t0)           = defaultInit ;     pf.l(r,f,a,t)        = pf.l(r,f,a,t0) ;

   pnd1.l(r,a,t0)           = defaultInit ;     pnd1.l(r,a,t)        = pnd1.l(r,a,t0) ;
   pnd2.l(r,a,t0)           = defaultInit ;     pnd2.l(r,a,t)        = pnd2.l(r,a,t0) ;
   pwat.l(r,a,t0)           = defaultInit ;     pwat.l(r,a,t)        = pwat.l(r,a,t0) ;
   pnrg.l(r,a,vOld,t0)      = defaultInit ;     pnrg.l(r,a,v,t)      = pnrg.l(r,a,vOld,t0) ;
   paNRG.l(r,a,NRG,vOld,t0) = defaultInit ;     paNRG.l(r,a,NRG,v,t) = paNRG.l(r,a,NRG,vOld,t0) ;
   pnely.l(r,a,vOld,t0)     = defaultInit ;     pnely.l(r,a,v,t)     = pnely.l(r,a,vOld,t0) ;
   polg.l(r,a,vOld,t0)      = defaultInit ;     polg.l(r,a,v,t)      = polg.l(r,a,vOld,t0) ;

   plab1.l(r,a,t0)          = defaultInit ;     plab1.l(r,a,t)       = plab1.l(r,a,t0) ;
   plab2.l(r,a,t0)          = defaultInit ;     plab2.l(r,a,t)       = plab2.l(r,a,t0) ;

   pks.l(r,a,vOld,t0)       = defaultInit ;     pks.l(r,a,v,t)       = pks.l(r,a,vOld,t0) ;
   pksw.l(r,a,vOld,t0)      = defaultInit ;     pksw.l(r,a,v,t)      = pksw.l(r,a,vOld,t0) ;
   pkf.l(r,a,vOld,t0)       = defaultInit ;     pkf.l(r,a,v,t)       = pkf.l(r,a,vOld,t0) ;
   pkef.l(r,a,vOld,t0)      = defaultInit ;     pkef.l(r,a,v,t)      = pkef.l(r,a,vOld,t0) ;

   pva.l(r,a,vOld,t0)       = defaultInit ;     pva.l(r,a,v,t)       = pva.l(r,a,vOld,t0) ;
   pva1.l(r,a,vOld,t0)      = defaultInit ;     pva1.l(r,a,v,t)      = pva1.l(r,a,vOld,t0) ;
   pva2.l(r,a,vOld,t0)      = defaultInit ;     pva2.l(r,a,v,t)      = pva2.l(r,a,vOld,t0) ;

   ps.l(r,i,t0)             = defaultInit ;     ps.l(r,i,t)          = ps.l(r,i,t0) ;

   pwmg.l(r,i,rp,t0)        = defaultInit ;     pwmg.l(r,i,rp,t)     = pwmg.l(r,i,rp,t0) ;

   pmt.l(r,i,t0)            = defaultInit ;     pmt.l(r,i,t)         = pmt.l(r,i,t0) ;

   ptmg.l(img,t0)           = defaultInit ;     ptmg.l(img,t)        = ptmg.l(img,t0) ;

) ;

* --------------------------------------------------------------------------------------------------
*
*  Price/volume splits for energy
*
* --------------------------------------------------------------------------------------------------

Parameters
   xatNRG00(r,e)        "Total energy absorption in MTOE"
   xaNRG00(r,e,aa)      "Total energy absorption in MTOE by agent"
   patNRG00(r,e)        "Average price of energy in $/MTOE"
   paNRG00(r,e,aa)      "Agents' price in $/MTOE"
;

gammaeda(r,i,aa) = 1 ;
gammaedd(r,i,aa) = 1 ;
gammaedm(r,i,aa) = 1 ;

if(ifNRG,

*  Initialize initial volumes

   xaNRG00(r,e,a)   = escale*(sum((i0,a0)$(mapi0(i0,e) and mapa0(a0,a)), nrgdf(i0,a0,r))
                    + sum((i0,a0)$(mapi0(i0,e) and mapa0(a0,a)), nrgmf(i0,a0,r))) ;
   xaNRG00(r,e,h)   = escale*(sum(i0$mapi0(i0,e), nrgdp(i0,r)) + sum(i0$mapi0(i0,e), nrgmp(i0,r))) ;
   xaNRG00(r,e,gov) = escale*(sum(i0$mapi0(i0,e), nrgdg(i0,r)) + sum(i0$mapi0(i0,e), nrgmg(i0,r))) ;
   xaNRG00(r,e,inv) = escale*(sum(i0$mapi0(i0,e), nrgdi(i0,r)) + sum(i0$mapi0(i0,e), nrgmi(i0,r))) ;
   xatNRG00(r,e)    = sum(aa, xaNRG00(r,e,aa)) ;

*  Initialize cumbustion ratio

   phiNRG(r,fuel,aa)   = 1 ;
   phiNRG(r,fuel,a)    = eScale*sum((i0,a0)$(mapi0(i0,fuel) and mapa0(a0,a)), nrgComb(i0,a0,r)) ;
   phiNRG(r,fuel,a)$xaNRG00(r,fuel,a) = phiNRG(r,fuel,a)/xaNRG00(r,fuel,a) ;
   phiNRG(r,fuel,aa)$(phiNRG(r,fuel,aa) > 1) = 1 ;

*  Initialize values excl sales taxes (using price matrices temporarily)

   paNRG00(r,e,a)    = inscale*(Agg3(vdfb,e,mapi,a,mapa) + Agg3(vmfb,e,mapi,a,mapa)) ;
   paNRG00(r,e,h)    = inscale*(Agg2(vdpb,e,mapi) + Agg2(vmpb,e,mapi)) ;
   paNRG00(r,e,gov)  = inscale*(Agg2(vdgb,e,mapi) + Agg2(vmgb,e,mapi)) ;
   paNRG00(r,e,inv)  = inscale*(Agg2(vdib,e,mapi) + Agg2(vmib,e,mapi)) ;

*  Check for consistency -- xaNrg contains energy volumes, paNrg contains SAM values

   if(1,
      put screen ;
      screen.nd = 9 ;
      put / ;
      work = 0 ;
      loop((r,e,aa),
         if(xaNRG00(r,e,aa) le 0 and paNRG00(r,e,aa) ne 0,
            put "WARNING: NRG=0, SAM<>0 --> ", r.tl, e.tl, aa.tl, (xaNRG00(r,e,aa)/escale):15:8, (paNRG00(r,e,aa)/inscale):15:8 / ;
            work = work + 1 ;
         elseif(xaNRG00(r,e,aa) ne 0 and paNRG00(r,e,aa) le 0),
            put "WARNING: NRG<>0, SAM=0 --> ", r.tl, e.tl, aa.tl, (xaNRG00(r,e,aa)/escale):15:8, (paNRG00(r,e,aa)/inscale):15:8 / ;
            work = work + 1 ;
         ) ;
      ) ;
      if(work > 0, Abort "Inconsistent energy statistics" ; ) ;
   ) ;

*  Calculate average price

   patNRG00(r,e) = (sum(aa, paNRG00(r,e,aa))/xaTNRG00(r,e))$(xatNRG00(r,e))
                 + (1)$(xatNRG00(r,e) eq 0)
                 ;

*  Calculate end-user price

   paNRG00(r,e,aa) = (paNRG00(r,e,aa)/xaNRG00(r,e,aa))$(xaNRG00(r,e,aa))
                   + (1)$(xaNRG00(r,e,aa) eq 0) ;

*  Calculate price adjustment factor

   gammaeda(r,e,aa)$(xatNRG00(r,e)) = paNRG00(r,e,aa)/patNRG00(r,e) ;

   pat.l(r,e,t)  = patNRG00(r,e) ;
   xatNRG(r,e,t) = xatNRG00(r,e) ;
) ;

*  Incorporate trade dimension of energy volumes

gammaew(r,i,rp) = 1 ;
gammaesd(r,i)   = 1 ;
gammaese(r,i)   = 1 ;

Parameters
   xwNRG0(r,e,rp)       "Volume of bilateral trade in MTOE"
   peNRG0(r,e,rp)       "Price of bilateral trade at producer prices"
   petNRG0(r,e)         "Average price of exports"
   xetNRG0(r,e)         "Total exports in MTOE"
   xmtNRG0(r,e)         "Total imports in MTOE"
   pmtNRG0(r,e)         "Price of aggregate imports"
   xdNRG0(r,e)          "Domestic absorption of domestic output"
   xsNRG0(r,e)          "Domestic supply"
;

if(ifNRG,

*  Initialize volumes and values, using pe to hold values

   xwNRG0(r,e,rp) = escale*sum(i0$mapi0(i0,e),exi(i0,r,rp)) ;
   peNRG0(r,e,rp) = inscale*sum(i0$mapi0(i0,e),vxsb(i0, r, rp)) ;

*  Check consistency of flows

   put screen ; put / ;
   loop((r,e,rp)$((xwNRG0(r,e,rp) eq 0 and peNRG0(r,e,rp)) or
                  (xwNRG0(r,e,rp) and peNRG0(r,e,rp) eq 0)),
      put "Inconsistent energy data: ", r.tl, e.tl, rp.tl, "xw = ", (xwNRG0(r,e,rp)/escale):15:6,
         "  SAM = ", (peNRG0(r,e,rp)/inscale) / ;
   ) ;

*  Calculate total exports and average export price

   xetNRG0(r,e) = sum(rp, xwNRG0(r,e,rp)) ;
   petNRG0(r,e) = (sum(rp, peNRG0(r,e,rp))/xetNRG0(r,e))$xetNRG0(r,e)
                + 1$(xetNRG0(r,e) eq 0) ;

*  Calculate bilateral export price

   peNRG0(r,e,rp) = (peNRG0(r,e,rp)/xwNRG0(r,e,rp))$xwNRG0(r,e,rp)
                  + (1)$(not xwNRG0(r,e,rp)) ;

*  Calculate price adjustment factors

   gammaew(r,e,rp)$xwNRG0(r,e,rp) = peNRG0(r,e,rp)/petNRG0(r,e) ;

   pet.l(r,e,t) = petNRG0(r,e) ;

*  Calculate aggregate import price

   xmtNRG0(r,e) = sum(rp, xwNRG0(rp,e,r)) ;
   pmtNRG0(r,e) = inscale*(sum(i0$mapi0(i0,e),sum(rp,vmsb(i0, rp, r)))) ;
   pmtNRG0(r,e) = (pmtNRG0(r,e)/xmtNRG0(r,e))$(xmtNRG0(r,e))
                + (1)$(xmtNRG0(r,e) eq 0) ;

   xdNRG0(r,e)  = xatNRG00(r,e) - xmtNRG0(r,e) ;
   pdt.l(r,e,t) = ((patNRG00(r,e)*xatNRG00(r,e) - pmtNRG0(r,e)*xmtNRG0(r,e))/xdNRG0(r,e))
                $(xdNRG0(r,e) gt 0)
                + 1$(xdnrg0(r,e) le 0) ;

*  !!!! 03-Mar-2017 (DvdM)
*  Have a tolerance level for pd
*  We should review the energy consistencies--it gets messy with the 'make' system
   if(1,
      pdt.l(r,e,t)$(pdt.l(r,e,t) lt 0 or abs(pdt.l(r,e,t)) le 1e-5) = 0 ;
      loop(t0, xdNRG0(r,e)$(pdt.l(r,e,t0) eq 0) = 0 ; ) ;
      pdt.l(r,e,t)$(pdt.l(r,e,t) = 0) = 1 ;
   ) ;

   xsNRG0(r,e)  = xdNRG0(r,e) + xetNRG0(r,e) ;
   ps.l(r,e,t)  = ((pdt.l(r,e,t)*xdNRG0(r,e) + petNRG0(r,e)*xetNRG0(r,e))/xsNRG0(r,e))
                $(xsNRG0(r,e) gt 0)
                + 1$(xsNRG0(r,e) le 0) ;
   loop(t0,
      gammaesd(r,e) = pdt.l(r,e,t0)/ps.l(r,e,t0) ;
      gammaese(r,e) = pet.l(r,e,t0)/ps.l(r,e,t0) ;
   ) ;
) ;

* display xdNRG0, xsNRG0, xetNRG0, pdt.l, petnrg0, pmtnrg0 ;

*  Set producer price of exports to aggregate producer price

pdt.l(r,i,t)     = gammaesd(r,i)*ps.l(r,i,t) ;
pet.l(r,i,t)     = gammaese(r,i)*ps.l(r,i,t) ;
pe.l(r,i,rp,t)   = gammaew(r,i,rp)*pet.l(r,i,t) ;

loop((i,k)$mapk(i,k),
   cmat(i,k,r) = Agg2(vdpp,i,mapi) + Agg2(vmpp,i,mapi) ;
) ;

*  Initialize Armington elasticities

*  !!!! NEEDS REVIEW -- SIGMAM ALSO READ IN !!!!
*  USE GTAP elasticities

$ifthen %ifGTAPArm% == 1

   sigmamt(r,i) = sum(i0$mapi0(i0,i), sum(a0, vdfp(i0,a0,r) + vmfp(i0,a0,r))
                +                             vdpp(i0,r)    + vmpp(i0,r)
                +                             vdgp(i0,r)    + vmgp(i0,r)
                +                             vdip(i0,r)    + vmip(i0,r)) ;
   sigmamt(r,i)$sigmamt(r,i)
                = sum(i0$mapi0(i0,i), ESUBD(i0,r)*(sum(a0, vdfp(i0,a0,r) + vmfp(i0,a0,r))
                +                                          vdpp(i0,r)    + vmpp(i0,r)
                +                                          vdgp(i0,r)    + vmgp(i0,r)
                +                                          vdip(i0,r)    + vmip(i0,r)))
                / sigmamt(r,i) ;

   sigmaw(r,i) = sum(i0$mapi0(i0,i), sum(a0, vmfp(i0,a0,r))
               +                             vmpp(i0,r)
               +                             vmgp(i0,r)
               +                             vmip(i0,r)) ;
   sigmaw(r,i)$sigmaw(r,i)
               = sum(i0$mapi0(i0,i), ESUBM(i0,r)*(sum(a0, vmfp(i0,a0,r))
               +                                          vmpp(i0,r)
               +                                          vmgp(i0,r)
               +                                          vmip(i0,r)))
               / sigmaw(r,i) ;

sigmam(r,i,aa) = sigmamt(r,i) ;

$endif

*  Initialize household utility parameters

eh0(k,r) = sum(i$mapk(i,k), sum(i0$mapi0(i0,i), vdpp(i0,r) + vmpp(i0,r))) ;
bh0(k,r) = eh0(k,r) ;
eh0(k,r)$eh0(k,r)
          = sum(i$mapk(i,k), sum(i0$mapi0(i0,i), INCPAR(i0,r)*(vdpp(i0,r) + vmpp(i0,r))))
          / eh0(k,r) ;
bh0(k,r)$bh0(k,r)
          = sum(i$mapk(i,k), sum(i0$mapi0(i0,i), SUBPAR(i0,r)*(vdpp(i0,r) + vmpp(i0,r))))
          / bh0(k,r) ;

*  Aggregate other elasticities

loop((nrs,t0),
   etanrs.l(r,a,t0) = sum(a0$mapa0(a0,a), evfb(nrs, a0, r)) ;
   etanrsx(r,a,lh)$etanrs.l(r,a,t0) = sum(a0$mapa0(a0,a), etanrsx0(r,a0,lh)*evfb(nrs, a0, r))/etanrs.l(r,a,t0) ;
) ;

*  Initialize labor market assumptions

loop((r,l),
   if(ifLSeg(r,l) eq 1,
*     Segmented labor markets
      lsFlag(r,l,rur) = yes ;
      lsFlag(r,l,urb) = yes ;
      lsFlag(r,l,nsg) = no ;
      migr0(r,l)       = 0.01*labHyp(r,l,"migr0") ;
      uez0(r,l,rur)    = 0.01*labHyp(r,l,"uezRur0") ;
      uez0(r,l,urb)    = 0.01*labHyp(r,l,"uezUrb0") ;
      ueMinz0(r,l,rur) = 0.01*labHyp(r,l,"ueMinzRur0") ;
      ueMinz0(r,l,urb) = 0.01*labHyp(r,l,"ueMinzUrb0") ;
      resWage0(r,l,rur) = labHyp(r,l,"resWageRur0") ;
      resWage0(r,l,urb) = labHyp(r,l,"resWageUrb0") ;
   else
*     Integrated labor markets
      lsFlag(r,l,rur)  = no ;
      lsFlag(r,l,urb)  = no ;
      lsFlag(r,l,nsg)  = yes ;
      migr0(r,l)       = 0 ;
      uez0(r,l,nsg)    = 0.01*labHyp(r,l,"uezUrb0") ;
      ueMinz0(r,l,nsg) = 0.01*labHyp(r,l,"ueMinzUrb0") ;
      resWage0(r,l,nsg) = labHyp(r,l,"resWageUrb0") ;
   ) ;
   omegarwg(r,l,z)  = labHyp(r,l,"omegarwg") ;
   omegarwue(r,l,z) = labHyp(r,l,"omegarwue") ;
   omegarwp(r,l,z)  = labHyp(r,l,"omegarwp") ;
) ;
ueFlag(r,l,z) = no ;

*  Checks

put screen ; put / ;
work = 0 ;
loop(lsFlag(r,l,z),
   if(uez0(r,l,z) lt ueMinz0(r,l,z),
      put "Initial unemployment is less than minimum UE: ", r.tl, l.tl, z.tl / ;
      work = work + 1 ;
   ) ;
   if(resWage0(r,l,z) ne na,
      ueFlag(r,l,z) = yes ;
      if(resWage0(r,l,z) gt 1,
         put "Initial reservation wage is greater than actual wage: ", r.tl, l.tl, z.tl / ;
         work = work + 1 ;
      ) ;
   ) ;
) ;

if(work > 0,
   put "Invalid UE initialization..." / ;
   abort "Check parameter file..." ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Initialize Armington demand
*
* --------------------------------------------------------------------------------------------------

*  Value of agent specific Armington tax

paTax.l(r,i,a,t) = inscale*(Agg3(vdfp,i,mapi,a,mapa) + Agg3(vmfp,i,mapi,a,mapa)) ;
paTax.l(r,i,h,t) = inscale*(Agg2(vdpp,i,mapi) + Agg2(vmpp,i,mapi)) ;
paTax.l(r,i,gov,t) = inscale*(Agg2(vdgp,i,mapi) + Agg2(vmgp,i,mapi)) ;
paTax.l(r,i,inv,t) = inscale*(Agg2(vdip,i,mapi) + Agg2(vmip,i,mapi)) ;

pdTax.l(r,i,a,t)   = inscale*Agg3(vdfp,i,mapi,a,mapa) ;
pdTax.l(r,i,h,t)   = inscale*Agg2(vdpp,i,mapi) ;
pdTax.l(r,i,gov,t) = inscale*Agg2(vdgp,i,mapi) ;
pdTax.l(r,i,inv,t) = inscale*Agg2(vdip,i,mapi) ;

pmTax.l(r,i,a,t)   = inscale*Agg3(vmfp,i,mapi,a,mapa) ;
pmTax.l(r,i,h,t)   = inscale*Agg2(vmpp,i,mapi) ;
pmTax.l(r,i,gov,t) = inscale*Agg2(vmgp,i,mapi) ;
pmTax.l(r,i,inv,t) = inscale*Agg2(vmip,i,mapi) ;

paTax.l(r,i,aa,t)  = pdTax.l(r,i,aa,t) + pmTax.l(r,i,aa,t) ;

*  Value of agent specific Armington consumption at market price

xd.l(r,i,a,t)    = inscale*Agg3(vdfb,i,mapi,a,mapa) ;
xd.l(r,i,h,t)    = inscale*Agg2(vdpb,i,mapi) ;
xd.l(r,i,gov,t)  = inscale*Agg2(vdgb,i,mapi) ;
xd.l(r,i,inv,t)  = inscale*Agg2(vdib,i,mapi) ;

xm.l(r,i,a,t)    = inscale*Agg3(vmfb,i,mapi,a,mapa) ;
xm.l(r,i,h,t)    = inscale*Agg2(vmpb,i,mapi) ;
xm.l(r,i,gov,t)  = inscale*Agg2(vmgb,i,mapi) ;
xm.l(r,i,inv,t)  = inscale*Agg2(vmib,i,mapi) ;

xa.l(r,i,aa,t)   = xd.l(r,i,aa,t) + xm.l(r,i,aa,t) ;

*  Agent specific tax rate

paTax.l(r,i,aa,t)$xa.l(r,i,aa,t) = paTax.l(r,i,aa,t) / xa.l(r,i,aa,t) - 1 ;
pdTax.l(r,i,aa,t)$xd.l(r,i,aa,t) = pdTax.l(r,i,aa,t) / xd.l(r,i,aa,t) - 1 ;
pmTax.l(r,i,aa,t)$xm.l(r,i,aa,t) = pmTax.l(r,i,aa,t) / xm.l(r,i,aa,t) - 1 ;

*  Impose price/volume split

xa.l(r,i,aa,t) = xa.l(r,i,aa,t) / (gammaeda(r,i,aa)*pat.l(r,i,t)) ;
xd.l(r,i,aa,t) = xd.l(r,i,aa,t) / (gammaedd(r,i,aa)*pdt.l(r,i,t)) ;
xm.l(r,i,aa,t) = xm.l(r,i,aa,t) / (gammaedm(r,i,aa)*pmt.l(r,i,t)) ;

*  Determine agent' specific Armington price, i.e. tax inclusive Armington price

pa.l(r,i,aa,t) = gammaeda(r,i,aa) * pat.l(r,i,t) * (1 + paTax.l(r,i,aa,t)) ;
pd.l(r,i,aa,t) = gammaedd(r,i,aa) * pdt.l(r,i,t) * (1 + pdTax.l(r,i,aa,t)) ;
pm.l(r,i,aa,t) = gammaedm(r,i,aa) * pmt.l(r,i,t) * (1 + pmTax.l(r,i,aa,t)) ;

*  Initialize aggregate final demand

yfd.l(r,fd,t) = sum(i, pa.l(r,i,fd,t)*xa.l(r,i,fd,t)) ;
pfd.l(r,fd,t) = 1 ;
xfd.l(r,fd,t) = yfd.l(r,fd,t) / pfd.l(r,fd,t) ;

* --------------------------------------------------------------------------------------------------
*
*  Initialize the production variables
*
* --------------------------------------------------------------------------------------------------

*  Labor demand

xf.l(r,l,a,t) = (inscale*sum(a0$mapa0(a0,a),evfb(l,a0,r)))$(sum(a0$mapa0(a0,a),empl(l,a0,r)) eq na)
              + (lscale*sum(a0$mapa0(a0,a),empl(l,a0,r)))$(sum(a0$mapa0(a0,a),empl(l,a0,r)) ne na) ;
loop(t0,
   pf.l(r,l,a,t) = (inscale*sum(a0$mapa0(a0,a),evfb(l,a0,r)) / xf.l(r,l,a,t0))$(xf.l(r,l,a,t0))
                 + (1)$(xf.l(r,l,a,t0) eq 0) ;
) ;

*  Capital demand

pk.l(r,a,v,t)   = trent.l(r,t) ;
pf.l(r,cap,a,t) = trent.l(r,t) ;

loop(cap,
   kv.l(r,a,vOld,t) = inscale*(sum(a0$mapa0(a0,a),evfb(cap,a0,r))) ;
   xf.l(r,cap,a,t)  = sum(vOld, kv.l(r,a,vOld,t)) ;
) ;

*  Capital price split

kv.l(r,a,vOld,t) = kv.l(r,a,vOld,t)/pk.l(r,a,vOld,t) ;

arent.l(r,t) = 1 ;

*  Land demand

ptland.l(r,t)$(etat(r) eq inf)     = 1 ;
pf.l(r,lnd,a,t)$(omegat(r) eq inf) = ptland.l(r,t) ;

xf.l(r,lnd,a,t) = (inscale*(sum(a0$mapa0(a0,a),evfb(lnd,a0,r))))/pf.l(r,lnd,a,t) ;

*  Natural resource demand

xf.l(r,nrs,a,t) = (inscale*(sum(a0$mapa0(a0,a),evfb(nrs,a0,r)))) / pf.l(r,nrs,a,t) ;

*   Water demand

pf.l(r,wat,a,t) = 1 ;
loop(wat$IFWATER,
   xf.l(r,wat,a,t) = watScale*sum(a0$mapa0(a0,a),h2oCrp(a0,r)) ;
   pf.l(r,wat,a,t)$xf.l(r,wat,a,t) = inscale*sum(a0$mapa0(a0,a),evfb(wat,a0,r))/xf.l(r,wat,a,t) ;
) ;

*  Factor tax rate and purchasers' price of factors

pftax.l(r,f,a,t)  = inscale*sum(a0$mapa0(a0,a),evfb(f,a0,r)) ;
pftax.l(r,f,a,t)$pftax.l(r,f,a,t)
   = inscale*sum(a0$mapa0(a0,a),evfp(f,a0,r))/pftax.l(r,f,a,t) - 1 ;

pfp.l(r,f,a,t) = pf.l(r,f,a,t)*(1 + pftax.l(r,f,a,t)) ;
loop(cap,
   pkp.l(r,a,v,t) = pk.l(r,a,v,t)*(1 + pftax.l(r,cap,a,t)) ;
) ;

pfact.l(r,t) = 1 ;
pwfact.l(t)  = 1 ;

*  Construct the intermediate demand bundles

nd1.l(r,a,t)        = sum(i$mapi1(i,a), pa.l(r,i,a,t)*xa.l(r,i,a,t)) / pnd1.l(r,a,t) ;
nd2.l(r,a,t)        = sum(i$mapi2(i,a), pa.l(r,i,a,t)*xa.l(r,i,a,t)) / pnd2.l(r,a,t) ;
xwat.l(r,a,t)       = (sum(i$iw(i), pa.l(r,i,a,t)*xa.l(r,i,a,t))
                    +  sum(wat, pfp.l(r,wat,a,t)*xf.l(r,wat,a,t))) / pwat.l(r,a,t) ;
xnrg.l(r,a,vOld,t)  = sum(e, pa.l(r,e,a,t)*xa.l(r,e,a,t)) / pnrg.l(r,a,vOld,t) ;
xaNRG.l(r,a,NRG,vOld,t) = sum(e$mape(NRG,e), pa.l(r,e,a,t)*xa.l(r,e,a,t))
                        / paNRG.l(r,a,NRG,vOld,t) ;
xolg.l(r,a,vOld,t)  = (paNRG.l(r,a,"GAS",vOld,t)*xaNRG.l(r,a,"GAS",vOld,t)
                    +  paNRG.l(r,a,"OIL",vOld,t)*xaNRG.l(r,a,"OIL",vOld,t)) / polg.l(r,a,vOld,t) ;
xnely.l(r,a,vOld,t) = (paNRG.l(r,a,"COA",vOld,t)*xaNRG.l(r,a,"COA",vOld,t)
                    +   polg.l(r,a,vOld,t)*xolg.l(r,a,vOld,t)) / pnely.l(r,a,vOld,t) ;
xnrg.l(r,a,vOld,t)  = ((paNRG.l(r,a,"ELY",vOld,t)*xaNRG.l(r,a,"ELY",vOld,t)
                    +   pnely.l(r,a,vOld,t)*xnely.l(r,a,vOld,t)) / pnrg.l(r,a,vOld,t))$ifNRGNest
                    + (sum(e, pa.l(r,e,a,t)*xa.l(r,e,a,t)) / pnrg.l(r,a,vOld,t))$(not ifNRGNest)
                    ;

*  Construct the labor demand bundles

lab1.l(r,a,t)      = sum(ul, pfp.l(r,ul,a,t)*xf.l(r,ul,a,t)) / plab1.l(r,a,t) ;
lab2.l(r,a,t)      = sum(sl, pfp.l(r,sl,a,t)*xf.l(r,sl,a,t)) / plab2.l(r,a,t) ;

*  Construct the KF/KEF bundles

ks.l(r,a,vOld,t)  = (pkp.l(r,a,vOld,t)*kv.l(r,a,vOld,t) + lab2.l(r,a,t)*plab2.l(r,a,t))
                  / pks.l(r,a,vOld,t) ;
ksw.l(r,a,vOld,t) = (pks.l(r,a,vOld,t)*ks.l(r,a,vOld,t) + xwat.l(r,a,t)*pwat.l(r,a,t))
                  / pksw.l(r,a,vOld,t) ;
kf.l(r,a,vOld,t)  = (pksw.l(r,a,vOld,t)*ksw.l(r,a,vOld,t) + sum(nrs, pfp.l(r,nrs,a,t)*xf.l(r,nrs,a,t)))
                  / pkf.l(r,a,vOld,t) ;
kef.l(r,a,vOld,t) = (pkf.l(r,a,vOld,t)*kf.L(r,a,vOld,t) + pnrg.l(r,a,vOld,t)*xnrg.l(r,a,vOld,t))
                  / pkef.l(r,a,vOld,t) ;

*  Construct the VA bundles

va2.l(r,a,vOld,t) = ((sum(lnd, pfp.l(r,lnd,a,t)*xf.l(r,lnd,a,t)) + pkef.l(r,a,vOld,t)*kef.l(r,a,vOld,t))
                  / pva2.l(r,a,vOld,t))$acr(a)
                  + ((sum(lnd, pfp.l(r,lnd,a,t)*xf.l(r,lnd,a,t)) + pnd2.l(r,a,t)*nd2.l(r,a,t))
                  / pva2.l(r,a,vOld,t))$alv(a)
                  ;

va1.l(r,a,vOld,t) = ((pnd2.l(r,a,t)*nd2.l(r,a,t) + pva2.l(r,a,vOld,t)*va2.l(r,a,vOld,t))
                  / pva1.l(r,a,vOld,t))$acr(a)
                  + ((lab1.l(r,a,t)*plab1.l(r,a,t) + pkef.l(r,a,vOld,t)*kef.l(r,a,vOld,t))
                  / pva1.l(r,a,vOld,t))$alv(a)
                  + ((sum(lnd, pfp.l(r,lnd,a,t)*xf.l(r,lnd,a,t)) + pkef.l(r,a,vOld,t)*kef.l(r,a,vOld,t))
                  / pva1.l(r,a,vOld,t))$ax(a)
                  ;

va.l(r,a,vOld,t)  = ((lab1.l(r,a,t)*plab1.l(r,a,t) + pva1.l(r,a,vOld,t)*va1.l(r,a,vOld,t))
                  / pva.l(r,a,vOld,t))$acr(a)
                  + ((pva2.l(r,a,vOld,t)*va2.l(r,a,vOld,t) + pva1.l(r,a,vOld,t)*va1.l(r,a,vOld,t))
                  / pva.l(r,a,vOld,t))$alv(a)
                  + ((lab1.l(r,a,t)*plab1.l(r,a,t) + pva1.l(r,a,vOld,t)*va1.l(r,a,vOld,t))
                  / pva.l(r,a,vOld,t))$ax(a)
                  ;

*  Construct the XPX bundle

xpx.l(r,a,vOld,t) = (pnd1.l(r,a,t)*nd1.l(r,a,t) + pva.l(r,a,vOld,t)*va.l(r,a,vOld,t))
                  / pxp.l(r,a,vOld,t) ;

*  Incorporate GHG bundle

* !!!! TO BE DONE

xghg.l(r,a,v,t)  = 0 ;
uctax.l(r,a,v,t) = 0 ;

* Construct the XPV bundle

xpv.l(r,a,vOld,t) = (pxp.l(r,a,vOld,t)*xpx.l(r,a,vOld,t) + pxghg.l(r,a,vOld,t)*xghg.l(r,a,vOld,t))
                  / uc.l(r,a,vOld,t) ;

pxv.l(r,a,v,t) = uc.l(r,a,v,t)*(1 + uctax.l(r,a,v,t)) ;

*  Calculate cost of production pre-tax in value terms

xp.l(r,a,t) = sum(vOld, pxv.l(r,a,vOld,t)*xpv.l(r,a,vOld,t)) ;

loop(vOld,
   px.l(r,a,t) = pxv.l(r,a,vOld,t)
) ;
xp.l(r,a,t) = xp.l(r,a,t) / px.l(r,a,t) ;

* display uc.l, px.l, pp.l ;

*  Initialize the technology parameters

axghg.l(r,a,v,t)         = 1 ;
lambdaxp.l(r,a,v,t)      = 1 ;
lambdaghg.l(r,a,v,t)     = 1 ;
lambdaf.l(r,f,a,t)       = 1 ;
lambdak.l(r,a,v,t)       = 1 ;
chiglab.fx(r,l,t)        = 0 ;
lambdaio.l(r,i,a,t)      = 1 ;
lambdae.l(r,e,a,v,t)     = 1 ;
lambdace.l(r,e,k,h,t)    = 1 ;
lambdapb(r,elya,elyc,t)  = 1 ;
lambdapow(r,pb,elyc,t)   = 1 ;

lambdah2obnd.l(r,wbnd,t) = 1 ;

*  Initialize production flags

loop((t, vOld)$(ord(t) eq 1),
   xpFlag(r,a)$xp.l(r,a,t)            = 1 ;
   ghgFlag(r,a)$xghg.l(r,a,vOld,t)    = 1 ;

   nd1Flag(r,a)$nd1.l(r,a,t)          = 1 ;
   nd2Flag(r,a)$nd2.l(r,a,t)          = 1 ;
   watFlag(r,a)$xwat.l(r,a,t)         = 1 ;
   lab1Flag(r,a)$lab1.l(r,a,t)        = 1 ;
   lab2Flag(r,a)$lab2.l(r,a,t)        = 1 ;

   va1Flag(r,a)$va1.l(r,a,vOld,t)     = 1 ;
   va2Flag(r,a)$va2.l(r,a,vOld,t)     = 1 ;
   kefFlag(r,a)$kef.l(r,a,vOld,t)     = 1 ;
   xfFlag(r,f,a)$xf.l(r,f,a,t)        = 1 ;
   kfFlag(r,a)$kf.l(r,a,vOld,t)       = 1 ;
   kFlag(r,a)$kv.l(r,a,vOld,t)        = 1 ;
   xnrgFlag(r,a)$xnrg.l(r,a,vOld,t)   = 1 ;
   xnelyFlag(r,a)$xnely.l(r,a,vOld,t) = 1 ;
   xolgFlag(r,a)$xolg.l(r,a,vOld,t)   = 1 ;
   xaFlag(r,i,aa)$xa.l(r,i,aa,t)      = 1 ;
   xdFlag(r,i,aa)$xd.l(r,i,aa,t)      = 1 ;
   xmFlag(r,i,aa)$xm.l(r,i,aa,t)      = 1 ;
   xaNRGFlag(r,a,NRG)$xaNRG.l(r,a,NRG,vOld,t) = 1 ;
) ;

*  Initialize the 'make/use' module

*  !!!! Need to insure that when running the model with perfect transformation and perfect
*       substitution that the prices align (one way is to have fixed price adjusters)
*  Set 'pp' to ps as it is more likely that demand has perfect substitutes than
*  supply

*  Calculate x tax-inclusive

x.l(r,a,i,t)     = inscale*sum((a0,i0)$(mapa0(a0,a) and mapi0(i0,i)), makb(i0,a0,r)) ;
lambdas(r,a,i,t) = 1 ;
ptax.l(r,a,i,t)  = inscale*sum((a0,i0)$(mapa0(a0,a) and mapi0(i0,i)), maks(i0,a0,r)) ;
ptax.l(r,a,i,t)$ptax.l(r,a,i,t) = x.l(r,a,i,t)/ptax.l(r,a,i,t) - 1 ;
x.l(r,a,i,t)     = x.l(r,a,i,t) / ps.l(r,i,t) ;
pp.l(r,a,i,t)    = ps.l(r,i,t) ;
p.l(r,a,i,t)     = pp.l(r,a,i,t)/(1+ptax.l(r,a,i,t)) ;

xs.l(r,i,t)  = sum(a, pp.l(r,a,i,t)*x.l(r,a,i,t))/ps.l(r,i,t) ;

loop(t$(ord(t) eq 1),
   xsFlag(r,i)$xs.l(r,i,t) = 1 ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Initialize household demand module
*
* --------------------------------------------------------------------------------------------------

*  Top level demand

cmat(i,k,r)     = inscale*cmat(i,k,r) ;
pc.l(r,k,h,t)   = 1 ;
xc.l(r,k,h,t)   = sum(i, cmat(i,k,r)) / pc.l(r,k,h,t) ;
hshr.l(r,k,h,t) = (pc.l(r,k,h,t)*xc.l(r,k,h,t))/yfd.l(r,h,t) ;
loop(t0,
   xcFlag(r,k,h)$xc.l(r,k,h,t0) = 1 ;
) ;

*  Initialize income elasticity for ELES calibration
*  !!!! TAKEN FROM CDE FUNCTION
loop((h,t0),
   incElas(k,r) = ((eh0(k,r)*bh0(k,r)
                - sum(kp$xcFlag(r,kp,h), hshr.l(r,kp,h,t0)*eh0(kp,r)*bh0(kp,r)))
                / sum(kp$xcFlag(r,kp,h), hshr.l(r,kp,h,t0)*eh0(kp,r)) - (bh0(k,r)-1)
                + sum(kp$xcFlag(r,kp,h), hshr.l(r,kp,h,t0)*bh0(kp,r))) ;
) ;

kron(k,k) = 1 ;

*  Non-energy demand

pcnnrg.l(r,k,h,t)  = 1 ;
xcnnrg.l(r,k,h,t)  = sum(i$(not e(i)), cmat(i,k,r)) / pcnnrg.l(r,k,h,t) ;

pcnrg.l(r,k,h,t) = 1 ;
xcnrg.l(r,k,h,t) = sum(e, cmat(e,k,r)) / pcnrg.l(r,k,h,t) ;

loop(t0,
   xcnnrgFlag(r,k,h)$xcnnrg.l(r,k,h,t0) = 1 ;
   xcnrgFlag(r,k,h)$xcnrg.l(r,k,h,t0)   = 1 ;
) ;

pacNRG.l(r,k,h,NRG,t) = 1 ;
xacNRG.l(r,k,h,NRG,t) = sum(e$mape(NRG,e), cmat(e,k,r)) / pacNRG.l(r,k,h,NRG,t) ;
pcolg.l(r,k,h,t)      = 1 ;
xcolg.l(r,k,h,t)      = (pacNRG.l(r,k,h,"GAS",t)*xacNRG.l(r,k,h,"GAS",t)
                      +  pacNRG.l(r,k,h,"OIL",t)*xacNRG.l(r,k,h,"OIL",t)) / pcolg.l(r,k,h,t) ;
pcnely.l(r,k,h,t)     = 1 ;
xcnely.l(r,k,h,t)     = (pacNRG.l(r,k,h,"COA",t)*xacNRG.l(r,k,h,"COA",t)
                      +  pcolg.l(r,k,h,t)*xcolg.l(r,k,h,t)) / pcnely.l(r,k,h,t) ;

loop(t0,
   xcnelyFlag(r,k,h)$xcnely.l(r,k,h,t0) = 1 ;
   xcolgFlag(r,k,h)$xcolg.l(r,k,h,t0)   = 1 ;
   xacNRGFlag(r,k,h,NRG)$xacNRG.l(r,k,h,NRG,t0) = 1 ;
) ;

*  Waste module

alphawc(r,i,h)$(alphawc(r,i,h) eq na or alphawc(r,i,h) eq 0) = 0 ;
loop(t0,
   hWasteFlag(r,i,h)$(alphawc(r,i,h) ne 0 and xa.l(r,i,h,t0)) = 1 ;
) ;

alphaac(r,i,h)$hWasteFlag(r,i,h) = (1 - alphawc(r,i,h)) ;
paac.l(r,i,h,t) = pa.l(r,i,h,t) ;
pawc.l(r,i,h,t) = pa.l(r,i,h,t) ;
xawc.l(r,i,h,t)$xa.l(r,i,h,t) = alphawc(r,i,h)*xa.l(r,i,h,t) ;
xaac.l(r,i,h,t) = xa.l(r,i,h,t) - xawc.l(r,i,h,t) ;
paacc.l(r,i,h,t) = pa.l(r,i,h,t) ;
lambdaac(r,i,h,t) = 1 ;
lambdawc(r,i,h,t) = 1 ;

wtaxh.fx(r,i,h,t)  = 0 ;
wtaxhx.fx(r,i,h,t) = 0 ;

display hWasteFlag, xa.l, xaac.l, xawc.l, paac.l, pawc.l, paacc.l ;

* --------------------------------------------------------------------------------------------------
*
*  Initialize bilateral trade
*
* --------------------------------------------------------------------------------------------------

xw.l(r,i,rp,t)   = inscale*sum(i0$mapi0(i0,i),vxsb(i0, r, rp)) / pe.l(r,i,rp,t) ;
loop(t0,
   xwFlag(r,i,rp)$xw.l(r,i,rp,t0) = 1 ;
) ;
etax.l(r,i,rp,t) = inscale*(sum(i0$mapi0(i0,i),vfob(i0, r, rp))
                 - sum(i0$mapi0(i0,i),vxsb(i0, r, rp))) ;
etax.l(r,i,rp,t)$xwFlag(r,i,rp) = etax.l(r,i,rp,t)/(pe.l(r,i,rp,t)*xw.l(r,i,rp,t)) ;
etaxi.fx(r,i,t)  = 0 ;

*  FOB price equals producer price plus export tax/subsidy

pwe.l(r,i,rp,t)  = (1+etax.l(r,i,rp,t))*pe.l(r,i,rp,t) ;

*  CIF/FOB margins

tmarg.l(r,i,rp,t) = inscale*(sum(i0$mapi0(i0,i),vcif(i0, r, rp))
                  - sum(i0$mapi0(i0,i),vfob(i0, r, rp))) ;
tmarg.l(r,i,rp,t)$xw.l(r,i,rp,t) = tmarg.l(r,i,rp,t)/(pwmg.l(r,i,rp,t)*xw.l(r,i,rp,t)) ;

*  CIF price equals FOB price plus margin

pwm.l(r,i,rp,t) = pwe.l(r,i,rp,t) + pwmg.l(r,i,rp,t)*tmarg.l(r,i,rp,t) ;

*  Import tariff

mtax.l(r,i,rp,t)    = inscale*(sum(i0$mapi0(i0,i), vmsb(i0, r, rp))
                    - sum(i0$mapi0(i0,i), vcif(i0, r, rp))
                    - sum(i0$mapi0(i0,i), vntm(i0, r, rp))) ;
ntmAVE.fx(r,i,rp,t) = inscale*sum(i0$mapi0(i0,i), vntm(i0, r, rp)) ;
ntmY.l(r,t)         = sum((i,rp), ntmAVE.l(rp,i,r,t)) ;

mtax.l(r,i,rp,t)$xw.l(r,i,rp,t)    = mtax.l(r,i,rp,t) / (pwm.l(r,i,rp,t)*xw.l(r,i,rp,t)) ;
ntmAVE.fx(r,i,rp,t)$xw.l(r,i,rp,t) = ntmAVE.l(r,i,rp,t) / (pwm.l(r,i,rp,t)*xw.l(r,i,rp,t)) ;

display ntmAVE.l, mtax.l ;

*  Default to NTM revenues go to importing government

chigNTM(s,d,t) = 0 ;
chihNTM(s,d,t) = 0 ;
chigNTM(r,r,t) = 1 ;

*  End-user price of imports

pdm.l(r,i,rp,t) = (1 + mtax.l(r,i,rp,t) + ntmAVE.l(r,i,rp,t))*pwm.l(r,i,rp,t) ;
xmt.l(r,i,t)    = sum(rp, pdm.l(rp,i,r,t)*xw.l(rp,i,r,t)) / pmt.l(r,i,t) ;

*  NEW--MRIO

file xwcsv / xw.csv / ;
put xwcsv ;
put "Var,Importer,Commodity,Exporter,Agent,Value" / ;
xwcsv.pc=5 ;
xwcsv.nd=9 ;

if(MRIO,

   if(not ArmFlag,

      put screen ; put / ;
      put ">>>> Terminating simulation..." / ;
      put ">>>> MRIO requested but ArmFlag = 0, set ArmFlag to 1 in 'Opt' file." / / ;
      putclose screen ;
      Abort "MRIO requested but ArmFlag = 0, set ArmFlag to 1 in 'Opt' file" ;

   ) ;

   $$ifthen exist "%BASENAME%MRIO.gdx"

      viums(i,amrio,s,d) = sum(i0$mapi0(i0,i), viums0(i0,amrio,s,d)) ;
      viuws(i,amrio,s,d) = sum(i0$mapi0(i0,i), viuws0(i0,amrio,s,d)) ;

      mtaxa.l(s,i,d,a,t)$viuws(i,"INT",s,d)    = viums(i,"INT",s,d)/viuws(i,"INT",s,d) - 1 ;
      mtaxa.l(s,i,d,h,t)$viuws(i,"CONS",s,d)   = viums(i,"CONS",s,d)/viuws(i,"CONS",s,d) - 1 ;
      mtaxa.l(s,i,d,gov,t)$viuws(i,"CONS",s,d) = viums(i,"CONS",s,d)/viuws(i,"CONS",s,d) - 1 ;
      mtaxa.l(s,i,d,inv,t)$viuws(i,"CGDS",s,d) = viums(i,"CGDS",s,d)/viuws(i,"CGDS",s,d) - 1 ;

      pdma.l(s,i,d,aa,t)  = (1 + mtaxa.l(s,i,d,aa,t))*pwm.l(s,i,d,t) ;

*     Value share of intermediate trade from region 's' into region 'd'
      xwa.l(s,i,d,a,t)$sum(r, VIUMS(i,"INT",r,d)) = VIUMS(i,"INT",s,d)/sum(r, VIUMS(i,"INT",r,d)) ;
      xwa.l(s,i,d,a,t) = xwa.l(s,i,d,a,t)*xm.l(d,i,a,t)*pmt.l(d,i,t)/ pdma.l(s,i,d,a,t) ;

*     Value share of 'cons' trade from region 's' into region 'd'
      xwa.l(s,i,d,h,t)$sum(r, VIUMS(i,"CONS",r,d)) = VIUMS(i,"CONS",s,d)/sum(r, VIUMS(i,"CONS",r,d)) ;
      xwa.l(s,i,d,h,t) = xwa.l(s,i,d,h,t)*xm.l(d,i,h,t)*pmt.l(d,i,t)/ pdma.l(s,i,d,h,t) ;
      xwa.l(s,i,d,gov,t)$sum(r, VIUMS(i,"CONS",r,d)) = VIUMS(i,"CONS",s,d)/sum(r, VIUMS(i,"CONS",r,d)) ;
      xwa.l(s,i,d,gov,t) = xwa.l(s,i,d,gov,t)*xm.l(d,i,gov,t)*pmt.l(d,i,t)/ pdma.l(s,i,d,gov,t) ;

*     Value share of 'inv' trade from region 's' into region 'd'
      xwa.l(s,i,d,inv,t)$sum(r, VIUMS(i,"CGDS",r,d)) = VIUMS(i,"CGDS",s,d)/sum(r, VIUMS(i,"CGDS",r,d)) ;
      xwa.l(s,i,d,inv,t) = xwa.l(s,i,d,inv,t)*xm.l(d,i,inv,t)*pmt.l(d,i,t)/ pdma.l(s,i,d,inv,t) ;

      pma.l(r,i,aa,t) = (sum(s, pdma.l(s,i,r,aa,t)*xwa.l(s,i,r,aa,t))
                      /    xm.l(r,i,aa,t))$xm.l(r,i,aa,t)
                      + 1$(xm.l(r,i,aa,t) eq 0)
                      ;
   $$else

*     Initialize MRIO assuming uniformity across agents

      mtaxa.l(s,i,r,aa,t) = mtax.l(s,i,r,t) ;
      pdma.l(s,i,r,aa,t)  = (1 + mtaxa.l(s,i,r,aa,t))*pwm.l(s,i,r,t) ;
*     Initialize agent-specific bilateral trade to share of aggregatate imports from region s
      xwa.l(s,i,r,aa,t)$xmt.l(r,i,t) = pdm.l(s,i,r,t)*xw.l(s,i,r,t)
                                     / sum(rp, pdm.l(rp,i,r,t)*xw.l(rp,i,r,t)) ;
      xwa.l(s,i,r,aa,t) = xwa.l(s,i,r,aa,t)*xm.l(r,i,aa,t)*pmt.l(r,i,t)
                        / pdma.l(s,i,r,aa,t) ;
      pma.l(r,i,aa,t) = (sum(s, pdma.l(s,i,r,aa,t)*xwa.l(s,i,r,aa,t))
                      /    xm.l(r,i,aa,t))$xm.l(r,i,aa,t)
                      + 1$(xm.l(r,i,aa,t) eq 0)
                      ;


   $$endif

   loop(t0,
      xwaFlag(s,i,r,aa)$xwa.l(s,i,r,aa,t0) = 1 ;
   ) ;

   if(0,
      loop((d,i,t)$t0(t),
         loop(s,
            put "xw", d.tl, i.tl, s.tl, "Tot", (xw.l(s,i,d,t)/inscale) / ;
            put "pwm", d.tl, i.tl, s.tl, "Tot", pwm.l(s,i,d,t) / ;
            put "pdm", d.tl, i.tl, s.tl, "Tot", pdm.l(s,i,d,t) / ;
            put "mtax", d.tl, i.tl, s.tl, "Tot", mtax.l(s,i,d,t) / ;
            loop(aa,
               put "xwa",  d.tl, i.tl, s.tl, aa.tl, (xwa.l(s,i,d,aa,t)/inscale) / ;
               put "pdma", d.tl, i.tl, s.tl, aa.tl, (pdma.l(s,i,d,aa,t)) / ;
               put "mtaxa", d.tl, i.tl, s.tl, aa.tl, (mtaxa.l(s,i,d,aa,t)) / ;
            ) ;
            if(1,
               loop(amrio,
                  put "VIUMS", d.tl, i.tl, s.tl, amrio.tl, (VIUMS(i,amrio,s,d)) / ;
                  put "VIUWS", d.tl, i.tl, s.tl, amrio.tl, (VIUWS(i,amrio,s,d)) / ;
               ) ;
            ) ;
         ) ;
         put "xmt", d.tl, i.tl, "Tot", "Tot", (xmt.l(d,i,t)/inscale) / ;
         put "pmt", d.tl, i.tl, "Tot", "Tot", (pmt.l(d,i,t)) / ;
         loop(aa,
            put "xm", d.tl, i.tl, "Tot", aa.tl, (xm.l(d,i,aa,t)/inscale) / ;
            put "pmt", d.tl, i.tl, "Tot", aa.tl, (pmt.l(d,i,t)) / ;
            put "pma", d.tl, i.tl, "Tot", aa.tl, (pma.l(d,i,aa,t)) / ;
         ) ;
      ) ;
      abort "Temp" ;
   ) ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Initialize domestic supply of international trade and transport services
*
* --------------------------------------------------------------------------------------------------

xtt.l(r,i,t) = inscale*sum(i0$mapi0(i0,i), vst(i0,r))/pdt.l(r,i,t) ;

* --------------------------------------------------------------------------------------------------
*
*  Initialize domestic closure
*
* --------------------------------------------------------------------------------------------------

deprY.l(r,t)      = inscale*vdep(r) ;
remit.l(r,l,rp,t) = inscale*remit00(l, r, rp) ;
yqtf.l(r,t)       = inscale*yqtf0(r) ;
yqht.l(r,t)       = inscale*yqht0(r) ;
trustY.l(t)       = sum(r, yqtf.l(r,t)) ;

ODAIn.l(r,t)       = inscale*ODAIn0(r) ;
ODAOut.l(r,t)      = inscale*ODAOut0(r) ;
ODAGbl.l(t)        = sum(r, ODAIn.l(r,t)) ;

pnum.l(t)  = 1 ;
pwsav.l(t) = pnum.l(t) ;
pmuv.l(t)  = pnum.l(t) ;
pwgdp.l(t) = pnum.l(t) ;

savf.l(r,t)  = (sum((i,rp), pwm.l(rp,i,r,t)*xw.l(rp,i,r,t))
             -    sum((i,rp), pwe.l(r,i,rp,t)*xw.l(r,i,rp,t))
             -    sum(img, pdt.l(r,img,t)*xtt.l(r,img,t))
             -    (sum((l,rp), remit.l(r,l,rp,t) - remit.l(rp,l,r,t)))
             -    (yqht.l(r,t) - yqtf.l(r,t))
             -    (ODAIn.l(r,t) - ODAOut.l(r,t)) ) / pwsav.l(t) ;

savg.l(r,t)   = 0 ;
pgdpmp.l(r,t) = 1 ;
rsg.l(r,t)  = savg.l(r,t) / pgdpmp.l(r,t) ;

gdpmp.l(r,t) = sum(fd, yfd.l(r,fd,t))
             + sum((i,rp), pwe.l(r,i,rp,t)*xw.l(r,i,rp,t) - pwm.l(rp,i,r,t)*xw.l(rp,i,r,t))
             + sum(img, pdt.l(r,img,t)*xtt.l(r,img,t)) ;

savfRat.l(r,t) = savf.l(r,t)/gdpmp.l(r,t) ;

*  Override of capital stock data and depreciation rates

loop((r,t0),
   if(cap_out_Ratio0(r) ne na,
      kstock.l(r,t) = inscale*cap_out_Ratio0(r)*vkb(r) ;
   else
      kstock.l(r,t) = inscale*vkb(r) ;
   ) ;
) ;

depr(r,t) = (deprT(r,t))$(deprT(r,t) ne na)
          + (deprY.l(r,t)/sum(inv, pfd.l(r,inv,t)*kstock.l(r,t)))$(deprT(r,t) eq na)
          ;

fdepr(r,t)   = depr(r,t) ;
deprY.l(r,t) = sum(inv, fdepr(r,t)*pfd.l(r,inv,t)*kstock.l(r,t)) ;

loop((h,inv),
   savh.l(r,h,t) = yfd.l(r,inv,t) - deprY.l(r,t) - pwsav.l(t)*savf.l(r,t) - savg.l(r,t) ;
) ;
ev.l(r,h,t) = yfd.l(r,h,t) + savh.l(r,h,t)$(%utility% eq ELES) ;

* --------------------------------------------------------------------------------------------------
*
*  Initialize income variables
*
* --------------------------------------------------------------------------------------------------

*  Factor income taxes

kappaf.l(r,f,a,t)$xf.l(r,f,a,t) = 1 - inscale*sum(a0$mapa0(a0,a), evos(f,a0,r))
                                /      (pf.l(r,f,a,t)*xf.l(r,f,a,t)) ;

yh.l(r,t) = sum((f,a)$xfFlag(r,f,a), (1-kappaf.l(r,f,a,t))*pf.l(r,f,a,t)*xf.l(r,f,a,t))
          -    sum((l,rp), remit.l(rp,l,r,t))  +  sum((l,rp), remit.l(r, l, rp, t))
          -    yqtf.l(r,t) + yqht.l(r,t) - deprY.l(r,t)
          ;

loop(h,
   kappah.l(r,t) = (yh.l(r,t) - savh.l(r,h,t) - yfd.l(r,h,t))/yh.l(r,t) ;
   yd.l(r,t)     = (1 - kappah.l(r,t))*yh.l(r,t) ;
   chiaps.l(r,t) = 1 ;
   aps.l(r,h,t)  = savh.l(r,h,t) / (chiaps.l(r,t)*yd.l(r,t)) ;
) ;


ygov.l(r,gy,t) = (sum((a,i), ptax.l(r,a,i,t)*p.l(r,a,i,t)*x.l(r,a,i,t)
               +   sum(v, uc.l(r,a,v,t)*uctax.l(r,a,v,t)*xpv.l(r,a,v,t))))$ptx(gy)
               +  (sum((f,a)$xfFlag(r,f,a), pftax.l(r,f,a,t)*pf.l(r,f,a,t)*xf.l(r,f,a,t)))$vtx(gy)
               +  (sum((i,aa)$xaFlag(r,i,aa),
                        paTax.l(r,i,aa,t)*gammaeda(r,i,aa)*pat.l(r,i,t)*xa.l(r,i,aa,t)))$itx(gy)
               +  (sum((i,rp)$xwFlag(rp,i,r),
                        mtax.l(rp,i,r,t)*pwm.l(rp,i,r,t)*xw.l(rp,i,r,t)))$mtx(gy)
               +  (sum((i,rp)$xwFlag(r,i,rp),
                        etax.l(r,i,rp,t)*pe.l(r,i,rp,t)*xw.l(r,i,rp,t)))$etx(gy)
               +  (sum((f,a), kappaf.l(r,f,a,t)*pf.l(r,f,a,t)*xf.l(r,f,a,t))
               +   kappah.l(r,t)*yh.l(r,t))$dtx(gy)
               +  (0)$ctx(gy)
               ;

* --------------------------------------------------------------------------------------------------
*
*  Initialize trade block
*
* --------------------------------------------------------------------------------------------------

*  Top level Armington

xat.l(r,i,t) = sum(aa, gammaeda(r,i,aa)*xa.l(r,i,aa,t)) ;
xet.l(r,i,t) = sum(rp, pe.l(r,i,rp,t)*xw.l(r,i,rp,t)) / pet.l(r,i,t) ;
xdt.l(r,i,t)  = (ps.l(r,i,t)*xs.l(r,i,t) - pet.l(r,i,t)*xet.l(r,i,t))/pdt.l(r,i,t) ;
xdt.l(r,i,t)$(xdt.l(r,i,t) lt 0) = 0 ;

loop(t0,
   xatFlag(r,i)$xat.l(r,i,t0) = 1 ;
   xddFlag(r,i)$((xdt.l(r,i,t0) - xtt.l(r,i,t0)) gt 0) = 1 ;
   xmtFlag(r,i)$xmt.l(r,i,t0) = 1 ;

   xdtFlag(r,i)$xdt.l(r,i,t0) = 1 ;
   xetFlag(r,i)$xet.l(r,i,t0) = 1 ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Initialize trade margins block
*
* --------------------------------------------------------------------------------------------------

alias(i0,j0) ;

xtmg.l(img,t)          = sum(r, pdt.l(r,img,t)*xtt.l(r,img,t)) / ptmg.l(img,t) ;
xmgm.l(img,r,i,rp,t)   = inscale*sum((j0,i0)$(mapi0(j0,img) and mapi0(i0,i)), VTWR(j0, i0, r, rp))
                       / ptmg.l(img,t) ;
xwmg.l(r,i,rp,t)       = tmarg.l(r,i,rp,t)*xw.l(r,i,rp,t) ;
lambdamg(img,r,i,rp,t) = 1 ;

loop(t0,
   xttFlag(r,img)$xtt.l(r,img,t0) = 1 ;
   tmgFlag(r,i,rp)$xwmg.l(r,i,rp,t0) = 1 ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Initialize factor supply block
*
* --------------------------------------------------------------------------------------------------

lsFlag(r,l,z)$(lsFlag(r,l,z) and sum((a,t0)$mapz(z,a), xf.l(r,l,a,t0)) = 0) = no ;
ueFlag(r,l,z)$(ueFlag(r,l,z) and not lsFlag(r,l,z)) = no ;
awagez.l(r,l,z,t) = sum(a$mapz(z,a), xf.l(r,l,a,t)) ;
awagez.l(r,l,z,t)$awagez.l(r,l,z,t) = sum(a$mapz(z,a), pf.l(r,l,a,t)*xf.l(r,l,a,t))
                                    / awagez.l(r,l,z,t) ;
twage.l(r,l,t) = sum(a, pf.l(r,l,a,t)*xf.l(r,l,a,t))/sum(a, xf.l(r,l,a,t)) ;

uez.l(r,l,z,t)$ueFlag(r,l,z) = uez0(r,l,z) ;
urbPrem.l(r,l,t) = sum(rur, (1-uez.l(r,l,rur,t))*awagez.l(r,l,rur,t)) ;
urbPrem.l(r,l,t)$urbPrem.l(r,l,t) = sum(urb, (1-uez.l(r,l,urb,t))*awagez.l(r,l,urb,t))
                 / urbPrem.l(r,l,t) ;

ldz.l(r,l,z,t)$lsFlag(r,l,z) = sum(a$mapz(z,a), xf.l(r,l,a,t)) ;
lsz.l(r,l,z,t)$lsFlag(r,l,z) = ldz.l(r,l,z,t)/(1 - uez.l(r,l,z,t)) ;
ls.l(r,l,t)    = sum(z$lsFlag(r,l,z), lsz.l(r,l,z,t)) ;
tls.l(r,t)     = sum(l, ls.l(r,l,t)) ;
loop(t0,
   tlabFlag(r,l)$ls.l(r,l,t0) = 1 ;
) ;

migrFlag(r,l) = no ;
loop(t0,
   migrFlag(r,l)$(omegam(r,l) ne inf) = yes ;
) ;

loop(rur,
   migr.l(r,l,t)$migrFlag(r,l) = migr0(r,l)*lsz.l(r,l,rur,t) ;
) ;
migrmult.l(r,l,z,t) = 1 ;

*  Check migration assumptions

work = 0 ;
loop((r,l)$(omegam(r,l) ne inf),
   if(ifLSeg(r,l) eq 0,
      if(work eq 0,
         put screen ;
         put / ;
         put 'Invalid assumption(s) for labor market segmentation: ' / ;
         work = 1 ;
      ) ;
      put '   ', r.tl:<12, 'omegam = ', omegam(r,l):10:2, ' but no labor market segmentation.' / ;
   ) ;
) ;
if(work, Abort$(1) "Check labor market assumptions" ; ) ;

ewagez.l(r,l,z,t)$lsFlag(r,l,z) = awagez.l(r,l,z,t) ;

loop(mapz(z,a),
   wPrem.l(r,l,a,t)$lsFlag(r,l,z) = pf.l(r,l,a,t)/ewagez.l(r,l,z,t) ;
) ;

resWage.l(r,l,z,t) = 0.001 ;
resWage.l(r,l,z,t)$ueFlag(r,l,z) = resWage0(r,l,z)*ewagez.l(r,l,z,t) ;
loop(t0,
   chirw.fx(r,l,z,t)$ueFlag(r,l,z) = resWage.l(r,l,z,t0)
                                   *  ((1+0)**omegarwg(r,l,z))
                                   *  ((1)**omegarwue(r,l,z))
                                   *  (1**omegarwp(r,l,z))
                                   ;
) ;

ueMinz(r,l,z,t)$ueFlag(r,l,z) = ueMinz0(r,l,z) ;
uez.lo(r,l,z,t)$ueFlag(r,l,z) = ueMinz(r,l,z,t) ;

glab.l(r,l,t)       = 0.0 ;
glabz.l(r,l,z,t)    = 0.0 ;

skillprem.l(r,l,t)$ls.l(r,l,t) = (sum(lr, twage.l(r,lr,t)*ls.l(r,lr,t))
                               /  sum(lr, ls.l(r,lr,t)))/twage.l(r,l,t) - 1 ;

tkaps.l(r,t) = sum((a,v), pk.l(r,a,v,t)*kv.l(r,a,v,t)) / trent.l(r,t) ;

loop(t0,
   chiKaps0(r)  = tkaps.l(r,t0)/kstock.l(r,t0) ;
) ;
k0.l(r,a,t)     = sum(v, kv.l(r,a,v,t)) ;
rrat.l(r,a,t)   = 1 ;
loop(vOld,
   kxRat.l(r,a,v,t)$xpFlag(r,a) = kv.l(r,a,vOld,t)/xpv.l(r,a,vOld,t) ;
) ;
invGFact.l(r,t) = 20 ;
* invGfact.l(r,t) = 0.02 ;

*  !!!! NEEDS to be reviewed if we have the right price/volume split
*       NEED to add wedges if we allow for infinite transformation

tland.l(r,t)    = sum((lnd,a), pf.l(r,lnd,a,t)*xf.l(r,lnd,a,t))/ptland.l(r,t) ;

loop(t0,
   tlandFlag(r)$tland.l(r,t0) = 1 ;
) ;

xlb.l(r,lb,t) = sum((lnd,a)$maplb(lb,a), xf.l(r,lnd,a,t)) ;
plb.l(r,lb,t)$xlb.l(r,lb,t) =
   sum((lnd,a)$maplb(lb,a), pf.l(r,lnd,a,t)*xf.l(r,lnd,a,t))/xlb.l(r,lb,t) ;
plbndx.l(r,lb,t) = plb.l(r,lb,t) ;

* display land.l, xlb.l, maplb ;

xnlb.l(r,t) = sum(lb$(not lb1(lb)), xlb.l(r,lb,t)) ;
pnlb.l(r,t)$xnlb.l(r,t) = sum(lb$(not lb1(lb)), plb.l(r,lb,t)*xlb.l(r,lb,t))/xnlb.l(r,t) ;
pnlb.l(r,t)$(xnlb.l(r,t) eq 0) = 1 ;
pnlbndx.l(r,t) = pnlb.l(r,t) ;

tland.l(r,t) = sum(lb1, xlb.l(r,lb1,t)) + xnlb.l(r,t) ;
ptland.l(r,t)$tland.l(r,t) = (sum(lb1, plb.l(r,lb1,t)*xlb.l(r,lb1,t))
                           + pnlb.l(r,t)*xnlb.l(r,t))/tland.l(r,t) ;
ptlandndx.l(r,t) = ptland.l(r,t) ;

landmax.fx(r,t) = landMax0(r)*tland.l(r,t) ;

* --------------------------------------------------------------------------------------------------
*
*  Water supply module
*
* --------------------------------------------------------------------------------------------------

h2obnd.l(r,wbnd,t) = watScale*h2oUse(wbnd, r)$IFWATER ;

*  !!!! FOR THE MOMENT, assume water price is uniform across broad aggregates

ph2obnd.l(r,wbnd,t) = sum((wat,acr), xf.l(r,wat,acr,t)) ;
ph2obnd.l(r,wbnd,t)$ph2obnd.l(r,wbnd,t)
   = sum((wat,acr), pf.l(r,wat,acr,t)*xf.l(r,wat,acr,t)) / ph2obnd.l(r,wbnd,t) ;
ph2obndndx.l(r,wbnd,t) = ph2obnd.l(r,wbnd,t) ;

*  Build the nested bundles

h2obnd.l(r,wbnd1,t) = sum(wbnd2$mapw1(wbnd1, wbnd2), h2obnd.l(r,wbnd2,t)) ;
ph2obnd.l(r,wbnd1,t)$h2obnd.l(r,wbnd1,t) =
   sum(wbnd2$mapw1(wbnd1, wbnd2), ph2obnd.l(r,wbnd2,t)*h2obnd.l(r,wbnd2,t))/h2obnd.l(r,wbnd1,t) ;

th2om.l(r,t) = sum(wbnd1, h2obnd.l(r,wbnd1,t)) ;
pth2o.l(r,t)$th2om.l(r,t) =
   sum(wbnd1, ph2obnd.l(r,wbnd1,t)*h2obnd.l(r,wbnd1,t))/th2om.l(r,t) ;
th2o.l(r,t) = th2om.l(r,t) + sum(wbnd$wbndEx(wbnd), h2obnd.l(r,wbnd,t)) ;
pth2ondx.l(r,t) = pth2o.l(r,t) ;

h2oMax.fx(r,t) = h2oMax0(r)*th2o.l(r,t) ;

loop(t0,
   th2oFlag(r)$th2o.l(r,t0) = 1 ;
   h2obndFlag(r,wbnd)$h2obnd.l(r,wbnd,t0) = 1 ;
   h2obndFlag(r,wbndEx) = 0 ;
) ;

*  !!!! This might need revision if the matrix is not diagonal or if we have
*       an independent source for production volumes

xp.l(r,a,t)       = sum(i, p.l(r,a,i,t)*x.l(r,a,i,t))/px.l(r,a,t) ;
pxv.l(r,a,v,t)    = px.l(r,a,t) ;
uc.l(r,a,v,t)     = pxv.l(r,a,v,t)/(1 + uctax.l(r,a,v,t)) ;
xpv.l(r,a,vOld,t) = xp.l(r,a,t) ;
xpx.l(r,a,vOld,t) = (xpv.l(r,a,vOld,t)*uc.l(r,a,vOld,t) - pxghg.l(r,a,vOld,t)*xghg.l(r,a,vOld,t))
                  /  pxp.l(r,a,vOld,t) ;

*  !!!! NEED TO RESOLVE

$ontext
put screen ;
put / ;
loop((r,a,vOld,t0)$(xp.l(r,a,t0) < 0),
   put r.tl / ;
   put uc.l(r,a,vOld,t0), px.l(r,a,t0), pp.l(r,a,t0), xpFlag(r,a), xp.l(r,a,t0):15:8 / ;
) ;
loop((r,i,t0)$(xs.l(r,i,t0) < 0),
   put r.tl / ;
   put xsFlag(r,i), xs.l(r,i,t0):15:8 / ;
) ;
abort "Temp" ;

*  !!!! Temporary fix to energy problem -- quite dangerous

loop(t0,
   xpFlag(r,a)$(xp.l(r,a,t0) < 0) = 0 ;
   ghgFlag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   nd1Flag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   nd2Flag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   lab1Flag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   lab2Flag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   kFlag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   kfFlag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   kefFlag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   va1Flag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   va2Flag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   xnrgFlag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   xwatfFlag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   xaFlag(r,i,a)$(xpFlag(r,a) = 0) = 0 ;
   xnelyFlag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   xolgFlag(r,a)$(xpFlag(r,a) = 0) = 0 ;
   xaNRGFlag(r,a,NRG)$(xpFlag(r,a) = 0) = 0 ;
) ;
$offtext

loop(vOld,
   kxRat.l(r,a,v,t)$xpFlag(r,a) = kv.l(r,a,vOld,t)/xpv.l(r,a,vOld,t) ;
) ;

*  Price electricity consumption in gwhr

put screen ;

if(IFPOWER,

   gwhr(r,elya) = inscale*sum(a0$mapa0(a0,elya), gwhr0(a0,r)) ;

*  Reprice make matrix in terms of $ per gwhr

   loop(t0$(1),

*     !!!! Check: it is apparently possible to have px*xp = 0 and not gwhr!

      loop((r,elya,elyc),
         if(px.l(r,elya,t0)*xp.l(r,elya,t0) eq 0 and gwhr(r,elya) ne 0,
            put "XP=0, GWHR<>0: ", r.tl, elya.tl, (gwhr(r,elya)/inscale):15:4 / ;
         ) ;
         if(px.l(r,elya,t0)*xp.l(r,elya,t0) ne 0 and gwhr(r,elya) eq 0,
            put "XP<>0, GWHR=0: ", r.tl, elya.tl, (px.l(r,elya,t0)*xp.l(r,elya,t0)/inscale):15:4 / ;
         ) ;
      ) ;

      loop(elya,
*        Price per Gwhr
         rwork(r)$gwhr(r,elya)   = (px.l(r,elya,t0)*xp.l(r,elya,t0))/gwhr(r,elya) ;
         display rwork ;
         xp.l(r,elya,t)$rwork(r) = (px.l(r,elya,t0)*xp.l(r,elya,t0))/rwork(r) ;
         px.l(r,elya,t)          = rwork(r)$xp.l(r,elya,t)
                                 + 1$(xp.l(r,elya,t) eq 0) ;
      ) ;
*     !!!! Caution here...
      pxv.l(r,elya,vOld,t) = px.l(r,elya,t) ;
      uc.l(r,elya,vOld,t)  = px.l(r,elya,t) ;
      xpv.l(r,elya,vOld,t) = xp.l(r,elya,t) ;

*     !!!! Assume each power activity produces only one commodity
      x.l(r,elya,elyc,t)  = xp.l(r,elya,t) ;
      p.l(r,elya,elyc,t)  = px.l(r,elya,t) ;
      pp.l(r,elya,elyc,t) = p.l(r,elya,elyc,t0)*(1+ptax.l(r,elya,elyc,t0)) ;

*     !!!! Reprice electricity supply

      xs.l(r,elyc,t) = sum(elya, x.l(r,elya,elyc,t)) ;
      ps.l(r,elyc,t) = (sum(elya, pp.l(r,elya,elyc,t)*x.l(r,elya,elyc,t)) / xs.l(r,elyc,t))
                     $     xs.l(r,elyc,t)
                     + 1$(xs.l(r,elyc,t) eq 0) ;

*     Gamma's in effect convert supply from Gwhr to MTOE

      gammaesd(r,elyc) = pdt.l(r,elyc,t0)/ps.l(r,elyc,t0) ;
      gammaese(r,elyc) = pet.l(r,elyc,t0)/ps.l(r,elyc,t0) ;
   ) ;
) ;

putclose screen ;

*  Initialization of power nesting

if(IFPOWER,

*  Create the power bundles and reprice 'etd'

   loop((r,elyc,t0),

      xpb.l(r,pb,elyc,t)    = sum(elya$mappow(pb,elya), x.l(r,elya,elyc,t)) ;
      ppb.l(r,pb,elyc,t)    = (sum(elya$mappow(pb,elya), pp.l(r,elya,elyc,t)*x.l(r,elya,elyc,t))
                            / xpb.l(r,pb,elyc,t))$xpb.l(r,pb,elyc,t)
                            + 1$(xpb.l(r,pb,elyc,t) eq 0) ;
      ppbndx.l(r,pb,elyc,t) = ppb.l(r,pb,elyc,t) ;
      xpow.l(r,elyc,t)      = sum(pb, xpb.l(r,pb,elyc,t)) ;
      ppow.l(r,elyc,t)      = (sum(pb, ppb.l(r,pb,elyc,t)*xpb.l(r,pb,elyc,t))
                            / xpow.l(r,elyc,t))$xpow.l(r,elyc,t)
                            + 1$(xpow.l(r,elyc,t) eq 0) ;
      ppowndx.l(r,elyc,t)   = ppow.l(r,elyc,t) ;
*     Reprice etd services
*     !!!! Check taxes
      as(r,etd,elyc)        = pp.l(r,etd,elyc,t0)*x.l(r,etd,elyc,t0) ;
      x.l(r,etd,elyc,t)     = x.l(r,etd,elyc,t0) ;
      pp.l(r,etd,elyc,t)    = (as(r,etd,elyc)/x.l(r,etd,elyc,t0))
                            $x.l(r,etd,elyc,t0)
                            + 1
                            $(x.l(r,etd,elyc,t0) eq 0) ;
      p.l(r,etd,elyc,t)     = pp.l(r,etd,elyc,t)/(1+ptax.l(r,etd,elyc,t0)) ;
   ) ;

) ;

file fpow / pow.csv / ;
if(1,
   put fpow ;
   put "Var,Region,Activity,Commodity,Value" / ;
   fpow.pc=5 ;
   fpow.nd=9 ;
   loop((r,elya,elyc,t0),
      put "x", r.tl, elya.tl, elyc.tl, (x.l(r,elya,elyc,t0)/inscale) / ;
      put "p", r.tl, elya.tl, elyc.tl, (p.l(r,elya,elyc,t0)) / ;
      put "pp", r.tl, elya.tl, elyc.tl, (pp.l(r,elya,elyc,t0)) / ;
      put "ptax", r.tl, elya.tl, elyc.tl, (ptax.l(r,elya,elyc,t0)) / ;
   ) ;
   loop((r,elya,t0),
      put "xp", r.tl, elya.tl, "", (xp.l(r,elya,t0)/inscale) / ;
      put "px", r.tl, elya.tl, "", (px.l(r,elya,t0)) / ;
   ) ;
   loop((r,elyc,t0),
      put "xs", r.tl, "", elyc.tl, (xs.l(r,elyc,t0)/inscale) / ;
      put "ps", r.tl, "", elyc.tl, (ps.l(r,elyc,t0)) / ;
   ) ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Initialization of capital account module
*
* --------------------------------------------------------------------------------------------------

kstocke.l(r,t) = (1-depr(r,t))*kstock.l(r,t) + sum(inv, xfd.l(r,inv,t)) ;

ror.l(r,t) = sum((a,cap),(1-kappaf.l(r,cap,a,t))*pf.l(r,cap,a,t)*xf.l(r,cap,a,t))/kstock.l(r,t) ;

rorc.l(r,t) = ror.l(r,t)/sum(inv, pfd.l(r,inv,t)) - depr(r,t) ;

rore.l(r,t) = rorc.l(r,t)*(kstocke.l(r,t)/kstock.l(r,t))**(-epsRor(r,t)) ;

rorg.l(t) = (sum(r, rore.l(r,t)*sum(inv, pfd.l(r,inv,t)*(xfd.l(r,inv,t) - depr(r,t)*kstock.l(r,t))))
          /  sum((rp,inv), pfd.l(rp,inv,t)*(xfd.l(rp,inv,t) - depr(rp,t)*kstock.l(rp,t))))$(savfFlag ne capFlexUSAGE) ;

riskPrem(r,t) = (rorg.l(t) / rore.l(r,t))$(savfFlag ne capFlexINF)
              + (rorg.l(t) / rorc.l(r,t))$(savfFlag eq capFlexINF)
              ;

savfBar(r,t)  = savf.l(r,t) ;

if(0,
   display kstock.l, kstocke.l, ror.l, rorc.l, rore.l, rorg.l, riskPrem ;

   abort "Temp" ;
) ;

*  Direct initialization

loop((inv,t0),
   grK.l(r,t)    = xfd.l(r,inv,t0)/kstock.l(r,t0) - depr(r,t0) ;
   if(savfFlag eq capFlexUSAGE,
      devRoR.l(r,t) = log(((grKMax(r,t0) - grKTrend(r,t0))/(grKTrend(r,t0) - grKMin(r,t0)))
                    * (grK.l(r,t0) - grKMin(r,t0))/(grKMax(r,t0) - grK.l(r,t0)))
                    / chigrK(r,t) ;
      rore.l(r,t)   = (ror.l(r,t0)/pfd.l(r,inv,t0) + (1-depr(r,t0)))/1.05 - 1 ;
      rorg.l(t)     = 0 ;
      rord.l(r,t)   = rore.l(r,t) - rorn(r,t) - rorg.l(t) - devRor.l(r,t) ;
   ) ;
) ;

if(0,
   option decimals=6 ;
   display grk.l, devRoR.l, rore.l, rorg.l, rord.l,
   grkMin, grkMax, grkTrend, chigrK, rorn ;

   abort "Temp" ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Initialization of emissions module
*
* --------------------------------------------------------------------------------------------------

*  The 'm' variables are in millions of tons of CO2

*  Conversion factor for emissions

work = cscale*(1$(not ifCEQ) + (12/44)$ifCEQ) ;

*  Aggregate emissions

emird(r,"co2",i,a)   = work*(sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), mdf(i0,a0,r))) ;
emirm(r,"co2",i,a)   = work*(sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), mmf(i0,a0,r))) ;

emird(r,"co2",i,h)   = work*(sum(i0$mapi0(i0,i), mdp(i0,r))) ;
emirm(r,"co2",i,h)   = work*(sum(i0$mapi0(i0,i), mmp(i0,r))) ;

emird(r,"co2",i,gov) = work*(sum(i0$mapi0(i0,i), mdg(i0,r))) ;
emirm(r,"co2",i,gov) = work*(sum(i0$mapi0(i0,i), mmg(i0,r))) ;

emird(r,"co2",i,inv) = work*(sum(i0$mapi0(i0,i), mdi(i0,r))) ;
emirm(r,"co2",i,inv) = work*(sum(i0$mapi0(i0,i), mmi(i0,r))) ;

emir(r,"co2",i,aa)    = emird(r,"co2",i,aa) + emirm(r,"co2",i,aa) ;
emi.l(r,"co2",i,aa,t) = emir(r,"co2",i,aa) ;

*  Non-CO2 emissions are not source specific

loop(em$(ghg(em) and not sameas(em,"CO2")),
   emir(r,em,i,a)    = work*sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), nc_trad_ceq(em, i0, a0, r)) ;
   emir(r,em,fp,a)   = work*sum(a0$mapa0(a0,a), nc_endw_ceq(em, fp, a0, r)) ;
   emir(r,em,tot,a)  = work*sum(a0$mapa0(a0,a), nc_qo_ceq(em, a0, r)) ;
   emir(r,em,i,h)    = work*sum(i0$mapi0(i0,i), nc_hh_ceq(em, i0, r)) ;
) ;

loop(em$nghg(em),
   emir(r,em,i,a)    = work*sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), nc_trad(em, i0, a0, r)) ;
   emir(r,em,fp,a)   = work*sum(a0$mapa0(a0,a), nc_endw(em, fp, a0, r)) ;
   emir(r,em,tot,a)  = work*sum(a0$mapa0(a0,a), nc_qo(em, a0, r)) ;
   emir(r,em,i,h)    = work*sum(i0$mapi0(i0,i), nc_hh(em, i0, r)) ;
) ;

*  Calculate the coeffiecients

emi.l(r,em,is,aa,t) = emir(r,em,is,aa) ;

*  Calibrate the emissions coefficients

loop(t0,
   emir(r,em,i,aa)$xa.l(r,i,aa,t0) = emi.l(r,em,i,aa,t0) / xa.l(r,i,aa,t0) ;

   emird(r,"CO2",i,aa)$xd.l(r,i,aa,t0) = emird(r,"CO2",i,aa) / xd.l(r,i,aa,t0) ;
   emirm(r,"CO2",i,aa)$xm.l(r,i,aa,t0) = emirm(r,"CO2",i,aa) / xm.l(r,i,aa,t0) ;

   emird(r,emn,i,aa)$(xd.l(r,i,aa,t0) + xm.l(r,i,aa,t0))
      = emi.l(r,emn,i,aa,t0) / (xd.l(r,i,aa,t0) + xm.l(r,i,aa,t0)) ;
   emirm(r,emn,i,aa) = emird(r,emn,i,aa) ;

   emir(r,em,f,a)$xf.l(r,f,a,t0) = emi.l(r,em,f,a,t0) / xf.l(r,f,a,t0) ;
   emir(r,em,tot,a)$xp.l(r,a,t0) = emi.l(r,em,tot,a,t0) / xp.l(r,a,t0) ;
) ;

gwp("co2") = 1 ;
if(ifNCO2,
   gwp(emn) = 1000*sum(r, sum((i,a), sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)),
                                nc_trad_ceq(emn, i0, a0, r)))
            +             sum((fp,a), sum(a0$mapa0(a0,a), nc_endw_ceq(emn, fp, a0, r)))
            +             sum(a, sum(a0$mapa0(a0,a), nc_qo_ceq(emn, a0, r)))
            +             sum(i, sum(i0$mapi0(i0,i), nc_hh_ceq(emn, i0, r))))
            / sum(r, sum((i,a), sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), nc_trad(emn, i0, a0, r)))
            +                   sum((fp,a),sum(a0$mapa0(a0,a), nc_endw(emn, fp, a0, r)))
            +                   sum(a, sum(a0$mapa0(a0,a), nc_qo(emn, a0, r)))
            +                   sum(i, sum(i0$mapi0(i0,i), nc_hh(emn, i0, r)))) ;
else
   gwp(emn) = 1 ;
) ;

if(0,
   display nc_qo_ceq, nc_qo ;
   display gwp ;
   work = 1000*sum(r, sum(a, sum(a0$mapa0(a0,a), nc_qo_ceq("fgas", a0, r)))) ;
   display "nc_qo_ceq(fgas) = ", work ;
   work = sum(r, sum(a, sum(a0$mapa0(a0,a), nc_qo("fgas", a0, r)))) ;
   display "nc_qo(fgas) = ", work ;
) ;

chiEmi.fx(em,t)    = 1 ;
emiOth.fx(r,em,t)  = 0 ;
emiOthGbl.fx(em,t) = 0 ;

emiTot.l(r,em,t)   = emiOth.l(r,em,t) + sum((is,aa), emi.l(r,em,is,aa,t)) ;
emiGbl.l(em,t)     = emiOthGbl.l(em,t) + sum(r, emiTot.l(r,em,t)) ;

*  Intialize tax regime components

*  No tax exemptions
part(r,em,i,aa)       = 1 ;

emiTax.fx(r,em,t)     = 0 ;
emiCap.fx(ra,em,t)    = 0 ;
emiQuota.fx(r,em,t)   = 0 ;
emiQuotaY.fx(r,em,t)  = 0 ;
emiRegTax.fx(ra,em,t) = 0 ;
chiCap.fx(em,t)       = 1 ;

ifEmiCap              = 0 ;
emFlag(em)            = 0 ;
ifEmiQuota(r)         = 0 ;

* --------------------------------------------------------------------------------------------------
*
*  Miscellaneous initializations
*
* --------------------------------------------------------------------------------------------------

gdpmp.l(r,t) = sum(fd, yfd.l(r,fd,t))
             + sum((i,rp), pwe.l(r,i,rp,t)*xw.l(r,i,rp,t) - pwm.l(rp,i,r,t)*xw.l(rp,i,r,t))
             + sum(img, pdt.l(r,img,t)*xtt.l(r,img,t)) ;

rgdpmp.l(r,t) = gdpmp.l(r,t) ;

loop(gov,
   rgovshr.l(r,t) = xfd.l(r,gov,t) / rgdpmp.l(r,t) ;
   govshr.l(r,t)  = yfd.l(r,gov,t) / gdpmp.l(r,t) ;
) ;

loop(inv,
   rinvshr.l(r,t) = xfd.l(r,inv,t) / rgdpmp.l(r,t) ;
   invshr.l(r,t)  = yfd.l(r,inv,t) / gdpmp.l(r,t) ;
) ;

loop(t0,
*  Initialization for comparative static model
   pop.l(r,t)$(popT(r,"PTOTL",t0) eq 0) = popScale*popg(r) ;
) ;

rgdppc.l(r,t)   = rgdpmp.l(r,t) / pop.l(r,t) ;
grrgdppc.l(r,t) = 0 ;
gl.l(r,t)       = 0 ;


klrat.l(r,t) = sum((a,v), pk.l(r,a,v,t)*kv.l(r,a,v,t))
             / sum((a,l), pf.l(r,l,a,t)*xf.l(r,l,a,t)) ;

pw.l(a,t) = sum((r,t0), px.l(r,a,t)*xp.l(r,a,t0))
          / sum((r,t0), px.l(r,a,t0)*xp.l(r,a,t0)) ;

pwtrend(a,tt) = na ;
pwshock(a,tt) = na ;

walras.l = 0.0 ;
