$include "%baseName%Opt.gms"
$include "miscDat.gms"

* $include "faotab.gms"

*  Some set up for R

file freg / regions.csv / ;
file yearf / years.csv / ;
set tr(t) / 2011, 2014, 2017, 2020, 2025, 2030 / ;
alias(ra,sa) ; alias(ra,da) ;
if(1,
   put freg ;
   put "ISO,Name" / ;
   freg.pc=5 ;
   loop(ra,
      put ra.tl, ra.te(ra) / ;
   ) ;

   put yearf ;
   put "Years" / ;
   yearf.pc=5 ;
   loop(t$tr(t),
      put years(t):4:0 / ;
   ) ;
) ;

$macro reScale1(varName, i__1, suffix)  &varName.fx(r,i__1,t) = &varName.l(r,i__1,t)*&varName&suffix(r,i__1) ;

Parameters
   val         "Contains value"
;

*  Population/GDP

execute_load "%odir%/%SIMNAME%.gdx", popT, pop, pop0, rgdpmp, rgdpmp0, gdpmp, gdpmp0, ev, ev0, xfd, xfd0, yfd, yfd0 ;

file csvgdppop / %odir%\gdppop.csv / ;

if(1,
   put csvgdppop ;
   if(%ifAppend%,
      csvgdppop.ap = 1 ;
      put csvgdppop ;
   else
      csvgdppop.ap = 0 ;
      put csvgdppop ;
      put "Var,Sim,Region,Year,Value" / ;
   ) ;
   csvgdppop.pc = 5 ;
   csvgdppop.nd = 9 ;
   loop((ra,t),
      vol = outScale*sum(r$mapr(ra,r), rgdpmp.l(r,t)*rgdpmp0(r)) ;
      put "rgdpmp",  "%SIMNAME%", ra.tl, years(t):4:0, (vol) / ;
      val = outScale*sum(r$mapr(ra,r), gdpmp.l(r,t)*gdpmp0(r)) ;
      put "gdpmp",  "%SIMNAME%", ra.tl, years(t):4:0, (val) / ;
      work$vol = 100*val / vol ;
      put "pdpmp",  "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
      work = sum(r$mapr(ra,r), popT(r,"P1564",t))/popscale ;
      put "P1564",  "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
      work = sum(r$mapr(ra,r), popT(r,"PTOTL",t))/popscale ;
      put "PopT",  "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
      work = sum(r$mapr(ra,r), pop0(r)*pop.l(r,t))/popscale ;
      put "Pop",  "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
      work$work = vol / work ;
      put "rgdppc", "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
*     !!!! Caution summing over households
      vol = outScale*sum(r$mapr(ra,r), sum(h, ev.l(r,h,t)*ev0(r,h))) ;
      put "EV",  "%SIMNAME%", ra.tl, years(t):4:0, (vol) / ;
      vol = outScale*sum(r$mapr(ra,r), sum(h, xfd.l(r,h,t)*xfd0(r,h))) ;
      put "XFD",  "%SIMNAME%", ra.tl, years(t):4:0, (vol) / ;
      vol = outScale*sum(r$mapr(ra,r), sum(h, yfd.l(r,h,t)*yfd0(r,h))) ;
      put "YFD",  "%SIMNAME%", ra.tl, years(t):4:0, (vol) / ;
   ) ;
) ;
putclose csvgdppop ;

*  Aggregate factor prices

execute_load "%odir%/%SIMNAME%.gdx", pf, pf0, xf, xf0,
      ptland, ptland0, tland, tland0 ;

file csvfactp / %odir%\factp.csv / ;

if(1,
   put csvfactp ;
   if(%ifAppend%,
      csvfactp.ap = 1 ;
      put csvfactp ;
   else
      csvfactp.ap = 0 ;
      put csvfactp ;
      put "Var,Sim,Region,Year,Value" / ;
   ) ;
   csvfactp.pc = 5 ;
   csvfactp.nd = 9 ;
   loop((ra,t),
      loop(l,
         work = outScale*sum((r,a)$mapr(ra,r), xf0(r,l,a)*xf.l(r,l,a,t)) ;
         work$work = outScale*sum((r,a)$mapr(ra,r),
            pf0(r,l,a)*pf.l(r,l,a,t)*xf0(r,l,a)*xf.l(r,l,a,t))/work ;
         put l.tl:0:0, "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
      ) ;
      loop(cap,
         work = outScale*sum((r,a)$mapr(ra,r), xf0(r,cap,a)*xf.l(r,cap,a,t)) ;
         work$work = outScale*sum((r,a)$mapr(ra,r),
            pf0(r,cap,a)*pf.l(r,cap,a,t)*xf0(r,cap,a)*xf.l(r,cap,a,t))/work ;
         put "trent",  "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
      ) ;
      work = outScale*sum((r)$mapr(ra,r), tland0(r)*tland.l(r,t)) ;
      work$work = outScale*sum((r)$mapr(ra,r),
         ptland0(r)*ptland.l(r,t)*tland0(r)*tland.l(r,t))/work ;
      put "ptland",  "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
      loop(nrs,
         work = outScale*sum((r,a)$mapr(ra,r), xf0(r,nrs,a)*xf.l(r,nrs,a,t)) ;
         work$work = outScale*sum((r,a)$mapr(ra,r),
            pf0(r,nrs,a)*pf.l(r,nrs,a,t)*xf0(r,nrs,a)*xf.l(r,nrs,a,t))/work ;
         put "ptnrs", "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
      ) ;
      loop(wat,
         work = outScale*sum((r,a)$mapr(ra,r), xf0(r,wat,a)*xf.l(r,wat,a,t)) ;
         work$work = outScale*sum((r,a)$mapr(ra,r),
            pf0(r,wat,a)*pf.l(r,wat,a,t)*xf0(r,wat,a)*xf.l(r,wat,a,t))/work ;
         put "pth2o", "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
      ) ;
   ) ;
) ;
putclose csvfactp ;

*  Houseshold taxes as a share of household income

execute_load "%odir%/%SIMNAME%.gdx", kappah, yh, yh0 ;

file csvkappah / %odir%\kappah.csv / ;

if(1,
   put csvkappah ;
   if(%ifAppend%,
      csvkappah.ap = 1 ;
      put csvkappah ;
   else
      csvkappah.ap = 0 ;
      put csvkappah ;
      put "Var,Sim,Region,Year,Value" / ;
   ) ;
   csvkappah.pc = 5 ;
   csvkappah.nd = 9 ;
   loop((ra,t),
      work = sum(r$mapr(ra,r), yh.l(r,t)*yh0(r)) ;
      work$work = 100*sum(r$mapr(ra,r), kappah.l(r,t)*yh.l(r,t)*yh0(r)) / work ;
      put "kappah",  "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
   ) ;
) ;
putclose csvkappah ;

*  Government expenditures as a share of GDP

execute_load "%odir%/%SIMNAME%.gdx", xfd, xfd0, rgdpmp, rgdpmp0 ;

file csvrgovshr / %odir%\rgovshr.csv / ;

if(1,
   put csvrgovshr ;
   if(%ifAppend%,
      csvrgovshr.ap = 1 ;
      put csvrgovshr ;
   else
      csvrgovshr.ap = 0 ;
      put csvrgovshr ;
      put "Var,Sim,Region,Year,Value" / ;
   ) ;
   csvrgovshr.pc = 5 ;
   csvrgovshr.nd = 9 ;
   loop((ra,t),
      work = sum(r$mapr(ra,r), rgdpmp.l(r,t)*rgdpmp0(r)) ;
      work$work = 100*sum((r,gov)$mapr(ra,r), xfd.l(r,gov,t)*xfd0(r,gov)) / work ;
      put "rgovshr",  "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
   ) ;
) ;
putclose csvrgovshr ;

*  Domestic savings/investment

execute_load "%odir%/%SIMNAME%.gdx", yfd, yfd0, xfd, xfd0, savh, savh0, savg, pwsav,
   savf, deprY, deprY0, gdpmp, gdpmp0, rgdpmp, rgdpmp0, yd, yd0 ;

file csvsavinv / %odir%\savinv.csv / ;

if(1,
   put csvsavinv ;
   if(%ifAppend%,
      csvsavinv.ap = 1 ;
      put csvsavinv ;
   else
      csvsavinv.ap = 0 ;
      put csvsavinv ;
      put "Var,Sim,Region,Year,Value" / ;
   ) ;
   csvsavinv.pc = 5 ;
   csvsavinv.nd = 9 ;
   loop((ra,t),
      work = sum(r$mapr(ra,r), rgdpmp.l(r,t)*gdpmp0(r)) ;
      put "gdpmp", "%SIMNAME%", ra.tl, years(t):4:0, (work*outscale) / ;
      work = sum(r$mapr(ra,r), rgdpmp.l(r,t)*rgdpmp0(r)) ;
      put "rgdpmp", "%SIMNAME%", ra.tl, years(t):4:0, (work*outscale) / ;
      work$work = 100*sum((r,inv)$mapr(ra,r), xfd.l(r,inv,t)*xfd0(r,inv)) / work ;
      put "rinvshr", "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
      work = sum((r,inv)$mapr(ra,r), xfd.l(r,inv,t)*xfd0(r,inv)) ;
      put "rinv", "%SIMNAME%", ra.tl, years(t):4:0, (work*outscale) / ;
      work = sum((r,inv)$mapr(ra,r), yfd.l(r,inv,t)*yfd0(r,inv)) ;
      put "inv", "%SIMNAME%", ra.tl, years(t):4:0, (work*outscale) / ;
      work = sum((r,h)$mapr(ra,r), savh.l(r,h,t)*savh0(r,h)) ;
      put "savh", "%SIMNAME%", ra.tl, years(t):4:0, (work*outscale) / ;
      work = 100*work / sum((r)$mapr(ra,r), yd.l(r,t)*yd0(r)) ;
      put "aps", "%SIMNAME%", ra.tl, years(t):4:0, (work) / ;
      work = sum(r$mapr(ra,r), savg.l(r,t)) ;
      put "savg", "%SIMNAME%", ra.tl, years(t):4:0, (work*outscale) / ;
      work = sum(r$mapr(ra,r), pwsav.l(t)*savf.l(r,t)) ;
      put "savf", "%SIMNAME%", ra.tl, years(t):4:0, (work*outscale) / ;
      work = sum(r$mapr(ra,r), deprY.l(r,t)*deprY0(r)) ;
      put "deprY", "%SIMNAME%", ra.tl, years(t):4:0, (work*outscale) / ;
   ) ;
) ;
putclose csvsavinv ;

file csvxp / %odir%\Output.csv / ;

if(1,
   put csvxp ;
   if(%ifAppend%,
      csvxp.ap = 1 ;
      put csvxp ;
   else
      csvxp.ap = 0 ;
      put csvxp ;
      put "Var,Sim,Region,Activity,Year,Value" / ;
   ) ;
   csvxp.pc = 5 ;
   csvxp.nd = 9 ;

   execute_load "%odir%/%SIMNAME%.gdx", px, xp, px0, xp0 ;

   reScale1(px, a, 0)
   reScale1(xp, a, 0)

   loop((ra,aga,t,t0),
      vol = sum((r,a)$(mapr(ra,r) and mapaga(aga,a)), xp.l(r,a,t)) ;
      if(vol ne 0,
*        Unweighted aggregation of volumes
         put "xp",  "%SIMNAME%", ra.tl, aga.tl, years(t):4:0, (outScale*vol) / ;
*        Base year price weighted aggregation of volumes
         work = sum((r,a)$(mapr(ra,r) and mapaga(aga,a)), px.l(r,a,t0)*xp.l(r,a,t)) ;
         put "xpw", "%SIMNAME%", ra.tl, aga.tl, years(t):4:0, (outScale*work) / ;
*        Value of output
         val = sum((r,a)$(mapr(ra,r) and mapaga(aga,a)), px.l(r,a,t)*xp.l(r,a,t)) ;
         put "xpd", "%SIMNAME%", ra.tl, aga.tl, years(t):4:0, (outScale*val) / ;
*        Volume weighted prices
         work = sum((r,a)$(mapr(ra,r) and mapaga(aga,a)), px.l(r,a,t)*xp.l(r,a,t)) ;
         put "px", "%SIMNAME%", ra.tl, aga.tl, years(t):4:0, (work/vol) / ;
*        Price index
         work = sum((r,a)$(mapr(ra,r) and mapaga(aga,a)), px.l(r,a,t)*xp.l(r,a,t0))
              / sum((r,a)$(mapr(ra,r) and mapaga(aga,a)), px.l(r,a,t0)*xp.l(r,a,t0))
         put "pxn", "%SIMNAME%", ra.tl, aga.tl, years(t):4:0, (work) / ;
      ) ;
   ) ;
) ;

set vagg /
   set.endw
   tlab        "All labor"
   tcap        "All non-labor"
   tot         "All value added"
/ ;

set mapvagg(vagg,fp) ;
mapvagg(vagg,fp)$(sameas(vagg,fp)) = yes ;
mapvagg("tlab",l) = yes ;
mapvagg("tcap",fp)$(not l(fp)) = yes ;
mapvagg("tot",fp) = yes ;
* display mapvagg ; abort "Temp" ;

*  Value added

file csvva / %odir%\VA.csv / ;

set aggaga(aga)   "Aggregate activities" /
   ttot-a    "Total"
/ ;

* !!!! override

aggaga(aga) = yes ;

if(1,
   put csvva ;
   if(%ifAppend%,
      csvva.ap = 1 ;
      put csvva ;
   else
      csvva.ap = 0 ;
      put csvva ;
      put "Var,Sim,Region,Activity,Factor,Year,Value" / ;
   ) ;
   csvva.pc = 5 ;
   csvva.nd = 9 ;
   execute_load "%odir%/%SIMNAME%.gdx", pf0, xf0, pf, xf ;

   loop((ra,vagg,aga,t,t0)$(aggaga(aga)),
      val = sum((r,fp,a)$(mapr(ra,r) and mapvagg(vagg,fp) and mapaga(aga,a)),
         pf.l(r,fp,a,t)*pf0(r,fp,a)*xf.l(r,fp,a,t)*xf0(r,fp,a)) ;
      if(val ne 0,
         put "va_d",  "%SIMNAME%", ra.tl, aga.tl, vagg.tl, years(t):4:0, (outscale*val) / ;
         vol = sum((r,fp,a)$(mapr(ra,r) and mapvagg(vagg,fp) and mapaga(aga,a)),
            pf.l(r,fp,a,t0)*pf0(r,fp,a)*xf.l(r,fp,a,t)*xf0(r,fp,a)) ;
         put "va_n",  "%SIMNAME%", ra.tl, aga.tl, vagg.tl, years(t):4:0, (outscale*vol) / ;
         put "pva_n", "%SIMNAME%", ra.tl, aga.tl, vagg.tl, years(t):4:0, (val/vol) / ;
         vol = sum((r,fp,a)$(mapr(ra,r) and mapvagg(vagg,fp) and mapaga(aga,a)),
            xf.l(r,fp,a,t)*xf0(r,fp,a)) ;
         put "va",    "%SIMNAME%", ra.tl, aga.tl, vagg.tl, years(t):4:0, (outscale*vol) / ;
         put "pva",   "%SIMNAME%", ra.tl, aga.tl, vagg.tl, years(t):4:0, (val/vol) / ;
      ) ;
   ) ;

   putclose csvva ;
) ;

*  Investment

Parameters
   tinv        "Total investment"
   tva         "Total value added"
;

file csvinv / %odir%\INV.csv / ;

if(1,
   put csvinv ;
   if(%ifAppend%,
      csvinv.ap = 1 ;
      put csvinv ;
   else
      csvinv.ap = 0 ;
      put csvinv ;
      put "Var,Sim,Region,Activity,Year,Value" / ;
   ) ;
   csvinv.pc = 5 ;
   csvinv.nd = 9 ;
   execute_load "%odir%/%SIMNAME%.gdx",
      kstock, trent, kv, pk, kstock0, trent0, kv0, pk0, tkaps, tkaps0, pfd, pfd0, depr ;

*  Get value added

   execute_load "%odir%/%SIMNAME%.gdx", pf, xf, pf0, xf0 ;

*  Sectoral investment

   loop((ra,inv,t,t0)$(years(t) gt years(t0)),

      tinv = outScale*sum((r,a)$(mapr(ra,r)), (depr(r,t-1)/(1-power(1-depr(r,t-1),gap(t))))
              *   pfd0(r,inv)*pfd.l(r,inv,t-1)
              *   (sum(v, kv0(r,a)*kv.l(r,a,v,t)) - power(1-depr(r,t-1),gap(t))*sum(v, kv0(r,a)*kv.l(r,a,v,t-1)))
              *      (kstock0(r)*kstock.l(r,t0)/(tkaps0(r)*tkaps.l(r,t0)))) ;
      tva = sum((r,a)$(mapr(ra,r)), sum(fp, pf0(r,fp,a)*pf.l(r,fp,a,t)*xf0(r,fp,a)*xf.l(r,fp,a,t))) ;

      loop(aga,
         work = outscale*sum((r,a)$(mapr(ra,r) and mapaga(aga,a)), (depr(r,t-1)/(1-power(1-depr(r,t-1),gap(t))))
              *   (sum(v, kv0(r,a)*kv.l(r,a,v,t))
                     - power(1-depr(r,t-1),gap(t))*sum(v, kv0(r,a)*kv.l(r,a,v,t-1)))
                     * (kstock0(r)*kstock.l(r,t0)/(tkaps0(r)*tkaps.l(r,t0)))) ;
         put "inv_sec", "%SIMNAME%", ra.tl, aga.tl, years(t):4:0, (work) / ;
         work = outscale*sum((r,a)$(mapr(ra,r) and mapaga(aga,a)), (depr(r,t-1)/(1-power(1-depr(r,t-1),gap(t))))
              *   pfd0(r,inv)*pfd.l(r,inv,t-1)
              *   (sum(v, kv0(r,a)*kv.l(r,a,v,t)) - power(1-depr(r,t-1),gap(t))*sum(v, kv0(r,a)*kv.l(r,a,v,t-1)))
              *      (kstock0(r)*kstock.l(r,t0)/(tkaps0(r)*tkaps.l(r,t0)))) ;
         put "invd_sec", "%SIMNAME%", ra.tl, aga.tl, years(t):4:0, (work) / ;
         put "invd_shr", "%SIMNAME%", ra.tl, aga.tl, years(t):4:0, (100*work/tinv) / ;

         val = sum((r,a)$(mapr(ra,r) and mapaga(aga,a)), sum(fp, pf0(r,fp,a)*pf.l(r,fp,a,t)*xf0(r,fp,a)*xf.l(r,fp,a,t))) ;
         put "va_shr",   "%SIMNAME%", ra.tl, aga.tl, years(t):4:0, (100*val/tva) / ;

         if(val,
            put "invRatio", "%SIMNAME%", ra.tl, aga.tl, years(t):4:0, ((work/tinv)/(val/tva)) / ;
         ) ;
      ) ;
   ) ;
) ;

*  Emissions

file csvemi / %odir%\EMI.csv / ;

if(1,
   put csvemi ;
   if(%ifAppend%,
      csvemi.ap = 1 ;
      put csvemi ;
   else
      csvemi.ap = 0 ;
      put csvemi ;
      put "Var,Sim,Region,Agent,Emission,Unit,Year,Value" / ;
   ) ;
   csvemi.pc = 5 ;
   csvemi.nd = 9 ;

   execute_load "%odir%/%SIMNAME%.gdx", emiTot, emi, emiTot0, emi0 ;

   loop((em,t,ra),
      work = sum(r$mapr(ra,r), emiTot0(r,em)*emiTot.l(r,em,t)) ;
      if(work ne 0,
         if(ifCEQ,
            put "emi", "%SIMNAME%", ra.tl, "Tot", em.tl, "CEQ",   years(t):4:0, (work/cscale) / ;
            put "emi", "%SIMNAME%", ra.tl, "Tot", em.tl, "CO2EQ", years(t):4:0, ((44/12)*work/cscale) / ;
            put "emi", "%SIMNAME%", ra.tl, "Tot", em.tl, "MT",    years(t):4:0, ((44/12)*work/(cscale*gwp(em))) / ;
         else
            put "emi", "%SIMNAME%", ra.tl, "Tot", em.tl, "CEQ",   years(t):4:0, ((12/44)*work/cscale) / ;
            put "emi", "%SIMNAME%", ra.tl, "Tot", em.tl, "CO2EQ", years(t):4:0, (work/cscale) / ;
            put "emi", "%SIMNAME%", ra.tl, "Tot", em.tl, "MT",    years(t):4:0, (work/(cscale*gwp(em))) / ;
         ) ;
      ) ;

      loop(aga,
         work = sum((r,a,i)$(mapr(ra,r) and mapaga(aga,a)), emi0(r,em,i,a)*emi.l(r,em,i,a,t)) ;
         if(work ne 0,
            if(ifCEQ,
               put "emi_io", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CEQ",   years(t):4:0, (work/cscale) / ;
               put "emi_io", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CO2EQ", years(t):4:0, ((44/12)*work/cscale) / ;
               put "emi_io", "%SIMNAME%", ra.tl, aga.tl, em.tl, "MT",    years(t):4:0, ((44/12)*work/(cscale*gwp(em))) / ;
            else
               put "emi_io", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CEQ",   years(t):4:0, ((12/44)*work/cscale) / ;
               put "emi_io", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CO2EQ", years(t):4:0, (work/cscale) / ;
               put "emi_io", "%SIMNAME%", ra.tl, aga.tl, em.tl, "MT",    years(t):4:0, (work/(cscale*gwp(em))) / ;
            ) ;
         ) ;
      ) ;

      loop(aga,
         work = sum((r,a,fp)$(mapr(ra,r) and mapaga(aga,a)), emi0(r,em,fp,a)*emi.l(r,em,fp,a,t)) ;
         if(work ne 0,
            if(ifCEQ,
               put "emi_fp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CEQ",   years(t):4:0, (work/cscale) / ;
               put "emi_fp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CO2EQ", years(t):4:0, ((44/12)*work/cscale) / ;
               put "emi_fp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "MT",    years(t):4:0, ((44/12)*work/(cscale*gwp(em))) / ;
            else
               put "emi_fp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CEQ",   years(t):4:0, ((12/44)*work/cscale) / ;
               put "emi_fp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CO2EQ", years(t):4:0, (work/cscale) / ;
               put "emi_fp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "MT",    years(t):4:0, (work/(cscale*gwp(em))) / ;
            ) ;
         ) ;
      ) ;

      loop(aga,
         work = sum((r,a,is)$(sameas(is,"tot") and mapr(ra,r) and mapaga(aga,a)), emi0(r,em,is,a)*emi.l(r,em,is,a,t)) ;
         if(work ne 0,
            if(ifCEQ,
               put "emi_xp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CEQ",   years(t):4:0, (work/cscale) / ;
               put "emi_xp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CO2EQ", years(t):4:0, ((44/12)*work/cscale) / ;
               put "emi_xp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "MT",    years(t):4:0, ((44/12)*work/(cscale*gwp(em))) / ;
            else
               put "emi_xp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CEQ",   years(t):4:0, ((12/44)*work/cscale) / ;
               put "emi_xp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "CO2EQ", years(t):4:0, (work/cscale) / ;
               put "emi_xp", "%SIMNAME%", ra.tl, aga.tl, em.tl, "MT",    years(t):4:0, (work/(cscale*gwp(em))) / ;
            ) ;
         ) ;
      ) ;

      loop(fd,
         work = sum((r,is)$(mapr(ra,r) and emir(r,em,is,fd)), emi0(r,em,is,fd)*emi.l(r,em,is,fd,t)) ;
         if(work ne 0,
            if(ifCEQ,
               put "emi_io", "%SIMNAME%", ra.tl, fd.tl, em.tl, "CEQ",   years(t):4:0, (work/cscale) / ;
               put "emi_io", "%SIMNAME%", ra.tl, fd.tl, em.tl, "CO2EQ", years(t):4:0, ((44/12)*work/cscale) / ;
               put "emi_io", "%SIMNAME%", ra.tl, fd.tl, em.tl, "MT",    years(t):4:0, ((44/12)*work/(cscale*gwp(em))) / ;
            else
               put "emi_io", "%SIMNAME%", ra.tl, fd.tl, em.tl, "CEQ",   years(t):4:0, ((12/44)*work/cscale) / ;
               put "emi_io", "%SIMNAME%", ra.tl, fd.tl, em.tl, "CO2EQ", years(t):4:0, (work/cscale) / ;
               put "emi_io", "%SIMNAME%", ra.tl, fd.tl, em.tl, "MT",    years(t):4:0, (work/(cscale*gwp(em))) / ;
            ) ;
         ) ;
      ) ;
   ) ;
   putclose csvemi ;
) ;

Parameters
   cshr(is)       "Cost shares"
   delpx          "Change in aggregate price"
   delxp          "Change in aggregate volume"
   cwgt           "Share weights"
;

cwgt = 0.5 ;

*  Cost structure

file csvcost / %odir%\Cost.csv / ;

if(1,
   put csvcost ;
   if(%ifAppend%,
      csvcost.ap = 1 ;
      put csvcost ;
   else
      csvcost.ap = 0 ;
      put csvcost ;
      put "Var,Sim,Region,Activity,Input,Qualifier,Year,Value" / ;
   ) ;
   csvcost.pc = 5 ;
   csvcost.nd = 9 ;

   execute_load "%odir%/%SIMNAME%.gdx", px, xp, px0, xp0
      pa, pa0, xa, xa0, pfp, pfp0, pf, pf0, xf, xf0 ;

   loop((r,a,t,t0)$(years(t) gt years(t0) and xpFlag(r,a)),
      delpx = (px.l(r,a,t)/px.l(r,a,t-1))**(1/gap(t)) - 1 ;
      delxp = (xp.l(r,a,t)/xp.l(r,a,t-1))**(1/gap(t)) - 1 ;
      put "delpx", "%SIMNAME%",  r.tl, a.tl, "tot", "", years(t):4:0, (delpx) / ;
      put "delxp","%SIMNAME%",   r.tl, a.tl, "tot", "", years(t):4:0, (delxp) / ;
      loop(i$xaFlag(r,i,a),
         cshr(i) = cwgt*(pa0(r,i,a)*xa0(r,i,a))*pa.l(r,i,a,t-1)*xa.l(r,i,a,t-1)/((px0(r,a)*xp0(r,a))*px.l(r,a,t-1)*xp.l(r,a,t-1))
                 + (1-cwgt)*pa0(r,i,a)*xa0(r,i,a)*pa.l(r,i,a,t)*xa.l(r,i,a,t)/((px0(r,a)*xp0(r,a))*px.l(r,a,t)*xp.l(r,a,t))
                 ;
         put "pcshr", "%SIMNAME%",  r.tl, a.tl, i.tl, "io", years(t):4:0, (cshr(i)*((pa.l(r,i,a,t)/pa.l(r,i,a,t-1))**(1/gap(t)) - 1)) / ;
         put "xcshr", "%SIMNAME%",  r.tl, a.tl, i.tl, "io", years(t):4:0, (cshr(i)*((xa.l(r,i,a,t)/xa.l(r,i,a,t-1))**(1/gap(t)) - 1 - delxp)) / ;
         put "cshr",  "%SIMNAME%",  r.tl, a.tl, i.tl, "io", years(t):4:0, (cshr(i)) / ;
      ) ;
      loop(f$xfFlag(r,f,a),
         cshr(f) = cwgt*(pfp0(r,f,a)*xf0(r,f,a))*pfp.l(r,f,a,t-1)*xf.l(r,f,a,t-1)/(px0(r,a)*xp0(r,a)*px.l(r,a,t-1)*xp.l(r,a,t-1))
                 + (1-cwgt)*(pfp0(r,f,a)*xf0(r,f,a))*pfp.l(r,f,a,t)*xf.l(r,f,a,t)/(px0(r,a)*xp0(r,a)*px.l(r,a,t)*xp.l(r,a,t))
                 ;
         put "pcshr", "%SIMNAME%",  r.tl, a.tl, f.tl, "fp", years(t):4:0, (cshr(f)*((pfp.l(r,f,a,t)/pfp.l(r,f,a,t-1))**(1/gap(t)) - 1)) / ;
         put "xcshr", "%SIMNAME%",  r.tl, a.tl, f.tl, "fp", years(t):4:0, (cshr(f)*((xf.l(r,f,a,t)/xf.l(r,f,a,t-1))**(1/gap(t)) - 1 - delxp)) / ;
         put "cshr",  "%SIMNAME%",  r.tl, a.tl, f.tl, "fp", years(t):4:0, (cshr(f)) / ;
      ) ;
   ) ;
   putclose csvcost ;
) ;


*  Sources of growth

parameters
   fshr(r,fp,a,t)    "Factor share in value added"
   qdel(r,fp,a,t)    "Volume source of growth"
   ldel(r,fp,a,t)    "Productivity source of growth"
   rgdpfc(r,t)       "Real GDP at factor cost -- excl. indirect taxes"
   gdpfc(r,t)        "Nominal GDP at factor cost -- excl. indirect taxes"
;

file ydecomp / %odir%\ydecomp.csv / ;

if(1,
   put ydecomp ;
   if(%ifAppend%,
      ydecomp.ap = 1 ;
      put ydecomp ;
   else
      ydecomp.ap = 0 ;
      put ydecomp ;
      put "Var,Sim,Region,Activity,Factor,Year,Value" / ;
   ) ;
   ydecomp.pc = 5 ;
   ydecomp.nd = 9 ;

   execute_load "%odir%/%SIMNAME%.gdx", pf, pf0, xf, xf0, lambdaf ;

   fshr(r,f,a,t) = pf0(r,f,a)*xf0(r,f,a)*pf.l(r,f,a,t)*xf.l(r,f,a,t) ;
   qdel(r,f,a,t) = xf0(r,f,a)*xf.l(r,f,a,t) ;
   ldel(r,f,a,t) = lambdaf.l(r,f,a,t) ;

   gdpfc(r,t) = sum((fp,a), fshr(r,fp,a,t)) ;
   loop(t0,
      rgdpfc(r,t) =  sum((a,f), pf0(r,f,a)*pf.l(r,f,a,t0)*lambdaf.l(r,f,a,t)*xf0(r,f,a)*xf.l(r,f,a,t)) ;
   ) ;
   loop((ra,t),
      put "gdpfc",  "%SIMNAME%", ra.tl, "Tot", "Tot", years(t):4:0, (outscale*sum(r$mapr(ra,r), gdpfc(r,t))) / ;
      put "rgdpfc", "%SIMNAME%", ra.tl, "Tot", "Tot", years(t):4:0, (outscale*sum(r$mapr(ra,r), rgdpfc(r,t))) / ;
      put "pgdpfc", "%SIMNAME%", ra.tl, "Tot", "Tot", years(t):4:0, (sum(r$mapr(ra,r), gdpfc(r,t))/sum(r$mapr(ra,r), rgdpfc(r,t))) / ;
   ) ;
   fshr(r,fp,a,t) = fshr(r,fp,a,t) / gdpfc(r,t) ;
   loop((r,t,t0)$(years(t) gt years(t0)),
      loop((fp,a)$qdel(r,fp,a,t-1),
         put "qdel",  "%SIMNAME%", r.tl, a.tl, fp.tl, years(t):4:0,
            (100*(0.5*fshr(r,fp,a,t-1) + (1-0.5)*fshr(r,fp,a,t))*((qdel(r,fp,a,t)/qdel(r,fp,a,t-1))**(1/gap(t))-1)) / ;
      ) ;
      loop((fp,a)$ldel(r,fp,a,t-1),
         put "ldel",  "%SIMNAME%", r.tl, a.tl, fp.tl, years(t):4:0,
            (100*(0.5*fshr(r,fp,a,t-1) + (1-0.5)*fshr(r,fp,a,t))*((ldel(r,fp,a,t)/ldel(r,fp,a,t-1))**(1/gap(t))-1)) / ;
      ) ;
   ) ;
) ;

*  Trade

file trade / %odir%\trade.csv / ;

parameters
   trdvol(ra,ia,t)
   trdval(ra,ia,t)
   trdprc(ra,ia,t)
;

if(1,
   put trade ;
   if(%ifAppend%,
      trade.ap = 1 ;
      put trade ;
   else
      trade.ap = 0 ;
      put trade ;
      put "Var,Sim,Region,Commodity,Year,Value" / ;
   ) ;
   trade.pc = 5 ;
   trade.nd = 9 ;

   execute_load "%odir%/%SIMNAME%.gdx", xw, pe, pwe, pwm, pdm, xw0, pe0, pwe0, pwm0, pdm0,
         gammaeda, gammaedd, gammaedm, pat, xa, pat0, xa0, pdt, pmt, xd, xm, pdt0, xd0, pmt0, xm0 ;

   trdval(ra,ia,t) = sum((r,i)$(mapr(ra,r) and mapi(ia,i)), sum(rp, pwe0(r,i,rp)*xw0(r,i,rp)*pwe.l(r,i,rp,t)*xw.l(r,i,rp,t))) ;
   trdvol(ra,ia,t) = sum((r,i,t0)$(mapr(ra,r) and mapi(ia,i)), sum(rp, pwe0(r,i,rp)*xw0(r,i,rp)*pwe.l(r,i,rp,t0)*xw.l(r,i,rp,t))) ;
   trdprc(ra,ia,t) = sum((r,i,t0)$(mapr(ra,r) and mapi(ia,i)), sum(rp, pe0(r,i,rp)*xw0(r,i,rp)*pe.l(r,i,rp,t)*xw.l(r,i,rp,t))) ;
   loop((ra,ia,t)$trdval(ra,ia,t),
         put "exp_d", "%SIMNAME%", ra.tl, ia.tl, years(t):4:0, (outscale*trdval(ra,ia,t)) / ;
         put "exp",   "%SIMNAME%", ra.tl, ia.tl, years(t):4:0, (outscale*trdvol(ra,ia,t)) / ;
         put "etax",  "%SIMNAME%", ra.tl, ia.tl, years(t):4:0, (100*trdval(ra,ia,t)/trdprc(ra,ia,t)-100) / ;
   ) ;

   trdval(ra,ia,t) = sum((r,i)$(mapr(ra,r) and mapi(ia,i)), sum(rp, pwe0(rp,i,r)*xw0(rp,i,r)*pwe.l(rp,i,r,t)*xw.l(rp,i,r,t))) ;
   trdvol(ra,ia,t) = sum((r,i,t0)$(mapr(ra,r) and mapi(ia,i)), sum(rp, pwe0(rp,i,r)*xw0(rp,i,r)*pwe.l(rp,i,r,t0)*xw.l(rp,i,r,t))) ;

   loop((ra,ia,t)$trdval(ra,ia,t),
         put "imp_fob_d", "%SIMNAME%", ra.tl, ia.tl, years(t):4:0, (outscale*trdval(ra,ia,t)) / ;
         put "imp_fob",   "%SIMNAME%", ra.tl, ia.tl, years(t):4:0, (outscale*trdvol(ra,ia,t)) / ;
   ) ;

   trdval(ra,ia,t) = sum((r,i)$(mapr(ra,r) and mapi(ia,i)), sum(rp, pwm0(rp,i,r)*xw0(rp,i,r)*pwm.l(rp,i,r,t)*xw.l(rp,i,r,t))) ;
   trdvol(ra,ia,t) = sum((r,i,t0)$(mapr(ra,r) and mapi(ia,i)), sum(rp, pwm0(rp,i,r)*xw0(rp,i,r)*pwm.l(rp,i,r,t0)*xw.l(rp,i,r,t))) ;
   trdprc(ra,ia,t) = sum((r,i,t0)$(mapr(ra,r) and mapi(ia,i)), sum(rp, pdm0(rp,i,r)*xw0(rp,i,r)*pdm.l(rp,i,r,t)*xw.l(rp,i,r,t))) ;

   loop((ra,ia,t)$trdval(ra,ia,t),
         put "imp_cif_d", "%SIMNAME%", ra.tl, ia.tl, years(t):4:0, (outscale*trdval(ra,ia,t)) / ;
         put "imp_cif",   "%SIMNAME%", ra.tl, ia.tl, years(t):4:0, (outscale*trdvol(ra,ia,t)) / ;
         put "mtax",      "%SIMNAME%", ra.tl, ia.tl, years(t):4:0, (100*trdprc(ra,ia,t)/trdval(ra,ia,t)-100) / ;
   ) ;

   if(ArmFlag eq 0,
      trdval(ra,ia,t) = sum((r,i,aa)$(mapr(ra,r) and mapi(ia,i)),
                           gammaeda(r,i,aa)*pat.l(r,i,t)*xa.l(r,i,aa,t)*(pat0(r,i)*xa0(r,i,aa))) ;
   else
      trdval(ra,ia,t) =  sum((r,i,aa)$(mapr(ra,r) and mapi(ia,i)),
                           gammaedd(r,i,aa)*pdt.l(r,i,t)*xd.l(r,i,aa,t)*(pdt0(r,i)*xd0(r,i,aa))
                      +    gammaedm(r,i,aa)*pmt.l(r,i,t)*xm.l(r,i,aa,t)*(pmt0(r,i)*xm0(r,i,aa))) ;
   ) ;

   loop((ra,ia,t)$trdval(ra,ia,t),
         put "Absorb", "%SIMNAME%", ra.tl, ia.tl, years(t):4:0, (outscale*trdval(ra,ia,t)) / ;
   ) ;

   putclose trade ;

) ;

*  Bilateral trade

file bilat / %odir%\bilat.csv / ;

if(1,
   put bilat ;
   if(%ifAppend%,
      bilat.ap = 1 ;
      put bilat ;
   else
      bilat.ap = 0 ;
      put bilat ;
      put "Var,Sim,Source,Commodity,Destination,Year,Value" / ;
   ) ;
   bilat.pc = 5 ;
   bilat.nd = 9 ;

   execute_load "%odir%/%SIMNAME%.gdx", xw, pwe, pwm, xw0, pwe0, pwm0, lambdaw ;

   loop((sa,ia,da,t),
      vol = sum((s,i,d)$(mapr(sa,s) and mapi(ia,i) and mapr(da,d)), xw.l(s,i,d,t)*xw0(s,i,d)) ;
      if(vol ne 0,
*        Real exports
         put "XWs", "%SIMNAME%", sa.tl, ia.tl, da.tl, years(t):4:0, (outscale*vol) / ;
*        Nominal exports FOB proces
         val = sum((s,i,d)$(mapr(sa,s) and mapi(ia,i) and mapr(da,d)), pwe.l(s,i,d,t)*pwe0(s,i,d)*xw.l(s,i,d,t)*xw0(s,i,d)) ;
         put "XWs_d", "%SIMNAME%", sa.tl, ia.tl, da.tl, years(t):4:0, (outscale*val) / ;
*        Export price index
         put "PWE", "%SIMNAME%", sa.tl, ia.tl, da.tl, years(t):4:0, (val/vol) / ;
*        Iceberg parameter
         val = sum((s,i,d)$(mapr(sa,s) and mapi(ia,i) and mapr(da,d)), lambdaw(s,i,d,t)*xw.l(s,i,d,t)*xw0(s,i,d)) ;
         put "lambdaw", "%SIMNAME%", sa.tl, ia.tl, da.tl, years(t):4:0, (val/vol) / ;
*        Real imports
         vol = sum((s,i,d)$(mapr(sa,s) and mapi(ia,i) and mapr(da,d)), lambdaw(s,i,d,t)*xw.l(s,i,d,t)*xw0(s,i,d)) ;
         put "XWd", "%SIMNAME%", sa.tl, ia.tl, da.tl, years(t):4:0, (outscale*vol) / ;
*        Nominal imports
         val = sum((s,i,d)$(mapr(sa,s) and mapi(ia,i) and mapr(da,d)), pwm.l(s,i,d,t)*pwm0(s,i,d)*lambdaw(s,i,d,t)*xw.l(s,i,d,t)*xw0(s,i,d)) ;
         put "XWd_d", "%SIMNAME%", sa.tl, ia.tl, da.tl, years(t):4:0, (outscale*val) / ;
*        Import price index
         put "PWM", "%SIMNAME%", sa.tl, ia.tl, da.tl, years(t):4:0, (val/vol) / ;
*        Average tariff
         vol = sum((s,i,d)$(mapr(sa,s) and mapi(ia,i) and mapr(da,d)), mtax.l(s,i,d,t)*pwm.l(s,i,d,t)*pwm0(s,i,d)*lambdaw(s,i,d,t)*xw.l(s,i,d,t)*xw0(s,i,d)) ;
         put "MTAX", "%SIMNAME%", sa.tl, ia.tl, da.tl, years(t):4:0, (vol/val) / ;
      ) ;
   ) ;

   putclose bilat ;

) ;

*  Labor demand--need to deal with UE

file labcsv / %odir%\lab.csv / ;

if(1,
   put labcsv ;
   if(%ifAppend%,
      labcsv.ap = 1 ;
      put labcsv ;
   else
      labcsv.ap = 0 ;
      put labcsv ;
      put "Var,Sim,Region,Type,Zone,Year,Value" / ;
   ) ;
   labcsv.pc = 5 ;
   labcsv.nd = 9 ;

   execute_load "%odir%/%SIMNAME%.gdx", ls, twage, migr, awagez, ewagez, lsz,
         ls0, twage0, migr0, awagez0, ewagez0, lsz0, pfd, pfd0 ;

   loop((ra,lagg,t),
      vol = sum((r,l)$(mapr(ra,r) and mapl(lagg,l)), ls0(r,l)*ls.l(r,l,t)/lScale) ;
      if(vol > 0,
         val = sum((r,l)$(mapr(ra,r) and mapl(lagg,l)), twage0(r,l)*twage.l(r,l,t)*ls0(r,l)*ls.l(r,l,t)) ;
         put "ls",  "%SIMNAME%", ra.tl, lagg.tl, "Tot", years(t):4:0, (vol/lscale) / ;
         put "twage", "%SIMNAME%", ra.tl, lagg.tl, "Tot", years(t):4:0, (val/vol) / ;
*        Real wage
         loop(h,
            val = sum((r,l)$(mapr(ra,r) and mapl(lagg,l)), (twage0(r,l)*twage.l(r,l,t)/(pfd.l(r,h,t)/pfd0(r,h)))*ls0(r,l)*ls.l(r,l,t)) ;
            put "trwage", "%SIMNAME%", ra.tl, lagg.tl, "Tot", years(t):4:0, (val/vol) / ;
         ) ;
      ) ;
      vol = sum((r,l)$(mapr(ra,r) and mapl(lagg,l)), migr0(r,l)*migr.l(r,l,t)) ;
      if(vol > 0,
         put "migr", "%SIMNAME%", ra.tl, lagg.tl, "Tot", years(t):4:0, (vol/lscale) / ;
      ) ;
      loop(z,
         vol = sum((r,l)$(mapr(ra,r) and mapl(lagg,l)), lsz0(r,l,z)*lsz.l(r,l,z,t)) ;
         if(vol > 0,
            put "lsz",   "%SIMNAME%", ra.tl, lagg.tl, z.tl, years(t):4:0, (vol/lscale) / ;
            val = sum((r,l)$(mapr(ra,r) and mapl(lagg,l)), awagez0(r,l,z)*awagez.l(r,l,z,t)*lsz0(r,l,z)*lsz.l(r,l,z,t)) ;
            put "awage", "%SIMNAME%", ra.tl, lagg.tl, z.tl, years(t):4:0, (val/vol) / ;
            val = sum((r,l)$(mapr(ra,r) and mapl(lagg,l)), ewagez0(r,l,z)*ewagez.l(r,l,z,t)*lsz0(r,l,z)*lsz.l(r,l,z,t)) ;
            put "ewage", "%SIMNAME%", ra.tl, lagg.tl, z.tl, years(t):4:0, (val/vol) / ;
*           Real wages
            loop(h,
               val = sum((r,l)$(mapr(ra,r) and mapl(lagg,l)), (awagez0(r,l,z)*awagez.l(r,l,z,t)/(pfd.l(r,h,t)/pfd0(r,h)))*lsz0(r,l,z)*lsz.l(r,l,z,t)) ;
               put "arwage", "%SIMNAME%", ra.tl, lagg.tl, z.tl, years(t):4:0, (val/vol) / ;
            ) ;
            loop(h,
               val = sum((r,l)$(mapr(ra,r) and mapl(lagg,l)), (ewagez0(r,l,z)*ewagez.l(r,l,z,t)/(pfd.l(r,h,t)/pfd0(r,h)))*lsz0(r,l,z)*lsz.l(r,l,z,t)) ;
               put "aewage", "%SIMNAME%", ra.tl, lagg.tl, z.tl, years(t):4:0, (val/vol) / ;
            ) ;
         ) ;
      ) ;
   ) ;
   putclose labcsv ;
) ;

*  Power supply

file powcsv / %odir%\power.csv / ;

if(1,
   put powcsv ;
   if(%ifAppend%,
      powcsv.ap = 1 ;
      put powcsv ;
   else
      powcsv.ap = 0 ;
      put powcsv ;
      put "Var,Sim,Region,Activity,Year,Value" / ;
   ) ;
   powcsv.pc = 5 ;
   powcsv.nd = 9 ;

   execute_load "%odir%/%SIMNAME%.gdx", xp, px, xp0, px0 ;

   loop((ra,a,t,t0)$elya(a),
      vol = sum(r$mapr(ra,r),xp0(r,a)*xp.l(r,a,t)) ;
      val = sum(r$mapr(ra,r),px0(r,a)*px.l(r,a,t)*xp0(r,a)*xp.l(r,a,t)) ;
      if(vol,
         put "XP", "%SIMNAME%", ra.tl, a.tl, years(t):4:0, (vol/inscale) / ;
         put "PX", "%SIMNAME%", ra.tl, a.tl, years(t):4:0, (val/vol) / ;
      ) ;
   ) ;

   putclose powcsv ;
) ;
