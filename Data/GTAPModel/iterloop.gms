* --------------------------------------------------------------------------------------------------
*
*  Code implemented between solution periods
*
* --------------------------------------------------------------------------------------------------

if(years(tsim) gt FirstYear and ifDyn,

*  Update variables

*  Calculate the growth of total GDP by region

   rwork(r) = power(1 + ggdppcT(r,tsim), gap(tsim))*pop.l(r,tsim)/pop.l(r,tsim-1) ;

   $$batinclude "mvar.gms" initvar tsim

) ;

*  Closure

*  Policy variables

fctts.fx(r,fp,a,tsim) = fctts.l(r,fp,a,tsim) ;
fcttx.fx(r,fp,a,tsim) = fcttx.l(r,fp,a,tsim) ;
prdtx.fx(r,a,i,tsim)  = prdtx.l(r,a,i,tsim) ;
exptx.fx(r,i,rp,tsim) = exptx.l(r,i,rp,tsim) ;
imptx.fx(r,i,rp,tsim) = imptx.l(r,i,rp,tsim) ;
if(MRIO,
   imptxa.fx(r,i,rp,aa,tsim) = imptxa.l(r,i,rp,aa,tsim) ;
) ;

dtxshft.fx(r,i,aa,tsim) = dtxshft.l(r,i,aa,tsim) ;
mtxshft.fx(r,i,aa,tsim) = mtxshft.l(r,i,aa,tsim) ;
rtxshft.fx(r,aa,tsim)   = rtxshft.l(r,aa,tsim) ;
dintx.fx(r,i,aa,tsim)$(not intxFlag(r,i,aa)) =
   dintx0(r,i,aa) + dtxshft.l(r,i,aa,tsim) + rtxshft.l(r,aa,tsim) ;
mintx.fx(r,i,aa,tsim)$(not intxFlag(r,i,aa)) =
   mintx0(r,i,aa) + mtxshft.l(r,i,aa,tsim) + rtxshft.l(r,aa,tsim) ;

ytaxshr.l(r,gy,t)    = (ytax.l(r,gy,t) / regY.l(r,t)) * (ytax0(r,gy) / regY0(r)) ;

*  Fix the numeraire

pnum.fx(t)   = pnum.l(t) ;

*  Capital account closure

if(RoRFlag eq capSFix,
   chif.fx(r,t)$(not rres(r)) = chif.l(r,t) ;
) ;

chiInv.lo(r,t) = -inf ;
chiInv.up(r,t) = +inf ;
if(RoRFlag eq capShrFix,
   chiInv.fx(r,t) = chiInv.l(r,t) ;
) ;

*  Technology variables

tmarg.fx(r,i,rp,tsim) = tmarg.l(r,i,rp,tsim) ;

*  Preference parameters

betaP.fx(r,t) = betaP.l(r,t) ;
betaG.fx(r,t) = betaG.l(r,t) ;
betaS.fx(r,t) = betaS.l(r,t) ;

*  Put a lower bound on prices

px.lo(r,a,tsim)$xpFlag(r,a)             = 0.001*px.l(r,a,tsim-1) ;
pva.lo(r,a,tsim)$vaFlag(r,a)            = 0.001*pva.l(r,a,tsim-1) ;
pnd.lo(r,a,tsim)$ndFlag(r,a)            = 0.001*pnd.l(r,a,tsim-1) ;
p.lo(r,a,i,tsim)$xFlag(r,a,i)           = 0.001*p.l(r,a,i,tsim-1) ;
ps.lo(r,i,tsim)$xsFlag(r,i)             = 0.001*ps.l(r,i,tsim-1) ;
pdp.lo(r,i,aa,tsim)$alphad(r,i,aa,tsim) = 0.001*pdp.l(r,i,aa,tsim-1) ;
pmp.lo(r,i,aa,tsim)$alpham(r,i,aa,tsim) = 0.001*pmp.l(r,i,aa,tsim-1) ;
pa.lo(r,i,aa,tsim)$xaFlag(r,i,aa)       = 0.001*pa.l(r,i,aa,tsim-1) ;
pmt.lo(r,i,tsim)$xmtFlag(r,i)           = 0.001*pmt.l(r,i,tsim-1) ;
pe.lo(r,i,rp,tsim)$xwFlag(r,i,rp)       = 0.001*pe.l(r,i,rp,tsim-1) ;
pefob.lo(r,i,rp,tsim)$xwFlag(r,i,rp)    = 0.001*pefob.l(r,i,rp,tsim-1) ;
pmcif.lo(r,i,rp,tsim)$xwFlag(r,i,rp)    = 0.001*pmcif.l(r,i,rp,tsim-1) ;
pm.lo(r,i,rp,tsim)$xwFlag(r,i,rp)       = 0.001*pm.l(r,i,rp,tsim-1) ;
pet.lo(r,i,tsim)$xetFlag(r,i)           = 0.001*pet.l(r,i,tsim-1) ;
pd.lo(r,i,tsim)$xdFlag(r,i)             = 0.001*pd.l(r,i,tsim-1) ;
pwmg.lo(r,i,rp,tsim)$tmgFlag(r,i,rp)    = 0.001*pwmg.l(r,i,rp,tsim-1) ;
pf.lo(r,fp,a,tsim)$xfFlag(r,fp,a)       = 0.001*pf.l(r,fp,a,tsim-1) ;
pfa.lo(r,fp,a,tsim)$xfFlag(r,fp,a)      = 0.001*pfa.l(r,fp,a,tsim-1) ;
*pft.lo(r,fm,tsim)$xftFlag(r,fm)         = 0.001*pft.l(r,fm,tsim-1) ;

uh.lo(r,h,tsim)  = 0.001*uh.l(r,h,tsim-1) ;
ug.lo(r,tsim)    = 0.001*ug.l(r,tsim-1) ;
us.lo(r,tsim)    = 0.001*us.l(r,tsim-1) ;
u.lo(r,tsim)     = 0.001*u.l(r,tsim-1) ;
pcons.lo(r,tsim) = 0.001*pcons.l(r,tsim-1) ;
pg.lo(r,tsim)    = 0.001*pg.l(r,tsim-1) ;
pi.lo(r,tsim)    = 0.001*pi.l(r,tsim-1) ;
ptmg.lo(m,tsim)  = 0.001*ptmg.l(m,tsim-1) ;

*  Fix zero variables

loop(t0,

   lambdand.fx(r,a,tsim)$(not ndFlag(r,a)) = 1 ;
   lambdava.fx(r,a,tsim)$(not vaFlag(r,a)) = 1 ;
   nd.fx(r,a,tsim)$(not ndFlag(r,a))       = 0 ;
   va.fx(r,a,tsim)$(not vaFlag(r,a))       = 0 ;
   px.fx(r,a,tsim)$(not xpFlag(r,a))       = px.l(r,a,t0) ;

   lambdaio.fx(r,i,a,t)$(not xaFlag(r,i,a)) = 1 ;
   xa.fx(r,i,aa,tsim)$(not xaFlag(r,i,aa))  = 0 ;
   pa.fx(r,i,aa,tsim)$(not xaFlag(r,i,aa))  = pa.l(r,i,aa,tsim) ;
   pnd.fx(r,a,tsim)$(not ndFlag(r,a))       = pnd.l(r,a,t0) ;

   lambdaf.fx(r,fp,a,t)$(not xfFlag(r,fp,a)) = 1 ;
   xf.fx(r,fp,a,tsim)$(not xfFlag(r,fp,a))   = 0 ;
   pf.fx(r,fp,a,tsim)$(not xfFlag(r,fp,a))   = pf.l(r,fp,a,t0) ;
   pva.fx(r,a,tsim)$(not vaFlag(r,a))        = pva.l(r,a,t0) ;

   x.fx(r,a,i,tsim)$(not xFlag(r,a,i)) = 0.0 ;
   p.fx(r,a,i,tsim)$(not xFlag(r,a,i)) = p.l(r,a,i,t0) ;
   xs.fx(r,i,tsim)$(not xsFlag(r,i))   = 0.0 ;
   ps.fx(r,i,tsim)$(not xsFlag(r,i))   = ps.l(r,i,t0) ;

   zcons.fx(r,i,h,t)$(not xaFlag(r,i,h)) = 0 ;
   xcshr.fx(r,i,h,t)$(not xaFlag(r,i,h)) = 0 ;

   xd.fx(r,i,aa,t)$(not alphad(r,i,aa,t))  = 0 ;
   xm.fx(r,i,aa,t)$(not alpham(r,i,aa,t))  = 0 ;
   pdp.fx(r,i,aa,t)$(not alphad(r,i,aa,t)) = pdp.l(r,i,aa,t) ;
   pmp.fx(r,i,aa,t)$(not alpham(r,i,aa,t)) = pmp.l(r,i,aa,t) ;

   xmt.fx(r,i,tsim)$(not xmtFlag(r,i)) = 0 ;
   pmt.fx(r,i,tsim)$(not xmtFlag(r,i)) = pmt.l(r,i,t0) ;

   xw.fx(r,i,rp,tsim)$(not xwFlag(r,i,rp))    = 0 ;
   pe.fx(r,i,rp,tsim)$(not xwFlag(r,i,rp))    = pe.l(r,i,rp,t0) ;
   pefob.fx(r,i,rp,tsim)$(not xwFlag(r,i,rp)) = pefob.l(r,i,rp,t0) ;
   pmcif.fx(r,i,rp,tsim)$(not xwFlag(r,i,rp)) = pmcif.l(r,i,rp,t0) ;
   pm.fx(r,i,rp,tsim)$(not xwFlag(r,i,rp))    = pm.l(r,i,rp,t0) ;

   xwmg.fx(r,i,rp,tsim)$(not tmgFlag(r,i,rp))  = 0 ;
   pwmg.fx(r,i,rp,tsim)$(not tmgFlag(r,i,rp))  = pwmg.l(r,i,rp,tsim) ;
   xmgm.fx(m,r,i,rp,tsim)$(not amgm(m,r,i,rp)) = 0 ;

   xds.fx(r,i,tsim)$(not xdFlag(r,i))  = 0 ;
   pd.fx(r,i,tsim)$(not xdFlag(r,i))   = pd.l(r,i,t0) ;
   xet.fx(r,i,tsim)$(not xetFlag(r,i)) = 0 ;
   pet.fx(r,i,tsim)$(not xetFlag(r,i)) = pet.l(r,i,t0) ;

   pfa.fx(r,fp,a,tsim)$(not xfFlag(r,fp,a)) = pfa.l(r,fp,a,t0) ;
   xft.fx(r,fm,tsim)$(not xftFlag(r,fm))    = 0 ;
   pft.fx(r,fm,tsim)$(not xftFlag(r,fm))    = pft.l(r,fm,t0) ;

*  01-May-2019: MRIO
   pma.fx(r,i,aa,tsim)$(not alpham(r,i,aa,tsim))  = pma.l(r,i,aa,t0) ;
   xwa.fx(s,i,d,aa,tsim)$(not xwaFlag(s,i,d,aa))  = xwa.l(s,i,d,aa,t0) ;
   pdma.fx(s,i,d,aa,tsim)$(not xwaFlag(s,i,d,aa)) = pdma.l(s,i,d,aa,t0) ;
) ;

*  Fix lags

if(years(tsim) ne firstYear,
   axp.fx(r,a,tsim-1)        = axp.l(r,a,tsim-1) ;
   lambdand.fx(r,a,tsim-1)   = lambdand.l(r,a,tsim-1) ;
   lambdava.fx(r,a,tsim-1)   = lambdava.l(r,a,tsim-1) ;
   lambdaio.fx(r,i,a,tsim-1) = lambdaio.l(r,i,a,tsim-1) ;
   lambdaf.fx(r,fp,a,tsim-1) = lambdaf.l(r,fp,a,tsim-1) ;

   pf.fx(r,fp,a,tsim-1)      = pf.l(r,fp,a,tsim-1) ;
   xf.fx(r,fp,a,tsim-1)      = xf.l(r,fp,a,tsim-1) ;

   pa.fx(r,i,aa,tsim-1)      = pa.l(r,i,aa,tsim-1) ;
   xa.fx(r,i,aa,tsim-1)      = xa.l(r,i,aa,tsim-1) ;
   pe.fx(r,i,rp,tsim-1)      = pe.l(r,i,rp,tsim-1) ;
   pefob.fx(r,i,rp,tsim-1)   = pefob.l(r,i,rp,tsim-1) ;
   pmcif.fx(r,i,rp,tsim-1)   = pmcif.l(r,i,rp,tsim-1) ;
   pm.fx(r,i,rp,tsim-1)      = pm.l(r,i,rp,tsim-1) ;
   xw.fx(r,i,rp,tsim-1)      = xw.l(r,i,rp,tsim-1) ;
   ptmg.fx(m,tsim-1)         = ptmg.l(m,tsim-1) ;

   psave.fx(r,tsim-1)        = psave.l(r,tsim-1) ;
   pi.fx(r,tsim-1)           = pi.l(r,tsim-1) ;

   uh.fx(r,h,tsim-1)         = uh.l(r,h,tsim-1) ;
   yc.fx(r,tsim-1)           = yc.l(r,tsim-1) ;

   pabs.fx(r,tsim-1)         = pabs.l(r,tsim-1) ;
   pmuv.fx(tsim-1)           = pmuv.l(tsim-1) ;
   pfact.fx(r,tsim-1)        = pfact.l(r,tsim-1) ;
   pwfact.fx(tsim-1)         = pwfact.l(tsim-1) ;
   gdpmp.fx(r,tsim-1)        = gdpmp.l(r,tsim-1) ;
   rgdpmp.fx(r,tsim-1)       = rgdpmp.l(r,tsim-1) ;
   pgdpmp.fx(r,tsim-1)       = pgdpmp.l(r,tsim-1) ;
) ;
