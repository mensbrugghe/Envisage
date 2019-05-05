* --------------------------------------------------------------------------------------------------
*
*  Calculate post-simulation results
*
* --------------------------------------------------------------------------------------------------

*  SAM calculation

*  Domestic production

sam(r,i,aa,t)      = (pd0(r,i)*xd0(r,i,aa)*pd.l(r,i,t)*xd.l(r,i,aa,t)
                   + ((pmt0(r,i)*pmt.l(r,i,t))$(not MRIO) + (pma0(r,i,aa)*pma.l(r,i,aa,t))$MRIO)
                   *  xm0(r,i,aa)*xm.l(r,i,aa,t))
                   $(not ArmFlag(r,i))
                   + (pat0(r,i)*xa0(r,i,aa)*pat.l(r,i,t)*xa.l(r,i,aa,t))
                   $ArmFlag(r,i) ;
sam(r,"itax",aa,t) = sum(i, (dintx.l(r,i,aa,t)*pd0(r,i)*xd0(r,i,aa)*pd.l(r,i,t)*xd.l(r,i,aa,t)
                   +         mintx.l(r,i,aa,t)*((pmt0(r,i)*pmt.l(r,i,t))$(not MRIO)
                   +          (pma0(r,i,aa)*pma.l(r,i,aa,t))$MRIO)*xm0(r,i,aa)*xm.l(r,i,aa,t))
                   $(not ArmFlag(r,i))
                   +        (aintx.l(r,i,aa,t)*pat0(r,i)*xa0(r,i,aa)*pat.l(r,i,t)*xa.l(r,i,aa,t))
                   $ArmFlag(r,i)) ;
sam(r,fp,a,t)      = pf0(r,fp,a)*xf0(r,fp,a)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t) ;
sam(r,"vtax",a,t)  =
   sum(fp, fcttx.l(r,fp,a,t)*pf0(r,fp,a)*xf0(r,fp,a)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) ;
sam(r,"vsub",a,t)  =
   sum(fp, fctts.l(r,fp,a,t)*pf0(r,fp,a)*xf0(r,fp,a)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) ;

sam(r,a,i,t)$xFlag(r,a,i) = p0(r,a,i)*x0(r,a,i)*p.l(r,a,i,t)*x.l(r,a,i,t) ;
sam(r,"ptax",i,t)  = sum(a, prdtx.l(r,a,i,t)*p0(r,a,i)*x0(r,a,i)*p.l(r,a,i,t)*x.l(r,a,i,t)) ;

*  Income distribution

if(0,
*  'Old' method
   sam(r,h,fp,t)
      = sum(a, (1-kappaf.l(r,fp,a,t))*pf0(r,fp,a)*xf0(r,fp,a)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) ;
   sam(r,"dtax",fp,t)
      = sum(a, kappaf.l(r,fp,a,t)*pf0(r,fp,a)*xf0(r,fp,a)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) ;
   sam(r,gov,"vsub",t)  = sum(a, sam(r,"vsub",a,t)) ;
   sam(r,gov,"vtax",t)  = sum(a, sam(r,"vtax",a,t)) ;
   sam(r,"etax",i,t)    = sum(d, exptx.l(r,i,d,t)*pe0(r,i,d)*pe.l(r,i,d,t)*xw0(r,i,d)*xw.l(r,i,d,t)) ;
   sam(r,"mtax",i,t)
      = sum(s, imptx.l(s,i,r,t)*pmcif0(s,i,r)*pmcif.l(s,i,r,t)*xw0(s,i,r)*xw.l(s,i,r,t)) ;
   sam(r,gov,"etax",t)  = sum(j, sam(r,"etax",j,t)) ;
   sam(r,gov,"mtax",t)  = sum(j, sam(r,"mtax",j,t)) ;
   sam(r,gov,"ptax",t)  = sum(i, sam(r,"ptax",i,t)) ;
   sam(r,gov,"itax",t)  = sum(aa, sam(r,"itax",aa,t)) ;
   sam(r,gov,"dtax",t)  = sum(js, sam(r,"dtax",js,t)) ;

   sam(r,gov,h,t)       = yg0(r)*yg.l(r,t) - ytaxTot.l(r,t)*ytaxTot0(r) ;
   sam(r,inv,h,t)       = rsav0(r)*rsav.l(r,t) ;
   sam(r,"depry",h,t)   = pi0(r)*pi.l(r,t)*kstock.l(r,t)*kstock0(r)*depr(r,t) ;
   sam(r,inv,"depry",t) = pi0(r)*pi.l(r,t)*kstock.l(r,t)*kstock0(r)*depr(r,t) ;

else

*  'Standard GTAP' method

   sam(r,"regY",fp,t)
      = sum(a, (1-kappaf.l(r,fp,a,t))*pf0(r,fp,a)*xf0(r,fp,a)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) ;
   sam(r,"dtax",fp,t)
      = sum(a, kappaf.l(r,fp,a,t)*pf0(r,fp,a)*xf0(r,fp,a)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)) ;
   sam(r,"regY","vsub",t)  = sum(a, sam(r,"vsub",a,t)) ;
   sam(r,"regY","vtax",t)  = sum(a, sam(r,"vtax",a,t)) ;
   sam(r,"etax",i,t)    = sum(d, exptx.l(r,i,d,t)*pe0(r,i,d)*pe.l(r,i,d,t)*xw0(r,i,d)*xw.l(r,i,d,t)) ;
   sam(r,"mtax",i,t)
      = sum(s, imptx.l(s,i,r,t)*pmcif0(s,i,r)*pmcif.l(s,i,r,t)*xw0(s,i,r)*xw.l(s,i,r,t)) ;
   sam(r,"regY","etax",t)  = sum(j, sam(r,"etax",j,t)) ;
   sam(r,"regY","mtax",t)  = sum(j, sam(r,"mtax",j,t)) ;
   sam(r,"regY","ptax",t)  = sum(i, sam(r,"ptax",i,t)) ;
   sam(r,"regY","itax",t)  = sum(aa, sam(r,"itax",aa,t)) ;
   sam(r,"regY","dtax",t)  = sum(js, sam(r,"dtax",js,t)) ;

   sam(r,h,"regY",t)       = yc0(r)*yc.l(r,t) ;
   sam(r,gov,"regY",t)     = yg0(r)*yg.l(r,t) ;
   sam(r,inv,"regY",t)     = rsav0(r)*rsav.l(r,t) ;

   sam(r,"depry","regY",t) = pi0(r)*pi.l(r,t)*kstock.l(r,t)*kstock0(r)*depr(r,t) ;
   sam(r,inv,"depry",t)    = pi0(r)*pi.l(r,t)*kstock.l(r,t)*kstock0(r)*depr(r,t) ;

   if(NTMFLAG,
      sam(r,"ntmY",i,t)
         = sum(s, ntmAVE.l(s,i,r,t)*pmcif0(s,i,r)*xw0(s,i,r)*pmcif.l(s,i,r,t)*xw.l(s,i,r,t)) ;
      sam(r,"regY","ntmY",t)
         = sum((i,s), ntmAVE.l(s,i,r,t)*pmcif.l(s,i,r,t)*xw.l(s,i,r,t)*chiNTM(s,i,r)
         *              (pmcif0(s,i,r)*xw0(s,i,r))) ;
      sam(r,"BoP","ntmY",t)
         = sum((i,s), ntmAVE.l(s,i,r,t)*pmcif.l(s,i,r,t)*xw.l(s,i,r,t)*(1-chiNTM(s,i,r))
         *              (pmcif0(s,i,r)*xw0(s,i,r))) ;
      sam(r,"regY","BoP",t)
         = sum((i,d), ntmAVE.l(r,i,d,t)*pmcif.l(r,i,d,t)*xw.l(r,i,d,t)*(1-chiNTM(r,i,d))
         *              (pmcif0(r,i,d)*xw0(r,i,d))) ;
   ) ;
) ;

sam(r,inv,"bop",t)   = savf.l(r,t) ;

*  Trade

sam(r,s,i,t)      = pmcif0(s,i,r)*pmcif.l(s,i,r,t)*xw0(s,i,r)*xw.l(s,i,r,t) ;
sam(r,"bop",s,t)  = sum(i, sam(r,s,i,t)) ;

sam(r,i,d,t)      = pefob0(r,i,d)*pefob.l(r,i,d,t)*xw0(r,i,d)*xw.l(r,i,d,t) ;
sam(r,d,"bop",t)  = sum(i, sam(r,i,d,t)) ;

loop(tmg,
   sam(r,tmg,"bop",t) = sum(i, sam(r,i,tmg,t)) ;
) ;

*  Convert back to scale
sam(r,is,js,t) = sam(r,is,js,t) / inScale ;

*  Calculate other post-simulation statistics

*  Output the results
if(ifCSV,
   put csv ;

   loop((r,is,js,t)$(sam(r,is,js,t) ne 0),
      put "sam", r.tl, is.tl, js.tl, years(t):4:0, sam(r,is,js,t) / ;
   ) ;

*  Production variables

   loop((r,a,t)$xpFlag(r,a),
      put "xp", r.tl, a.tl, "", years(t):4:0, ((xp0(r,a)*xp.l(r,a,t))/inScale) / ;
      put "nd", r.tl, a.tl, "", years(t):4:0, ((nd0(r,a)*nd.l(r,a,t))/inScale) / ;
      put "va", r.tl, a.tl, "", years(t):4:0, ((va0(r,a)*va.l(r,a,t))/inScale) / ;
      put "px", r.tl, a.tl, "", years(t):4:0, (px0(r,a)*px.l(r,a,t)) / ;
   ) ;

*  Supply variables

   loop((r,i,t)$xsFlag(r,i),
      put "xs",  r.tl, i.tl, "", years(t):4:0, (xs0(r,i)*xs.l(r,i,t)/inScale) / ;
      put "xds", r.tl, i.tl, "", years(t):4:0, (xds0(r,i)*xds.l(r,i,t)/inScale) / ;
      put "xet", r.tl, i.tl, "", years(t):4:0, (xet0(r,i)*xet.l(r,i,t)/inScale) / ;
      put "ps",  r.tl, i.tl, "", years(t):4:0, (ps0(r,i)*ps.l(r,i,t)) / ;
      put "pd",  r.tl, i.tl, "", years(t):4:0, (pd0(r,i)*pd.l(r,i,t)) / ;
      put "pet", r.tl, i.tl, "", years(t):4:0, (pet0(r,i)*pet.l(r,i,t)) / ;
      loop(aa$alphad(r,i,aa,t),
         put "xd",  r.tl, i.tl, aa.tl, years(t):4:0, ((xd0(r,i,aa)*xd.l(r,i,aa,t))/inScale) / ;
         put "pdp", r.tl, i.tl, aa.tl, years(t):4:0, (pdp0(r,i,aa)*pdp.l(r,i,aa,t)) / ;
         put "dintx", r.tl, i.tl, aa.tl, years(t):4:0, (dintx.l(r,i,aa,t)) / ;
      ) ;
   ) ;

   loop((r,a,i,t)$xFlag(r,a,i),
      put "prdtx", r.tl,a.tl, i.tl, years(t):4:0, (100*prdtx.l(r,a,i,t)) / ;
      put "p", r.tl,a.tl, i.tl, years(t):4:0, (p0(r,a,i)*p.l(r,a,i,t)) / ;
      put "x", r.tl,a.tl, i.tl, years(t):4:0, (x0(r,a,i)*x.l(r,a,i,t)/inScale) / ;
   ) ;

*  Factor variables

   loop((r,fp,a,t)$xfFlag(r,fp,a),
      put "xf",    r.tl, a.tl, fp.tl, years(t):4:0, (xf0(r,fp,a)*xf.l(r,fp,a,t)/inScale) / ;
      put "pf",    r.tl, a.tl, fp.tl, years(t):4:0, (pf0(r,fp,a)*pf.l(r,fp,a,t)) / ;
      put "pfy",   r.tl, a.tl, fp.tl, years(t):4:0, (pfy0(r,fp,a)*pfy.l(r,fp,a,t)) / ;
      put "fcttx", r.tl, a.tl, fp.tl, years(t):4:0, (100*fcttx.l(r,fp,a,t)) / ;
      put "fctts", r.tl, a.tl, fp.tl, years(t):4:0, (100*fctts.l(r,fp,a,t)) / ;
   ) ;

*  Income

   loop((r,t),
      loop(gy,
         put "ytax", r.tl, "", gy.tl, years(t):4:0, (ytax0(r,gy)*ytax.l(r,gy,t)/inScale) / ;
      ) ;
      put "ytax",    r.tl, "", "IND", years(t):4:0, (ytaxInd0(r)*ytaxInd.l(r,t)/inScale) / ;
      put "ytax",    r.tl, "", "TOT", years(t):4:0, (ytaxTot0(r)*ytaxTot.l(r,t)/inScale) / ;
      put "factY",   r.tl, "", "", years(t):4:0, (factY0(r)*factY.l(r,t)/inScale) / ;
      put "deprY",   r.tl, "", "", years(t):4:0,
         ((fdepr(r,t)*pi0(r)*pi.l(r,t)*kstock.l(r,t)*kstock0(r))/inScale) / ;
      put "regY",    r.tl, "", "", years(t):4:0, (regY0(r)*regY.l(r,t)/inScale) / ;
      put "yg",      r.tl, "", "", years(t):4:0, (yg0(r)*yg.l(r,t)/inScale) / ;
      put "yc",      r.tl, "", "", years(t):4:0, (yc0(r)*yc.l(r,t)/inScale) / ;
      put "rsav",    r.tl, "", "", years(t):4:0, (rsav0(r)*rsav.l(r,t)/inScale) / ;
      put "yi",      r.tl, "", "", years(t):4:0, (yi0(r)*yi.l(r,t)/inScale) / ;
      put "savf",    r.tl, "", "", years(t):4:0, (savf.l(r,t)/inScale) / ;
      put "uh",      r.tl, "", "", years(t):4:0, (sum(h, uh.l(r,h,t))) / ;
      put "ug",      r.tl, "", "", years(t):4:0, (ug.l(r,t)) / ;
      put "us",      r.tl, "", "", years(t):4:0, (us.l(r,t)) / ;
      put "u",       r.tl, "", "", years(t):4:0, (u.l(r,t)) / ;
      put "pop",     r.tl, "", "", years(t):4:0, (pop.l(r,t)) / ;
      put "pabs",    r.tl, "", "", years(t):4:0, (pabs0(r)*pabs.l(r,t)) / ;
      put "rgdpmp",  r.tl, "", "", years(t):4:0, (rgdpmp0(r)*rgdpmp.l(r,t)/inscale) / ;
      put "gdpmp",   r.tl, "", "", years(t):4:0, (gdpmp0(r)*gdpmp.l(r,t)/inscale) / ;
      put "gl",      r.tl, "", "", years(t):4:0, (100*gl.l(r,t)) / ;
   ) ;

*  Trade
   loop((s,i,d,t),
      put "xw",   s.tl, i.tl, d.tl, years(t):4:0, (xw0(s,i,d)*xw.l(s,i,d,t)/inScale) / ;
      put "pe",   s.tl, i.tl, d.tl, years(t):4:0, (pe0(s,i,d)*pe.l(s,i,d,t)) / ;
      put "xwmg", s.tl, i.tl, d.tl, years(t):4:0, (xwmg0(s,i,d)*xwmg.l(s,i,d,t)/inScale) / ;
      put "pwmg", s.tl, i.tl, d.tl, years(t):4:0, (pwmg0(s,i,d)*pwmg.l(s,i,d,t)) / ;
      loop(m, put "xmgm", s.tl, i.tl, d.tl, years(t):4:0, (xmgm0(m,s,i,d)*xmgm.l(m,s,i,d,t)) / ; ) ;
*     put "amw",  s.tl, i.tl, d.tl, years(t):4:0, (amw(s,i,d,t)) / ;
*     put "gw",   s.tl, i.tl, d.tl, years(t):4:0, (gw(s,i,d,t)) / ;
   ) ;

   loop((r,i,aa,t),
      put "xa",     r.tl, i.tl, aa.tl, years(t):4:0, ((xa0(r,i,aa)*xa.l(r,i,aa,t))/inScale) / ;
      put "pa",     r.tl, i.tl, aa.tl, years(t):4:0, (pa0(r,i,aa)*pa.l(r,i,aa,t)) / ;
      put "alphaa", r.tl, i.tl, aa.tl, years(t):4:0, (alphaa(r,i,aa,t)) / ;
*     put "alphad", r.tl, i.tl, aa.tl, years(t):4:0, (alphad(r,i,aa,t)) / ;
*     put "alpham", r.tl, i.tl, aa.tl, years(t):4:0, (alpham(r,i,aa,t)) / ;
   ) ;

   loop((r,i,h,t),
      put "eh",     r.tl, i.tl, h.tl, years(t):4:0, (eh.l(r,i,t)) / ;
      put "bh",     r.tl, i.tl, h.tl, years(t):4:0, (bh.l(r,i,t)) / ;
   ) ;

   loop((m,t),
      put "xtmg", "GBL", m.tl, "", years(t):4:0, (xtmg0(m)*xtmg.l(m,t)/inscale) / ;
      put "ptmg", "GBL", m.tl, "", years(t):4:0, (ptmg0(m)*ptmg.l(m,t)) / ;
   ) ;

*  Investment variables

   loop((r,t),
      put "arent",  r.tl, "", "", years(t):4:0, (100*arent0(r)*arent.l(r,t)) / ;
      put "rorc",   r.tl, "", "", years(t):4:0, (100*rorc0(r)*rorc.l(r,t)) / ;
      put "rore",   r.tl, "", "", years(t):4:0, (100*rore0(r)*rore.l(r,t)) / ;
      put "risk",   r.tl, "", "", years(t):4:0, (risk(r,t)) / ;
      put "kapend", r.tl, "", "", years(t):4:0, (kapend0(r)*kapend.l(r,t)/inScale) / ;
      put "kstock", r.tl, "", "", years(t):4:0, (kstock0(r)*kstock.l(r,t)/inScale) / ;
      put "xi",     r.tl, "", "", years(t):4:0, (xi0(r)*xi.l(r,t)/inScale) / ;
      loop(cap, put "pcap",   r.tl, "", "", years(t):4:0, (pft0(r,cap)*pft.l(r,cap,t)) / ; ) ;
   ) ;

   loop((r,fp,t)$xft.l(r,fp,t),
      put "xft",   r.tl, fp.tl, "", years(t):4:0, (xft0(r,fp)*xft.l(r,fp,t)/inscale) / ;
      put "pft",   r.tl, fp.tl, "", years(t):4:0, (pft0(r,fp)*pft.l(r,fp,t)) / ;
   ) ;

   loop(t,
      put "rorg",   "GBL", "", "", years(t):4:0, (100*rorg0*rorg.l(t)) / ;
   ) ;

*  Equivalent variation

   loop((r,t),
      loop(h,
         put "EVP", r.tl, "", "", years(t):4:0, (ev0(r,h)*ev.l(r,h,t)/inscale) / ;
      ) ;
      loop(t0,
         put "EVG", r.tl, "", "", years(t):4:0, (xg0(r)*pg0(r)*xg.l(r,t)*pg.l(r,t0)/inscale) / ;
         put "EVI", r.tl, "", "", years(t):4:0, (xi0(r)*pi0(r)*xi.l(r,t)*pi.l(r,t0)/inscale) / ;
         put "EVS", r.tl, "", "", years(t):4:0,
            ((rsav0(r)*rsav.l(r,t)/psave.l(r,t))*psave.l(r,t0)/inscale) / ;
      ) ;
   ) ;

   $$iftheni "%simType%" == "RcvDyn"
      if(1,
         loop((r,tranche,t),
            put "PopScen", r.tl, tranche.tl, "", years(t):4:0,
               (popScen("%POPSCEN%", r, tranche, t)) / ;
         ) ;
         loop((r,t),
            put "GDPScen", r.tl, "", "", years(t):4:0,
               gdpScen("%SSPMOD%","%SSPSCEN%","GDP",r,t) / ;
         ) ;
      ) ;
   $$endif

   if(1,
      loop(r,
         put "save",  r.tl, "", "", (2011):4:0, (save(r)) / ;
         put "vdep",  r.tl, "", "", (2011):4:0, (vdep(r)) / ;
         loop(fp,
            loop(a0,
               put "evfp", r.tl, fp.tl, a0.tl, (2011):4:0, (evfp(fp,a0,r)) / ;
               put "evfb",  r.tl, fp.tl, a0.tl, (2011):4:0, (evfb(fp,a0,r)) / ;
               put "evos", r.tl, fp.tl, a0.tl, (2011):4:0, (evos(fp,a0,r)) / ;
               put "fbep", r.tl, fp.tl, a0.tl, (2011):4:0, (fbep(fp,a0,r)) / ;
               put "ftrv", r.tl, fp.tl, a0.tl, (2011):4:0, (ftrv(fp,a0,r)) / ;
            ) ;
         ) ;
         loop((i0,a0),
            put "vdfp", r.tl, i0.tl, a0.tl, (2011):4:0, (vdfp(i0,a0,r)) / ;
            put "vdfb", r.tl, i0.tl, a0.tl, (2011):4:0, (vdfb(i0,a0,r)) / ;
            put "vmfp", r.tl, i0.tl, a0.tl, (2011):4:0, (vmfp(i0,a0,r)) / ;
            put "vmfb", r.tl, i0.tl, a0.tl, (2011):4:0, (vmfb(i0,a0,r)) / ;
            put "maks", r.tl, i0.tl, a0.tl, (2011):4:0, (maks(i0,a0,r)) / ;
            put "makb", r.tl, i0.tl, a0.tl, (2011):4:0, (makb(i0,a0,r)) / ;
         ) ;
         loop(i0,
            put "vdpp", r.tl, i0.tl, "", (2011):4:0, (vdpp(i0,r)) / ;
            put "vmpp", r.tl, i0.tl, "", (2011):4:0, (vmpp(i0,r)) / ;
            put "vdpb", r.tl, i0.tl, "", (2011):4:0, (vdpb(i0,r)) / ;
            put "vmpb", r.tl, i0.tl, "", (2011):4:0, (vmpb(i0,r)) / ;
            put "vdgp", r.tl, i0.tl, "", (2011):4:0, (vdgp(i0,r)) / ;
            put "vmgp", r.tl, i0.tl, "", (2011):4:0, (vmgp(i0,r)) / ;
            put "vdgb", r.tl, i0.tl, "", (2011):4:0, (vdgb(i0,r)) / ;
            put "vmgb", r.tl, i0.tl, "", (2011):4:0, (vmgb(i0,r)) / ;
            put "vdip", r.tl, i0.tl, "", (2011):4:0, (vdip(i0,r)) / ;
            put "vmip", r.tl, i0.tl, "", (2011):4:0, (vmip(i0,r)) / ;
            put "vdib", r.tl, i0.tl, "", (2011):4:0, (vdib(i0,r)) / ;
            put "vmib", r.tl, i0.tl, "", (2011):4:0, (vmib(i0,r)) / ;
            put "vst",  r.tl, i0.tl, "", (2011):4:0, (vst(i0,r)) / ;
         ) ;
         loop((i0,d),
            put "vxsb",  r.tl, i0.tl, d.tl, (2011):4:0, (vxsb(i0,r,d)) / ;
            put "vfob",  r.tl, i0.tl, d.tl, (2011):4:0, (vfob(i0,r,d)) / ;
            put "vmsb",  r.tl, i0.tl, d.tl, (2011):4:0, (vmsb(i0,r,d)) / ;
            put "vcif",  r.tl, i0.tl, d.tl, (2011):4:0, (vcif(i0,r,d)) / ;
         ) ;
      ) ;
   ) ;
) ;
