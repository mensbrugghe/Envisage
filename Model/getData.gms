* --------------------------------------------------------------------------------------------------
*
*  Load the base SAM from GTAP
*
* --------------------------------------------------------------------------------------------------

alias(i0,j0) ;

parameters

*  From the standard database

   VDFB(i0, a0, r)      "Firm purchases of domestic goods at basic prices"
   VDFP(i0, a0, r)      "Firm purchases of domestic goods at purchaser prices"
   VMFB(i0, a0, r)      "Firm purchases of imported goods at basic prices"
   VMFP(i0, a0, r)      "Firm purchases of domestic goods at purchaser prices"
   VDPB(i0, r)          "Private purchases of domestic goods at basic prices"
   VDPP(i0, r)          "Private purchases of domestic goods at purchaser prices"
   VMPB(i0, r)          "Private purchases of imported goods at basic prices"
   VMPP(i0, r)          "Private purchases of domestic goods at purchaser prices"
   VDGB(i0, r)          "Government purchases of domestic goods at basic prices"
   VDGP(i0, r)          "Government purchases of domestic goods at purchaser prices"
   VMGB(i0, r)          "Government purchases of imported goods at basic prices"
   VMGP(i0, r)          "Government purchases of domestic goods at purchaser prices"
   VDIB(i0, r)          "Investment purchases of domestic goods at basic prices"
   VDIP(i0, r)          "Investment purchases of domestic goods at purchaser prices"
   VMIB(i0, r)          "Investment purchases of imported goods at basic prices"
   VMIP(i0, r)          "Investment purchases of domestic goods at purchaser prices"

   EVFB(fp, a0, r)      "Primary factor purchases at basic prices"
   EVFP(fp, a0, r)      "Primary factor purchases at purchaser prices"
   EVOS(fp, a0, r)      "Factor remuneration after income tax"

   VXSB(i0, r, r)       "Exports at basic prices"
   VFOB(i0, r, r)       "Exports at FOB prices"
   VCIF(i0, r, r)       "Import at CIF prices"
   VMSB(i0, r, r)       "Imports at basic prices"

   VST(i0, r)           "Exports of trade and transport services"
   VTWR(j0, i0, r, r)   "Margins by margin commodity"

   SAVE(r)              "Net saving, by region"
   VDEP(r)              "Capital depreciation"
   VKB(r)               "Capital stock"
   POPG(r)              "GTAP population"

   MAKS(i0,a0,r)        "Make matrix at supply prices"
   MAKB(i0,a0,r)        "Make matrix at basic prices (incl taxes)"
*  PTAX(i0,a0,r)        "Output taxes"

   VNTM(i0, r, rp)      "Non-tariff measures revenue"

   remit00(l,r,rp)      "Initial remittances"
   yqtf0(r)             "Initial outflow of capital income"
   yqht0(r)             "Initial inflow of capital income"

   voa0(a0,r)           "Value of output"
   voa(a,r)             "Value of output"
   osep0(a0,r)          "Value of output subsidies"
   osep(a,r)            "Value of output subsidies"
   cmat(i,k,r)          "Consumer transition matrix"

   empl(l,a0,r)         "Employment levels"

*  Water data

   h2ocrp(a0,r)         "Water withdrawal in crop activities"
   h2oUse(wbnd,r)       "Water withdrawal by aggregate uses"

*  Energy matrices

   nrgdf(i0, a0, r)     "Usage of domestic products by firm, MTOE"
   nrgmf(i0, a0, r)     "Usage of imported products by firm, MTOE"
   nrgdp(i0, r)         "Private usage of domestic products, MTOE"
   nrgmp(i0, r)         "Private usage of imported products, MTOE"
   nrgdg(i0, r)         "Government usage of domestic products, MTOE"
   nrgmg(i0, r)         "Government usage of imported products, MTOE"
   nrgdi(i0, r)         "Investment usage of domestic products, MTOE"
   nrgmi(i0, r)         "Investment usage of imported products, MTOE"
   exi(i0, r, rp)       "Bilateral trade in energy"

   nrgComb(i0, a0, r)   "Energy combustion matrix"

   gwhr0(a0,r)          "Electricity output in gwhr"
   gwhr(r,a)            "Electricity output in gwhr"

*  Carbon emission matrices

   mdf(i0, a0, r)       "Emissions from domestic product in current production, .."
   mmf(i0, a0, r)       "Emissions from imported product in current production, .."
   mdp(i0, r)           "Emissions from private consumption of domestic product, Mt CO2"
   mmp(i0, r)           "Emissions from private consumption of imported product, Mt CO2"
   mdg(i0, r)           "Emissions from govt consumption of domestic product, Mt CO2"
   mmg(i0, r)           "Emissions from govt consumption of imported product, Mt CO2"
   mdi(i0, r)           "Emissions from invt consumption of domestic product, Mt CO2"
   mmi(i0, r)           "Emissions from invt consumption of imported product, Mt CO2"

*  NON-CO2 emission matrices

   nc_qo_ceq(em, a0, r)          "Non-CO2 emissions assoc. with output by industries-M. .."
   nc_endw_ceq(em, fp, a0, r)    "Non-CO2 emissions assoc. with endowment .."
   nc_trad_ceq(em, i0, a0, r)    "Non-CO2 emissions assoc. with input use.."
   nc_hh_ceq(em, i0, r)          "Non-CO2 emissions assoc. with input use by households-.."
   nc_qo(em, a0, r)              "Non-CO2 emissions assoc. with output by industries-M. .."
   nc_endw(em, fp, a0, r)        "Non-CO2 emissions assoc. with endowment .."
   nc_trad(em, i0, a0, r)        "Non-CO2 emissions assoc. with input use.."
   nc_hh(em, i0, r)              "Non-CO2 emissions assoc. with input use by households-.."
;

execute_load "%BASENAME%Dat.gdx"
   vdfb, vdfp, vmfb, vmfp,
   vdpb, vdpp, vmpb, vmpp,
   vdgb, vdgp, vmgb, vmgp,
   vdib, vdip, vmib, vmip,
   evfb, evfp, evos,
   vxsb, vfob, vcif, vmsb,
   vst, vtwr,
   save, vdep, vkb, popg=pop,
*  ptax,
   maks, makb
;

*  For Comp Stat Overlaypop should always be 0
*  For dynamics, popg = SSP_POP if Overlaypop = 1, else equals GTAP level

if(%OVERLAYPOP% eq 0,
   execute_load "%BASENAME%Dat.gdx" , popg=pop ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  Load the satellite file
*
* --------------------------------------------------------------------------------------------------

execute_load "%BASENAME%Sat.gdx"
   nrgComb, gwhr0=gwhr,
   h2ocrp, h2oUse
;

* --------------------------------------------------------------------------------------------------
*
*  Load the energy file
*
* --------------------------------------------------------------------------------------------------

execute_load "%BASENAME%Vole.gdx"
   nrgdf=edf, nrgmf=emf,
   nrgdp=edp, nrgmp=emp,
   nrgdg=edg, nrgmg=emg,
   nrgdi=edi, nrgmi=emi,
   exi=exidag ;
;

* --------------------------------------------------------------------------------------------------
*
*  Load the emission files
*
* --------------------------------------------------------------------------------------------------

execute_load "%BASENAME%Emiss.gdx"
   mdf, mmf, mdp,  mmp, mdg, mmg, mdi, mmi ;

$ifthen exist "%BASENAME%NCO2.gdx"

   execute_load "%BASENAME%NCO2.gdx"
      nc_qo_ceq, nc_endw_ceq, nc_trad_ceq, nc_hh_ceq, nc_qo, nc_endw, nc_trad, nc_hh ;

   ifNCO2 = 1 ;

$else

   nc_qo_ceq(emn, a0, r)        = 0 ;
   nc_endw_ceq(emn, fp, a0, r)  = 0 ;
   nc_trad_ceq(emn, i0, a0, r)  = 0 ;
   nc_hh_ceq(emn, i0, r)        = 0 ;
   nc_qo(emn, a0, r)            = 0 ;
   nc_endw(emn, fp, a0, r)      = 0 ;
   nc_trad(emn, i0, a0, r)      = 0 ;
   nc_hh(emn, i0, r)            = 0 ;

   ifNCO2 = 0 ;

$endif

* --------------------------------------------------------------------------------------------------
*
*  Load the BoP file
*
* --------------------------------------------------------------------------------------------------

$ifthen exist "%BASENAME%BoP.gdx"

   execute_load "%BASENAME%BoP.gdx"
      remit00=remit, yqtf0=yqtf, yqht0=yqht, ODAIn0=ODAIn, ODAOut0=ODAOut ;

$else

   remit00(l,r,rp) = 0 ;
   yqtf0(r)        = 0 ;
   yqht0(r)        = 0 ;
   ODAIn0(r)       = 0 ;
   ODAOut0(r)      = 0 ;

$endif

* --------------------------------------------------------------------------------------------------
*
*  Load the employment file
*
* --------------------------------------------------------------------------------------------------

$ifthen exist "%BASENAME%Wages.gdx"

   execute_load "%BASENAME%Wages.gdx", empl=q ;

$else

   empl(l,a0,r) = na ;

$endif

* --------------------------------------------------------------------------------------------------
*
*  Load the NTM file
*
* --------------------------------------------------------------------------------------------------

$iftheni %NTMFlag% == 1

   $$ifthen exist "%BASENAME%NTM.gdx"

      ntmFlag = 1 ;

      execute_load "%BASENAME%NTM.gdx", VNTM ;

   $$else

      ntmFlag = 0 ;

      VNTM(i0, r, rp) = 0 ;

   $$endif

$else

      ntmFlag = 0 ;

      VNTM(i0, r, rp) = 0 ;

$endif

set amrio "End-user accounts in MRIO database" /
   INT   "Intermediate demand"
   CONS  "Private and public demand"
   CGDS  "Investment demand"
/ ;

Parameter
   VIUMS0(i0,amrio,s,d)    "Value of imports by end-user, tariff-inclusive"
   VIUWS0(i0,amrio,s,d)    "Value of imports by end-user, at border prices"
   VIUMS(i,amrio,s,d)      "Value of imports by end-user, tariff-inclusive"
   VIUWS(i,amrio,s,d)      "Value of imports by end-user, at border prices"
;


VIUMS(i,amrio,s,d) = 0 ;
VIUWS(i,amrio,s,d) = 0 ;

if(MRIO,

   $$ifthen exist "%BASENAME%MRIO.gdx"

*     Get the MRIO data

      execute_load "%BASENAME%MRIO.gdx", viums0=viums, viuws0=viuws ;

   $$endif
) ;
