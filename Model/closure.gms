*  Standard comparative static closure

aps.fx(r,h,t)$(%utility% ne ELES) = aps.l(r,h,t) ;
chiaps.fx(r,t)    = chiaps.l(r,t) ;
wprem.fx(r,l,a,t) = wprem.l(r,l,a,t) ;
lsz.fx(r,l,z,t)   = lsz.l(r,l,z,t) ;
rsg.fx(r,t)       = rsg.l(r,t) ;
kstock.fx(r,t)    = kstock.l(r,t) ;
RoRd.fx(r,t)      = RoRd.l(r,t) ;
xfd.fx(r,gov,t)   = xfd.l(r,gov,t) ;
tkaps.fx(r,t)     = tkaps.l(r,t) ;
pnum.fx(t)        = pnum.l(t) ;
savfRat.fx(r,t)$(savfFlag eq capRFix and not rres(r)) = savfRat.l(r,t) ;
pop.fx(r,t)       = pop.l(r,t) ;

*  Temporarily fix other endogenous variables
pxghg.fx(r,a,v,t) = pxghg.l(r,a,v,t) ;

*  Consumer demand parameters for the 'LES' type utility functions

if(%utility%=CD or %utility%=LES or %utility%=ELES or %utility%=AIDADS,
  theta.fx(r,k,h,t) = theta.l(r,k,h,t) ;
   if(%utility%=CD or %utility%=LES or %utility%=ELES,
      muc.fx(r,k,h,t) = muc.l(r,k,h,t) ;
   ) ;
) ;

*  Fix policy variables

ptax.fx(r,a,i,t)   = ptax.l(r,a,i,t) ;
uctax.fx(r,a,v,t)  = uctax.l(r,a,v,t) ;
paTax.fx(r,i,aa,t) = paTax.l(r,i,aa,t) ;
pdTax.fx(r,i,aa,t) = pdTax.l(r,i,aa,t) ;
pmTax.fx(r,i,aa,t) = pmTax.l(r,i,aa,t) ;
etax.fx(r,i,rp,t)  = etax.l(r,i,rp,t) ;
if(not MRIO,
   mtax.fx(r,i,rp,t)  = mtax.l(r,i,rp,t) ;
else
   mtaxa.fx(r,i,rp,aa,t)  = mtaxa.l(r,i,rp,aa,t) ;
) ;
pftax.fx(r,f,a,t)  = pftax.l(r,f,a,t) ;
kappaf.fx(r,f,a,t) = kappaf.l(r,f,a,t) ;

h2obnd.fx(r,wbndEx,t) = h2obnd.l(r,wbndEx,t) ;

*  Fix technology parameters

axghg.fx(r,a,v,t)         = axghg.l(r,a,v,t) ;
lambdaxp.fx(r,a,v,t)      = lambdaxp.l(r,a,v,t) ;
lambdaghg.fx(r,a,v,t)     = lambdaghg.l(r,a,v,t) ;
lambdak.fx(r,a,v,t)       = lambdak.l(r,a,v,t) ;
lambdaf.fx(r,f,a,t)       = lambdaf.l(r,f,a,t) ;
lambdaio.fx(r,i,a,t)      = lambdaio.l(r,i,a,t) ;
lambdae.fx(r,e,a,v,t)     = lambdae.l(r,e,a,v,t) ;
lambdace.fx(r,e,k,h,t)    = lambdace.l(r,e,k,h,t) ;
lambdah2obnd.fx(r,wbnd,t) = lambdah2obnd.l(r,wbnd,t) ;
tmarg.fx(r,i,rp,t)        = tmarg.l(r,i,rp,t) ;

*  Fix inactive variables

px.fx(r,a,t)$(not xpFlag(r,a))         = px.l(r,a,t) ;
uc.fx(r,a,v,t)$(not xpFlag(r,a))       = uc.l(r,a,v,t) ;
pxv.fx(r,a,v,t)$(not xpFlag(r,a))      = pxv.l(r,a,v,t) ;
xpx.fx(r,a,v,t)$(not xpFlag(r,a))      = xpx.l(r,a,v,t) ;
xpv.fx(r,a,v,t)$(not xpFlag(r,a))      = xpv.l(r,a,v,t) ;
xghg.fx(r,a,v,t)$(not ghgFlag(r,a))    = xghg.l(r,a,v,t) ;
nd1.fx(r,a,t)$(not nd1Flag(r,a))       = nd1.l(r,a,t) ;
nd2.fx(r,a,t)$(not nd2Flag(r,a))       = nd2.l(r,a,t) ;
xwat.fx(r,a,t)$(not watFlag(r,a))      = xwat.l(r,a,t) ;
xf.fx(r,f,a,t)$(not xfFlag(r,f,a))     = xf.l(r,f,a,t) ;
pnd1.fx(r,a,t)$(not nd1Flag(r,a))      = pnd1.l(r,a,t) ;
pnd2.fx(r,a,t)$(not nd2Flag(r,a))      = pnd2.l(r,a,t) ;
pwat.fx(r,a,t)$(not watFlag(r,a))      = pwat.l(r,a,t) ;
va.fx(r,a,v,t)$(not xpFlag(r,a))       = va.l(r,a,v,t) ;
va1.fx(r,a,v,t)$(not va1Flag(r,a))     = va1.l(r,a,v,t) ;
va2.fx(r,a,v,t)$(not va2Flag(r,a))     = va2.l(r,a,v,t) ;
pva.fx(r,a,v,t)$(not xpFlag(r,a))      = pva.l(r,a,v,t) ;
pva1.fx(r,a,v,t)$(not va1Flag(r,a))    = pva1.l(r,a,v,t) ;
pva2.fx(r,a,v,t)$(not va2Flag(r,a))    = pva2.l(r,a,v,t) ;
pxp.fx(r,a,v,t)$(not xpFlag(r,a))      = pxp.l(r,a,v,t) ;
lab1.fx(r,a,t)$(not lab1Flag(r,a))     = lab1.l(r,a,t) ;
lab2.fx(r,a,t)$(not lab2Flag(r,a))     = lab2.l(r,a,t) ;
plab1.fx(r,a,t)$(not lab1Flag(r,a))    = plab1.l(r,a,t) ;
plab2.fx(r,a,t)$(not lab2Flag(r,a))    = plab2.l(r,a,t) ;
kef.fx(r,a,v,t)$(not kefFlag(r,a))     = kef.l(r,a,v,t) ;
pkef.fx(r,a,v,t)$(not kefFlag(r,a))    = pkef.l(r,a,v,t) ;
kf.fx(r,a,v,t)$(not kfFlag(r,a))       = kf.l(r,a,v,t) ;
pkf.fx(r,a,v,t)$(not kfFlag(r,a))      = pkf.l(r,a,v,t) ;

xnrg.fx(r,a,v,t)$(not xnrgFlag(r,a))   = xnrg.l(r,a,v,t) ;
xnely.fx(r,a,v,t)$(not xnelyFlag(r,a)) = xnely.l(r,a,v,t) ;
xolg.fx(r,a,v,t)$(not xolgFlag(r,a))   = xolg.l(r,a,v,t) ;
xaNRG.fx(r,a,NRG,v,t)$(not xaNRGFlag(r,a,NRG)) = xaNRG.l(r,a,NRG,v,t) ;
paNRG.fx(r,a,NRG,v,t)$(not xaNRGFlag(r,a,NRG)) = paNRG.l(r,a,NRG,v,t) ;
polg.fx(r,a,v,t)$(not xolgFlag(r,a))   = polg.l(r,a,v,t) ;
pnely.fx(r,a,v,t)$(not xnelyFlag(r,a)) = pnely.l(r,a,v,t) ;
pnrg.fx(r,a,v,t)$(not xnrgFlag(r,a))   = pnrg.l(r,a,v,t) ;

ksw.fx(r,a,v,t)$(not kFlag(r,a))       = ksw.l(r,a,v,t) ;
pksw.fx(r,a,v,t)$(not kFlag(r,a))      = pksw.l(r,a,v,t) ;
ks.fx(r,a,v,t)$(not kFlag(r,a))        = ks.l(r,a,v,t) ;
pks.fx(r,a,v,t)$(not kFlag(r,a))       = pks.l(r,a,v,t) ;
kv.fx(r,a,v,t)$(not kFlag(r,a))        = kv.l(r,a,v,t) ;

xa.fx(r,i,aa,t)$(not xaFlag(r,i,aa))   = xa.l(r,i,aa,t) ;

x.fx(r,a,i,t)$(gp(r,a,i) eq 0)         = x.l(r,a,i,t) ;
p.fx(r,a,i,t)$(gp(r,a,i) eq 0)         = p.l(r,a,i,t) ;
pp.fx(r,a,i,t)$(gp(r,a,i) eq 0)        = pp.l(r,a,i,t) ;
xp.fx(r,a,t)$(not xpFlag(r,a))         = xp.l(r,a,t) ;
ps.fx(r,i,t)$(not xsFlag(r,i))         = ps.l(r,i,t) ;

xpow.fx(r,elyc,t)$(apow(r,elyc) eq 0)    = xpow.l(r,elyc,t) ;
ppow.fx(r,elyc,t)$(apow(r,elyc) eq 0)    = ppow.l(r,elyc,t) ;
ppowndx.fx(r,elyc,t)$(apow(r,elyc) eq 0) = ppowndx.l(r,elyc,t) ;

xpb.fx(r,pb,elyc,t)$(apb(r,pb,elyc) eq 0)    = xpb.l(r,pb,elyc,t) ;
ppb.fx(r,pb,elyc,t)$(apb(r,pb,elyc) eq 0)    = ppb.l(r,pb,elyc,t) ;
ppbndx.fx(r,pb,elyc,t)$(apb(r,pb,elyc) eq 0) = ppbndx.l(r,pb,elyc,t) ;

deprY.fx(r,t)$(deprY0(r) eq 0)         = 0 ;
yqtf.fx(r,t)$(yqtf0(r) eq 0)           = 0 ;
trustY.fx(t)$(trustY0 eq 0)            = 0 ;
yqht.fx(r,t)$(yqht0(r) eq 0)           = 0 ;
ntmY.fx(r,t)$(ntmFlag eq 0)            = 0 ;
ODAIn.fx(r,t)$(ODAIn0(r) eq 0)         = 0 ;
ODAGbl.fx(t)$(ODAGbl0 eq 0)            = 0 ;
ODAOut.fx(r,t)$(ODAOut0(r) eq 0)       = 0 ;
remit.fx(rp,l,r,t)$(remit0(rp,l,r) eq 0) = 0 ;

ygov.fx(r,gy,t)$(ygov0(r,gy) eq 0)     = 0 ;

xc.fx(r,k,h,t)$(not xcFlag(r,k,h))         = xc.l(r,k,h,t) ;
pc.fx(r,k,h,t)$(not xcFlag(r,k,h))         = pc.l(r,k,h,t) ;
hshr.fx(r,k,h,t)$(not xcFlag(r,k,h))       = hshr.l(r,k,h,t) ;
theta.fx(r,k,h,t)$(not xcFlag(r,k,h))      = theta.l(r,k,h,t) ;
xcnnrg.fx(r,k,h,t)$(not xcnnrgFlag(r,k,h)) = xcnnrg.l(r,k,h,t) ;
pcnnrg.fx(r,k,h,t)$(not xcnnrgFlag(r,k,h)) = pcnnrg.l(r,k,h,t) ;
xcnrg.fx(r,k,h,t)$(not xcnrgFlag(r,k,h))   = xcnrg.l(r,k,h,t) ;
pcnrg.fx(r,k,h,t)$(not xcnrgFlag(r,k,h))   = pcnrg.l(r,k,h,t) ;
xcnely.fx(r,k,h,t)$(not xcnelyFlag(r,k,h)) = xcnely.l(r,k,h,t) ;
pcnely.fx(r,k,h,t)$(not xcnelyFlag(r,k,h)) = pcnely.l(r,k,h,t) ;
xcolg.fx(r,k,h,t)$(not xcolgFlag(r,k,h))   = xcolg.l(r,k,h,t) ;
pcolg.fx(r,k,h,t)$(not xcolgFlag(r,k,h))   = pcolg.l(r,k,h,t) ;
xacNRG.fx(r,k,h,NRG,t)$(not xacNRGFlag(r,k,h,NRG)) = xacNRG.l(r,k,h,NRG,t) ;
pacNRG.fx(r,k,h,NRG,t)$(not xacNRGFlag(r,k,h,NRG)) = pacNRG.l(r,k,h,NRG,t) ;

xaac.fx(r,i,h,t)$(xaac0(r,i,h) eq 0) = 0 ;
xawc.fx(r,i,h,t)$(hWasteFlag(r,i,h) ne 1) = 0 ;

paac.fx(r,i,h,t)$(xaac0(r,i,h) eq 0) = 1 ;
pah.fx(r,i,h,t)$(xaac0(r,i,h) eq 0)  = 1 ;
paacc.fx(r,i,h,t)$(hWasteFlag(r,i,h) ne 1) = 1 ;
pawc.fx(r,i,h,t)$(hWasteFlag(r,i,h) ne 1)  = 1 ;

xat.fx(r,i,t)$(not xatFlag(r,i))       = xat.l(r,i,t) ;
xdt.fx(r,i,t)$(not xdtFlag(r,i))       = xdt.l(r,i,t) ;
xmt.fx(r,i,t)$(not xmtFlag(r,i))       = xmt.l(r,i,t) ;
pat.fx(r,i,t)$(not xatFlag(r,i))       = pat.l(r,i,t) ;
pa.fx(r,i,aa,t)$(not xaFlag(r,i,aa))   = pa.l(r,i,aa,t) ;

xw.fx(r,i,rp,t)$(not xwFlag(r,i,rp))   = xw.l(r,i,rp,t) ;
if(not MRIO,
   pmt.fx(r,i,t)$(not xmtFlag(r,i))       = pmt.l(r,i,t) ;
   pdm.fx(r,i,rp,t)$(not xwFlag(r,i,rp))  = pdm.l(r,i,rp,t) ;
else
   xwa.fx(r,i,rp,aa,t)$(not xwaFlag(r,i,rp,aa))   = xwa.l(r,i,rp,aa,t) ;
   pdma.fx(r,i,rp,aa,t)$(not xwaFlag(r,i,rp,aa))  = pdma.l(r,i,rp,aa,t) ;
   pma.fx(r,i,aa,t)$(not xmFlag(r,i,aa))  = pma.l(r,i,aa,t) ;
) ;

pdt.fx(r,i,t)$(not xdtFlag(r,i))       = pdt.l(r,i,t) ;
xet.fx(r,i,t)$(not xetFlag(r,i))       = xet.l(r,i,t) ;
xs.fx(r,i,t)$(not xsFlag(r,i))         = xs.l(r,i,t) ;
pe.fx(r,i,rp,t)$(not xwFlag(r,i,rp))   = pe.l(r,i,rp,t) ;
pet.fx(r,i,t)$(not xetFlag(r,i))       = pet.l(r,i,t) ;
pwe.fx(r,i,rp,t)$(not xwFlag(r,i,rp))  = pwe.l(r,i,rp,t) ;
pwm.fx(r,i,rp,t)$(not xwFlag(r,i,rp))  = pwm.l(r,i,rp,t) ;

xwmg.fx(r,i,rp,t)$(not tmgFlag(r,i,rp)) = xwmg.l(r,i,rp,t) ;
xwmg.fx(r,i,rp,t)$(not tmgFlag(r,i,rp)) = xwmg.l(r,i,rp,t) ;
pwmg.fx(r,i,rp,t)$(not tmgFlag(r,i,rp)) = pwmg.l(r,i,rp,t) ;
xmgm.fx(img,r,i,rp,t)$(amgm(img,r,i,rp) eq 0) = xmgm.l(img,r,i,rp,t) ;
xtt.fx(r,i,t)$(not xttFlag(r,i))        = xtt.l(r,i,t) ;

pf.fx(r,f,a,t)$(not xfFlag(r,f,a))  = pf.l(r,f,a,t) ;
pfp.fx(r,f,a,t)$(not xfFlag(r,f,a)) = pfp.l(r,f,a,t) ;

ldz.fx(r,l,z,t)$(not lsFlag(r,l,z))     = 0 ;
awagez.fx(r,l,z,t)$(not lsFlag(r,l,z))  = awagez.l(r,l,z,t) ;
urbPrem.fx(r,l,t)$(not tLabFlag(r,l) or (omegam(r,l) eq inf)) = urbPrem.l(r,l,t) ;
ewagez.l(r,l,z,t)$(not lsFlag(r,l,z))   = ewagez.l(r,l,z,t) ;
twage.fx(r,l,t)$(not tlabFlag(r,l))     = twage.l(r,l,t) ;
skillprem.fx(r,l,t)$(not tlabFlag(r,l)) = skillprem.l(r,l,t) ;
ls.fx(r,l,t)$(not tlabFlag(r,l))        = ls.l(r,l,t) ;
uez.fx(r,l,z,t)$(not ueFlag(r,l,z))     = 0 ;
resWage.fx(r,l,z,t)$(not ueFlag(r,l,z)) = ewagez.l(r,l,z,t) ;

migr.fx(r,l,t)$(not migrFlag(r,l))       = 0 ;
migrMult.fx(r,l,z,t)$(not migrFlag(r,l)) = 1 ;
lsz.fx(r,l,z,t)$(not lsFlag(r,l,z))      = lsz.l(r,l,z,t) ;
glab.fx(r,l,t)$(not tlabFlag(r,l))       = glab.l(r,l,t) ;

pk.fx(r,a,v,t)$(not kFlag(r,a))        = pk.l(r,a,v,t) ;
pkp.fx(r,a,v,t)$(not kFlag(r,a))       = pkp.l(r,a,v,t) ;
kxRat.fx(r,a,v,t)$(not kFlag(r,a))     = kxRat.l(r,a,v,t) ;
rrat.fx(r,a,t)$(not kFlag(r,a))        = rrat.l(r,a,t) ;

tland.fx(r,t)$(not tlandFlag(r))       = tland.l(r,t) ;
ptland.fx(r,t)$(not tlandFlag(r))      = ptland.l(r,t) ;
ptlandndx.fx(r,t)$(not tlandFlag(r))   = ptlandndx.l(r,t) ;
xlb.fx(r,lb,t)$(gamlb(r,lb,t) eq 0)    = xlb.l(r,lb,t) ;
plb.fx(r,lb,t)$(gamlb(r,lb,t) eq 0)    = plb.l(r,lb,t) ;
plbndx.fx(r,lb,t)$(gamlb(r,lb,t) eq 0) = plbndx.l(r,lb,t) ;
xnlb.fx(r,t)$(gamnlb(r,t) eq 0)        = xnlb.l(r,t) ;
pnlb.fx(r,t)$(gamnlb(r,t) eq 0)        = pnlb.l(r,t) ;
pnlbndx.fx(r,t)$(gamnlb(r,t) eq 0)     = pnlbndx.l(r,t) ;

th2o.fx(r,t)$(not th2oFlag(r))         = th2o.l(r,t) ;
th2om.fx(r,t)$(not th2oFlag(r))        = th2om.l(r,t) ;
pth2o.fx(r,t)$(not th2oFlag(r))        = pth2o.l(r,t) ;
pth2ondx.fx(r,t)$(not th2oFlag(r))     = pth2ondx.l(r,t) ;
h2obnd.fx(r,wbnd,t)$(not h2obndFlag(r,wbnd))     = h2obnd.l(r,wbnd,t) ;
ph2obnd.fx(r,wbnd,t)$(not h2obndFlag(r,wbnd))    = ph2obnd.l(r,wbnd,t) ;
ph2obndndx.fx(r,wbnd,t)$(not h2obndFlag(r,wbnd)) = ph2obndndx.l(r,wbnd,t) ;

emi.fx(r,em,is,aa,t)$(not emir(r,em,is,aa)) = 0 ;
emiTot.fx(r,em,t)$(emiTot0(r,em) = 0)       = 0 ;
emiGbl.fx(em,t)$(emiGbl0(em) = 0)           = 0 ;
