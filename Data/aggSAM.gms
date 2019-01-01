if(%ifCSV%,
   put csv ;
   if(ifFirstPass,
      put "SAMLabel,Var,Region,RowLabel,ColLabel,Value" / ;
      csv.pc=5 ;
      csv.nd=9 ;
      ifFirstPass = 0 ;
   ) ;

*  Production accounts

   loop((r,a),
      loop(i,
         put "%1", "SAM", r.tl, i.tl, a.tl, (vdfb%2(i,a,r)+vmfb%2(i,a,r)) / ;
      ) ;
      put "%1", "SAM", r.tl, "itax", a.tl, (sum(i,vdfp%2(i,a,r)+vmfp%2(i,a,r)-vdfb%2(i,a,r)-vmfb%2(i,a,r))) / ;

      loop(fp,
         put "%1", "SAM", r.tl, fp.tl, a.tl,(evfb%2(fp,a,r)) / ;
      ) ;
      put "%1", "SAM", r.tl, "vtax", a.tl, (sum(fp,evfp%2(fp,a,r) - evfb%2(fp,a,r))) / ;
   ) ;

*  Commodity supply

   loop((r,i),
      put "%1", "SAM", r.tl, "ptax", i.tl, (sum(a, ptax%2(i,a,r))) / ;
      put "%1", "SAM", r.tl, "etax", i.tl, (sum(d, vfob%2(i,r,d) - vxsb%2(i,r,d))) / ;
      put "%1", "SAM", r.tl, "mtax", i.tl, (sum(s, vmsb%2(i,s,r) - vcif%2(i,s,r))) / ;
   ) ;

   loop(r,
      if(ifAggTrade,
         loop(i,
            put "%1", "SAM", r.tl, "BoP",  i.tl, (sum(s, vcif%2(i,s,r))) / ;
         ) ;
      else
         loop(s,
            loop(i,
               put "%1", "SAM", r.tl, s.tl,  i.tl, vcif%2(i,s,r) / ;
            ) ;
            put "%1", "SAM", r.tl, "BoP",  s.tl, (sum(i, vcif%2(i,s,r))) / ;
         ) ;
      ) ;
   ) ;

*  Income distribution

   loop((r,fp),
      put "%1", "SAM", r.tl, "dtax", fp.tl, (sum(a, evfb%2(fp,a,r)-evos%2(fp,a,r))) / ;
      put "%1", "SAM", r.tl, "REGY",   fp.tl, (sum(a, evos%2(fp,a,r))) / ;
   ) ;

   loop(r,
      put "%1", "SAM", r.tl, "REGY", "itax", (
*        Production
         sum((i,a), vdfp%2(i,a,r)+vmfp%2(i,a,r)-vdfb%2(i,a,r)-vmfb%2(i,a,r))
*        Private consumption
         + sum(i, vdpp%2(i,r)+vmpp%2(i,r)-vdpb%2(i,r)-vmpb%2(i,r))
*        Public consumption
         + sum(i, vdgp%2(i,r)+vmgp%2(i,r)-vdgb%2(i,r)-vmgb%2(i,r))
*        Investment
         + sum(i, vdip%2(i,r)+vmip%2(i,r)-vdib%2(i,r)-vmib%2(i,r))
      ) / ;
      put "%1", "SAM", r.tl, "REGY", "vtax", (sum((fp,a), evfp%2(fp,a,r) - evfb%2(fp,a,r))) / ;
      put "%1", "SAM", r.tl, "REGY", "ptax", (sum((i,a), ptax%2(i,a,r))) / ;
      put "%1", "SAM", r.tl, "REGY", "etax", (sum((i,d), vfob%2(i,r,d) - vxsb%2(i,r,d))) / ;
      put "%1", "SAM", r.tl, "REGY", "mtax", (sum((i,s), vmsb%2(i,s,r) - vcif%2(i,s,r))) / ;
      put "%1", "SAM", r.tl, "REGY", "dtax", (sum(fp, sum(a, evfb%2(fp,a,r) - evos%2(fp,a,r)))) / ;
      put "%1", "SAM", r.tl, "DEPR", "REGY", (vdep%2(r)) / ;

      put "%1", "SAM", r.tl, "PRIV", "REGY", (sum(i, vdpp%2(i,r)+vmpp%2(i,r))) / ;
      put "%1", "SAM", r.tl, "GOV",  "REGY", (sum(i, vdgp%2(i,r)+vmgp%2(i,r))) / ;
      put "%1", "SAM", r.tl, "INV",  "REGY", (save%2(r)) / ;
   ) ;

*  Domestic absorption

   loop((r,i),
      put "%1", "SAM", r.tl, i.tl, "PRIV", (vdpb%2(i,r)+vmpb%2(i,r)) / ;
      put "%1", "SAM", r.tl, i.tl, "GOV",  (vdgb%2(i,r)+vmgb%2(i,r)) / ;
      put "%1", "SAM", r.tl, i.tl, "INV",  (vdib%2(i,r)+vmib%2(i,r)) / ;
   ) ;
   loop(r,
      put "%1", "SAM", r.tl, "itax", "PRIV", (sum(i, vdpp%2(i,r)+vmpp%2(i,r)-vdpb%2(i,r)-vmpb%2(i,r))) / ;
      put "%1", "SAM", r.tl, "itax", "GOV",  (sum(i, vdgp%2(i,r)+vmgp%2(i,r)-vdgb%2(i,r)-vmgb%2(i,r))) / ;
      put "%1", "SAM", r.tl, "itax", "INV",  (sum(i, vdip%2(i,r)+vmip%2(i,r)-vdib%2(i,r)-vmib%2(i,r))) / ;
   ) ;

*  Exports

   loop((r,img),
      put "%1", "SAM", r.tl, img.tl, "ITT",  (vst%2(img,r)) / ;
   ) ;
   if(ifAggTrade,
      loop((r,i),
         put "%1", "SAM", r.tl, i.tl, "BOP",  (sum(d, vfob%2(i,r,d))) / ;
      ) ;
   else
      loop((r,i,d),
         put "%1", "SAM", r.tl, i.tl, d.tl,  vfob%2(i,r,d) / ;
      ) ;
      loop((r,d),
         put "%1", "SAM", r.tl, d.tl, "BOP",  (sum(i, vfob%2(i,r,d))) / ;
      ) ;
   ) ;

*  Closure

   loop(r,
      put "%1", "SAM", r.tl, "INV", "DEPR",  (vdep%2(r)) / ;
      put "%1", "SAM", r.tl, "ITT", "BOP", (sum(img, vst%2(img,r))) / ;
      put "%1", "SAM", r.tl, "INV", "BOP", (sum((i,s), vcif%2(i,s,r) - vfob%2(i,r,s)) - sum(img, vst%2(img,r))) / ;
   ) ;

*  Miscellaneous

   loop(r,
      put "%1", "MACRO", r.tl, "VKB", "", (VKB%2(r)) / ;
      put "%1", "MACRO", r.tl, "POP", "", (POP%2(r)) / ;
   ) ;
) ;
