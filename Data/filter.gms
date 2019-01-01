*-----------------------------------------------------------------------------------------
$ontext

   Envisage 10 project -- Data preparation modules

   GAMS file : LoadData.gms

   @purpose  : Loads the data for the filter routine

   @author   : Tom Rutherford, with modifications by Wolfgang Britz
               and adjustments for Env10 by Dominique van der Mensbrugghe
   @date     : 21.10.16
   @since    :
   @refDoc   :
   @seeAlso  :
   @calledBy : AggGTAP.cmd
   @Options  :

$offtext
*-----------------------------------------------------------------------------------------

*  Read the user-defined options for this run

$setGlobal PGMName      FILTER
$include "%BaseName%Flt.gms"

scalars
   ifFirstPass    / 1 /
   ifAggTrade     / %ifAggTrade% /
;

file logfile / %basename%Flt.log / ;
file msglog / msglog / ;

*  Get the data

$include "%BaseName%Map.gms"

alias(r,s) ; alias(r,d) ; alias(r,rp) ; alias(i,img) ; alias(i,j) ;

*  Declare and read the GTAP data

Parameters
*  From the standard database

   VDFB(i, a, r)              "Firm purchases of domestic goods at basic prices"
   VDFP(i, a, r)              "Firm purchases of domestic goods at purchaser prices"
   VMFB(i, a, r)              "Firm purchases of imported goods at basic prices"
   VMFP(i, a, r)              "Firm purchases of domestic goods at purchaser prices"
   VDPB(i, r)                 "Private purchases of domestic goods at basic prices"
   VDPP(i, r)                 "Private purchases of domestic goods at purchaser prices"
   VMPB(i, r)                 "Private purchases of imported goods at basic prices"
   VMPP(i, r)                 "Private purchases of domestic goods at purchaser prices"
   VDGB(i, r)                 "Government purchases of domestic goods at basic prices"
   VDGP(i, r)                 "Government purchases of domestic goods at purchaser prices"
   VMGB(i, r)                 "Government purchases of imported goods at basic prices"
   VMGP(i, r)                 "Government purchases of domestic goods at purchaser prices"
   VDIB(i, r)                 "Investment purchases of domestic goods at basic prices"
   VDIP(i, r)                 "Investment purchases of domestic goods at purchaser prices"
   VMIB(i, r)                 "Investment purchases of imported goods at basic prices"
   VMIP(i, r)                 "Investment purchases of domestic goods at purchaser prices"

   EVFB(fp, a, r)             "Primary factor purchases at basic prices"
   EVFP(fp, a, r)             "Primary factor purchases at purchaser prices"
   EVOS(fp, a, r)             "Factor remuneration after income tax"

   VXSB(i, r, r)              "Exports at basic prices"
   VFOB(i, r, r)              "Exports at FOB prices"
   VCIF(i, r, r)              "Import at CIF prices"
   VMSB(i, r, r)              "Imports at basic prices"

   VST(img, r)                "Exports of trade and transport services"
   VTWR(img, i, r, r)         "Margins by margin commodity"

   SAVE(r)                    "Net saving, by region"
   VDEP(r)                    "Capital depreciation"
   VKB(r)                     "Capital stock"
   POP(r)                     "Population"

   MAKS(i,a,r)                "Make matrix at supply prices"
   MAKB(i,a,r)                "Make matrix at basic prices (incl taxes)"
   PTAX(i,a,r)                "Output taxes"

*  CO2 Emissions

   mdf(i, a, r)      "CO2 emissions from intermediate demand for domestic goods"
   mmf(i, a, r)      "CO2 emissions from intermediate demand for imported good"
   mdp(i, r)         "CO2 emissions from private demand for domestic goods"
   mmp(i, r)         "CO2 emissions from private demand for imported goods"
   mdg(i, r)         "CO2 emissions from public demand for domestic goods"
   mmg(i, r)         "CO2 emissions from public demand for imported goods"
   mdi(i, r)         "CO2 emissions from investment demand for domestic goods"
   mmi(i, r)         "CO2 emissions from investment demand for imported goods"

*  Energy volumes

   edf(i, a, r)      "Usage of domestic products by firm"
   emf(i, a, r)      "Usage of imported products by firm"
   edp(i, r)         "Private consumption of domestic goods"
   emp(i, r)         "Private consumption of imported goods"
   edg(i, r)         "Public consumption of domestic goods"
   emg(i, r)         "Public consumption of imported goods"
   edi(i, r)         "Investment consumption of domestic goods"
   emi(i, r)         "Investment consumption of imported goods"
   exidag(i, s, r)   "Bilateral trade in energy"

*  Non-CO2 emissions

   NC_TRAD(NCO2, i, a, r)        "Non-CO2 emissions assoc. with input use.."
   NC_ENDW(NCO2, fp, a, r)       "Non-CO2 emissions assoc. with endowment .."
   NC_QO(NCO2, a, r)             "Non-CO2 emissions assoc. with output by industries-M. .."
   NC_HH(NCO2, i, r)             "Non-CO2 emissions assoc. with input use by households-.."
   NC_TRAD_CEQ(NCO2, i, a, r)    "Non-CO2 emissions assoc. with input use.."
   NC_ENDW_CEQ(NCO2, fp, a, r)   "Non-CO2 emissions assoc. with endowment .."
   NC_QO_CEQ(NCO2, a, r)         "Non-CO2 emissions assoc. with output by industries-M. .."
   NC_HH_CEQ(NCO2, i, r)         "Non-CO2 emissions assoc. with input use by households-.."
;

execute_load "%baseName%/agg/%baseName%Dat.gdx",
   vdfb, vdfp, vmfb, vmfp,
   vdpb, vdpp, vmpb, vmpp,
   vdgb, vdgp, vmgb, vmgp,
   vdib, vdip, vmib, vmip,
   evfb, evfp, evos,
   vxsb, vfob, vcif, vmsb,
   vst, vtwr,
   save, vdep, vkb, pop,
   maks, makb, ptax
;

$include "filter/filter.gms"
