* --------------------------------------------------------------------------------------------------
*
*  Initialize model variables
*
* --------------------------------------------------------------------------------------------------

* --------------------------------------------------------------------------------------------------
*
*  Initialize prices
*
* --------------------------------------------------------------------------------------------------

loop(t$t0(t),
   px.l(r,a,t)      = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
   ps.l(r,i,t)      = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
   pft.l(r,fm,t)    = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
   if(1,
      pfy.l(r,fnm,a,t) = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
   else
      pf.l(r,fnm,a,t)  = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
   ) ;
   pa.l(r,i,aa,t)   = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
   pg.l(r,t)        = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
   pi.l(r,t)        = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
   pmt.l(r,i,t)     = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
   pnd.l(r,a,t)     = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
   pva.l(r,a,t)     = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
   ptmg.l(m,t)      = ifdebug*uniform(0.5,1.5) + (1 - ifDebug)*1 ;
) ;

loop(t$(not t0(t)),
   loop(t0,
      px.l(r,a,t)      = px.l(r,a,t0) ;
      ps.l(r,i,t)      = ps.l(r,i,t0) ;
      pft.l(r,fm,t)    = pft.l(r,fm,t0) ;
      if(1,
         pfy.l(r,fnm,a,t) = pfy.l(r,fnm,a,t0) ;
      else
         pf.l(r,fnm,a,t)  = pf.l(r,fnm,a,t0) ;
      ) ;
      pa.l(r,i,aa,t)   = pa.l(r,i,aa,t0) ;
      pg.l(r,t)        = pg.l(r,t0) ;
      pi.l(r,t)        = pi.l(r,t0) ;
      pmt.l(r,i,t)     = pmt.l(r,i,t0) ;
      pnd.l(r,a,t)     = pnd.l(r,a,t0) ;
      pva.l(r,a,t)     = pva.l(r,a,t0) ;
      ptmg.l(m,t)      = ptmg.l(m,t0) ;
   ) ;
) ;

pd.l(r,i,t)     = ps.l(r,i,t) ;
pabs.l(r,t)     = 1 ;
pmuv.l(t)       = 1 ;
pnum.l(t)       = 1 ;
pfact.l(r,t)    = 1 ;
pwfact.l(t)     = 1 ;

* --------------------------------------------------------------------------------------------------
*
*     Initialize Armington matrices
*
* --------------------------------------------------------------------------------------------------

*  Firm demand

xd.l(r,i,a,t) = sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), inScale*vdfb(i0,a0,r))/pd.l(r,i,t) ;
xm.l(r,i,a,t) = sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), inScale*vmfb(i0,a0,r))/pmt.l(r,i,t) ;

dintx.fx(r,i,a,t)$xd.l(r,i,a,t)
   = sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), inScale*(vdfp(i0,a0,r) - vdfb(i0,a0,r)))
   / (pd.l(r,i,t)*xd.l(r,i,a,t)) ;
mintx.fx(r,i,a,t)$xm.l(r,i,a,t)
   = sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), inScale*(vmfp(i0,a0,r) - vmfb(i0,a0,r)))
   / (pmt.l(r,i,t)*xm.l(r,i,a,t)) ;

*  Private demand

xd.l(r,i,h,t) = sum(i0$mapi0(i0,i), inScale*vdpb(i0,r))/pd.l(r,i,t) ;
xm.l(r,i,h,t) = sum(i0$mapi0(i0,i), inScale*vmpb(i0,r))/pmt.l(r,i,t) ;

dintx.fx(r,i,h,t)$xd.l(r,i,h,t)
   = sum(i0$mapi0(i0,i), inScale*(vdpp(i0,r) - vdpb(i0,r)))
   / (pd.l(r,i,t)*xd.l(r,i,h,t)) ;
mintx.fx(r,i,h,t)$xm.l(r,i,h,t)
   = sum(i0$mapi0(i0,i), inScale*(vmpp(i0,r) - vmpb(i0,r)))
   / (pmt.l(r,i,t)*xm.l(r,i,h,t)) ;

*  Government demand

xd.l(r,i,gov,t) = sum(i0$mapi0(i0,i), inScale*vdgb(i0,r))/pd.l(r,i,t) ;
xm.l(r,i,gov,t) = sum(i0$mapi0(i0,i), inScale*vmgb(i0,r))/pmt.l(r,i,t) ;

dintx.fx(r,i,gov,t)$xd.l(r,i,gov,t)
   = sum(i0$mapi0(i0,i), inScale*(vdgp(i0,r) - vdgb(i0,r)))
   / (pd.l(r,i,t)*xd.l(r,i,gov,t)) ;
mintx.fx(r,i,gov,t)$xm.l(r,i,gov,t)
   = sum(i0$mapi0(i0,i), inScale*(vmgp(i0,r) - vmgb(i0,r)))
   / (pmt.l(r,i,t)*xm.l(r,i,gov,t)) ;

*  Investment demand

xd.l(r,i,inv,t) = sum(i0$mapi0(i0,i), inScale*vdib(i0,r))/pd.l(r,i,t) ;
xm.l(r,i,inv,t) = sum(i0$mapi0(i0,i), inScale*vmib(i0,r))/pmt.l(r,i,t) ;

dintx.fx(r,i,inv,t)$xd.l(r,i,inv,t)
   = sum(i0$mapi0(i0,i), inScale*(vdip(i0,r) - vdib(i0,r)))
   / (pd.l(r,i,t)*xd.l(r,i,inv,t)) ;
mintx.fx(r,i,inv,t)$xm.l(r,i,inv,t)
   = sum(i0$mapi0(i0,i), inScale*(vmip(i0,r) - vmib(i0,r)))
   / (pmt.l(r,i,t)*xm.l(r,i,inv,t)) ;

*  Domestic supply of margin services

xd.l(r,i,tmg,t) = sum(i0$mapi0(i0,i), inScale*vst(i0,r))/pd.l(r,i,t) ;
xm.l(r,i,tmg,t) = 0 ;

dintx.fx(r,i,tmg,t)$xd.l(r,i,tmg,t) = 0 ;
mintx.fx(r,i,tmg,t)$xm.l(r,i,tmg,t) = 0 ;

*  End user prices of goods

pdp.l(r,i,aa,t) = pd.l(r,i,t)*(1 + dintx.l(r,i,aa,t)) ;
pmp.l(r,i,aa,t) = pmt.l(r,i,t)*(1 + mintx.l(r,i,aa,t)) ;

*  Armington demand

xa.l(r,i,aa,t)  = (pdp.l(r,i,aa,t)*xd.l(r,i,aa,t)
                +  pmp.l(r,i,aa,t)*xm.l(r,i,aa,t))/pa.l(r,i,aa,t) ;

loop((r,i),
   if(not ArmFlag(r,i),
      pat0(r,i) = 1 ;
   else
      pat.l(r,i,t)   = 1 ;
      xa.l(r,i,aa,t) = (pd.l(r,i,t)*xd.l(r,i,aa,t)
                     +  pmt.l(r,i,t)*xm.l(r,i,aa,t)) / pat.l(r,i,t) ;
      aintx.fx(r,i,aa,t)$xa.l(r,i,aa,t)
                     = (pd.l(r,i,t)*xd.l(r,i,aa,t)*dintx.l(r,i,aa,t)
                     +  pmt.l(r,i,t)*xm.l(r,i,aa,t)*mintx.l(r,i,aa,t))
                     / (pat.l(r,i,t) * xa.l(r,i,aa,t)) ;
      pa.l(r,i,aa,t) = (1 + aintx.l(r,i,aa,t)) * pat.l(r,i,t) ;
      xat.l(r,i,t)   = sum(aa, xa.l(r,i,aa,t)) ;
   ) ;
) ;

* --------------------------------------------------------------------------------------------------
*
* Production module initialization
*
* --------------------------------------------------------------------------------------------------

*  Initialize factor prices and volumes

*  CET decision is based on after tax remuneration --> set pfy = pft ;
*  PFY for sector-specific factors initialized above

if(1,
   pfy.l(r,fm,a,t)    = pft.l(r,fm,t) ;
   kappaf.l(r,fp,a,t) = inscale*(sum(a0$mapa0(a0,a), EVFB(fp,a0,r))) ;
   kappaf.fx(r,fp,a,t)$kappaf.l(r,fp,a,t)
                      = inscale*(sum(a0$mapa0(a0,a), EVFB(fp,a0,r) - EVOS(fp,a0,r)))
                      /    kappaf.l(r,fp,a,t) ;
   pf.l(r,fp,a,t)     = pfy.l(r,fp,a,t)/(1 - kappaf.l(r,fp,a,t)) ;
   xf.l(r,fp,a,t)     = sum(a0$mapa0(a0,a), inScale*evfb(fp,a0,r)) / pf.l(r,fp,a,t) ;
   xft.l(r,fm,t)      = sum(a, pfy.l(r,fm,a,t)*xf.l(r,fm,a,t)) / pft.l(r,fm,t) ;
else
   pf.l(r,fm,a,t)     = pft.l(r,fm,t) ;
   kappaf.l(r,fp,a,t) = inscale*(sum(a0$mapa0(a0,a), EVFB(fp,a0,r))) ;
   kappaf.fx(r,fp,a,t)$kappaf.l(r,fp,a,t)
                      = inscale*(sum(a0$mapa0(a0,a), EVFB(fp,a0,r) - EVOS(fp,a0,r)))
                      /    kappaf.l(r,fp,a,t) ;
   pfy.l(r,fp,a,t)    = pf.l(r,fp,a,t)*(1 - kappaf.l(r,fp,a,t)) ;
   xf.l(r,fp,a,t)     = sum(a0$mapa0(a0,a), inScale*evfb(fp,a0,r)) / pf.l(r,fp,a,t) ;
   xft.l(r,fm,t)      = sum(a, pf.l(r,fm,a,t)*xf.l(r,fm,a,t)) / pft.l(r,fm,t) ;
) ;

fctts.fx(r,fp,a,t)$xf.l(r,fp,a,t)
   = -sum(a0$mapa0(a0,a), inScale*fbep(fp,a0,r))/(pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) ;
fcttx.fx(r,fp,a,t)$xf.l(r,fp,a,t)
   =  sum(a0$mapa0(a0,a), inScale*ftrv(fp,a0,r))/(pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) ;
pfa.l(r,fp,a,t) = pf.l(r,fp,a,t)*(1 + fctts.l(r,fp,a,t) + fcttx.l(r,fp,a,t)) ;

xp.l(r,a,t) = (sum(i, pdp.l(r,i,a,t)*xd.l(r,i,a,t) + pmp.l(r,i,a,t)*xm.l(r,i,a,t))
            +  sum(fp, pfa.l(r,fp,a,t)*xf.l(r,fp,a,t)))/px.l(r,a,t) ;

loop(t0,
   xpFlag(r,a)$(xp.l(r,a,t0) ne 0) = 1 ;
   xpFlag(r,a)$xpFlag(r,a) = 10**(-round(log10(xp.l(r,a,t0)))) ;
) ;

loop(t0,
   xaFlag(r,i,aa)$xa.l(r,i,aa,t0) = 1 ;
) ;

nd.l(r,a,t) = sum(i, pa.l(r,i,a,t)*xa.l(r,i,a,t))/pnd.l(r,a,t) ;
loop(t0,
   ndFlag(r,a)$nd.l(r,a,t0) = 1 ;
) ;

va.l(r,a,t)    = sum(fp, pfa.l(r,fp,a,t)*xf.l(r,fp,a,t))/pva.l(r,a,t) ;
loop(t0,
   vaFlag(r,a)$va.l(r,a,t0) = 1 ;
   xfFlag(r,fp,a)$xf.l(r,fp,a,t0) = 1 ;
) ;

*  Tech parameters

axp.l(r,a,t)        = 1 ;
axpsec.fx(a,t)      = 0 ;
axpreg.fx(r,t)      = 0 ;
axpall.fx(r,a,t)    = 0 ;

lambdand.l(r,a,t)   = 1 ;
andsec.fx(a,t)      = 0 ;
andreg.fx(r,t)      = 0 ;
andall.fx(r,a,t)    = 0 ;

lambdava.l(r,a,t)   = 1 ;
avasec.fx(a,t)      = 0 ;
avareg.fx(r,t)      = 0 ;
avaall.fx(r,a,t)    = 0 ;

lambdaio.l(r,i,a,t) = 1 ;
aiocom.fx(i,t)      = 0 ;
aiosec.fx(a,t)      = 0 ;
aioreg.fx(r,t)      = 0 ;
aioall.fx(r,i,a,t)  = 0 ;

lambdaf.l(r,fp,a,t) = 1 ;
afecom.fx(fp,t)     = 0 ;
afesec.fx(a,t)      = 0 ;
afereg.fx(r,t)      = 0 ;
afefac.fx(r,fp,t)   = 0 ;
afeall.fx(r,fp,a,t) = 0 ;
*  Make labor augmenting by default ;
afeFlag(r,l)        = yes ;

* --------------------------------------------------------------------------------------------------
*
* Private demand module initialization
*
* --------------------------------------------------------------------------------------------------

pop.fx(r,t) = pop0(r) ;

loop(h,

   yc.l(r,t) = sum(i, pa.l(r,i,h,t)*xa.l(r,i,h,t)) ;

   xcshr.l(r,i,h,t) = pa.l(r,i,h,t)*xa.l(r,i,h,t)/yc.l(r,t) ;

   pcons.l(r,t) = sum(i, xcshr.l(r,i,h,t)*pa.l(r,i,h,t)) ;

   uh.l(r,h,t) = 1 ;

   ev.l(r,h,t) = yc.l(r,t) ;
   cv.l(r,h,t) = yc.l(r,t) ;

) ;

* --------------------------------------------------------------------------------------------------
*
* Public demand module initialization
*
* --------------------------------------------------------------------------------------------------

loop(gov,
   yg.l(r,t) = sum(i, pa.l(r,i,gov,t)*xa.l(r,i,gov,t)) ;
   xg.l(r,t) = yg.l(r,t)/pg.l(r,t) ;
   ug.l(r,t) = 1 ;
) ;

* --------------------------------------------------------------------------------------------------
*
* Investment demand module initialization
*
* --------------------------------------------------------------------------------------------------

loop(inv,
   yi.l(r,t)    = sum(i, pa.l(r,i,inv,t)*xa.l(r,i,inv,t)) ;
   xi.l(r,t)    = yi.l(r,t)/pi.l(r,t) ;
   us.l(r,t)    = 1 ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Make module
*
* --------------------------------------------------------------------------------------------------

*  Set 'pp' to ps as it is more likely that demand has perfect substitutes than
*  supply

*  Calculate x tax-inclusive

x.l(r,a,i,t) = inScale*sum((a0,i0)$(mapa0(a0,a) and mapi0(i0,i)), makb(i0,a0,r)) ;
loop(t0,
   xFlag(r,a,i)$x.l(r,a,i,t0) = 1 ;
) ;

prdtx.l(r,a,i,t) = inScale*sum((a0,i0)$(mapa0(a0,a) and mapi0(i0,i)), maks(i0,a0,r)) ;
prdtx.l(r,a,i,t)$prdtx.l(r,a,i,t) = x.l(r,a,i,t)/prdtx.l(r,a,i,t) - 1 ;
x.l(r,a,i,t)$xFlag(r,a,i) = x.l(r,a,i,t) / ps.l(r,i,t) ;
p.l(r,a,i,t)  = (ps.l(r,i,t)/(1+prdtx.l(r,a,i,t)))$xFlag(r,a,i)
              + 1$(not xFlag(r,a,i)) ;
pp.l(r,a,i,t) = (1+prdtx.l(r,a,i,t))*p.l(r,a,i,t) ;

xs.l(r,i,t)  = sum(a, pp.l(r,a,i,t)*x.l(r,a,i,t))/ps.l(r,i,t) ;

* --------------------------------------------------------------------------------------------------
*
*  Trade module
*
* --------------------------------------------------------------------------------------------------

*  Allow for the possibility of perfect transformation

pet.l(r,i,t)   = ps.l(r,i,t) ;
pd.l(r,i,t)    = ps.l(r,i,t) ;
pe.l(s,i,d,t)  = pet.l(s,i,t) ;

xw.l(s,i,d,t) = sum(i0$mapi0(i0,i), inScale*VXSB(i0, s, d))/pe.l(s,i,d,t) ;
loop(t0,
   xwFlag(s,i,d)$xw.l(s,i,d,t0) = 1 ;
) ;
etax.fx(r,i,t) = 0 ;
exptx.fx(s,i,d,t)$xwFlag(s,i,d)
   = sum(i0$mapi0(i0,i), inScale*(VFOB(i0, s, d)-VXSB(i0, s, d)))
   / (pe.l(s,i,d,t)*xw.l(s,i,d,t)) ;
pefob.l(s,i,d,t) = (1 + exptx.l(s,i,d,t))*pe.l(s,i,d,t) ;

pwmg.l(s,i,d,t) = 1 ;
tmarg.fx(s,i,d,t)$xwFlag(s,i,d)
   = sum(i0$mapi0(i0,i), inScale*(VCIF(i0, s, d)-VFOB(i0, s, d)))
   / (xw.l(s,i,d,t)*pwmg.l(s,i,d,t)) ;

*  !!!! Check on tmarg

work = 0 ;
loop((s,i,d,t0),
   if(sum((i0,m0)$mapi0(i0,i), VTWR(m0,i0,s,d)) eq 0,
*     Probably means the the CIF FOB difference is very small
      if(abs(tmarg.l(s,i,d,t0)) lt 1e-6,
         tmarg.fx(s,i,d,t) = 0 ;
      else
         work = work + 1 ;
         put s.tl:<14, i.tl:<14, d.tl:<15, (tmarg.l(s,i,d,t0)*1e16) / ;
      ) ;
   ) ;
) ;
abort$work "Margin inconsistency" ;

loop(t0,
   tmgFlag(s,i,d)$tmarg.l(s,i,d,t0) = 1 ;
) ;

pmCIF.l(s,i,d,t) = (pefob.l(s,i,d,t) + pwmg.l(s,i,d,t)*tmarg.l(s,i,d,t)) ;

imptx.fx(s,i,d,t)$xwFlag(s,i,d)
   = sum(i0$mapi0(i0,i), inScale*(VMSB(i0, s, d)-VCIF(i0, s, d)))
   / (pmCIF.l(s,i,d,t)*xw.l(s,i,d,t)) ;

pm.l(s,i,d,t) = (1 + imptx.l(s,i,d,t))*pmCIF.l(s,i,d,t) ;

mtax.fx(rp,i,t) = 0 ;
lambdam.fx(rp,i,r,t) = 1 ;

if(not NTMFlag,
   ntmAVE.fx(s,i,d,t) = 0 ;
   chiNTM(s,i,d)      = 0 ;
) ;

xmt.l(r,i,t) = sum(aa, xm.l(r,i,aa,t)) ;
xds.l(r,i,t) = sum(aa, xd.l(r,i,aa,t)) ;
xdt.l(r,i,t) = xds.l(r,i,t) ;

xet.l(r,i,t) = sum(d, pe.l(r,i,d,t)*xw.l(r,i,d,t)) / pet.l(r,i,t) ;
xet.l(r,i,t) = (ps.l(r,i,t)*xs.l(r,i,t) - pd.l(r,i,t)*xds.l(r,i,t))/pet.l(r,i,t) ;

*  Check XET by residual

put screen ; put / ;

loop((r,i,t)$t0(t),
   if(abs(xet.l(r,i,t)/inscale) lt 1e-5 and xet.l(r,i,t),
      put r.tl:<10, i.tl:<10, (xet.l(r,i,t)*1e20) / ;
      xet.l(r,i,t) = 0 ;
   ) ;
) ;

loop(t0,
   xsFlag(r,i)$xs.l(r,i,t0)   = 1 ;
   xdFlag(r,i)$xds.l(r,i,t0)  = 1 ;
   xmtFlag(r,i)$xmt.l(r,i,t0) = 1 ;
   xetFlag(r,i)$xet.l(r,i,t0) = 1 ;
   xatFlag(r,i)$xat.l(r,i,t0) = 1 ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  MRIO module
*
* --------------------------------------------------------------------------------------------------

$macro M_VIUMS(i,amrio,s,d)    (inscale*sum(i0$mapi0(i0,i), viums(i0, amrio, s ,d)))
$macro M_VIUWS(i,amrio,s,d)    (inscale*sum(i0$mapi0(i0,i), viuws(i0, amrio, s ,d)))

if(MRIO,
   imptxa.l(s,i,d,a,t) = M_VIUWS(i,"INT",s,d) ;
   imptxa.l(s,i,d,a,t)$imptxa.l(s,i,d,a,t) = M_VIUMS(i,"INT",s,d)/imptxa.l(s,i,d,a,t) - 1.0 ;
   loop(gov,
      imptxa.l(s,i,d,gov,t) = M_VIUWS(i,"CONS",s,d) ;
      imptxa.l(s,i,d,h,t)$imptxa.l(s,i,d,gov,t)
         = M_VIUMS(i,"CONS",s,d)/imptxa.l(s,i,d,gov,t) - 1.0 ;
      imptxa.l(s,i,d,gov,t)$imptxa.l(s,i,d,gov,t)
         = M_VIUMS(i,"CONS",s,d)/imptxa.l(s,i,d,gov,t) - 1.0 ;
   ) ;
   loop(inv,
      imptxa.l(s,i,d,inv,t) = M_VIUWS(i,"CGDS",s,d) ;
      imptxa.l(s,i,d,inv,t)$imptxa.l(s,i,d,inv,t)
         = M_VIUMS(i,"CGDS",s,d)/imptxa.l(s,i,d,inv,t) - 1.0 ;
   ) ;

   pdma.l(s,i,d,aa,t) = (1.0 + imptxa.l(s,i,d,aa,t))*pmcif.l(s,i,d,t) ;


*  Value share of intermediate trade from region 's' into region 'd'

   xwa.l(s,i,d,a,t) = sum(r, M_VIUMS(i,"INT",r,d)) ;
   xwa.l(s,i,d,a,t)$xwa.l(s,i,d,a,t) = M_VIUMS(i,"INT",s,d)/xwa.l(s,i,d,a,t) ;
   xwa.l(s,i,d,a,t)$xwa.l(s,i,d,a,t) = xwa.l(s,i,d,a,t)*xm.l(d,i,a,t)
                                     *    pmt.l(d,i,t)/ pdma.l(s,i,d,a,t) ;

*  Value share of 'cons' trade from region 's' into region 'd'
   loop(gov,
      xwa.l(s,i,d,gov,t) = sum(r, M_VIUMS(i,"CONS",r,d)) ;
      xwa.l(s,i,d,gov,t)$xwa.l(s,i,d,gov,t) = M_VIUMS(i,"CONS",s,d)/xwa.l(s,i,d,gov,t) ;
      xwa.l(s,i,d,h,t)$xwa.l(s,i,d,gov,t)   = xwa.l(s,i,d,gov,t)*xm.l(d,i,h,t)
                                            *    pmt.l(d,i,t)/pdma.l(s,i,d,h,t) ;
      xwa.l(s,i,d,gov,t)$xwa.l(s,i,d,gov,t) = xwa.l(s,i,d,gov,t)*xm.l(d,i,gov,t)
                                            *    pmt.l(d,i,t)/pdma.l(s,i,d,gov,t) ;
   ) ;

*  Value share of 'inv' trade from region 's' into region 'd'
   loop(inv,
      xwa.l(s,i,d,inv,t) = sum(r, M_VIUMS(i,"CGDS",r,d)) ;
      xwa.l(s,i,d,inv,t)$xwa.l(s,i,d,inv,t) = M_VIUMS(i,"CGDS",s,d)/xwa.l(s,i,d,inv,t) ;
      xwa.l(s,i,d,inv,t)$xwa.l(s,i,d,inv,t) = xwa.l(s,i,d,inv,t)*xm.l(d,i,inv,t)
                                            *    pmt.l(d,i,t)/ pdma.l(s,i,d,inv,t) ;
   ) ;

   pma.l(r,i,aa,t) = (sum(s, pdma.l(s,i,r,aa,t)*xwa.l(s,i,r,aa,t))
                   /    xm.l(r,i,aa,t))$xm.l(r,i,aa,t)
                   + 1$(xm.l(r,i,aa,t) eq 0)
                   ;

   loop(t0,
      xwaFlag(s,i,d,aa)$xwa.l(s,i,d,aa,t0) = 1 ;
   ) ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Margins module
*
* --------------------------------------------------------------------------------------------------

ptmg.l(m,t) = 1 ;

loop(tmg,
   xtmg.l(m,t) = sum(r, pa.l(r,m,tmg,t)*xa.l(r,m,tmg,t)) / ptmg.l(m,t) ;
   xwmg.l(r,i,d,t) = tmarg.l(r,i,d,t)*xw.l(r,i,d,t) ;
   xmgm.l(m,r,i,d,t)
      = sum((m0,i0)$(mapi0(m0,m) and mapi0(i0,i)), inScale*VTWR(m0,i0,r,d)) / ptmg.l(m,t) ;
   pwmg.l(r,i,d,t)$xwmg.l(r,i,d,t)
      = sum(m, ptmg.l(m,t)*xmgm.l(m,r,i,d,t)) / xwmg.l(r,i,d,t) ;
) ;

loop(t0,
   mFlag(m)$xtmg.l(m,t0) = 1 ;
) ;
lambdamg.fx(m,s,i,d,t) = 1 ;

* --------------------------------------------------------------------------------------------------
*
*  Income distribution
*
* --------------------------------------------------------------------------------------------------

YTAX.l(r,"pt",t) = sum((a,i), prdtx.l(r,a,i,t)*p.l(r,a,i,t)*x.l(r,a,i,t)) ;
YTAX.l(r,"fc",t) = sum((i,a), dintx.l(r,i,a,t)*pd.l(r,i,t)*xd.l(r,i,a,t)
                 +            mintx.l(r,i,a,t)*pmt.l(r,i,t)*xm.l(r,i,a,t)) ;
YTAX.l(r,"pc",t) = sum((i,h), dintx.l(r,i,h,t)*pd.l(r,i,t)*xd.l(r,i,h,t)
                 +            mintx.l(r,i,h,t)*pmt.l(r,i,t)*xm.l(r,i,h,t)) ;
YTAX.l(r,"gc",t) = sum((i,gov), dintx.l(r,i,gov,t)*pd.l(r,i,t)*xd.l(r,i,gov,t)
                 +              mintx.l(r,i,gov,t)*pmt.l(r,i,t)*xm.l(r,i,gov,t)) ;
YTAX.l(r,"ic",t) = sum((i,inv), dintx.l(r,i,inv,t)*pd.l(r,i,t)*xd.l(r,i,inv,t)
                 +              mintx.l(r,i,inv,t)*pmt.l(r,i,t)*xm.l(r,i,inv,t)) ;
YTAX.l(r,"et",t) = sum((i,d), (exptx.l(r,i,d,t) + etax.l(r,i,t))*pe.l(r,i,d,t)*xw.l(r,i,d,t)) ;
YTAX.l(r,"mt",t) = sum((i,s), (imptx.l(s,i,r,t)
                 +   mtax.l(r,i,t))*pmcif.l(s,i,r,t)*xw.l(s,i,r,t)) ;
YTAX.l(r,"ft",t) = sum((fp,a), fcttx.l(r,fp,a,t)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) ;
YTAX.l(r,"fs",t) = sum((fp,a), fctts.l(r,fp,a,t)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) ;

YTAX.l(r,"dt",t) = sum((a,fp), kappaf.l(r,fp,a,t)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) ;

yTaxTot.l(r,t)   = sum(gy, ytax.l(r,gy,t)) ;
yTaxInd.l(r,t)   = yTaxTot.l(r,t) - ytax.l(r,"dt",t) ;
kstock.l(r,t)    = inScale*VKB(r) ;
fdepr(r,t)       = inScale*VDEP(r)/(pi.l(r,t)*kstock.l(r,t)) ;
depr(r,t)        = fdepr(r,t) ;
loop(cap,
   krat(r,t)     = xft.l(r,cap,t)/kstock.l(r,t) ;
) ;

loop((h,inv,gov),
   rsav.l(r,t) = inScale*SAVE(r) ;
   savf.l(r,t) = sum((i,s), pmCIF.l(s,i,r,t)*xw.l(s,i,r,t))
               - sum((i,d), peFOB.l(r,i,d,t)*xw.l(r,i,d,t))
               - sum(i0, inScale*vst(i0,r)) ;
) ;

work = sum((r,t0)$(not rres(r)), savf.l(r,t0)) ;
savf.l(rres,t) = -work ;

xigbl.l(t)     = sum(r, xi.l(r,t) - depr(r,t)*kstock.l(r,t)) ;
chiInv.l(r,t)  = (xi.l(r,t) - depr(r,t)*kstock.l(r,t))/xigbl.l(t) ;
pigbl.l(t)     = sum(r, pi.l(r,t)*(xi.l(r,t) - depr(r,t)*kstock.l(r,t)))/xigbl.l(t) ;
invwgt(r,t)    = pi.l(r,t)*(xi.l(r,t) - depr(r,t)*kstock.l(r,t))
               / sum(rp, pi.l(rp,t)*(xi.l(rp,t) - depr(rp,t)*kstock.l(rp,t))) ;
savwgt(r,t)    = rsav.l(r,t) / sum(rp, rsav.l(rp,t)) ;
chiSave.l(t)   = 1 ;
psave.l(r,t)   = 1 ;
factY.l(r,t)   = sum((fp,a), pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) - fdepr(r,t)*pi.l(r,t)*kstock.l(r,t) ;
regY.l(r,t)    = factY.l(r,t) + yTaxInd.l(r,t) ;
chif.l(r,t)    = savf.l(r,t) / regY.l(r,t) ;

savfBar(r,t)   = savf.l(r,t)/pigbl.l(t) ;

* --------------------------------------------------------------------------------------------------
*
*  Emissions module
*
* --------------------------------------------------------------------------------------------------

*  Production emissions

emid.l(r,i,a,t) = sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), mdf(i0, a0, r)) ;
emim.l(r,i,a,t) = sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), mmf(i0, a0, r)) ;

*  Household emissions

emid.l(r,i,h,t) = sum(i0$mapi0(i0,i), mdp(i0, r)) ;
emim.l(r,i,h,t) = sum(i0$mapi0(i0,i), mmp(i0, r)) ;

*  Government emissions

emid.l(r,i,gov,t) = sum(i0$mapi0(i0,i), mdg(i0, r)) ;
emim.l(r,i,gov,t) = sum(i0$mapi0(i0,i), mmg(i0, r)) ;

*  Investment emissions

emid.l(r,i,inv,t) = sum(i0$mapi0(i0,i), mdi(i0, r)) ;
emim.l(r,i,inv,t) = sum(i0$mapi0(i0,i), mmi(i0, r)) ;

* --------------------------------------------------------------------------------------------------
*
*  Initialize model parameters
*
* --------------------------------------------------------------------------------------------------

loop(t0,

*  sigmap is top level subsitution elasticity, by default equal to esubt
*  use production weights

   tvom(a0,r) = sum(i0, vdfp(i0,a0,r) + vmfp(i0,a0,r)) + sum(fp, evfp(fp,a0,r)) ;
   sigmap(r,a)$(sigmap(r,a) eq na and xp.l(r,a,t0))
      = sum(a0$mapa0(a0,a), tvom(a0,r)*esubt(a0,r))/sum(a0$mapa0(a0,a), tvom(a0,r)) ;

*  sigmand by default is equal to esubc

   tvom(a0,r) = sum(i0, vdfp(i0,a0,r) + vmfp(i0,a0,r)) ;
   sigmand(r,a)$(sigmand(r,a) eq na and nd.l(r,a,t0))
      = sum(a0$mapa0(a0,a), tvom(a0,r)*esubc(a0,r))/sum(a0$mapa0(a0,a), tvom(a0,r)) ;

*  sigmav is subsitution across factors, by default equal to esubva
*  use value added weights
   tvom(a0,r) = sum(fp, evfp(fp,a0,r)) ;
   sigmav(r,a)$(sigmav(r,a) eq na and va.l(r,a,t0))
      = sum(a0$mapa0(a0,a), tvom(a0,r)*esubva(a0,r))/sum(a0$mapa0(a0,a), tvom(a0,r)) ;

*  sigmam is region and agent specific, by default set to esubd

   sigmam(r,i,a)$(sigmam(r,i,a) eq na and xa.l(r,i,a,t0))
      = sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), (vdfp(i0,a0,r)+vmfp(i0,a0,r))*esubd(i0,r))
      / sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), (vdfp(i0,a0,r)+vmfp(i0,a0,r))) ;
   sigmam(r,i,h)$(sigmam(r,i,h) eq na and xa.l(r,i,h,t0))
      = sum(i0$mapi0(i0,i), (vdpp(i0,r)+vmpp(i0,r))*esubd(i0,r))
      / sum(i0$mapi0(i0,i), (vdpp(i0,r)+vmpp(i0,r))) ;
   sigmam(r,i,gov)$(sigmam(r,i,gov) eq na and xa.l(r,i,gov,t0))
      = sum(i0$mapi0(i0,i), (vdgp(i0,r)+vmgp(i0,r))*esubd(i0,r))
      / sum(i0$mapi0(i0,i), (vdgp(i0,r)+vmgp(i0,r))) ;
   sigmam(r,i,inv)$(sigmam(r,i,inv) eq na and xa.l(r,i,inv,t0))
      = sum(i0$mapi0(i0,i), (vdip(i0,r)+vmip(i0,r))*esubd(i0,r))
      / sum(i0$mapi0(i0,i), (vdip(i0,r)+vmip(i0,r))) ;

*  sigmam for trade margins does not exist in the standard GTAP model and is mostly
*  irrelevant since there are no imports for this activity. Set it to the investment elasticity

   loop(h,
      sigmam(r,i,tmg)$(sigmam(r,i,tmg)) = sigmam(r,i,h) ;
      sigmamt(r,i) = sigmam(r,i,h) ;
   ) ;

*  sigmaw is second level Armington subsitution elasticity, by default equal to esubm
*  use import weights

   sigmaw(r,i)$(sigmaw(r,i) eq na and xmt.l(r,i,t0))
      = sum((i0,s)$mapi0(i0,i), vcif(i0, s, r)*esubm(i0,r))
      / sum((i0,s)$mapi0(i0,i), vcif(i0, s, r)) ;

   sigmawa(r,i,aa)$(sigmawa(r,i,aa) eq na)
      = sigmaw(r,i) ;

*  eh0 and bh0 are the CDE expansion and substitution parameters, by default equal
*  to incpar and subpar respectively. Use consumption weights

   loop(h,
      eh0(r,i)$(eh0(r,i) eq na and xa.l(r,i,h,t0))
         = sum(i0$mapi0(i0,i), incpar(i0,r)*(vdpp(i0,r) + vmpp(i0,r)))
         / sum(i0$mapi0(i0,i), (vdpp(i0,r) + vmpp(i0,r))) ;
      bh0(r,i)$(bh0(r,i) eq na and xa.l(r,i,h,t0))
         = sum(i0$mapi0(i0,i), subpar(i0,r)*(vdpp(i0,r) + vmpp(i0,r)))
         / sum(i0$mapi0(i0,i), (vdpp(i0,r) + vmpp(i0,r))) ;

      eh0(r,i)$(eh0(r,i) eq na) = 0 ;
      bh0(r,i)$(bh0(r,i) eq na) = 0 ;
   ) ;

*  The GEMPACK version assumes CET elasticities are negative

   omegaf(r,fp)$(omegaf(r,fp) eq na) = -etrae(fp,r)$(etrae(fp,r) ne inf)
                                     + INF$(etrae(fp,r) eq inf) ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  MRIO module
*
* --------------------------------------------------------------------------------------------------

pma0(r,i,aa)   = 1 ;
xwa0(s,i,d,aa) = 0 ;

* --------------------------------------------------------------------------------------------------
*
*  Income allocation module
*
* --------------------------------------------------------------------------------------------------

*  Rescale eh0 !!!! DO WITH CAUTION
if(1,
   loop((h,t0),
      eh0(r,i) = eh0(r,i)/sum(j, eh0(r,j)*xcshr.l(r,j,h,t0)) ;
   ) ;
) ;

eh.fx(r,i,t) = eh0(r,i) ;
bh.fx(r,i,t) = bh0(r,i) ;
phiP.fx(r,t) = sum((i,h), xcshr.l(r,i,h,t)*eh.l(r,i,t))$(%utility% eq CDE)
             + sum((i,h), xcshr.l(r,i,h,t))$(%utility% eq CD) ;

display eh.l, bh.l, eh0, bh0, phiP.l, xcshr.l ;

kron(is,is) = 1 ; display kron ;

loop(h,
   ued.l(r,i,j,t)   = xcshr.l(r,i,h,t)*(-bh.l(r,i,t)
                    - (eh.l(r,i,t)*bh.l(r,i,t)
                    - sum(jp, xcshr.l(r,jp,h,t)*eh.l(r,jp,t)*bh.l(r,jp,t)))
                    /  sum(jp, xcshr.l(r,jp,h,t)*eh.l(r,jp,t))) + kron(i,j)*(bh.l(r,i,t) - 1) ;

   incelas.l(r,i,t) = (eh.l(r,i,t)*bh.l(r,i,t)
                    - sum(jp, xcshr.l(r,jp,h,t)*eh.l(r,jp,t)*bh.l(r,jp,t)))
                    /   sum(jp, xcshr.l(r,jp,h,t)*eh.l(r,jp,t))
                    -  (bh.l(r,i,t) - 1) + sum(jp, xcshr.l(r,jp,h,t)*bh.l(r,jp,t)) ;

   ced.l(r,i,j,t)   = ued.l(r,i,j,t) + xcshr.l(r,j,h,t) * incelas.l(r,i,t) ;

   ape.l(r,i,j,t)$xcshr.l(r,j,h,t)
                    = 1 - bh.l(r,j,t) - bh.l(r,i,t) + sum(jp, xcshr.l(r,jp,h,t)*bh.l(r,jp,t))
                    -  kron(i,j)*(1-bh.l(r,i,t))/xcshr.l(r,j,h,t) ;
) ;

*  Initialize parameters

betaP.l(r,t) = yc.l(r,t)/regY.l(r,t) ;
betaG.l(r,t) = yg.l(r,t)/regY.l(r,t) ;
betaS.l(r,t) = rsav.l(r,t)/regY.l(r,t) ;
phi.l(r,t)   = 1/(phiP.l(r,t)*betaP.l(r,t) + betaG.l(r,t) + betaS.l(r,t)) ;

*  Fix nominal levels

yc.fx(r,t)   = yc.l(r,t) ;
yg.fx(r,t)   = yg.l(r,t) ;
rsav.fx(r,t) = rsav.l(r,t) ;
regY.fx(r,t) = (yc.l(r,t) + yg.l(r,t) + rsav.l(r,t)) ;
regY0(r)     = 1 ;
rsav0(r)     = 1 ;
yg0(r)       = 1 ;
yc0(r)       = 1 ;
betaP0(r)    = 1 ;
betaG0(r)    = 1 ;
betaS0(r)    = 1 ;

rs(r) = yes ;
loop(tsim$t0(tsim),
   ts(tsim) = yes ;
   options limrow=0, limcol=0 ;
   solve betaCal using mcp ;
   ts(tsim) = no ;
) ;
rs(r) = no ;

*  Free nominal variables
phiP.lo(r,t) = -inf ; phiP.up(r,t) = + inf ;
yc.lo(r,t)   = -inf ; yc.up(r,t) = + inf ;
yg.lo(r,t)   = -inf ; yg.up(r,t) = + inf ;
rsav.lo(r,t) = -inf ; rsav.up(r,t) = + inf ;
regY.lo(r,t) = -inf ; regY.up(r,t) = + inf ;

yi.l(r,t) = pi.l(r,t)*depr(r,t)*kstock.l(r,t) + rsav.l(r,t) + savf.l(r,t) ;

* --------------------------------------------------------------------------------------------------
*
*  Factors
*
* --------------------------------------------------------------------------------------------------

loop(t0,
   xftFlag(r,fm)$xft.l(r,fm,t0) = 1 ;
) ;

rorFlag       = %savfFlag% ;

loop(cap,
   arent.l(r,t) = krat(r,t)*sum(a, (1-kappaf.l(r,cap,a,t))*pf.l(r,cap,a,t)*xf.l(r,cap,a,t))
                /    sum((a), xf.l(r,cap,a,t)) ;
) ;

kapEnd.l(r,t) = (1-depr(r,t))*kstock.l(r,t) + xi.l(r,t) ;
rorc.l(r,t)   = arent.l(r,t)/pi.l(r,t) - fdepr(r,t) ;
rore.l(r,t)   = rorc.l(r,t)*(kstock.l(r,t)/kapEnd.l(r,t))**RoRFlex(r,t) ;
rorg.l(t)     = sum(r, rore.l(r,t)*pi.l(r,t)*(xi.l(r,t) - depr(r,t)*kstock.l(r,t)))
              / sum(rp, pi.l(rp,t)*(xi.l(rp,t) - depr(rp,t)*kstock.l(rp,t))) ;
risk(r,t)     = rorg.l(t) / rore.l(r,t) ;

* display arent.l, kapEnd.l, rorc.l, rore.l, rorg.l, risk ;

* --------------------------------------------------------------------------------------------------
*
*  Closure
*
* --------------------------------------------------------------------------------------------------

loop(t0,
   dintx0(r,i,aa) = dintx.l(r,i,aa,t0) ;
   mintx0(r,i,aa) = mintx.l(r,i,aa,t0) ;
) ;
dtxshft.fx(r,i,aa,t) = 0 ;
mtxshft.fx(r,i,aa,t) = 0 ;
rtxshft.fx(r,aa,t)   = 0 ;
intxFlag(r,i,aa)     = 0 ;

ytaxshr.l(r,gy,t)    = ytax.l(r,gy,t) / regY.l(r,t) ;

gdpmp.l(r,t)  = sum((i,fd), pa.l(r,i,fd,t)*xa.l(r,i,fd,t))
              + sum((i,d), pefob.l(r,i,d,t)*xw.l(r,i,d,t))
              - sum((i,s), pmcif.l(s,i,r,t)*xw.l(s,i,r,t)) ;
rgdpmp.l(r,t) = gdpmp.l(r,t) ;
pgdpmp.l(r,t) = gdpmp.l(r,t)/rgdpmp.l(r,t) ;

ggdppc.l(r,t) = 0 ;
gl.l(r,t)     = 0 ;

* --------------------------------------------------------------------------------------------------
*
*  Emissions module
*
* --------------------------------------------------------------------------------------------------

$ontext
emid.l(r,i,aa) = emid0(r,i,aa) ;
emii.l(r,i,aa) = emii0(r,i,aa) ;
$offtext

* --------------------------------------------------------------------------------------------------
*
*  Calibration of parameters
*
* --------------------------------------------------------------------------------------------------

*  Domestic production

if(0,
   and(r,a,t)$ndFlag(r,a) = (nd.l(r,a,t)/xp.l(r,a,t))*(pnd.l(r,a,t)/px.l(r,a,t))**sigmap(r,a) ;
   ava(r,a,t)$vaFlag(r,a) = (va.l(r,a,t)/xp.l(r,a,t))*(pva.l(r,a,t)/px.l(r,a,t))**sigmap(r,a) ;
else
   and(r,a,t)$ndFlag(r,a) = (pnd.l(r,a,t)*nd.l(r,a,t))/(px.l(r,a,t)*xp.l(r,a,t)) ;
   ava(r,a,t)$vaFlag(r,a) = (pva.l(r,a,t)*va.l(r,a,t))/(px.l(r,a,t)*xp.l(r,a,t)) ;
) ;

if(0,
   io(r,i,a,t)$xaFlag(r,i,a)   = (xa.l(r,i,a,t)/nd.l(r,a,t))
                               * (pa.l(r,i,a,t)/pnd.l(r,a,t))**sigmand(r,a) ;
else
   io(r,i,a,t)$xaFlag(r,i,a)   = (pa.l(r,i,a,t)*xa.l(r,i,a,t))/(pnd.l(r,a,t)*nd.l(r,a,t)) ;
) ;

if(0,
   af(r,fp,a,t)$xfFlag(r,fp,a) = (xf.l(r,fp,a,t)/va.l(r,a,t))
                               * (pfa.l(r,fp,a,t)/pva.l(r,a,t))**sigmav(r,a) ;
else
   af(r,fp,a,t)$xfFlag(r,fp,a) = (pfa.l(r,fp,a,t)*xf.l(r,fp,a,t))/(pva.l(r,a,t)*va.l(r,a,t))
) ;

*  Make module

if(0,
   gx(r,a,i,t)$xFlag(r,a,i)
      = ((x.l(r,a,i,t)/xp.l(r,a,t))*(px.l(r,a,t)/p.l(r,a,i,t))**omegas(r,a))$(omegas(r,a) ne inf)
      + ((p.l(r,a,i,t)*x.l(r,a,i,t))/(px.l(r,a,t)*xp.l(r,a,t)))$(omegas(r,a) eq inf) ;
else
   gx(r,a,i,t)$xFlag(r,a,i)
      = (p.l(r,a,i,t)*x.l(r,a,i,t))/(px.l(r,a,t)*xp.l(r,a,t)) ;
) ;

if(0,
   ax(r,a,i,t)$xFlag(r,a,i)
      = ((x.l(r,a,i,t)/xs.l(r,i,t))*((1+prdtx.l(r,a,i,t))*p.l(r,a,i,t)/ps.l(r,i,t))**sigmas(r,i))
      $(sigmas(r,i) ne inf)
      + (((1+prdtx.l(r,a,i,t))*p.l(r,a,i,t)*x.l(r,a,i,t))/(ps.l(r,i,t)*xs.l(r,i,t)))
      $(sigmas(r,i) eq inf) ;
else
   ax(r,a,i,t)$xFlag(r,a,i)
      = ((1+prdtx.l(r,a,i,t))*p.l(r,a,i,t)*x.l(r,a,i,t))/(ps.l(r,i,t)*xs.l(r,i,t)) ;
) ;

if(%utility% eq CDE,

*  CDE utility function

   alphaa(r,i,h,t)$xaFlag(r,i,h) = ((xcshr.l(r,i,h,t)/bh.l(r,i,t))
                                 *  (((yc.l(r,t)/pop.l(r,t))/pa.l(r,i,h,t))**bh.l(r,i,t))
                                 *  (uh.l(r,h,t)**(-eh.l(r,i,t)*bh.l(r,i,t))))
                                 /  (sum(j$bh.l(r,j,t), xcshr.l(r,j,h,t)/bh.l(r,j,t))) ;

   zcons.l(r,i,h,t)$xaFlag(r,i,h) = alphaa(r,i,h,t)*bh.l(r,i,t)
                 * (uh.l(r,h,t)**(eh.l(r,i,t)*bh.l(r,i,t)))
                 * (pa.l(r,i,h,t)**(bh.l(r,i,t)))
                 * ((yc.l(r,t)/pop.l(r,t))**(-bh.l(r,i,t))) ;

elseif(%utility% eq CD),

*  CD utility function

   alphaa(r,i,h,t)$xaFlag(r,i,h) = xcshr.l(r,i,h,t) ;

*  Get them to add to one

   alphaa(r,i,h,t)$xaFlag(r,i,h)  = alphaa(r,i,h,t)/sum(j, alphaa(r,j,h,t)) ;
   zcons.l(r,i,h,t)$xaFlag(r,i,h) = alphaa(r,i,h,t) ;
   auh(r,h,t) = uh.l(r,h,t)/prod(i$xaFlag(r,i,h), xa.l(r,i,h,t)**alphaa(r,i,h,t)) ;

) ;

*  Government demand

*  sigmag is top level subsitution elasticity, by default equal to esubg

sigmag(r)$(sigmag(r) eq na) = esubg(r) ;
* sigmag(r)$(sigmag(r) eq 1)  = 1.01 ;

if(0,
   alphaa(r,i,gov,t)$xaFlag(r,i,gov)
      = (xa.l(r,i,gov,t)/xg.l(r,t))*(pa.l(r,i,gov,t)/pg.l(r,t))**sigmag(r) ;
else
   alphaa(r,i,gov,t)$xaFlag(r,i,gov)
      = (pa.l(r,i,gov,t)*xa.l(r,i,gov,t))/(pg.l(r,t)*xg.l(r,t)) ;
) ;

aug.fx(r,t) = ug.l(r,t)*pop.l(r,t)/xg.l(r,t) ;

loop(gov,
   axg(r,t)$(sigmag(r) ne 1) = 1 ;
   axg(r,t)$(sigmag(r) eq 1) = (prod(i$(alphaa(r,i,gov,t) ne 0),
               (pa.l(r,i,gov,t)/alphaa(r,i,gov,t))**alphaa(r,i,gov,t)))/pg.l(r,t) ;
) ;

*  Investment/savings

*  sigmai is top level subsitution elasticity, by default equal to esubi

sigmai(r)$(sigmai(r) eq na) = esubi(r) ;
sigmai(r)$(sigmai(r) eq 1)  = 1.01 ;

if(0,
   alphaa(r,i,inv,t)$xaFlag(r,i,inv)
      = (xa.l(r,i,inv,t)/xi.l(r,t))*(pa.l(r,i,inv,t)/pi.l(r,t))**sigmai(r) ;
else
   alphaa(r,i,inv,t)$xaFlag(r,i,inv)
      = (pa.l(r,i,inv,t)*xa.l(r,i,inv,t))/(pi.l(r,t)*xi.l(r,t)) ;
) ;

aus.fx(r,t) = us.l(r,t)*pop.l(r,t)/(rsav.l(r,t)/psave.l(r,t)) ;

lambdai.fx(r,i,t) = 1 ;
loop(inv,
   axi(r,t)$(sigmai(r) ne 1) = 1 ;
   axi(r,t)$(sigmai(r) eq 1) = (prod(i$(alphaa(r,i,inv,t) ne 0),
               (pa.l(r,i,inv,t)/alphaa(r,i,inv,t))**alphaa(r,i,inv,t)))/pi.l(r,t) ;
) ;

u.l(r,t)   = 1 ;
au.fx(r,t) = u.l(r,t)*(sum(h,uh.l(r,h,t))**(-betaP.l(r,t)))
           *   (ug.l(r,t)**(-betaG.l(r,t)))
           *   (us.l(r,t)**(-betaS.l(r,t))) ;

*  Top level Armington demand

if(0,
   alphad(r,i,aa,t)$xaFlag(r,i,aa) =
         (xd.l(r,i,aa,t)/xa.l(r,i,aa,t))*(pdp.l(r,i,aa,t)/pa.l(r,i,aa,t))**sigmam(r,i,aa) ;
   alpham(r,i,aa,t)$xaFlag(r,i,aa) =
         (xm.l(r,i,aa,t)/xa.l(r,i,aa,t))*(pmp.l(r,i,aa,t)/pa.l(r,i,aa,t))**sigmam(r,i,aa) ;
else
   alphad(r,i,aa,t)$xaFlag(r,i,aa) =
      (pdp.l(r,i,aa,t)*xd.l(r,i,aa,t))/(pa.l(r,i,aa,t)*xa.l(r,i,aa,t)) ;
   alpham(r,i,aa,t)$xaFlag(r,i,aa) =
      (pmp.l(r,i,aa,t)*xm.l(r,i,aa,t))/(pa.l(r,i,aa,t)*xa.l(r,i,aa,t)) ;
) ;

loop(ArmFlag(r,i),
   alphadt(r,i,t)$xat.l(r,i,t) = (pd.l(r,i,t)*xdt.l(r,i,t))/(pat.l(r,i,t)*xat.l(r,i,t)) ;
   alphamt(r,i,t)$xat.l(r,i,t) = (pmt.l(r,i,t)*xmt.l(r,i,t))/(pat.l(r,i,t)*xat.l(r,i,t)) ;
) ;

*  Second level Armington

if(0,
   if(not MRIO,
      amw(rp,i,r,t)$xwFlag(rp,i,r) = (xw.l(rp,i,r,t)/xmt.l(r,i,t))
                                   *   (pm.l(rp,i,r,t)/pmt.l(r,i,t))**sigmaw(r,i) ;
   else
      loop(t0,
         alphawa(s,i,d,aa)$xwaFlag(s,i,d,aa)
            = (xwa.l(s,i,d,aa,t0)/xm.l(d,i,aa,t0))
            * (pdma.l(s,i,d,aa,t0)/pma.l(d,i,aa,t0))**sigmawa(d,i,aa) ;
      ) ;
   ) ;
else
   if(not MRIO,
      amw(rp,i,r,t)$xwFlag(rp,i,r) = (pm.l(rp,i,r,t)*xw.l(rp,i,r,t))/(pmt.l(r,i,t)*xmt.l(r,i,t)) ;
   else
      loop(t0,
         alphawa(s,i,d,aa)$xwaFlag(s,i,d,aa)
            = (pdma.l(s,i,d,aa,t0)*xwa.l(s,i,d,aa,t0))/(pma.l(d,i,aa,t0)*xm.l(d,i,aa,t0)) ;
      )
   ) ;
) ;

*  Top level CET

loop((r,i),

   if(0 and omegax(r,i) ne inf,
      gd(r,i,t)$(xdFlag(r,i))  = (xds.l(r,i,t)/xs.l(r,i,t))
                               * (ps.l(r,i,t)/pd.l(r,i,t))**omegax(r,i) ;
      ge(r,i,t)$(xetFlag(r,i)) = (xet.l(r,i,t)/xs.l(r,i,t))
                               * (ps.l(r,i,t)/pet.l(r,i,t))**omegax(r,i) ;
   else

      gd(r,i,t)$(xdFlag(r,i))  = (pd.l(r,i,t)*xds.l(r,i,t))
                               / (ps.l(r,i,t)*xs.l(r,i,t)) ;
      ge(r,i,t)$(xetFlag(r,i)) = (pet.l(r,i,t)*xet.l(r,i,t))
                               / (ps.l(r,i,t)*xs.l(r,i,t)) ;
   ) ;
) ;

*  Second level CET

loop((r,i),
   if(0 and omegaw(r,i) ne inf,
      gw(r,i,d,t)$(xwFlag(r,i,d)) = (xw.l(r,i,d,t)/xet.l(r,i,t))
                                  * (pet.l(r,i,t)/pe.l(r,i,d,t))**omegaw(r,i) ;
   else
      gw(r,i,d,t)$(xwFlag(r,i,d)) = (pe.l(r,i,d,t)*xw.l(r,i,d,t)
                                  / (pet.l(r,i,t)*xet.l(r,i,t))) ;
   ) ;
) ;

*  TT services

loop(t$t0(t),
   amgm(m,s,i,d)$xwmg.l(s,i,d,t) = xmgm.l(m,s,i,d,t)/xwmg.l(s,i,d,t) ;
) ;

*  sigmamg is top level subsitution elasticity, by default equal to esubs

Loop(t0,
   work = sum((s,d,m0,i0), VTWR(m0,i0,s,d)) ;
   sigmamg(m)$(sigmamg(m) eq na and work)
      = sum((s,d,m0,i0)$mapi0(m0,m), VTWR(m0,i0,s,d)*esubs(m0)) / work ;
) ;

sigmamg(m)$(sigmamg(m) eq 1) = 1.01 ;

if(0,
   alphaa(r,m,tmg,t)$mflag(m) = (xa.l(r,m,tmg,t)/xtmg.l(m,t))
                              * (pa.l(r,m,tmg,t)/ptmg.l(m,t))**sigmamg(m) ;
else
   alphaa(r,m,tmg,t)$mflag(m) = (pa.l(r,m,tmg,t)*xa.l(r,m,tmg,t))/(ptmg.l(m,t)*xtmg.l(m,t)) ;
) ;

loop(tmg,
   axmg(m,t)$(sigmamg(m) eq 1) = prod(r$alphaa(r,m,tmg,t),
      (pa.l(r,m,tmg,t)/alphaa(r,m,tmg,t))**(alphaa(r,m,tmg,t)))/ptmg.l(m,t) ;
) ;
axmg(m,t)$(sigmamg(m) ne 1) = 1 ;

*  Factor markets

aft(r,fm,t) = xft.l(r,fm,t)*(pabs.l(r,t)/pft.l(r,fm,t))**etaf(r,fm) ;

*  Calibrate gf for mobile endowments

loop((r,fm),
   if(0 and omegaf(r,fm) ne inf,
      gf(r,fm,a,t)$xfFlag(r,fm,a) =
         (xf.l(r,fm,a,t)/xft.l(r,fm,t))*(pft.l(r,fm,t)/pfy.l(r,fm,a,t))**omegaf(r,fm) ;
   else
      gf(r,fm,a,t)$xfFlag(r,fm,a) =
         ((pfy.l(r,fm,a,t)*xf.l(r,fm,a,t))/(pft.l(r,fm,t)*xft.l(r,fm,t))) ;
   ) ;
) ;

*  Calibrate gf for sector-specific endowments

gf(r,fnm,a,t)$(xfFlag(r,fnm,a)) =
      xf.l(r,fnm,a,t)*(pabs.l(r,t)/pfy.l(r,fnm,a,t))**etaff(r,fnm,a) ;

ggdppcT(r,t) = 0 ;

walras.l(t) = 0 ;
obj.l       = sum((r,h,t)$t0(t), ev.l(r,h,t)) ;

* --------------------------------------------------------------------------------------------------
*
*  Dump the MRIO data for debugging
*
* --------------------------------------------------------------------------------------------------

file mcsv / mrio.csv / ;
if(0 and MRIO,
   put mcsv ;
   put "Var,Source,Comm,Dest,Agent,Value" / ;
   mcsv.pc=5 ;
   mcsv.nd=9 ;
   loop((r,i,t)$t0(t),
      loop(aa,
         put "XDVB", r.tl, i.tl, "", aa.tl, (pd.l(r,i,t)*xd.l(r,i,aa,t)/inscale) / ;
         put "XDVP", r.tl, i.tl, "", aa.tl,
            ((1+dintx.l(r,i,aa,t))*pd.l(r,i,t)*xd.l(r,i,aa,t)/inscale) / ;
         if(MRIO,
            put "XMVB", r.tl, i.tl, "", aa.tl, (pma.l(r,i,aa,t)*xm.l(r,i,aa,t)/inscale) / ;
            put "XMVP", r.tl, i.tl, "", aa.tl,
               ((1+mintx.l(r,i,aa,t))*pma.l(r,i,aa,t)*xm.l(r,i,aa,t)/inscale) / ;
         else
            put "XMVB", r.tl, i.tl, "", aa.tl, (pmt.l(r,i,t)*xm.l(r,i,aa,t)/inscale) / ;
            put "XMVP", r.tl, i.tl, "", aa.tl,
               ((1+mintx.l(r,i,aa,t))*pmt.l(r,i,t)*xm.l(r,i,aa,t)/inscale) / ;
         ) ;
      ) ;
   ) ;

   loop((r,i0,t)$t0(t),
      loop(a0,
         put "VDB", r.tl, i0.tl, "", a0.tl, vdfb(i0,a0,r) / ;
         put "VDP", r.tl, i0.tl, "", a0.tl, vdfp(i0,a0,r) / ;
         put "VMB", r.tl, i0.tl, "", a0.tl, vmfb(i0,a0,r) / ;
         put "VMP", r.tl, i0.tl, "", a0.tl, vmfp(i0,a0,r) / ;
      ) ;
      loop(h,
         put "VDB", r.tl, i0.tl, "", h.tl, vdpb(i0,r) / ;
         put "VDP", r.tl, i0.tl, "", h.tl, vdpp(i0,r) / ;
         put "VMB", r.tl, i0.tl, "", h.tl, vmpb(i0,r) / ;
         put "VMP", r.tl, i0.tl, "", h.tl, vmpp(i0,r) / ;
      ) ;
      loop(gov,
         put "VDB", r.tl, i0.tl, "", gov.tl, vdgb(i0,r) / ;
         put "VDP", r.tl, i0.tl, "", gov.tl, vdgp(i0,r) / ;
         put "VMB", r.tl, i0.tl, "", gov.tl, vmgb(i0,r) / ;
         put "VMP", r.tl, i0.tl, "", gov.tl, vmgp(i0,r) / ;
      ) ;
      loop(inv,
         put "VDB", r.tl, i0.tl, "", inv.tl, vdib(i0,r) / ;
         put "VDP", r.tl, i0.tl, "", inv.tl, vdip(i0,r) / ;
         put "VMB", r.tl, i0.tl, "", inv.tl, vmib(i0,r) / ;
         put "VMP", r.tl, i0.tl, "", inv.tl, vmip(i0,r) / ;
      ) ;
   ) ;

   if(MRIO,
      loop((s,i,d,aa,t)$t0(t),
         put "VXWW", s.tl, i.tl, d.tl, aa.tl, (pmcif.l(s,i,d,t)*xwa.l(s,i,d,aa,t)/inscale) / ;
         put "VXWM", s.tl, i.tl, d.tl, aa.tl,
            ((1+imptxa.l(s,i,d,aa,t))*pmcif.l(s,i,d,t)*xwa.l(s,i,d,aa,t)/inscale) / ;
         put "VXWP", s.tl, i.tl, d.tl, aa.tl, (pdma.l(s,i,d,aa,t)*xwa.l(s,i,d,aa,t)/inscale) / ;
      ) ;
      loop((i0,amrio,s,d),
         put "VIUMS", s.tl, i0.tl, d.tl, amrio.tl, (VIUMS(i0,amrio,s,d)) / ;
         put "VIUWS", s.tl, i0.tl, d.tl, amrio.tl, (VIUWS(i0,amrio,s,d)) / ;
      ) ;
   ) ;
   Abort "Temp" ;
)

* --------------------------------------------------------------------------------------------------
*
*  Normalize the variables
*
* --------------------------------------------------------------------------------------------------

$macro norm0(varName, suffix) \
      &varName&suffix(r) = &varName.l(r,t0) ; \
      varName.l(r,t) = 0 + 1$varName.l(r,t) ;
$macro norm1(varName,i__1,suffix) \
      &varName&suffix(r,i__1) = &varName.l(r,i__1,t0) ; \
      varName.l(r,i__1,t) = 0 + 1$varName.l(r,i__1,t) ;
$macro norm2(varName,i__1,i__2,suffix) \
      &varName&suffix(r,i__1,i__2) = &varName.l(r,i__1,i__2,t0) ; \
      varName.l(r,i__1,i__2,t) = 0 + 1$varName.l(r,i__1,i__2,t) ;
$macro norm3(varName,i__1,i__2,i__3,suffix) \
      &varName&suffix(r,i__1,i__2,i__3) = &varName.l(r,i__1,i__2,i__3,t0) ; \
      varName.l(r,i__1,i__2,i__3,t) = 0 + 1$varName.l(r,i__1,i__2,i__3,t) ;

loop(t0,
   norm1(nd, a, 0)
   norm1(va, a, 0)
   norm1(px, a, 0)
   norm1(pnd, a, 0)
   norm1(pva, a, 0)
   norm1(xp, a, 0)

   norm2(xa, i, aa, 0)
   norm2(pa, i, aa, 0)

   norm2(xf, fp, a, 0)
   norm2(pf, fp, a, 0)
   norm2(pfy, fp, a, 0)
   norm2(pfa, fp, a, 0)

   norm2(x, a, i, 0)
   norm2(p, a, i, 0)
   norm2(pp, a, i, 0)
   norm1(xs, i, 0)
   norm1(ps, i, 0)

   norm1(yTax, gy, 0)
   norm0(yTaxTot, 0)
   norm0(yTaxInd, 0)
   norm0(factY, 0)
   norm0(regY, 0)
   norm0(rsav, 0)
   norm0(yg, 0)
   norm0(yc, 0)
   norm0(betaP, 0)
   norm0(betaG, 0)
   norm0(betaS, 0)
   norm2(zcons, i, h, 0)
   norm2(xcshr, i, h, 0)
   norm0(pg, 0)
   norm0(xg, 0)
   norm0(pi, 0)
   norm0(xi, 0)
   norm0(yi, 0)

   norm1(pd, i, 0)
   norm1(pmt, i, 0)
   norm2(pdp, i, aa, 0)
   norm2(pmp, i, aa, 0)
   norm2(xd, i, aa, 0)
   norm2(xm, i, aa, 0)
   norm1(xmt, i, 0)
   norm2(xw, i, d, 0)
   norm2(pe, i, d, 0)
   norm2(pefob, i, d, 0)
   norm2(pmcif, i, d, 0)
   norm2(pm, i, d, 0)
   norm1(xet, i, 0)
   norm1(pet, i, 0)
   norm1(xds, i, 0)
   norm1(xdt, i, 0)

   norm2(xwmg, i, d, 0)
   xmgm0(m,s,i,d) = xmgm.l(m,s,i,d,t0) ; xmgm.l(m,s,i,d,t) = 0 + 1$xmgm.l(m,s,i,d,t) ;
   norm2(pwmg, i, d, 0)
   xtmg0(m) = xtmg.l(m,t0) ; xtmg.l(m,t) = 0 + 1$xtmg.l(m,t) ;
   ptmg0(m) = ptmg.l(m,t0) ; ptmg.l(m,t) = 0 + 1$ptmg.l(m,t) ;

   norm1(pft, fp, 0)
   norm1(xft, fp, 0)
   norm0(pabs, 0)
   norm0(kstock, 0)
   norm0(kapend, 0)
   norm0(arent, 0)
   norm0(rorc, 0)
   norm0(rore, 0)
   rorg0 = rorg.l(t0) ; rorg.l(t) = 0 + 1$rorg.l(t) ;
   pigbl0 = pigbl.l(t0) ; pigbl.l(t) = 0 + 1$pigbl.l(t) ;
   xigbl0 = xigbl.l(t0) ; xigbl.l(t) = 0 + 1$xigbl.l(t) ;
   norm1(ev, h, 0)
   norm1(cv, h, 0)
   obj0 = obj.l ; obj.l = 1 ;
   norm0(gdpmp, 0)
   norm0(rgdpmp, 0)

*  01-May-2019
   norm1(xat, i, 0)
   norm1(pat, i, 0)

*  01-May-2019
   if(MRIO,
      norm2(pma, i, aa, 0)
      norm3(xwa, i, d, aa, 0)
      norm3(pdma, i, d, aa, 0)
   ) ;
) ;
