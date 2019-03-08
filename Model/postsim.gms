$include "sam.gms"

$macro putv0(varName, suffix, oScale) put sim.tl, "&VarName", r.tl, "", "", "", PUTYEAR, (oScale*(&varName.l(r,t))*(&varName&suffix(r))) / ;
$macro putv1(varName, i__1, suffix, oScale) put sim.tl, "&VarName", r.tl, i__1.tl, "", "", PUTYEAR, (oScale*(&varName.l(r,i__1,t))*(&varName&suffix(r,i__1))) / ;
$macro putv2(varName, i__1, i__2, suffix, oScale) put sim.tl, "&VarName", r.tl, i__1.tl, i__2.tl, "", PUTYEAR, (oScale*(&varName.l(r,i__1,i__2,t))*(&varName&suffix(r,i__1,i__2))) / ;
$macro putv3(varName, i__1, i__2, i__3, suffix, oScale) put sim.tl, "&VarName", r.tl, i__1.tl, i__2.tl, i__3.tl, PUTYEAR, (oScale*(&varName.l(r,i__1,i__2,i__3,t))*(&varName&suffix(r,i__1,i__2,i__3))) / ;
$macro putv2v(varName, i__1, i__2, suffix, oScale) put sim.tl, "&VarName", r.tl, i__1.tl, i__2.tl, "", PUTYEAR, (oScale*(&varName.l(r,i__1,i__2,t))*(&varName&suffix(r,i__1))) / ;

*  Calculate aggregate labor share in value added

aggLabShr(r,t) = sum((a,f), pfp.l(r,f,a,t)*xf.l(r,f,a,t)*pfp0(r,f,a)*xf0(r,f,a)) ;
agglabShr(r,t)$aggLabShr(r,t) =
   100*sum(a, sum(l, pfp.l(r,l,a,t)*xf.l(r,l,a,t)*pfp0(r,l,a)*xf0(r,l,a)))
                              / aggLabShr(r,t) ;

if(ifSAM,
   if(ifSAMAppend,
      fsam.ap = 1 ;
      put fsam ;
   else
      fsam.ap = 0 ;
      put fsam ;
      put "Sim,Var,Region,rlab,clab,qual,Time,value" / ;
   ) ;
   fsam.pc=5 ;
   fsam.nd=9 ;
   loop((sim,t,r,is,js)$sam(r,is,js,t),
      put sim.tl,"sam",r.tl,is.tl,js.tl,"",PUTYEAR,(outScale*sam(r,is,js,t)) / ;
   ) ;
   loop((sim,t),
      loop((r,a,v),
         putv1(xp,a,0,outScale)
         putv1(px,a,0,1)
      ) ;
      loop((r,a,v),
         putv2v(xpv,a,v,0,outScale)
         putv2v(kv,a,v,0,outScale)
         putv2v(pxv,a,v,0,1)
         putv2v(kxRat,a,v,0,1)
         putv2v(pk,a,v,0,1)
      ) ;
      loop((r,i,aa),
         putv2(pa, i, aa, 0, 1)
         putv2(xa, i, aa, 0, outscale)
         put sim.tl,"patax",r.tl,i.tl,aa.tl,"",PUTYEAR,(patax.l(r,i,aa,t)) / ;
         put sim.tl,"gammaeda",r.tl,i.tl,aa.tl,"",PUTYEAR,(gammaeda(r,i,aa)) / ;
      ) ;

      loop((r,k,h),
         putv2(xc,k,h,0,outScale)
         putv2(pc,k,h,0,1)
         putv2(hshr,k,h,0,100)
         put sim.tl,"etah",r.tl,k.tl,"","",PUTYEAR,(etah.l(r,k,h,t)) / ;
         loop(kp, put sim.tl,"epsh",r.tl,k.tl,kp.tl,"",PUTYEAR,(epsh.l(r,k,kp,h,t)) / ; ) ;
         if(%utility% ne CDE,
            put sim.tl,"muc",r.tl,k.tl,"","",PUTYEAR,(muc0(r,k,h)*muc.l(r,k,h,t)) / ;
            put sim.tl,"gammac",r.tl,k.tl,"","",PUTYEAR,(gammac.l(r,k,h,t)) / ;
         ) ;
         if(%utility% eq CDE,
            put sim.tl,"eh",r.tl,k.tl,"","",PUTYEAR,(eh.l(r,k,h,t)) / ;
            put sim.tl,"bh",r.tl,k.tl,"","",PUTYEAR,(bh.l(r,k,h,t)) / ;
            putv2(zcons,k,h,0,1)
         ) ;
      ) ;
      loop((r,h),
         putv1(u,h,0,1)
         putv1(ev,h,0,outScale)

         if(%utility% eq ELES,
            putv1(supy,h,0,outScale)
            put sim.tl,"mus",r.tl,"sav","","",PUTYEAR,(mus.l(r,h,t)) / ;
         ) ;
      ) ;

      loop(r,
         putv0(pop,0,(1/popScale))
         putv0(gdpmp,0,outScale)
         putv0(rgdpmp,0,outScale)
         putv0(pgdpmp,0,1)
         putv0(pfact,0,1)
         putv0(rgdppc,0,(popScale/inScale))
         putv0(trent,0,1)
         putv0(tkaps,0,outScale)
         putv0(kstock,0,outScale)
         putv0(deprY,0,outScale)
         putv0(gdpmp,0,outScale)
         putv0(gdpmp,0,outScale)
         put sim.tl,"savg",r.tl,"","","",PUTYEAR,(outscale*savg.l(r,t)) / ;
         put sim.tl,"savf",r.tl,"","","",PUTYEAR,(outscale*savf.l(r,t)) / ;
         put sim.tl,"kstocke",r.tl,"","","",PUTYEAR,(outscale*kstocke.l(r,t)*kstock0(r)) / ;
         putv0(ror,0,1)
         putv0(rorc,0,1)
         putv0(rore,0,1)
         put sim.tl,"devRoR",r.tl,"","","",PUTYEAR,(devRoR.l(r,t)) / ;
         put sim.tl,"grK",r.tl,"","","",PUTYEAR,(grK.l(r,t)) / ;
         loop(h,
            putv1(savh,h,0,outScale)
            put sim.tl,"aps",r.tl,"","","",PUTYEAR,(aps.l(r,h,t)) / ;
         ) ;
         put sim.tl,"gl",r.tl,"","","",PUTYEAR,(gl.l(r,t)) / ;
         loop(fd,
            putv1(xfd,fd,0,outScale)
            putv1(yfd,fd,0,outScale)
            putv1(pfd,fd,0,1)
            put sim.tl, "rgdpshr", r.tl, fd.tl, "", "", PUTYEAR, (100*xfd.l(r,fd,t)/rgdpmp.l(r,t)) / ;
            put sim.tl, "gdpshr", r.tl, fd.tl,  "", "", PUTYEAR, (100*yfd.l(r,fd,t)/gdpmp.l(r,t)) / ;
         ) ;
         loop(fdc,
            putv1(evf,fdc,0,outScale)
         ) ;

         if(1,
            loop((i,rp),
               putv2(pe,i,rp,0,1)
               putv2(pwe,i,rp,0,1)
               putv2(pwm,i,rp,0,1)
               putv2(pwmg,i,rp,0,1)
               putv2(pdm,i,rp,0,1)
               putv2(xw,i,rp,0,outScale)
               put sim.tl, "gammaew", r.tl, i.tl, rp.tl,"", PUTYEAR, (gammaew(r,i,rp)) / ;
               put sim.tl, "mtax", r.tl, i.tl, rp.tl,"", PUTYEAR, (mtax.l(r,i,rp,t)) / ;
               put sim.tl, "etax", r.tl, i.tl, rp.tl,"", PUTYEAR, (etax.l(r,i,rp,t)) / ;
               put sim.tl, "tmarg", r.tl, i.tl, rp.tl,"", PUTYEAR, (tmarg.l(r,i,rp,t)) / ;
               put sim.tl, "xwFlag", r.tl, i.tl, rp.tl,"", PUTYEAR, (xwFlag(r,i,rp)) / ;
            ) ;
            loop(i,
               putv1(pet,i,0,1)
               putv1(xet,i,0,outScale)
               putv1(xat,i,0,outScale)
               putv1(xs,i,0,outScale)
               putv1(xdt,i,0,outScale)
               putv1(xmt,i,0,outScale)
               putv1(pdt,i,0,1)
               putv1(pat,i,0,1)
               putv1(ps,i,0,1)
               if(not MRIO,
                  putv1(pmt,i,0,1)
               else
                  loop(aa,
                     putv2(pma,i,aa,0,1)
                  ) ;
               ) ;
               loop(a,
                  putv2(x,a,i,0,outScale)
                  putv2(p,a,i,0,outScale)
               ) ;
            ) ;
            loop(e,
               put sim.tl, "xatNRG", r.tl, e.tl, "","", PUTYEAR, (xatNRG(r,e,t)*outScale) / ;
               put sim.tl, "gammaesd", r.tl, e.tl, "","", PUTYEAR, (gammaesd(r,e)) / ;
               put sim.tl, "gammaese", r.tl, e.tl, "","", PUTYEAR, (gammaese(r,e)) / ;
            ) ;
            loop(fuel,
               loop(aa,
                  put sim.tl, "nrgComb", r.tl, fuel.tl, aa.tl,"", PUTYEAR, (phiNrg(r,fuel,aa)*XA0(r,fuel,aa)*xa.l(r,fuel,aa,t)*outScale) / ;
               ) ;
            ) ;

         ) ;

         if(ifDyn,
            put sim.tl,"grrgdppc",r.tl,"","","",PUTYEAR,(grrgdppc.l(r,t)) / ;
            loop(tranche,
               put sim.tl, "popScen", r.tl, tranche.tl, "" ,"", PUTYEAR, (popScen("%POPSCEN%", r, tranche, t)) / ;
            ) ;
            loop(var,
               put sim.tl, "gdpScen", r.tl, var.tl, "" ,"", PUTYEAR, (gdpScen("%SSPMOD%", "%SSPSCEN%", var, r, t)) / ;
            ) ;
         ) ;

         put sim.tl, "exp",  r.tl, "", "" ,"", PUTYEAR, (outscale*sum((i,rp), pwe0(r,i,rp)*xw0(r,i,rp)*pwe.l(r,i,rp,t)*xw.l(r,i,rp,t))) / ;
         put sim.tl, "rexp", r.tl, "", "" ,"", PUTYEAR, (outscale*sum((i,rp,t0), pwe0(r,i,rp)*xw0(r,i,rp)*pwe.l(r,i,rp,t0)*xw.l(r,i,rp,t))) / ;
         put sim.tl, "imp",  r.tl, "", "" ,"", PUTYEAR, (outscale*sum((i,rp), pwm0(rp,i,r)*xw0(rp,i,r)*pwm.l(rp,i,r,t)*lambdaw(rp,i,r,t)*xw.l(rp,i,r,t))) / ;
         put sim.tl, "rimp", r.tl, "", "" ,"", PUTYEAR, (outscale*sum((i,rp,t0), pwm0(rp,i,r)*xw0(rp,i,r)*pwm.l(rp,i,r,t0)*lambdaw(rp,i,r,t)*xw.l(rp,i,r,t))) / ;
         put sim.tl, "itt",  r.tl, "", "" ,"", PUTYEAR, (outscale*sum((img), pdt0(r,img)*xtt0(r,img)*pdt.l(r,img,t)*xtt.l(r,img,t))) / ;
         put sim.tl, "ritt", r.tl, "", "" ,"", PUTYEAR, (outscale*sum((img,t0), pdt0(r,img)*xtt0(r,img)*pdt.l(r,img,t0)*xtt.l(r,img,t))) / ;

         putv0(tls,0,(1/lscale)
         putv0(tland,0,outScale)
         loop(l,
            putv1(ls,l,0,(1/lscale))
            putv1(twage,l,0,1)
            putv1(urbprem,l,0,1)
            putv1(migr,l,0,(1/lscale))
            put sim.tl,"skillprem",r.tl,"",l.tl,"",PUTYEAR,(skillprem.l(r,l,t)) / ;
            loop(z,
               putv2(awagez,l,z,0,1)
               putv2(ewagez,l,z,0,1)
               putv2(resWage,l,z,0,1)
               putv2(lsz,l,z,0,(1/lscale))
               putv2(lsz,l,z,0,(1/lscale))
               put sim.tl,"uez",     r.tl,"",l.tl,z.tl,PUTYEAR,(100*uez.l(r,l,z,t)) / ;
               put sim.tl,"ueMinz",  r.tl,"",l.tl,z.tl,PUTYEAR,(100*ueMinz(r,l,z,t)) / ;
            ) ;
         ) ;

         loop(a,
            loop(f,
               putv2(pf,f,a,0,1)
               putv2(pfp,f,a,0,1)
               putv2(xf,f,a,0,1)
            ) ;
            loop(v, putv2v(pk,a,v,0,1) ) ;
         ) ;

         putv0(th2o,0,1e6)
         putv0(th2om,0,1e6)
         putv0(pth2o,0,1)
         loop(wbnd,
            putv1(h2obnd,wbnd,0,1e6)
            putv1(ph2obnd,wbnd,0,1)
         ) ;
      ) ;
      put sim.tl,"rorg", "GBL","","","", PUTYEAR,(rorg.l(t)*rorg0) / ;
      put sim.tl,"sw",   "GBL","","","", PUTYEAR,(sw.l(t)*sw0*outscale) / ;
      put sim.tl,"swt",  "GBL","","","", PUTYEAR,(swt.l(t)*swt0*outscale) / ;

      loop((r,em,is,aa)$emir(r,em,is,aa),
         putv3(emi, em, is, aa, 0, (1/cscale))
      ) ;
      loop((r,em)$ghg(em),
         if(ifCEQ,
            put sim.tl, "emiTot", r.tl, "CEQ",   "", em.tl, PUTYEAR, (emiTot0(r,em)*emiTot.l(r,em,t)/cscale) / ;
            put sim.tl, "emiTot", r.tl, "CO2EQ", "", em.tl, PUTYEAR, ((44/12)*emiTot0(r,em)*emiTot.l(r,em,t)/cscale) / ;
            put sim.tl, "emiTot", r.tl, "mt",    "", em.tl, PUTYEAR, ((44/12)*emiTot0(r,em)*emiTot.l(r,em,t)/(cscale*gwp(em))) / ;
         else
            put sim.tl, "emiTot", r.tl, "CO2EQ", "", em.tl, PUTYEAR, (emiTot0(r,em)*emiTot.l(r,em,t)/cscale) / ;
            put sim.tl, "emiTot", r.tl, "CEQ",   "", em.tl, PUTYEAR, ((12/44)*emiTot0(r,em)*emiTot.l(r,em,t)/cscale) / ;
            put sim.tl, "emiTot", r.tl, "mt",    "", em.tl, PUTYEAR, (emiTot0(r,em)*emiTot.l(r,em,t)/(cscale*gwp(em))) / ;
         ) ;
         if(emiQuota.l(r,em,t),
            if(ifCEQ,
               put sim.tl, "emiQuota", r.tl, "CEQ",   "", em.tl, PUTYEAR, (emiQuota.l(r,em,t)/cscale) / ;
               put sim.tl, "emiQuota", r.tl, "CO2EQ", "", em.tl, PUTYEAR, ((44/12)*emiQuota.l(r,em,t)/cscale) / ;
               put sim.tl, "emiQuota", r.tl, "mt",    "", em.tl, PUTYEAR, ((44/12)*emiQuota.l(r,em,t)/(cscale*gwp(em))) / ;
            else
               put sim.tl, "emiQuota", r.tl, "CO2EQ", "", em.tl, PUTYEAR, (emiQuota.l(r,em,t)/cscale) / ;
               put sim.tl, "emiQuota", r.tl, "CEQ",   "", em.tl, PUTYEAR, ((12/44)*emiQuota.l(r,em,t)/cscale) / ;
               put sim.tl, "emiQuota", r.tl, "mt",    "", em.tl, PUTYEAR, (emiQuota.l(r,em,t)/(cscale*gwp(em))) / ;
            ) ;
         ) ;
         if(emiTax.l(r,em,t),
            if(ifCEQ,
               put sim.tl, "emiTax", r.tl, "USD/tCEQ", "", em.tl, PUTYEAR,   (emitax.l(r,em,t)/escale) / ;
               put sim.tl, "emiTax", r.tl, "USD/tCO2EQ", "", em.tl, PUTYEAR, ((12/44)*emitax.l(r,em,t)/escale) / ;
            else
               put sim.tl, "emiTax", r.tl, "USD/tCEQ", "", em.tl, PUTYEAR,   ((44/12)*emitax.l(r,em,t)/escale) / ;
               put sim.tl, "emiTax", r.tl, "USD/tCO2EQ", "", em.tl, PUTYEAR, (emitax.l(r,em,t)/escale) / ;
            ) ;
         ) ;
      ) ;
      loop(em$ghg(em),
         if(ifCEQ,
            put sim.tl, "emiTot", "GBL", "CEQ",   "", em.tl, PUTYEAR, (emiGbl0(em)*emiGbl.l(em,t)/cscale) / ;
            put sim.tl, "emiTot", "GBL", "CO2EQ", "", em.tl, PUTYEAR, ((44/12)*emiGbl0(em)*emiGbl.l(em,t)/cscale) / ;
            put sim.tl, "emiTot", "GBL", "mt",    "", em.tl, PUTYEAR, ((44/12)*emiGbl0(em)*emiGbl.l(em,t)/(cscale*gwp(em))) / ;
         else
            put sim.tl, "emiTot", "GBL", "CO2EQ", "", em.tl, PUTYEAR, (emiGbl0(em)*emiGbl.l(em,t)/cscale) / ;
            put sim.tl, "emiTot", "GBL", "CEQ",   "", em.tl, PUTYEAR, ((12/44)*emiGbl0(em)*emiGbl.l(em,t)/cscale) / ;
            put sim.tl, "emiTot", "GBL", "mt",    "", em.tl, PUTYEAR, (emiGbl0(em)*emiGbl.l(em,t)/(cscale*gwp(em))) / ;
         ) ;
      ) ;
      loop((r,em)$nghg(em),
         put sim.tl, "emiTot", r.tl, "Gg", "", em.tl, PUTYEAR, (emiTot0(r,em)*emiTot.l(r,em,t)/cscale) / ;
      ) ;
      loop(em$nghg(em),
         put sim.tl, "emiTot", "GBL", "Gg", "", em.tl, PUTYEAR, (emiGbl0(em)*emiGbl.l(em,t)/cscale) / ;
      ) ;

      loop(img,
         put sim.tl, "ptmg", "GBL", img.tl, "", "", PUTYEAR, (ptmg0(img)*ptmg.l(img,t)) / ;
      ) ;

      if(1 and ord(t) eq 1,
         loop((r,e),
            put sim.tl, "nrgedp",  r.tl, e.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,e), nrgdp(i0,r))) / ;
            put sim.tl, "nrgmp",  r.tl, e.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,e), nrgmp(i0,r))) / ;
            put sim.tl, "nrgdg",  r.tl, e.tl, "gov" ,"", PUTYEAR, (sum(i0$mapi0(i0,e), nrgdg(i0,r))) / ;
            put sim.tl, "nrgmg",  r.tl, e.tl, "gov" ,"", PUTYEAR, (sum(i0$mapi0(i0,e), nrgmg(i0,r))) / ;
            put sim.tl, "nrgdi",  r.tl, e.tl, "inv" ,"", PUTYEAR, (sum(i0$mapi0(i0,e), nrgdi(i0,r))) / ;
            put sim.tl, "nrgmi",  r.tl, e.tl, "inv" ,"", PUTYEAR, (sum(i0$mapi0(i0,e), nrgmi(i0,r))) / ;
         ) ;
         loop((r,i),
            put sim.tl, "vdpp", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vdpp(i0,r))) / ;
            put sim.tl, "vdpb", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vdpb(i0,r))) / ;
            put sim.tl, "vmpp", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vmpp(i0,r))) / ;
            put sim.tl, "vmpb", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vmpb(i0,r))) / ;

            put sim.tl, "vdgp", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vdgp(i0,r))) / ;
            put sim.tl, "vdgb", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vdgb(i0,r))) / ;
            put sim.tl, "vmgp", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vmgp(i0,r))) / ;
            put sim.tl, "vmgb", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vmgb(i0,r))) / ;

            put sim.tl, "vdip", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vdip(i0,r))) / ;
            put sim.tl, "vdib", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vdib(i0,r))) / ;
            put sim.tl, "vmip", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vmip(i0,r))) / ;
            put sim.tl, "vmib", r.tl, i.tl, "hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vmib(i0,r))) / ;
         ) ;

         loop((r,e,a),
            put sim.tl, "nrgdf",  r.tl, e.tl, a.tl ,"", PUTYEAR, (sum((i0,a0)$(mapi0(i0,e) and mapa0(a0,a)), nrgdf(i0,a0,r))) / ;
            put sim.tl, "nrgmf",  r.tl, e.tl, a.tl ,"", PUTYEAR, (sum((i0,a0)$(mapi0(i0,e) and mapa0(a0,a)), nrgmf(i0,a0,r))) / ;
            ) ;
         loop((r,i,a),
            put sim.tl, "vdfp", r.tl, i.tl, a.tl ,"", PUTYEAR, (sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), vdfp(i0,a0,r))) / ;
            put sim.tl, "vdfb", r.tl, i.tl, a.tl ,"", PUTYEAR, (sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), vdfb(i0,a0,r))) / ;
            put sim.tl, "vmfp", r.tl, i.tl, a.tl ,"", PUTYEAR, (sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), vmfp(i0,a0,r))) / ;
            put sim.tl, "vmfb", r.tl, i.tl, a.tl ,"", PUTYEAR, (sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), vmfb(i0,a0,r))) / ;
         ) ;
         loop((r,i),
            loop(rp,
               put sim.tl, "vmsb", r.tl, i.tl, rp.tl ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vmsb(i0,r,rp))) / ;
               put sim.tl, "vcif", r.tl, i.tl, rp.tl ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vcif(i0,r,rp))) / ;
               put sim.tl, "vxsb", r.tl, i.tl, rp.tl ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vxsb(i0,r,rp))) / ;
               put sim.tl, "vfob", r.tl, i.tl, rp.tl ,"", PUTYEAR, (sum(i0$mapi0(i0,i), vfob(i0,r,rp))) / ;
            ) ;
         ) ;
         loop((r,e),
            loop(rp,
               put sim.tl, "exi",  r.tl, e.tl, rp.tl ,"", PUTYEAR, (sum(i0$mapi0(i0,e), exi(i0,r,rp))) / ;
            ) ;
         ) ;
         loop((r,fuel),
            loop(a,
               put sim.tl, "mdf", r.tl, fuel.tl, a.tl ,"", PUTYEAR, (sum((i0,a0)$(mapi0(i0,fuel) and mapa0(a0,a)), mdf(i0,a0,r))) / ;
               put sim.tl, "mmf", r.tl, fuel.tl, a.tl ,"", PUTYEAR, (sum((i0,a0)$(mapi0(i0,fuel) and mapa0(a0,a)), mmf(i0,a0,r))) / ;
            ) ;
            put sim.tl, "mdg", r.tl, fuel.tl, "Gov" ,"", PUTYEAR, (sum(i0$mapi0(i0,fuel), mdg(i0,r))) / ;
            put sim.tl, "mmg", r.tl, fuel.tl, "Gov" ,"", PUTYEAR, (sum(i0$mapi0(i0,fuel), mmg(i0,r))) / ;
            put sim.tl, "mdp", r.tl, fuel.tl, "Hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,fuel), mdp(i0,r))) / ;
            put sim.tl, "mmp", r.tl, fuel.tl, "Hhd" ,"", PUTYEAR, (sum(i0$mapi0(i0,fuel), mmp(i0,r))) / ;
            put sim.tl, "mdi", r.tl, fuel.tl, "Inv" ,"", PUTYEAR, (sum(i0$mapi0(i0,fuel), mdi(i0,r))) / ;
            put sim.tl, "mmi", r.tl, fuel.tl, "Inv" ,"", PUTYEAR, (sum(i0$mapi0(i0,fuel), mmi(i0,r))) / ;
         ) ;
         loop((r, emn),
            loop(a,
               put sim.tl, "nc_qo_ceq", r.tl, "", a.tl, emn.tl, PUTYEAR, (sum(a0$mapa0(a0,a), nc_qo_ceq(emn, a0, r))) / ;
               put sim.tl, "nc_qo", r.tl, "", a.tl, emn.tl, PUTYEAR, (sum(a0$mapa0(a0,a), nc_qo(emn, a0, r))) / ;
               loop(fp,
                  put sim.tl, "nc_endw_ceq", r.tl, fp.tl, a.tl, emn.tl, PUTYEAR, (sum(a0$mapa0(a0,a), nc_endw_ceq(emn, fp, a0, r))) / ;
                  put sim.tl, "nc_endw", r.tl, fp.tl, a.tl, emn.tl, PUTYEAR, (sum(a0$mapa0(a0,a), nc_endw(emn, fp, a0, r))) / ;
               ) ;
               loop(i,
                  put sim.tl, "nc_trad_ceq", r.tl, i.tl, a.tl, emn.tl, PUTYEAR, (sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), nc_trad_ceq(emn, i0, a0, r))) / ;
                  put sim.tl, "nc_trad", r.tl, i.tl, a.tl, emn.tl, PUTYEAR, (sum((i0,a0)$(mapi0(i0,i) and mapa0(a0,a)), nc_trad(emn, i0, a0, r))) / ;
               ) ;
            ) ;
            loop(i,
               put sim.tl, "nc_hh_ceq", r.tl, i.tl, "hhd", emn.tl, PUTYEAR, (sum(i0$mapi0(i0,i), nc_hh_ceq(emn, i0, r))) / ;
               put sim.tl, "nc_hh", r.tl, i.tl, "hhd", emn.tl, PUTYEAR, (sum(i0$mapi0(i0,i), nc_hh(emn, i0, r))) / ;
            ) ;
         ) ;
      ) ;
   ) ;

) ;
