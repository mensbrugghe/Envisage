*  Note this file assumes explicitly that the intial and final
*  activities and commodites are as in the original data file

parameters
   VDFBF(i0, a0, r)      "Firm purchases of domestic goods at basic prices"
   VDFPF(i0, a0, r)      "Firm purchases of domestic goods at purchaser prices"
   VMFBF(i0, a0, r)      "Firm purchases of imported goods at basic prices"
   VMFPF(i0, a0, r)      "Firm purchases of domestic goods at purchaser prices"
   VDPBF(i0, r)          "Private purchases of domestic goods at basic prices"
   VDPPF(i0, r)          "Private purchases of domestic goods at purchaser prices"
   VMPBF(i0, r)          "Private purchases of imported goods at basic prices"
   VMPPF(i0, r)          "Private purchases of domestic goods at purchaser prices"
   VDGBF(i0, r)          "Government purchases of domestic goods at basic prices"
   VDGPF(i0, r)          "Government purchases of domestic goods at purchaser prices"
   VMGBF(i0, r)          "Government purchases of imported goods at basic prices"
   VMGPF(i0, r)          "Government purchases of domestic goods at purchaser prices"
   VDIBF(i0, r)          "Investment purchases of domestic goods at basic prices"
   VDIPF(i0, r)          "Investment purchases of domestic goods at purchaser prices"
   VMIBF(i0, r)          "Investment purchases of imported goods at basic prices"
   VMIPF(i0, r)          "Investment purchases of domestic goods at purchaser prices"

   EVFBF(fp, a0, r)      "Primary factor purchases at basic prices"
   EVFPF(fp, a0, r)      "Primary factor purchases at purchaser prices"
   EVOSF(fp, a0, r)      "Factor remuneration after income tax"

   VXSBF(i0, r, rp)      "Exports at basic prices"
   VFOBF(i0, r, rp)      "Exports at FOB prices"
   VCIFF(i0, r, rp)      "Import at CIF prices"
   VMSBF(i0, r, rp)      "Imports at basic prices"

   VSTF(i0, r)           "Exports of trade and transport services"
   VTWRF(i0, j0, r, rp)  "Margins by margin commodity"

   SAVEF(r)              "Net saving, by region"
   VDEPF(r)              "Capital depreciation"
   VKBF(r)               "Capital stock"
   POPF(r)              "Population"

   MAKSF(i0,a0,r)        "Make matrix at supply prices"
   MAKBF(i0,a0,r)        "Make matrix at basic prices (incl taxes)"
   PTAXF(i0,a0,r)        "Output taxes"

   TVOMF(a0,r)           "Output excl. taxes"
;

scalar reScale ; reScale = 1/inScale ;

loop(t$sameas(t,"%1"),

*  Production matrices

   VDFBF(i0,a0,r) = rescale*sum((i,a)$(mapi0(i0,i) and mapa0(a0,a)), pd.l(r,i,t)*xd.l(r,i,a,t)/xScale(r,a)) ;
   VDFPF(i0,a0,r) = rescale*sum((i,a)$(mapi0(i0,i) and mapa0(a0,a)), pdp.l(r,i,a,t)*xd.l(r,i,a,t)/xScale(r,a)) ;
   VMFBF(i0,a0,r) = rescale*sum((i,a)$(mapi0(i0,i) and mapa0(a0,a)), pmt.l(r,i,t)*xm.l(r,i,a,t)/xScale(r,a)) ;
   VMFPF(i0,a0,r) = rescale*sum((i,a)$(mapi0(i0,i) and mapa0(a0,a)), pmp.l(r,i,a,t)*xm.l(r,i,a,t)/xScale(r,a)) ;
   EVFBF(fp,a0,r) = rescale*sum(a$mapa0(a0,a), pf.l(r,fp,a,t)*xf.l(r,fp,a,t)/xScale(r,a)) ;
   EVFPF(fp,a0,r) = rescale*sum(a$mapa0(a0,a), pfa.l(r,fp,a,t)*xf.l(r,fp,a,t)/xScale(r,a)) ;
   tvomf(a0,r)    = sum(i0, (VDFPF(i0,a0,r) + VMFPF(i0,a0,r))) + sum(fp, EVFPF(fp,a0,r)) ;

*  Income distribution

   EVOSF(fp,a0,r) = rescale*sum(a$mapa0(a0,a), (1-kappaf.l(r,fp,a,t))*pf.l(r,fp,a,t)*xf.l(r,fp,a,t)/xScale(r,a)) ;

*  Final demand

   loop(h,
      VDPBF(i0,r) = reScale*sum(i$mapi0(i0,i), pd.l(r,i,t)*xd.l(r,i,h,t)/xScale(r,h)) ;
      VDPPF(i0,r) = reScale*sum(i$mapi0(i0,i), pdp.l(r,i,h,t)*xd.l(r,i,h,t)/xScale(r,h)) ;
      VMPBF(i0,r) = reScale*sum(i$mapi0(i0,i), pmt.l(r,i,t)*xm.l(r,i,h,t)/xScale(r,h)) ;
      VMPPF(i0,r) = reScale*sum(i$mapi0(i0,i), pmp.l(r,i,h,t)*xm.l(r,i,h,t)/xScale(r,h)) ;
   ) ;

   loop(gov,
      VDGBF(i0,r) = reScale*sum(i$mapi0(i0,i), pd.l(r,i,t)*xd.l(r,i,gov,t)/xScale(r,gov)) ;
      VDGPF(i0,r) = reScale*sum(i$mapi0(i0,i), pdp.l(r,i,gov,t)*xd.l(r,i,gov,t)/xScale(r,gov)) ;
      VMGBF(i0,r) = reScale*sum(i$mapi0(i0,i), pmt.l(r,i,t)*xm.l(r,i,gov,t)/xScale(r,gov)) ;
      VMGPF(i0,r) = reScale*sum(i$mapi0(i0,i), pmp.l(r,i,gov,t)*xm.l(r,i,gov,t)/xScale(r,gov)) ;
   ) ;

   loop(inv,
      VDIBF(i0,r) = reScale*sum(i$mapi0(i0,i), pd.l(r,i,t)*xd.l(r,i,inv,t)/xScale(r,inv)) ;
      VDIPF(i0,r) = reScale*sum(i$mapi0(i0,i), pdp.l(r,i,inv,t)*xd.l(r,i,inv,t)/xScale(r,inv)) ;
      VMIBF(i0,r) = reScale*sum(i$mapi0(i0,i), pmt.l(r,i,t)*xm.l(r,i,inv,t)/xScale(r,inv)) ;
      VMIPF(i0,r) = reScale*sum(i$mapi0(i0,i), pmp.l(r,i,inv,t)*xm.l(r,i,inv,t)/xScale(r,inv)) ;
   ) ;

*  Bilateral trade

   VXSBF(i0,r,rp) = reScale*sum(i$mapi0(i0,i), pe.l(r,i,rp,t)*xw.l(r,i,rp,t)) ;
   VFOBF(i0,r,rp) = reScale*sum(i$mapi0(i0,i), pefob.l(r,i,rp,t)*xw.l(r,i,rp,t)) ;
   VCIFF(i0,r,rp) = reScale*sum(i$mapi0(i0,i), pmcif.l(r,i,rp,t)*xw.l(r,i,rp,t)) ;
   VMSBF(i0,r,rp) = reScale*sum(i$mapi0(i0,i), pm.l(r,i,rp,t)*xw.l(r,i,rp,t)) ;

*  Margin exports

   loop(tmg,
      vstf(m0,r) = reScale*sum(m$mapi0(m0,m), (pa.l(r,m,tmg,t)*xa.l(r,m,tmg,t)*xScale(r,tmg))) ;
   ) ;

*  Bilateral margins

   VTWRF(m0, i0, r, rp) = reScale*sum((m,i)$(mapi0(m0,m) and mapi0(i0,i)), ptmg.l(m,t)*xmgm.l(m,r,i,rp,t)) ;

   vkbf(r)  = reScale*kstock.l(r,t) ;
   savef(r) = reScale*rsav.l(r,t) ;
   popf(r) = pop.l(r,t) ;
   vdepf(r) = rescale*fdepr(r,t)*pi.l(r,t)*kstock.l(r,t) ;

*  MAKE Matrices
   MAKSF(i0,a0,r) = reScale*sum((i,a)$(mapi0(i0,i) and mapa0(a0,a)), p.l(r,a,i,t)*x.l(r,a,i,t)) ;
   MAKBF(i0,a0,r) = reScale*sum((i,a)$(mapi0(i0,i) and mapa0(a0,a)), (1+prdtx.l(r,a,i,t))*p.l(r,a,i,t)*x.l(r,a,i,t)) ;
   PTAXF(i0,a0,r) = MAKBF(i0,a0,r) - MAKSF(i0,a0,r) ;
) ;

execute_unload "%oDir%/%BaseName%Dat.gdx",
   VDFBF=VDFB, VDFPF=VDFP, VMFBF=VMFB, VMFPF=VMFP,
   VDPBF=VDPB, VDPPF=VDPP, VMPBF=VMPB, VMPPF=VMPP,
   VDGBF=VDGB, VDGPF=VDGP, VMGBF=VMGB, VMGPF=VMGP,
   VDIBF=VDIB, VDIPF=VDIP, VMIBF=VMIB, VMIPF=VMIP,
   EVFBF=EVFB, EVFPF=EVFP, EVOSF=EVOS,
   VXSBF=VXSB, VFOBF=VFOB, VCIFF=VCIF, VMSBF=VMSB,
   VSTF=VST,   VTWRF=VTWR,
   SAVEF=SAVE, VDEPF=VDEP, VKBF=VKB,   POPF=POP,
   MAKSF=MAKS, MAKBF=MAKB, PTAXF=PTAX

*  26-Sep-2018
*
*  Introduction of NTMs
*

Parameter
   VNTM(i0, r, rp)
;

loop(t$sameas(t,"%1"),
   VNTM(i0, r, rp) = reScale*sum(i$mapi0(i0,i), ntmAVE.l(r,i,rp,t)*pmcif.l(r,i,rp,t)*xw.l(r,i,rp,t)) ;
) ;

if(NTMFlag,
   execute_unload "%oDir%/%BaseName%NTM.gdx", VNTM ;
) ;

* ----------------------------------------------------------------------------------------
*
*  Adjust emissions/energy
*
* ----------------------------------------------------------------------------------------

alias(emn, nco2) ; alias(r,s) ; alias(r,d) ;
set nco2eq "Labels for NCO2 gases in GWP units" /
   n2o_co2eq
   ch4_co2eq
   fgas_co2eq
/ ;

set mapco2eq(emn,nco2eq) /
   n2o . n2o_co2eq
   ch4 . ch4_co2eq
   fgas. fgas_co2eq
/ ;

Parameters

*  CO2 Emissions

   mdf(i0, a0, r)    "CO2 emissions from intermediate demand for domestic goods"
   mmf(i0, a0, r)    "CO2 emissions from intermediate demand for imported good"
   mdp(i0, r)        "CO2 emissions from private demand for domestic goods"
   mmp(i0, r)        "CO2 emissions from private demand for imported goods"
   mdg(i0, r)        "CO2 emissions from public demand for domestic goods"
   mmg(i0, r)        "CO2 emissions from public demand for imported goods"
   mdi(i0, r)        "CO2 emissions from investment demand for domestic goods"
   mmi(i0, r)        "CO2 emissions from investment demand for imported goods"

*  Energy volumes

   edf(i0, a0, r)    "Usage of domestic products by firm"
   emf(i0, a0, r)    "Usage of imported products by firm"
   edp(i0, r)        "Private consumption of domestic goods"
   emp(i0, r)        "Private consumption of imported goods"
   edg(i0, r)        "Public consumption of domestic goods"
   emg(i0, r)        "Public consumption of imported goods"
   edi(i0, r)        "Investment consumption of domestic goods"
   emi(i0, r)        "Investment consumption of imported goods"
   exidag(i0, s, r)  "Bilateral trade in energy"

*  Non-CO2 emissions

   NC_TRAD(NCO2, i0, a0, r)       "Non-CO2 emissions assoc. with input use.."
   NC_ENDW(NCO2, fp, a0, r)       "Non-CO2 emissions assoc. with endowment .."
   NC_QO(NCO2, a0, r)             "Non-CO2 emissions assoc. with output by industries-M. .."
   NC_HH(NCO2, i0, r)             "Non-CO2 emissions assoc. with input use by households-.."
   NC_TRAD_CEQ(NCO2, i0, a0, r)   "Non-CO2 emissions assoc. with input use.."
   NC_ENDW_CEQ(NCO2, fp, a0, r)   "Non-CO2 emissions assoc. with endowment .."
   NC_QO_CEQ(NCO2, a0, r)         "Non-CO2 emissions assoc. with output by industries-M. .."
   NC_HH_CEQ(NCO2, i0, r)         "Non-CO2 emissions assoc. with input use by households-.."

*  CO2 Emissions

   mdf0(i0, a0, r)    "CO2 emissions from intermediate demand for domestic goods"
   mmf0(i0, a0, r)    "CO2 emissions from intermediate demand for imported good"
   mdp0(i0, r)        "CO2 emissions from private demand for domestic goods"
   mmp0(i0, r)        "CO2 emissions from private demand for imported goods"
   mdg0(i0, r)        "CO2 emissions from public demand for domestic goods"
   mmg0(i0, r)        "CO2 emissions from public demand for imported goods"
   mdi0(i0, r)        "CO2 emissions from investment demand for domestic goods"
   mmi0(i0, r)        "CO2 emissions from investment demand for imported goods"

*  Energy volumes

   edf0(i0, a0, r)    "Usage of domestic products by firm"
   emf0(i0, a0, r)    "Usage of imported products by firm"
   edp0(i0, r)        "Private consumption of domestic goods"
   emp0(i0, r)        "Private consumption of imported goods"
   edg0(i0, r)        "Public consumption of domestic goods"
   emg0(i0, r)        "Public consumption of imported goods"
   edi0(i0, r)        "Investment consumption of domestic goods"
   emi0(i0, r)        "Investment consumption of imported goods"
   exidag0(i0, s, r)  "Bilateral trade in energy"

*  Non-CO2 emissions

   NC_TRAD0(NCO2, i0, a0, r)       "Non-CO2 emissions assoc. with input use.."
   NC_ENDW0(NCO2, fp, a0, r)       "Non-CO2 emissions assoc. with endowment .."
   NC_QO0(NCO2, a0, r)             "Non-CO2 emissions assoc. with output by industries-M. .."
   NC_HH0(NCO2, i0, r)             "Non-CO2 emissions assoc. with input use by households-.."
   NC_TRAD_CEQ0(NCO2, i0, a0, r)   "Non-CO2 emissions assoc. with input use.."
   NC_ENDW_CEQ0(NCO2, fp, a0, r)   "Non-CO2 emissions assoc. with endowment .."
   NC_QO_CEQ0(NCO2, a0, r)         "Non-CO2 emissions assoc. with output by industries-M. .."
   NC_HH_CEQ0(NCO2, i0, r)         "Non-CO2 emissions assoc. with input use by households-.."

   total(*,r)                      "Totals"
;

$ifthen exist "%baseName%/flt/%baseName%emiss.gdx"

   execute_load "%BaseName%/flt/%BaseName%Emiss.gdx",
      mdf=mdf, mmf=mmf, mdp=mdp, mmp=mmp, mdg=mdg, mmg=mmg, mdi=mdi, mmi=mmi ;

   mdp0(i0,r) = mdp(i0,r) ;
   mmp0(i0,r) = mmp(i0,r) ;
   mdg0(i0,r) = mdg(i0,r) ;
   mmg0(i0,r) = mmg(i0,r) ;
   mdi0(i0,r) = mdi(i0,r) ;
   mmi0(i0,r) = mmi(i0,r) ;
   mdf0(i0,a0,r) = mdf(i0,a0,r) ;
   mmf0(i0,a0,r) = mmf(i0,a0,r) ;

*
* --- scale emissions commodity specific emissions to recover totals
*

   if(1,

*     Scale individual cells first

      mdp(i0,r)$vdpb(i0,r) = (mdp0(i0,r)/vdpb(i0,r))*VDPBF(i0,r) ;
      mmp(i0,r)$vmpb(i0,r) = (mmp0(i0,r)/vmpb(i0,r))*VMPBF(i0,r) ;
      mdg(i0,r)$vdgb(i0,r) = (mdg0(i0,r)/vdgb(i0,r))*VDGBF(i0,r) ;
      mmg(i0,r)$vmgb(i0,r) = (mmg0(i0,r)/vmgb(i0,r))*VMGBF(i0,r) ;
      mdi(i0,r)$vdib(i0,r) = (mdi0(i0,r)/vdib(i0,r))*VDIBF(i0,r) ;
      mmi(i0,r)$vmib(i0,r) = (mmi0(i0,r)/vmib(i0,r))*VMIBF(i0,r) ;
      mdf(i0,j0,r)$vdfb(i0,j0,r) = (mdf0(i0,j0,r)/vdfb(i0,j0,r))*VDFBF(i0,j0,r) ;
      mmf(i0,j0,r)$vmfb(i0,j0,r) = (mmf0(i0,j0,r)/vmfb(i0,j0,r))*VMFBF(i0,j0,r) ;

   ) ;

   if(0,
      total("old",r) = sum(i0, mdp0(i0,r)) ;
      total("new",r) = sum(i0 $ VDPBF(i0,r), mdp(i0,r)) ;
      mdp(i0,r) $ total("new",r) = (mdp(i0,r) * total("old",r)/total("new",r)) $ VDPBF(i0,r);

      total("old",r) = sum(i0, mmp0(i0,r));
      total("new",r) = sum(i0 $ VMPBF(i0,r), mmp(i0,r));
      mmp(i0,r) $ total("new",r) = (mmp(i0,r) * total("old",r)/total("new",r)) $ VMPBF(i0,r);

      total("old",r) = sum(i0, mdg0(i0,r));
      total("new",r) = sum(i0 $ VDGBF(i0,r), mdg(i0,r));
      mdg(i0,r) $ total("new",r) = (mdg(i0,r) * total("old",r)/total("new",r)) $ VDGBF(i0,r);

      total("old",r) = sum(i0, mmg0(i0,r));
      total("new",r) = sum(i0 $ VMGBF(i0,r), mmg(i0,r));
      mmg(i0,r) $ total("new",r) = (mmg(i0,r) * total("old",r)/total("new",r)) $ VMGBF(i0,r);

      total("old",r) = sum(i0, mdi0(i0,r));
      total("new",r) = sum(i0 $ VDIBF(i0,r), mdi(i0,r));
      mdi(i0,r) $ total("new",r) = (mdi(i0,r) * total("old",r)/total("new",r)) $ VDIBF(i0,r);

      total("old",r) = sum(i0, mmi0(i0,r));
      total("new",r) = sum(i0 $ VMIBF(i0,r), mmi(i0,r));
      mmi(i0,r) $ total("new",r) = (mmi(i0,r) * total("old",r)/total("new",r)) $ VMIBF(i0,r);

      total("old",r) = sum((i0,a0), mdf0(i0,a0,r));
      total("new",r) = sum((i0,a0) $ VDFBF(i0,a0,r), mdf(i0,a0,r));
      mdf(i0,a0,r)$ total("new",r) = (mdf(i0,a0,r) * total("old",r)/total("new",r)) $ VDFBF(i0,a0,r);

      total("old",r) = sum((i0,a0), mmf0(i0,a0,r));
      total("new",r) = sum((i0,a0) $ VMFBF(i0,a0,r), mmf(i0,a0,r) );
      mmf(i0,a0,r) $ total("new",r) = (mmf(i0,a0,r) * total("old",r)/total("new",r)) $ VMFBF(i0,a0,r);
   ) ;

   execute_unload "%baseName%/alt/%baseName%emiss.gdx",
      mdf, mmf, mdp, mmp, mdg, mmg, mdi, mmi ;

$endif

$ifthen exist "%baseName%/flt/%baseName%vole.gdx"

   execute_load  "%baseName%/flt/%baseName%vole.gdx",
      EDF, EMF, EDP, EMP, EDG, EMG, EDI, EMI, EXIDAG ;

   edp0(i0,r) = edp(i0,r) ;
   emp0(i0,r) = emp(i0,r) ;
   edg0(i0,r) = edg(i0,r) ;
   emg0(i0,r) = emg(i0,r) ;
   edi0(i0,r) = edi(i0,r) ;
   emi0(i0,r) = emi(i0,r) ;
   edf0(i0,a0,r) = edf(i0,a0,r) ;
   emf0(i0,a0,r) = emf(i0,a0,r) ;
   exidag0(i0,r,d) = exidag(i0,r,d) ;

   if(1,

*     Scale individual cells first

      edp(i0,r)$vdpb(i0,r) = (edp0(i0,r)/vdpb(i0,r))*VDPBF(i0,r) ;
      emp(i0,r)$vmpb(i0,r) = (emp0(i0,r)/vmpb(i0,r))*VMPBF(i0,r) ;
      edg(i0,r)$vdgb(i0,r) = (edg0(i0,r)/vdgb(i0,r))*VDGBF(i0,r) ;
      emg(i0,r)$vmgb(i0,r) = (emg0(i0,r)/vmgb(i0,r))*VMGBF(i0,r) ;
      edi(i0,r)$vdib(i0,r) = (edi0(i0,r)/vdib(i0,r))*VDIBF(i0,r) ;
      emi(i0,r)$vmib(i0,r) = (emi0(i0,r)/vmib(i0,r))*VMIBF(i0,r) ;
      edf(i0,j0,r)$vdfb(i0,j0,r) = (edf0(i0,j0,r)/vdfb(i0,j0,r))*VDFBF(i0,j0,r) ;
      emf(i0,j0,r)$vmfb(i0,j0,r) = (emf0(i0,j0,r)/vmfb(i0,j0,r))*VMFBF(i0,j0,r) ;
      exidag(i0,r,d)$vfob(i0,r,d) = (exidag0(i0,r,d)/vfob(i0,r,d))*VFOBF(i0,r,d) ;
   ) ;

*
* --- scale energy volumes to recover totals
*
   if(0,
      total("old",r) = sum(i0, edp0(i0,r)) ;
      total("new",r) = sum(i0 $ VDPBF(i0,r), edp(i0,r)) ;
      edp(i0,r) $ total("new",r) = (edp(i0,r) * total("old",r)/total("new",r)) $ VDPBF(i0,r);

      total("old",r) = sum(i0, emp0(i0,r));
      total("new",r) = sum(i0 $ VMPBF(i0,r), emp(i0,r));
      emp(i0,r) $ total("new",r) = (emp(i0,r) * total("old",r)/total("new",r)) $ VMPBF(i0,r);

      total("old",r) = sum(i0, edg0(i0,r));
      total("new",r) = sum(i0 $ VDGBF(i0,r), edg(i0,r));
      edg(i0,r) $ total("new",r) = (edg(i0,r) * total("old",r)/total("new",r)) $ VDGBF(i0,r);

      total("old",r) = sum(i0, emg0(i0,r));
      total("new",r) = sum(i0 $ VMGBF(i0,r), emg(i0,r));
      emg(i0,r) $ total("new",r) = (emg(i0,r) *total("old",r)/total("new",r)) $ VMGBF(i0,r);

      total("old",r) = sum(i0, edi0(i0,r));
      total("new",r) = sum(i0 $ VDIBF(i0,r), edi(i0,r));
      edi(i0,r) $ total("new",r) = (edi(i0,r) * total("old",r)/total("new",r)) $ VDIBF(i0,r);

      total("old",r) = sum(i0, emi0(i0,r));
      total("new",r) = sum(i0 $ VMIBF(i0,r), emi(i0,r));
      emi(i0,r) $ total("new",r) = (emi(i0,r) *total("old",r)/total("new",r)) $ VMIBF(i0,r);

      total("old",r) = sum((i0,a0), edf0(i0,a0,r));
      total("new",r) = sum((i0,a0) $ VDFBF(i0,a0,r), edf(i0,a0,r));
      edf(i0,a0,r)$ total("new",r) = (edf(i0,a0,r) * total("old",r)/total("new",r)) $ VDFBF(i0,a0,r);

      total("old",r) = sum((i0,a0), emf0(i0,a0,r));
      total("new",r) = sum((i0,a0) $ VMFBF(i0,a0,r), emf(i0,a0,r));
      emf(i0,a0,r) $ total("new",r) = (emf(i0,a0,r) * total("old",r)/total("new",r)) $ VMFBF(i0,a0,r);

      loop(i0,
         total("old",r) = sum(rp, exidag0(i0,r,rp));
         total("new",r) = sum(rp $ VFOBF(i0,r,rp), exidag(i0,r,rp));
         exidag(i0,r,rp) $ total("new",r) = (exidag(i0,r,rp) * total("old",r)/total("new",r)) $ VFOBF(i0,r,rp) ;
      ) ;
   ) ;

   execute_unload "%baseName%/alt/%baseName%vole.gdx",
      EDF, EMF, EDP, EMP, EDG, EMG, EDI, EMI, EXIDAG ;

$endif

$ifthen exist "%baseName%/flt/%baseName%nco2.gdx"
   execute_load  "%baseName%/flt/%baseName%nco2.gdx",
      NC_TRAD, NC_ENDW, NC_QO, NC_HH, NC_TRAD_CEQ, NC_ENDW_CEQ, NC_QO_CEQ, NC_HH_CEQ ;

   NC_HH0(nco2,i0,r)          = NC_HH(nco2,i0,r) ;
   NC_HH_CEQ0(nco2,i0,r)      = NC_HH_CEQ(nco2,i0,r) ;
   NC_TRAD0(nco2,i0,a0,r)      = NC_TRAD(nco2,i0,a0,r) ;
   NC_TRAD_CEQ0(nco2,i0,a0,r)  = NC_TRAD_CEQ(nco2,i0,a0,r) ;
   NC_ENDW0(nco2,fp,j0,r)     = NC_ENDW(nco2,fp,j0,r) ;
   NC_ENDW_CEQ0(nco2,fp,j0,r) = NC_ENDW_CEQ(nco2,fp,j0,r) ;
   NC_QO0(nco2,j0,r)          = NC_QO(nco2,j0,r) ;
   NC_QO_CEQ0(nco2,j0,r)      = NC_QO_CEQ(nco2,j0,r) ;

*  Recalculate the original TVOM

   tvom(a0,r) = sum(i0, vdfp(i0,a0,r) + vmfp(i0,a0,r)) + sum(fp, evfp(fp,a0,r)) ;

   if(1,

*     Scale individual cells first

      NC_HH(nco2,i0,r)$(vdpb(i0,r) + vmpb(i0,r)) = (NC_HH0(nco2,i0,r)/(vdpb(i0,r) + vmpb(i0,r)))*(VDPBF(i0,r) + VMPBF(i0,r)) ;
      NC_HH_CEQ(nco2,i0,r)$(vdpb(i0,r) + vmpb(i0,r)) = (NC_HH_CEQ0(nco2,i0,r)/(vdpb(i0,r) + vmpb(i0,r)))*(VDPBF(i0,r) + VMPBF(i0,r)) ;

      NC_TRAD(nco2,i0,j0,r)$(vdfb(i0,j0,r) + vmfb(i0,j0,r)) = (NC_TRAD0(nco2,i0,j0,r)/(vdfb(i0,j0,r) + vmfb(i0,j0,r)))*(VDFBF(i0,j0,r) + VMFBF(i0,j0,r)) ;
      NC_TRAD_CEQ(nco2,i0,j0,r)$(vdfb(i0,j0,r) + vmfb(i0,j0,r)) = (NC_TRAD_CEQ0(nco2,i0,j0,r)/(vdfb(i0,j0,r) + vmfb(i0,j0,r)))*(VDFBF(i0,j0,r) + VMFBF(i0,j0,r)) ;

      NC_ENDW(nco2,fp,j0,r)$(evfb(fp,j0,r)) = (NC_ENDW0(nco2,fp,j0,r)/evfb(fp,j0,r))*EVFBF(fp,j0,r) ;
      NC_ENDW_CEQ(nco2,fp,j0,r)$(evfb(fp,j0,r)) = (NC_ENDW_CEQ0(nco2,fp,j0,r)/evfb(fp,j0,r))*EVFBF(fp,j0,r) ;

      NC_QO(nco2,j0,r)$(tvom(j0,r)) = (NC_QO0(nco2,j0,r)/tvom(j0,r))*tvomf(j0,r) ;
      NC_QO_CEQ(nco2,j0,r)$(tvom(j0,r)) = (NC_QO_CEQ0(nco2,j0,r)/tvom(j0,r))*tvomf(j0,r) ;
      display tvom, tvomf ;
   ) ;
*

*
* --- scale nco2 levels to recover totals

   if(0,
      loop(nco2,

*        Households

         total("old",r) = sum(i0, NC_HH0(nco2,i0,r)) ;
         total("new",r) = sum(i0 $ (VDPBF(i0,r) + VMPBF(i0,r)), NC_HH(nco2,i0,r)) ;
         NC_HH(nco2,i0,r) $ total("new",r) = (NC_HH(nco2,i0,r) * total("old",r)/total("new",r)) $ (VDPBF(i0,r) + VMPBF(i0,r)) ;

         total("old",r) = sum(i0, NC_HH_CEQ0(nco2,i0,r)) ;
         total("new",r) = sum(i0 $ (VDPBF(i0,r) + VMPBF(i0,r)), NC_HH_CEQ(nco2,i0,r)) ;
         NC_HH_CEQ(nco2,i0,r) $ total("new",r) = (NC_HH_CEQ(nco2,i0,r) * total("old",r)/total("new",r)) $ (VDPBF(i0,r) + VMPBF(i0,r)) ;

*        Firms

         total("old",r) = sum((i0,a0), NC_TRAD0(nco2,i0,a0,r));
         total("new",r) = sum((i0,a0) $ (VDFBF(i0,a0,r) + VMFBF(i0,a0,r)), NC_TRAD(nco2,i0,a0,r));
         NC_TRAD(nco2,i0,a0,r)$ total("new",r) = (NC_TRAD(nco2,i0,a0,r) * total("old",r)/total("new",r)) $ (VDFBF(i0,a0,r) + VMFBF(i0,a0,r)) ;

         total("old",r) = sum((i0,a0), NC_TRAD_CEQ0(nco2,i0,a0,r));
         total("new",r) = sum((i0,a0) $ (VDFBF(i0,a0,r) + VMFBF(i0,a0,r)), NC_TRAD_CEQ(nco2,i0,a0,r));
         NC_TRAD_CEQ(nco2,i0,a0,r)$ total("new",r) = (NC_TRAD_CEQ(nco2,i0,a0,r) * total("old",r)/total("new",r)) $ (VDFBF(i0,a0,r) + VMFBF(i0,a0,r)) ;

*        Endowments

         total("old",r) = sum((fp,a0), NC_ENDW0(nco2,fp,a0,r));
         total("new",r) = sum((fp,a0) $ (EVFBF(fp,a0,r)), NC_ENDW(nco2,fp,a0,r));
         NC_ENDW(nco2,fp,a0,r)$ total("new",r) = (NC_ENDW(nco2,fp,a0,r) * total("old",r)/total("new",r)) $ (EVFBF(fp,a0,r)) ;

         total("old",r) = sum((fp,a0), NC_ENDW_CEQ0(nco2,fp,a0,r));
         total("new",r) = sum((fp,a0) $ (EVFBF(fp,a0,r)), NC_ENDW_CEQ(nco2,fp,a0,r));
         NC_ENDW_CEQ(nco2,fp,a0,r)$ total("new",r) = (NC_ENDW_CEQ(nco2,fp,a0,r) * total("old",r)/total("new",r)) $ (EVFBF(fp,a0,r)) ;

*        Output

         total("old",r) = sum(j0, NC_QO0(nco2,j0,r)) ;
         total("new",r) = sum(j0 $ tvomf(j0,r), NC_QO(nco2,j0,r)) ;
         NC_QO(nco2,j0,r) $ total("new",r) = (NC_QO(nco2,j0,r) * total("old",r)/total("new",r)) $ tvomf(j0,r) ;

         total("old",r) = sum(j0, NC_QO_CEQ0(nco2,j0,r)) ;
         total("new",r) = sum(j0 $ tvomf(j0,r), NC_QO_CEQ(nco2,j0,r)) ;
         NC_QO_CEQ(nco2,j0,r) $ total("new",r) = (NC_QO_CEQ(nco2,j0,r) * total("old",r)/total("new",r)) $ tvomf(j0,r) ;
      ) ;
   ) ;

   execute_unload "%baseName%/alt/%baseName%nco2.gdx",
      NC_TRAD, NC_ENDW, NC_QO, NC_HH, NC_TRAD_CEQ, NC_ENDW_CEQ, NC_QO_CEQ, NC_HH_CEQ ;

$endif

$batinclude "emicsv" 1 0
$batinclude "emicsv" 2 0
$batinclude "emicsv" 3


* ----------------------------------------------------------------------------------------
*
*  Adjust labor volumes
*
* ----------------------------------------------------------------------------------------

$ifthen exist "%baseName%/flt/%baseName%Wages.gdx"

   Parameters
      q(l,a0,r)       "Initial labor volumes"
      wage(l,a0,r)    "Initial wage"
      q0(l,a0,r)      "Adjusted labor volume"
      wage0(l,a0,r)   "Adusted wage"
   ;

   execute_load "%baseName%/flt/%baseName%Wages.gdx",
      q, wage ;

   q0(l,a0,r)    = q(l,a0,r) ;
   wage0(l,a0,r) = wage(l,a0,r) ;

*
* --- scale labor volume--keeping wage the same
*

   if(1,

      q(l,a0,r)$wage(l,a0,r) = EVFBF(l,a0,r)/wage(l,a0,r) ;

   ) ;

   execute_unload "%baseName%/alt/%baseName%Wages.gdx",
      q, wage ;

$endif
