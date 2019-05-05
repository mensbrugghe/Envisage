* --------------------------------------------------------------------------------------------------
*
*     Read in the GTAP database
*
* --------------------------------------------------------------------------------------------------

parameters
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

   VXSB(i0, r, rp)      "Exports at basic prices"
   VFOB(i0, r, rp)      "Exports at FOB prices"
   VCIF(i0, r, rp)      "Import at CIF prices"
   VMSB(i0, r, rp)      "Imports at basic prices"

   VST(i0, r)           "Exports of trade and transport services"
   VTWR(i0, j0, r, rp)  "Margins by margin commodity"

   SAVE(r)              "Net saving, by region"
   VDEP(r)              "Capital depreciation"
   VKB(r)               "Capital stock"
   POP0(r)              "Population"

   MAKS(i0,a0,r)        "Make matrix at supply prices"
   MAKB(i0,a0,r)        "Make matrix at basic prices (incl taxes)"
   PTAX(i0,a0,r)        "Output taxes"

   fbep(fp, a0, r)      "Factor subsidies"
   ftrv(fp, a0, r)      "Tax on factor use"
   tvom(a0,r)           "Value of output"
   check(a0,r)          "Check"
;

execute_load "%inDir%/%BaseName%Dat.gdx",
   vdfb, vdfp, vmfb, vmfp,
   vdpb, vdpp, vmpb, vmpp,
   vdgb, vdgp, vmgb, vmgp,
   vdib, vdip, vmib, vmip,
   evfb, evfp, evos,
   vxsb, vfob, vcif, vmsb,
   vst, vtwr,
   save, vdep, vkb, pop0=pop,
   maks, makb
;

*  !!!! MAY WANT TO FIX THIS AT SOME STAGE--THERE IS INCONSISTENCY IN THE
*        HANDLING OF FBEP and FTRV

fbep(fp,a0,r) = 0 ;
ftrv(fp,a0,r) = evfp(fp,a0,r) - evfb(fp,a0,r) ;
ptax(i0,a0,r) = makb(i0,a0,r) - maks(i0,a0,r) ;

* --------------------------------------------------------------------------------------------------
*
*     Read in CO2 emissions data
*
* --------------------------------------------------------------------------------------------------

Parameters
   mdf(i0, a0, r)          "CO2 emissions from domestic intermediate demand"
   mmf(i0, a0, r)          "CO2 emissions from domestic intermediate demand"
   mdp(i0, r)              "CO2 emissions from domestic private demand"
   mmp(i0, r)              "CO2 emissions from domestic private demand"
   mdg(i0, r)              "CO2 emissions from domestic public demand"
   mmg(i0, r)              "CO2 emissions from domestic public demand"
   mdi(i0, r)              "CO2 emissions from investment demand"
   mmi(i0, r)              "CO2 emissions from investment demand"
;

$ifthen exist "%inDir%/%BaseName%Emiss.gdx"
   execute_load "%inDir%/%BaseName%Emiss.gdx", mdf, mmf, mdp, mmp, mdg, mmg, mdi, mmi ;
$else
   mdf(i0,a0,r) = 0 ;
   mmf(i0,a0,r) = 0 ;
   mdp(i0,r)    = 0 ;
   mmp(i0,r)    = 0 ;
   mdg(i0,r)    = 0 ;
   mmg(i0,r)    = 0 ;
   mdi(i0,r)    = 0 ;
   mmi(i0,r)    = 0 ;
$endif

* --------------------------------------------------------------------------------------------------
*
*     Read in the MRIO data if requested
*
* --------------------------------------------------------------------------------------------------

set amrio "MRIO broad agents" /
   INT      "Aggregate intermediate demand"
   CONS     "Private and public demand"
   CGDS     "Investment demand"
/ ;

Parameters
   viuws(i0, amrio,s,d)       "Bilateral imports by broad agent at border prices"
   viums(i0, amrio,s,d)       "Bilateral imports by broad agent at post-tariff prices"
;

if(MRIO,
   $$ifthen exist "%inDir%/%BaseName%MRIO.gdx"
      execute_load "%inDir%/%BaseName%MRIO.gdx", viums, viuws ;
   $$else
      put screen ; put / ;
      put "Requested MRIO version, but could not locate MRIO database" / ;
      put "Check for existence or set the MRIO flag to 0" / ;
      abort "No MRIO file" ;
   $$endif
else
   viuws(i0, amrio, s, d) = 0 ;
   viums(i0, amrio, s, d) = 0 ;
) ;
