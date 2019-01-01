* ------------------------------------------------------------------------------
*
*  Calculate post-simulation results
*
* ------------------------------------------------------------------------------

*  SAM calculation

*  Domestic production

sam(r,i,aa,t)      = pd.l(r,i,t)*xd.l(r,i,aa,t)/xScale(r,aa) + pmt.l(r,i,t)*xm.l(r,i,aa,t)/xScale(r,aa) ;
sam(r,"itax",aa,t) = sum(i, dintx.l(r,i,aa,t)*pd.l(r,i,t)*xd.l(r,i,aa,t)/xScale(r,aa)
                   +   mintx.l(r,i,aa,t)*pmt.l(r,i,t)*xm.l(r,i,aa,t)/xScale(r,aa)) ;
sam(r,fp,a,t)      = pf.l(r,fp,a,t)*xf.l(r,fp,a,t)/xScale(r,a) ;
sam(r,"vtax",a,t)  = sum(fp, fcttx.l(r,fp,a,t)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)/xScale(r,a)) ;
sam(r,"vsub",a,t)  = sum(fp, fctts.l(r,fp,a,t)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)/xScale(r,a)) ;

sam(r,a,i,t)$xFlag(r,a,i) = p.l(r,a,i,t)*x.l(r,a,i,t) ;
sam(r,"ptax",i,t)  = sum(a, prdtx.l(r,a,i,t)*p.l(r,a,i,t)*x.l(r,a,i,t)) ;

*  Income distribution
sam(r,h,fp,t)        = sum(a, (1-kappaf.l(r,fp,a,t))*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)/xScale(r,a)) ;
sam(r,"dtax",fp,t)   = sum(a, kappaf.l(r,fp,a,t)*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)/xScale(r,a)) ;
sam(r,gov,"vsub",t)  = sum(a, sam(r,"vsub",a,t)) ;
sam(r,gov,"vtax",t)  = sum(a, sam(r,"vtax",a,t)) ;
sam(r,"etax",i,t)    = sum(rp, exptx.l(r,i,rp,t)*pe.l(r,i,rp,t)*xw.l(r,i,rp,t)) ;
sam(r,"mtax",i,t)    = sum(rp, imptx.l(rp,i,r,t)*pmcif.l(rp,i,r,t)*xw.l(rp,i,r,t)) ;
sam(r,"ntmY",i,t)    = sum(rp, ntmAVE.l(rp,i,r,t)*pmcif.l(rp,i,r,t)*xw.l(rp,i,r,t)) ;
sam(r,gov,"ntmY",t)  = ntmY.l(r,t) ;
sam(r,gov,"etax",t)  = sum(j, sam(r,"etax",j,t)) ;
sam(r,gov,"mtax",t)  = sum(j, sam(r,"mtax",j,t)) ;
sam(r,gov,"ptax",t)  = sum(i, sam(r,"ptax",i,t)) ;
sam(r,gov,"itax",t)  = sum(aa, sam(r,"itax",aa,t)) ;
sam(r,gov,"dtax",t)  = sum(js, sam(r,"dtax",js,t)) ;
sam(r,inv,h,t)       = rsav.l(r,t) ;
sam(r,"depry",h,t)   = pi.l(r,t)*kstock.l(r,t)*depr(r,t) ;
sam(r,inv,"depry",t) = pi.l(r,t)*kstock.l(r,t)*depr(r,t) ;
sam(r,inv,"bop",t)   = savf.l(r,t) ;

sam(r,gov,h,t)       = yg.l(r,t) - ntmY.l(r,t) - ytaxTot.l(r,t) ;

*  Trade

sam(r,rp,i,t)     = pmcif.l(rp,i,r,t)*xw.l(rp,i,r,t) ;
sam(r,"bop",rp,t) = sum(i, sam(r,rp,i,t)) ;

sam(r,i,rp,t)     = pefob.l(r,i,rp,t)*xw.l(r,i,rp,t) ;
sam(r,rp,"bop",t) = sum(i, sam(r,i,rp,t)) ;

loop(tmg,
   sam(r,tmg,"bop",t) = sum(i, sam(r,i,tmg,t)) ;
) ;

*  Convert back to scale
sam(r,is,js,t) = sam(r,is,js,t) / inScale ;

*  Calculate other post-simulation statistics

$macro abs_m(agent,tp,tq)  (sum((i,fd)$sameas(agent,fd), pa.l(r,i,fd,tp)*xa.l(r,i,fd,tq)))
$macro exp_m(tp,tq)        (sum((i,d), pefob.l(r,i,d,tp)*xw.l(r,i,d,tq)))
$macro texp_m(tp,tq)       (sum((i,d), pefob.l(r,i,d,tp)*xw.l(r,i,d,tq)) + sum((i,tmg), pa.l(r,i,tmg,tp)*xa.l(r,i,tmg,tq)))
$macro imp_m(tp,tq)        (sum((i,s), pmcif.l(s,i,r,tp)*xw.l(s,i,r,tq)))

loop(t,
   macroVal(r,fdn,t)    = abs_m(fdn, t, t) ;
   macroVal(r,"exp",t)  = exp_m(t,t) ;
   macroVal(r,"texp",t) = texp_m(t,t) ;
   macroVal(r,"imp",t)  = imp_m(t,t) ;

   if(t0(t),
      macroVol(r,nipa,t) = macroVal(r,nipa,t) ;
      macroPrc(r,nipa,t) = 100 ;
   else
      $$iftheni "%simType%" == "compStat"
         macroVol(r,fdn,t)    = sum(t0, macroVol(r,fdn,t0)
                              *   sqrt((macroVal(r,fdn,t)/macroVal(r,fdn,t0))*(abs_m(fdn,t0,t)/abs_m(fdn,t,t0)))) ;
         macroVol(r,"exp",t)  = sum(t0, macroVol(r,"exp",t0)
                              *   sqrt((macroVal(r,"exp",t)/macroVal(r,"exp",t0))*(exp_m(t0,t)/exp_m(t,t0)))) ;
         macroVol(r,"texp",t) = sum(t0, macroVol(r,"texp",t0)
                              *   sqrt((macroVal(r,"texp",t)/macroVal(r,"texp",t0))*(texp_m(t0,t)/texp_m(t,t0)))) ;
         macroVol(r,"imp",t)  = sum(t0, macroVol(r,"imp",t0)
                              *   sqrt((macroVal(r,"imp",t)/macroVal(r,"imp",t0))*(imp_m(t0,t)/imp_m(t,t0)))) ;
      $$else
         macroVol(r,fdn,t)    = macroVol(r,fdn,t-1)
                              *   sqrt((macroVal(r,fdn,t)/macroVal(r,fdn,t-1))*(abs_m(fdn,t-1,t)/abs_m(fdn,t,t-1))) ;
         macroVol(r,"exp",t)  = macroVol(r,"exp",t-1)
                              *   sqrt((macroVal(r,"exp",t)/macroVal(r,"exp",t-1))*(exp_m(t-1,t)/exp_m(t,t-1))) ;
         macroVol(r,"texp",t) = macroVol(r,"texp",t-1)
                              *   sqrt((macroVal(r,"texp",t)/macroVal(r,"texp",t-1))*(texp_m(t-1,t)/texp_m(t,t-1))) ;
         macroVol(r,"imp",t)  = macroVol(r,"imp",t-1)
                              *   sqrt((macroVal(r,"imp",t)/macroVal(r,"imp",t-1))*(imp_m(t-1,t)/imp_m(t,t-1))) ;
      $$endif
   ) ;
   macroPrc(r,nipa,t)$macroVol(r,nipa,t) = macroVal(r,nipa,t)/macroVol(r,nipa,t) ;
) ;

*  Output the results
if(ifCSV,
   put csv ;

   loop((r,is,js,t)$(sam(r,is,js,t) ne 0),
      put "sam", r.tl, is.tl, js.tl, years(t):4:0, sam(r,is,js,t) / ;
   ) ;

*  Production variables

   loop((r,a,t)$xpFlag(r,a),
      put "xp", r.tl, a.tl, "", years(t):4:0, ((xp.l(r,a,t)/xScale(r,a))/inScale) / ;
      put "nd", r.tl, a.tl, "", years(t):4:0, ((nd.l(r,a,t)/xScale(r,a))/inScale) / ;
      put "va", r.tl, a.tl, "", years(t):4:0, ((va.l(r,a,t)/xScale(r,a))/inScale) / ;
      put "px", r.tl, a.tl, "", years(t):4:0, px.l(r,a,t) / ;
   ) ;

*  Supply variables

   loop((r,i,t)$xsFlag(r,i),
      put "xs",  r.tl, i.tl, "", years(t):4:0, (xs.l(r,i,t)/inScale) / ;
      put "xds", r.tl, i.tl, "", years(t):4:0, (xds.l(r,i,t)/inScale) / ;
      put "xet", r.tl, i.tl, "", years(t):4:0, (xet.l(r,i,t)/inScale) / ;
      put "ps",  r.tl, i.tl, "", years(t):4:0, ps.l(r,i,t) / ;
      put "pd",  r.tl, i.tl, "", years(t):4:0, pd.l(r,i,t) / ;
      put "pet", r.tl, i.tl, "", years(t):4:0, pet.l(r,i,t) / ;
      loop(aa$alphad(r,i,aa,t),
         put "xd",  r.tl, i.tl, aa.tl, years(t):4:0, ((xd.l(r,i,aa,t)/xScale(r,aa))/inScale) / ;
         put "pdp", r.tl, i.tl, aa.tl, years(t):4:0, (pdp.l(r,i,aa,t)) / ;
         put "dintx", r.tl, i.tl, aa.tl, years(t):4:0, (dintx.l(r,i,aa,t)) / ;
      ) ;
   ) ;

   loop((r,a,i,t)$xFlag(r,a,i),
      put "prdtx", r.tl,a.tl, i.tl, years(t):4:0, (100*prdtx.l(r,a,i,t)) / ;
      put "p", r.tl,a.tl, i.tl, years(t):4:0, (p.l(r,a,i,t)) / ;
      put "x", r.tl,a.tl, i.tl, years(t):4:0, (x.l(r,a,i,t)/inScale) / ;
   ) ;

*  Factor variables

   loop((r,fp,a,t)$xfFlag(r,fp,a),
      put "xf",    r.tl, a.tl, fp.tl, years(t):4:0, ((xf.l(r,fp,a,t)/xScale(r,a))/inScale) / ;
      put "pf",    r.tl, a.tl, fp.tl, years(t):4:0, (pf.l(r,fp,a,t)) / ;
      put "pfy",   r.tl, a.tl, fp.tl, years(t):4:0, (pfy.l(r,fp,a,t)) / ;
      put "fcttx", r.tl, a.tl, fp.tl, years(t):4:0, (100*fcttx.l(r,fp,a,t)) / ;
      put "fctts", r.tl, a.tl, fp.tl, years(t):4:0, (100*fctts.l(r,fp,a,t)) / ;
   ) ;

*  Income

   loop((r,t),
      loop(gy,
         put "ytax", r.tl, "", gy.tl, years(t):4:0, (ytax.l(r,gy,t)/inScale) / ;
      ) ;
      put "ytax",    r.tl, "", "IND", years(t):4:0, (ytaxInd.l(r,t)/inScale) / ;
      put "ytax",    r.tl, "", "TOT", years(t):4:0, (ytaxTot.l(r,t)/inScale) / ;
      put "factY",   r.tl, "", "", years(t):4:0, (factY.l(r,t)/inScale) / ;
      put "deprY",   r.tl, "", "", years(t):4:0, ((fdepr(r,t)*pi.l(r,t)*kstock.l(r,t))/inScale) / ;
      put "regY",    r.tl, "", "", years(t):4:0, (regY.l(r,t)/inScale) / ;
      put "yg",      r.tl, "", "", years(t):4:0, (yg.l(r,t)/inScale) / ;
      put "yc",      r.tl, "", "", years(t):4:0, (yc.l(r,t)/inScale) / ;
      put "rsav",    r.tl, "", "", years(t):4:0, (rsav.l(r,t)/inScale) / ;
      put "yi",      r.tl, "", "", years(t):4:0, (yi.l(r,t)/inScale) / ;
      put "savf",    r.tl, "", "", years(t):4:0, (savf.l(r,t)/inScale) / ;
      put "uh",      r.tl, "", "", years(t):4:0, (sum(h, uh.l(r,h,t))) / ;
      put "ug",      r.tl, "", "", years(t):4:0, (ug.l(r,t)) / ;
      put "us",      r.tl, "", "", years(t):4:0, (us.l(r,t)) / ;
      put "u",       r.tl, "", "", years(t):4:0, (u.l(r,t)) / ;
      loop(h$(card(h) eq 1), put "ev", r.tl, "", "", years(t):4:0, (ev.l(r,h,t)/inScale) / ; ) ;
      put "pop",     r.tl, "", "", years(t):4:0, (pop.l(r,t)) / ;
      put "pabs",    r.tl, "", "", years(t):4:0, (pabs.l(r,t)) / ;
      put "rgdpmp",  r.tl, "", "", years(t):4:0, (rgdpmp.l(r,t)/inscale) / ;
      put "gdpmp",   r.tl, "", "", years(t):4:0, (gdpmp.l(r,t)/inscale) / ;
      put "gl",      r.tl, "", "", years(t):4:0, (100*gl.l(r,t)) / ;
   ) ;

*  Macro

   loop((r,t),
      loop(nipa$macroVal(r,nipa,t),
         put "NIPA",  r.tl, nipa.tl, "", years(t):4:0, (macroVal(r,nipa,t)/inscale) / ;
         put "RNIPA", r.tl, nipa.tl, "", years(t):4:0, (macroVol(r,nipa,t)/inscale) / ;
         put "PNIPA", r.tl, nipa.tl, "", years(t):4:0, (100*macroPrc(r,nipa,t)) / ;
      ) ;
   ) ;

*  Trade
   loop((r,i,rp,t),
      put "xw",   r.tl, i.tl, rp.tl, years(t):4:0, (xw.l(r,i,rp,t)/inScale) / ;
      put "pe",   r.tl, i.tl, rp.tl, years(t):4:0, (pe.l(r,i,rp,t)) / ;
      put "xwmg", r.tl, i.tl, rp.tl, years(t):4:0, (xwmg.l(r,i,rp,t)/inScale) / ;
      put "pwmg", r.tl, i.tl, rp.tl, years(t):4:0, (pwmg.l(r,i,rp,t)) / ;
      loop(m, put "xmgm", r.tl, i.tl, rp.tl, years(t):4:0, (xmgm.l(m,r,i,rp,t)) / ; ) ;
*     put "amw",  r.tl, i.tl, rp.tl, years(t):4:0, (amw(r,i,rp,t)) / ;
*     put "gw",   r.tl, i.tl, rp.tl, years(t):4:0, (gw(r,i,rp,t)) / ;
   ) ;

   loop((r,i,aa,t),
      put "xa",     r.tl, i.tl, aa.tl, years(t):4:0, ((xa.l(r,i,aa,t)/xScale(r,aa))/inScale) / ;
      put "pa",     r.tl, i.tl, aa.tl, years(t):4:0, (pa.l(r,i,aa,t)) / ;
      put "alphaa", r.tl, i.tl, aa.tl, years(t):4:0, (alphaa(r,i,aa,t)) / ;
*     put "alphad", r.tl, i.tl, aa.tl, years(t):4:0, (alphad(r,i,aa,t)) / ;
*     put "alpham", r.tl, i.tl, aa.tl, years(t):4:0, (alpham(r,i,aa,t)) / ;
   ) ;

   loop((r,i,h,t),
      put "eh",     r.tl, i.tl, h.tl, years(t):4:0, (eh.l(r,i,t)) / ;
      put "bh",     r.tl, i.tl, h.tl, years(t):4:0, (bh.l(r,i,t)) / ;
   ) ;

   loop((m,t),
      put "xtmg", "GBL", m.tl, "", years(t):4:0, (xtmg.l(m,t)/1e-6) / ;
      put "ptmg", "GBL", m.tl, "", years(t):4:0, (ptmg.l(m,t)) / ;
   ) ;

*  Investment variables

   loop((r,t),
      put "arent",  r.tl, "", "", years(t):4:0, (100*arent.l(r,t)) / ;
      put "rorc",   r.tl, "", "", years(t):4:0, (100*rorc.l(r,t)) / ;
      put "rore",   r.tl, "", "", years(t):4:0, (100*rore.l(r,t)) / ;
      put "risk",   r.tl, "", "", years(t):4:0, (risk(r,t)) / ;
      put "kapend", r.tl, "", "", years(t):4:0, (kapend.l(r,t)/inScale) / ;
      put "kstock", r.tl, "", "", years(t):4:0, (kstock.l(r,t)/inScale) / ;
      put "xi",     r.tl, "", "", years(t):4:0, (xi.l(r,t)/inScale) / ;
      loop(cap, put "pcap",   r.tl, "", "", years(t):4:0, (pft.l(r,cap,t)) / ; ) ;
   ) ;

   loop((r,fp,t)$xft.l(r,fp,t),
      put "xft",   r.tl, fp.tl, "", years(t):4:0, (xft.l(r,fp,t)/inscale) / ;
      put "pft",   r.tl, fp.tl, "", years(t):4:0, (pft.l(r,fp,t)) / ;
   ) ;

   loop(t,
      put "rorg",   "GBL", "", "", years(t):4:0, (100*rorg.l(t)) / ;
   ) ;

   $$iftheni "%simType%" == "RcvDyn"
      if(1,
         loop((r,tranche,t),
            put "PopScen", r.tl, tranche.tl, "", years(t):4:0, (popScen("%POPSCEN%", r, tranche, t)) / ;
         ) ;
         loop((r,t),
            put "GDPScen", r.tl, "", "", years(t):4:0, gdpScen("%SSPMOD%","%SSPSCEN%","GDP",r,t) / ;
         ) ;
      ) ;
   $$endif

   if(0,
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
         loop((i0,rp),
            put "vxsb",  r.tl, i0.tl, rp.tl, (2011):4:0, (vxsb(i0,r,rp)) / ;
            put "vfob",  r.tl, i0.tl, rp.tl, (2011):4:0, (vfob(i0,r,rp)) / ;
            put "vmsb",  r.tl, i0.tl, rp.tl, (2011):4:0, (vmsb(i0,r,rp)) / ;
            put "vcif",  r.tl, i0.tl, rp.tl, (2011):4:0, (vcif(i0,r,rp)) / ;
         ) ;
      ) ;
   ) ;
) ;
