*-----------------------------------------------------------------------------------------
$ontext

   Envisage 10 project -- Data preparation modules

   GAMS file : AggGTAP.gms

   @purpose  : Aggregate standard GTAP database--emulation the GTAPAgg GEMPACK program.

   @author   : Dominique van der Mensbrugghe
   @date     : 21.10.16
   @since    :
   @refDoc   :
   @seeAlso  :
   @calledBy : AggGTAP.cmd
   @Options  : ifCSV (default=0)
               ifAggTrade (default=1)
               ifWater (default=OFF)

$offtext
*-----------------------------------------------------------------------------------------

* ----------------------------------------------------------------------------------------
*
*  GAMS program to aggregate a GTAP database
*
* ----------------------------------------------------------------------------------------

*  Define the aggregation macros

$macro AGG1(v0,v,x0,x,mapx)                     v(x)     = sum(x0$mapx(x0,x), v0(x0))
$macro AGG2(v0,v,x0,x,mapx,y0,y,mapy)           v(x,y)   = sum((x0,y0)$(mapx(x0,x) and mapy(y0,y)), v0(x0,y0))
$macro AGG3(v0,v,x0,x,mapx,y0,y,mapy,z0,z,mapz) v(x,y,z) = sum((x0,y0,z0)$(mapx(x0,x) and mapy(y0,y) and mapz(z0,z)), v0(x0,y0,z0))
$macro AGG4(v0,v,x0,x,mapx,y0,y,mapy,z0,z,mapz,w0,w,mapw) v(x,y,z,w) = sum((x0,y0,z0,w0)$(mapx(x0,x) and mapy(y0,y) and mapz(z0,z) and mapw(w0,w)), v0(x0,y0,z0,w0))

*  Labor options

acronyms off, on, noLab, agLab, allLab, giddLab, alterTax, GTAP, Env ;

*  Load the aggregation mappings

$include "%BaseName%Map.gms"

* put  "FS = ", "%system.filesys%" / ;

$set OPSYS
$If %system.filesys% == UNIX     $set OPSYS "UNIX"
$If %system.filesys% == DOS      $set OPSYS "DOS"
$If %system.filesys% == "MSNT"   $set OPSYS "DOS"
$If "%OPSYS%." == "." Abort "filesys not recognized" ;

$set console
$iftheni "%OPSYS%" == "UNIX"
   $$set console /dev/tty
$elseifi "%OPSYS%" == "DOS"
   $$set console con
$else
   Abort "Unknown operating system" ;
$endif

file screen / '%console%' /;

put screen ;
put / ;

scalar ifWater / %ifWater% / ;

scalar ifPower / %ifPower% / ;

$if not setglobal ifCSV $setglobal ifCSV
$if "%ifCSV%" == "" $setglobal ifCSV 0
scalar ifCSV / %ifCSV% / ;

$if not setglobal ifAggTrade $setglobal ifAggTrade
$if "%ifAggTrade%" == "" $setglobal ifAggTrade 1
scalar ifAggTrade / %ifAggTrade% / ;

$if not setGlobal ifMRIO $setGlobal ifMRIO
$if "%ifMRIO%" == "" $setglobal ifMRIO OFF

$show

* ------------------------------------------------------------------------------
*
*  Validate the aggregations
*
* ------------------------------------------------------------------------------

parameters
   r0Flag(r0)
   rFlag(r)
   a0Flag(a0)
   aFlag(a)
   i0Flag(a0)
   iFlag(a)
   fpFlag(fp)
   fp0Flag(fp0)
   total
   work
   ifFirstPass    / 1 /
   ifCheck        / 1 /
   ifFirst        / 1 /
   order          / 0 /
;

r0Flag(r0) = sum(mapr(r0,r), 1) ;
loop(r0,
   if(r0Flag(r0) ne 1,
      put screen ;
      if(ifFirst eq 1,
         ifFirst = 0 ;
         ifCheck = 0 ;
         put "The following GTAP region(s) have not been mapped:" / ;
      ) ;
      put r0.tl:<10, "     ", r0.te(r0) / ;
   ) ;
) ;

put screen ; put / ;

ifFirst = 1 ;
rFlag(r) = sum(mapr(r0,r), 1) ;
loop(r,
   if(rFlag(r) eq 0,
      put screen ;
      if(ifFirst eq 1,
         ifFirst = 0 ;
         ifCheck = 0 ;
         put "The following aggregate region(s) have no GTAP regions mapped to them:" / ;
      ) ;
      put r.tl:<10, "     ", r.te(r) / ;
   ) ;
) ;

ifFirst = 1 ;

i0Flag(i0) = sum(mapa(i0,i), 1) ;
loop(i0,
   if(i0Flag(i0) ne 1,
      put screen ;
      if(ifFirst eq 1,
         ifFirst = 0 ;
         ifCheck = 0 ;
         put "The following GTAP sector(s) have not been mapped:" / ;
      ) ;
      put i0.tl:<10, "     ", i0.te(i0) / ;
   ) ;
) ;

put screen ; put / ;

ifFirst = 1 ;
iFlag(i) = sum(mapa(i0,i), 1) ;
loop(i,
   if(iFlag(i) eq 0,
      put screen ;
      if(ifFirst eq 1,
         ifFirst = 0 ;
         ifCheck = 0 ;
         put "The following aggregate sector(s) have no GTAP sectors mapped to them:" / ;
      ) ;
      put i.tl:<10, "     ", i.te(i) / ;
   ) ;
) ;

fp0Flag(fp0) = sum(mapf(fp0,fp), 1) ;
loop(fp0,
   if(fp0Flag(fp0) ne 1,
      put screen ;
      if(ifFirst eq 1,
         ifFirst = 0 ;
         ifCheck = 0 ;
         put "The following GTAP factor(s) have not been mapped:" / ;
      ) ;
      put fp0.tl:<10, "     ", fp0.te(fp0) / ;
   ) ;
) ;

put screen ; put / ;

ifFirst = 1 ;
fpFlag(fp) = sum(mapf(fp0,fp), 1) ;
loop(fp,
   if(fpFlag(fp) eq 0,
      put screen ;
      if(ifFirst eq 1,
         ifFirst = 0 ;
         ifCheck = 0 ;
         put "The following aggregate factor(s) have no GTAP factors mapped to them:" / ;
      ) ;
      put fp.tl:<10, "     ", fp.te(fp) / ;
   ) ;
) ;

put screen ; put / ;

$iftheni %Model% == Env

*  Check the mapk mappings

Parameters
   commFlag(commf)
   kFlag(k)
;

ifFirst = 1 ;

commFlag(commf) = sum(mapk(commf,k), 1) ;
loop(commf,
   if(commFlag(commf) ne 1,
      put screen ;
      if(ifFirst eq 1,
         ifFirst = 0 ;
         ifCheck = 0 ;
         put "The following commodity(ies) have not been mapped to a consumer bundle:" / ;
      ) ;
      put commf.tl:<10, "     ", commf.te(commf) / ;
   ) ;
) ;

put screen ; put / ;

ifFirst = 1 ;
kFlag(k) = sum(mapk(commf,k), 1) ;
loop(k,
   if(kFlag(k) eq 0,
      put screen ;
      if(ifFirst eq 1,
         ifFirst = 0 ;
         ifCheck = 0 ;
         put "The following consumer bundle(s) have no commodities mapped to them:" / ;
      ) ;
      put k.tl:<10, "     ", k.te(k) / ;
   ) ;
) ;
$endif

abort$(ifCheck eq 0) "Invalid mapping file" ;

put screen ;
put "All mappings have passed standard checks..." / / ;

putclose screen ;

* ------------------------------------------------------------------------------
*
*  Save the aggregation mappings
*
* ------------------------------------------------------------------------------

$iftheni "%SAVEMAP%" == "TXT"
   $$include saveMap.gms
$elseifi "%SAVEMAP%" == "LATEX"
   $$include saveMap.gms
$else
   $$show
   DISPLAY "**** -- Invalid option for SAVEMAP (%SAVEMAP%)" ;
   DISPLAY "**** -- Valid options are 'TXT' and 'LATEX'" ;
*   Abort "Invalid option" ;
$endif

* ------------------------------------------------------------------------------
*
*  Aggregate the GTAP data
*
* ------------------------------------------------------------------------------

parameters

*  From the standard database

   VDFB(COMM, ACTS, REG)            "Firm purchases of domestic goods at basic prices"
   VDFP(COMM, ACTS, REG)            "Firm purchases of domestic goods at purchaser prices"
   VMFB(COMM, ACTS, REG)            "Firm purchases of imported goods at basic prices"
   VMFP(COMM, ACTS, REG)            "Firm purchases of domestic goods at purchaser prices"
   VDPB(COMM, REG)                  "Private purchases of domestic goods at basic prices"
   VDPP(COMM, REG)                  "Private purchases of domestic goods at purchaser prices"
   VMPB(COMM, REG)                  "Private purchases of imported goods at basic prices"
   VMPP(COMM, REG)                  "Private purchases of domestic goods at purchaser prices"
   VDGB(COMM, REG)                  "Government purchases of domestic goods at basic prices"
   VDGP(COMM, REG)                  "Government purchases of domestic goods at purchaser prices"
   VMGB(COMM, REG)                  "Government purchases of imported goods at basic prices"
   VMGP(COMM, REG)                  "Government purchases of domestic goods at purchaser prices"
   VDIB(COMM, REG)                  "Investment purchases of domestic goods at basic prices"
   VDIP(COMM, REG)                  "Investment purchases of domestic goods at purchaser prices"
   VMIB(COMM, REG)                  "Investment purchases of imported goods at basic prices"
   VMIP(COMM, REG)                  "Investment purchases of domestic goods at purchaser prices"

   EVFB(ENDW, ACTS, REG)            "Primary factor purchases at basic prices"
   EVFP(ENDW, ACTS, REG)            "Primary factor purchases at purchaser prices"
   EVOS(ENDW, ACTS, REG)            "Factor remuneration after income tax"

   VXSB(COMM, REG, REG)             "Exports at basic prices"
   VFOB(COMM, REG, REG)             "Exports at FOB prices"
   VCIF(COMM, REG, REG)             "Import at CIF prices"
   VMSB(COMM, REG, REG)             "Imports at basic prices"

   VST(MARG, REG)                   "Exports of trade and transport services"
   VTWR(MARG, COMM, REG, REG)       "Margins by margin commodity"

   SAVE(REG)                        "Net saving, by region"
   VDEP(REG)                        "Capital depreciation"
   VKB(REG)                         "Capital stock"
   POP(REG)                         "Population"

   MAKS(COMM,ACTS,REG)              "Make matrix at supply prices"
   MAKB(COMM,ACTS,REG)              "Make matrix at basic prices (incl taxes)"
   PTAX(COMM,ACTS,REG)              "Output taxes"

*  Auxiliary data

   VOA(ACTS, REG)                   "Value of output pre-tax"
;

*  Load the GTAP data base

execute_load "%gtpDir%%GTAPBASE%DAT.gdx",
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

voa(acts,reg) = sum(comm, maks(comm,acts,reg)) ;

*  Scale output -- takes care of advanced technologies
display scaleXP ;
vdfb(comm,acts,reg) = scaleXP(acts)*vdfb(comm,acts,reg) ;
vdfp(comm,acts,reg) = scaleXP(acts)*vdfp(comm,acts,reg) ;
vmfb(comm,acts,reg) = scaleXP(acts)*vmfb(comm,acts,reg) ;
vmfp(comm,acts,reg) = scaleXP(acts)*vmfp(comm,acts,reg) ;
evfb(endw,acts,reg) = scaleXP(acts)*evfb(endw,acts,reg) ;
evfp(endw,acts,reg) = scaleXP(acts)*evfp(endw,acts,reg) ;

* ----------------------------------------------------------------------------------------
*
*  Declare the aggregated parameters
*
* ----------------------------------------------------------------------------------------

alias(r,rp) ; alias(r,s) ; alias(r,d) ; alias(img,i) ; alias(a,a1) ;
alias(reg,src) ; alias(reg,dst) ;

parameters
   VDFB1(i, a, r)             "Firm purchases of domestic goods at basic prices"
   VDFP1(i, a, r)             "Firm purchases of domestic goods at purchaser prices"
   VMFB1(i, a, r)             "Firm purchases of imported goods at basic prices"
   VMFP1(i, a, r)             "Firm purchases of domestic goods at purchaser prices"
   VDPB1(i, r)                "Private purchases of domestic goods at basic prices"
   VDPP1(i, r)                "Private purchases of domestic goods at purchaser prices"
   VMPB1(i, r)                "Private purchases of imported goods at basic prices"
   VMPP1(i, r)                "Private purchases of domestic goods at purchaser prices"
   VDGB1(i, r)                "Government purchases of domestic goods at basic prices"
   VDGP1(i, r)                "Government purchases of domestic goods at purchaser prices"
   VMGB1(i, r)                "Government purchases of imported goods at basic prices"
   VMGP1(i, r)                "Government purchases of domestic goods at purchaser prices"
   VDIB1(i, r)                "Investment purchases of domestic goods at basic prices"
   VDIP1(i, r)                "Investment purchases of domestic goods at purchaser prices"
   VMIB1(i, r)                "Investment purchases of imported goods at basic prices"
   VMIP1(i, r)                "Investment purchases of domestic goods at purchaser prices"

   EVFB1(fp, a, r)            "Primary factor purchases at basic prices"
   EVFP1(fp, a, r)            "Primary factor purchases at purchaser prices"
   EVOS1(fp, a, r)            "Factor remuneration after income tax"

   VXSB1(i, r, r)             "Exports at basic prices"
   VFOB1(i, r, r)             "Exports at FOB prices"
   VCIF1(i, r, r)             "Import at CIF prices"
   VMSB1(i, r, r)             "Imports at basic prices"

   VST1(img, r)               "Exports of trade and transport services"
   VTWR1(img, i, r, r)        "Margins by margin commodity"

   SAVE1(r)                   "Net saving, by region"
   VDEP1(r)                   "Capital depreciation"
   VKB1(r)                    "Capital stock"
   POP1(r)                    "Population"

   MAKS1(i,a,r)               "Make matrix at supply prices"
   MAKB1(i,a,r)               "Make matrix at basic prices (incl taxes)"
   PTAX1(i,a,r)               "Output taxes"

*  Auxiliary data
   voa1(a,r)                  "Value of output pre-tax"
;

*  Aggregate the GTAP matrices

Agg3(vdfb,vdfb1,i0,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg3(vdfp,vdfp1,i0,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg3(vmfb,vmfb1,i0,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg3(vmfp,vmfp1,i0,i,mapa,a0,a,mapa,r0,r,mapr) ;

Agg2(vdpb,vdpb1,i0,i,mapa,r0,r,mapr) ;
Agg2(vdpp,vdpp1,i0,i,mapa,r0,r,mapr) ;
Agg2(vmpb,vmpb1,i0,i,mapa,r0,r,mapr) ;
Agg2(vmpp,vmpp1,i0,i,mapa,r0,r,mapr) ;

Agg2(vdgb,vdgb1,i0,i,mapa,r0,r,mapr) ;
Agg2(vdgp,vdgp1,i0,i,mapa,r0,r,mapr) ;
Agg2(vmgb,vmgb1,i0,i,mapa,r0,r,mapr) ;
Agg2(vmgp,vmgp1,i0,i,mapa,r0,r,mapr) ;

Agg2(vdib,vdib1,i0,i,mapa,r0,r,mapr) ;
Agg2(vdip,vdip1,i0,i,mapa,r0,r,mapr) ;
Agg2(vmib,vmib1,i0,i,mapa,r0,r,mapr) ;
Agg2(vmip,vmip1,i0,i,mapa,r0,r,mapr) ;

Agg3(evfb,evfb1,fp0,fp,mapf,i0,i,mapa,r0,r,mapr) ;
Agg3(evfp,evfp1,fp0,fp,mapf,i0,i,mapa,r0,r,mapr) ;
Agg3(evos,evos1,fp0,fp,mapf,i0,i,mapa,r0,r,mapr) ;

Agg3(VXSB,VXSB1,i0,i,mapa,r0,r,mapr,rp0,rp,mapr) ;
Agg3(VFOB,VFOB1,i0,i,mapa,r0,r,mapr,rp0,rp,mapr) ;
Agg3(VCIF,VCIF1,i0,i,mapa,r0,r,mapr,rp0,rp,mapr) ;
Agg3(VMSB,VMSB1,i0,i,mapa,r0,r,mapr,rp0,rp,mapr) ;

Agg2(VST,VST1,img0,img,mapa,r0,r,mapr) ;

Agg4(VTWR,VTWR1,img0,img,mapa,i0,i,mapa,r0,r,mapr,rp0,rp,mapr) ;

Agg1(SAVE,SAVE1,r0,r,mapr) ;
Agg1(VDEP,VDEP1,r0,r,mapr) ;
Agg1(VKB,VKB1,r0,r,mapr) ;
Agg1(POP,POP1,r0,r,mapr) ;

Agg3(maks,maks1,i0,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg3(makb,makb1,i0,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg3(ptax,ptax1,i0,i,mapa,a0,a,mapa,r0,r,mapr) ;

voa1(a,r) = sum(i, maks1(i,a,r)) ;

*  Move land to capital

loop((cap,lnd,a)$mapt(a),
   evfp1(cap,a,r) = evfp1(cap,a,r) + evfp1(lnd,a,r) ;
   evfp1(lnd,a,r) = 0 ;
   evfb1(cap,a,r) = evfb1(cap,a,r) + evfb1(lnd,a,r) ;
   evfb1(lnd,a,r) = 0 ;
   evos1(cap,a,r) = evos1(cap,a,r) + evos1(lnd,a,r) ;
   evos1(lnd,a,r) = 0 ;
) ;


*  Move natural resource to capital

loop((cap,nrs,a)$mapn(a),
   evfp1(cap,a,r) = evfp1(cap,a,r) + evfp1(nrs,a,r) ;
   evfp1(nrs,a,r) = 0 ;
   evfb1(cap,a,r) = evfb1(cap,a,r) + evfb1(nrs,a,r) ;
   evfb1(nrs,a,r) = 0 ;
   evos1(cap,a,r) = evos1(cap,a,r) + evos1(nrs,a,r) ;
   evos1(nrs,a,r) = 0 ;
) ;

*  Save the data

execute_unload "%baseName%/agg/%baseName%Dat.gdx",

   vdfb1=vdfb, vdfp1=vdfp, vmfb1=vmfb, vmfp1=vmfp,
   vdpb1=vdpb, vdpp1=vdpp, vmpb1=vmpb, vmpp1=vmpp,
   vdgb1=vdgb, vdgp1=vdgp, vmgb1=vmgb, vmgp1=vmgp,
   vdib1=vdib, vdip1=vdip, vmib1=vmib, vmip1=vmip,
   evfb1=evfb, evfp1=evfp, evos1=evos,
   vxsb1=vxsb, vfob1=vfob, vcif1=vcif, vmsb1=vmsb,
   vst1=vst,   vtwr1=vtwr,
   save1=save, vdep1=vdep,
   vkb1=vkb,   pop1=pop,
   maks1=maks, makb1=makb, ptax1=ptax
;

*  Save the NIPA accounts for dis-aggregated and aggregated database
*  Save energy subsidies as well

$include "nipa.gms"

*  Save the SAM if requested

file csv / "%baseName%/agg/%baseName%Agg.csv" / ;
$batinclude "aggsam.gms" AggGTAP 1

* ------------------------------------------------------------------------------
*
*  Aggregate the GTAP parameters
*
* ------------------------------------------------------------------------------

* ------------------------------------------------------------------------------
*
*  Aggregate GTAP parameters
*
* ------------------------------------------------------------------------------

*  GTAP parameters

parameters
   ESUBT(ACTS,REG)         "Top level production elasticity"
   ESUBC(ACTS,REG)         "Elasticity across intermedate inputs"
   ESUBVA(ACTS,REG)        "Inter-factor substitution elasticity"
   ETRAQ(ACTS,REG)         "CET make elasticity"
   ESUBQ(COMM,REG)         "CES make elasticity"
   INCPAR(COMM, REG)       "CDE expansion parameter"
   SUBPAR(COMM, REG)       "CDE substitution parameter"
   ESUBG(REG)              "CES government expenditure elasticity"
   ESUBI(REG)              "CES investment expenditure elasticity"
   ESUBD(COMM,REG)         "Top level Armington elasticity"
   ESUBM(COMM,REG)         "Second level Armington elasticity"
   ESUBS(MARG)             "CES margin elasticity"
   ETRAE(ENDW,REG)         "CET transformation elasticities for factors"
   RORFLEX(REG)            "Flexibility of expected net ROR wrt investment"
;

*  Load the data

execute_load "%gtpDir%%GTAPBASE%par.gdx",
   ESUBT, ESUBC, ESUBVA, ETRAQ, ESUBQ,
   INCPAR, SUBPAR, ESUBG, ESUBI,
   ESUBD, ESUBM, ESUBS, ETRAE, RORFLEX
;

*  Aggregate to intermediate levels

parameters
   ESUBT1(a,r)          "Top level production elasticity"
   ESUBC1(a,r)          "Elasticity across intermedate inputs"
   ESUBVA1(a,r)         "Inter-factor substitution elasticity"
*  USER SUPPLIED
*  ETRAQ1(a,r)          "CET make elasticity"
*  ESUBQ1(i,r)          "CES make elasticity"
   INCPAR1(i,r)         "CDE expansion parameter"
   SUBPAR1(i,r)         "CDE substitution parameter"
*  USER SUPPLIED
*  ESUBG1(r)            "CES government expenditure elasticity"
*  ESUBI1(r)            "CES investment expenditure elasticity"
   ESUBD1(i,r)          "Top level Armington elasticity"
   ESUBM1(i,r)          "Second level Armington elasticity"
*  USER SUPPLIED
   ESUBS1(img)          "CES margin elasticity"
   RORFLEX1(r)          "Flexibility of expected net ROR wrt investment"
;

*  Aggregate the data

*  ESUBT -- use regional output as weight

esubt1(a,r) = sum(a0$mapa(a0,a), sum(reg$mapr(reg,r), voa(a0, reg))) ;
esubt1(a,r)$esubt1(a,r) = sum(a0$mapa(a0,a),
      sum(reg$mapr(reg,r), voa(a0, reg)*ESUBT(a0,reg))) / esubt1(a,r) ;

*  ESUBC -- use regional intermediate demand at purchasers' prices as weight

esubc1(a,r) = sum(a0$mapa(a0,a), sum((reg,i0)$mapr(reg,r), (vdfp(i0,a0,reg)+vmfp(i0,a0,reg)))) ;
esubc1(a,r)$esubc1(a,r) = sum(a0$mapa(a0,a), sum((reg,i0)$mapr(reg,r),
      (vdfp(i0,a0,reg)+vmfp(i0,a0,reg))*ESUBC(a0,reg))) / esubc1(a,r) ;

*  ESUBVA -- use regional value added at agents' prices as weight

esubva1(a,r) = sum(a0$mapa(a0,a), sum((reg,fp0)$mapr(reg,r), evfp(fp0, a0, reg))) ;
esubva1(a,r)$esubva1(a,r) = sum(a0$mapa(a0,a),
      sum((reg,fp0)$mapr(reg,r), evfp(fp0, a0, reg)*ESUBVA(a0,reg))) / esubva1(a,r) ;

*  INCPAR, SUBPAR -- Use regional private demand at agents' prices

incpar1(i,r) = sum((i0,r0)$(mapa(i0,i) and mapr(r0,r)), vdpp(i0,r0) + vmpp(i0,r0)) ;
subpar1(i,r) = incpar1(i,r) ;
incpar1(i,r)$incpar1(i,r)
          = sum((i0,r0)$(mapa(i0,i) and mapr(r0,r)), INCPAR(i0,r0)*(vdpp(i0,r0) + vmpp(i0,r0)))
          / incpar1(i,r) ;
subpar1(i,r)$subpar1(i,r)
          = sum((i0,r0)$(mapa(i0,i) and mapr(r0,r)), SUBPAR(i0,r0)*(vdpp(i0,r0) + vmpp(i0,r0)))
          / subpar1(i,r) ;

*  ESUBD -- Use regional aggregate Armington demand

esubd1(i,r) = sum(i0$mapa(i0,i), sum(reg$mapr(reg,r),
               sum(a0, vdfp(i0,a0,reg) + vmfp(i0,a0,reg))
          +            vdpp(i0,reg) + vmpp(i0,reg)
          +            vdgp(i0,reg) + vmgp(i0,reg)
          +            vdip(i0,reg) + vmip(i0,reg)
               )) ;
esubd1(i,r)$esubd1(i,r)
          = sum(i0$mapa(i0,i), sum(reg$mapr(reg,r), ESUBD(i0,reg)*(
               sum(a0, vdfp(i0,a0,reg) + vmfp(i0,a0,reg))
          +            vdpp(i0,reg) + vmpp(i0,reg)
          +            vdgp(i0,reg) + vmgp(i0,reg)
          +            vdip(i0,reg) + vmip(i0,reg))))
          / esubd1(i,r) ;

*  ESUBM -- Use regional aggregate import demand

esubm1(i,r) = sum(i0$mapa(i0,i), sum(reg$mapr(reg,r),
            +  sum(a0, vmfp(i0,a0,reg))
            +          vmpp(i0,reg)
            +          vmgp(i0,reg)
            +          vmip(i0,reg))) ;
esubm1(i,r)$esubm1(i,r)
            = sum(i0$mapa(i0,i), sum(reg$mapr(reg,r), ESUBM(i0,reg)*(
            +  sum(a0, vmfp(i0,a0,reg))
            +          vmpp(i0,reg)
            +          vmgp(i0,reg)
            +          vmip(i0,reg))))
            / esubm1(i,r) ;

*  RORFLEX -- Use regional level of capital stock

RORFLEX1(r) = sum(r0$mapr(r0,r), vkb(r0)) ;
RORFLEX1(r)$RORFLEX1(r) =sum(r0$mapr(r0,r), RORFLEX(r0)*vkb(r0)) / RORFLEX1(r) ;

*  Save the data

execute_unload "%baseName%/agg/%baseName%Par.gdx",
   ESUBT1=ESUBT, ESUBC1=ESUBC, ESUBVA1=ESUBVA, ETRAQ1=ETRAQ, ESUBQ1=ESUBQ,
   INCPAR1=INCPAR, SUBPAR1=SUBPAR, ESUBG1=ESUBG, ESUBI1=ESUBI,
   ESUBD1=ESUBD, ESUBM1=ESUBM, ESUBS1=ESUBS, ETRAE1=ETRAE, RORFLEX1=RORFLEX
;

* ------------------------------------------------------------------------------
*
*  Aggregate energy data
*
* ------------------------------------------------------------------------------

*  Energy matrices

parameters
   EDF(ERG, ACTS, REG)          "Usage of domestic products by firm"
   EMF(ERG, ACTS, REG)          "Usage of imported products by firm"
   EDP(ERG,REG)                 "Private consumption of domestic goods"
   EMP(ERG,REG)                 "Private consumption of imported goods"
   EDG(ERG,REG)                 "Public consumption of domestic goods"
   EMG(ERG,REG)                 "Public consumption of imported goods"
   EDI(ERG,REG)                 "Investment consumption of domestic goods"
   EMI(ERG,REG)                 "Investment consumption of imported goods"
   EXIDAG(ERG, REG, REG)        "Bilateral trade in energy"
;

execute_load "%gtpDir%%GTAPBASE%vole.gdx",
   EDF, EMF, EDP, EMP, EDG, EMG, EDI, EMI, EXIDAG
;

parameters
   EDF1(i, a, r)         "Usage of domestic products by firm"
   EMF1(i, a, r)         "Usage of imported products by firm"
   EDP1(i, r)            "Private consumption of domestic goods"
   EMP1(i, r)            "Private consumption of imported goods"
   EDG1(i, r)            "Public consumption of domestic goods"
   EMG1(i, r)            "Public consumption of imported goods"
   EDI1(i, r)            "Investment consumption of domestic goods"
   EMI1(i, r)            "Investment consumption of imported goods"
   EXIDAG1(i, r, rp)     "Bilateral trade in energy"
;

Agg3(edf,edf1,ERG,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg3(emf,emf1,ERG,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg2(edp,edp1,ERG,i,mapa,r0,r,mapr) ;
Agg2(emp,emp1,ERG,i,mapa,r0,r,mapr) ;
Agg2(edg,edg1,ERG,i,mapa,r0,r,mapr) ;
Agg2(emg,emg1,ERG,i,mapa,r0,r,mapr) ;
Agg2(edi,edi1,ERG,i,mapa,r0,r,mapr) ;
Agg2(emi,emi1,ERG,i,mapa,r0,r,mapr) ;
Agg3(exidag,exidag1,ERG,i,mapa,r0,r,mapr,rp0,rp,mapr) ;

edf1(i,a,r)$(voa1(i,r) = 0)     = 0 ;
edp1(i,r)$(voa1(i,r) = 0)       = 0 ;
edg1(i,r)$(voa1(i,r) = 0)       = 0 ;
exidag1(i,r,rp)$(voa1(i,r) = 0) = 0 ;

*  Save the data

execute_unload  "%baseName%/agg/%baseName%Vole.gdx",
   EDF1=EDF, EMF1=EMF,
   EDP1=EDP, EMP1=EMP,
   EDG1=EDG, EMG1=EMG,
   EDI1=EDI, EMI1=EMI,
   EXIDAG1=EXIDAG
;

* ------------------------------------------------------------------------------
*
*  Aggregate CO2 emissions data
*
* ------------------------------------------------------------------------------

*  CO2 Emission matrices

parameters
   MDF(FUEL, ACTS, REG)          "Emissions from domestic product in current production, .."
   MMF(FUEL, ACTS, REG)          "Emissions from imported product in current production, .."
   MDP(FUEL, REG)                "Emissions from private consumption of domestic product, Mt CO2"
   MMP(FUEL, REG)                "Emissions from private consumption of imported product, Mt CO2"
   MDG(FUEL, REG)                "Emissions from govt consumption of domestic product, Mt CO2"
   MMG(FUEL, REG)                "Emissions from govt consumption of imported product, Mt CO2"
   MDI(FUEL, REG)                "Emissions from invt consumption of domestic product, Mt CO2"
   MMI(FUEL, REG)                "Emissions from invt consumption of imported product, Mt CO2"
;

execute_load "%gtpDir%%GTAPBASE%emiss.gdx",
   MDF, MMF, MDP, MMP, MDG, MMG, MDI, MMI
;

parameters
   MDF1(i, a, r)         "Emissions from domestic product in current production, .."
   MMF1(i, a, r)         "Emissions from imported product in current production, .."
   MDP1(i, r)            "Emissions from private consumption of domestic product, Mt CO2"
   MMP1(i, r)            "Emissions from private consumption of imported product, Mt CO2"
   MDG1(i, r)            "Emissions from govt consumption of domestic product, Mt CO2"
   MMG1(i, r)            "Emissions from govt consumption of imported product, Mt CO2"
   MDI1(i, r)            "Emissions from invt consumption of domestic product, Mt CO2"
   MMI1(i, r)            "Emissions from invt consumption of imported product, Mt CO2"
;

Agg3(mdf,mdf1,fuel,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg3(mmf,mmf1,fuel,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg2(mdp,mdp1,fuel,i,mapa,r0,r,mapr) ;
Agg2(mmp,mmp1,fuel,i,mapa,r0,r,mapr) ;
Agg2(mdg,mdg1,fuel,i,mapa,r0,r,mapr) ;
Agg2(mmg,mmg1,fuel,i,mapa,r0,r,mapr) ;
Agg2(mdi,mdi1,fuel,i,mapa,r0,r,mapr) ;
Agg2(mmi,mmi1,fuel,i,mapa,r0,r,mapr) ;

*  Save the data

execute_unload  "%baseName%/agg/%baseName%Emiss.gdx",
   MDF1=MDF, MMF1=MMF, MDP1=MDP, MMP1=MMP, MDG1=MDG, MMG1=MMG, MDI1=MDI, MMI1=MMI
;

* -------------------------------------------------------------------------------
*
*  Calculate the energy content of fossil fuel consumption
*
*  THIS IS A QUICK FIX AND NEEDS REVIEW

alias(fuel,f0) ;
alias(erg,e0) ;

set etr(f0) "Which fuels"      / coa, oil, gas, p_c, gdt / ;
set itr(a0) "Which activities" / oil, p_c, crp / ;

parameters
   eaf(e0,i0,r0)     "Armington energy consumption by firms"
   phiNRG(f0,i0,r0)  "Rate of burning of fossil fuels"
   nrgCOMB(f0,i0,r0) "Energy combusted"
   nrgCOMB1(i,a,r)   "Aggregated combusted energy"
;

parameters co2_mtoe(f0) "Standard emissions coefficients" /
coa   3.881135
oil   3.03961
gas   2.22606
p_c   2.89167
gdt   2.22606
/ ;

*  Convert to c_mtoe

co2_mtoe(f0) = co2_mtoe(f0)*12/44 ;

*  Total energy
eaf(e0,i0,r0) = edf(e0,i0,r0) + emf(e0,i0,r0) ;

*  Calculate combustion based on the standard emissions coefficient
nrgCOMB(f0,i0,r0) = ((mdf(f0,i0,r0)+mmf(f0,i0,r0))/co2_mtoe(f0))$(etr(f0) and itr(i0))
                  +  eaf(f0,i0,r0)$(not (etr(f0) and itr(i0))) ;

*  Cap combustion to actual energy consumption
nrgCOMB(f0,i0,r0) = eaf(f0,i0,r0)$(nrgCOMB(f0,i0,r0) > eaf(f0,i0,r0))
                  + nrgCOMB(f0,i0,r0)$(nrgCOMB(f0,i0,r0) <= eaf(f0,i0,r0))
                  ;

*  Aggregate
nrgCOMB1(i,a,r) = sum((r0,f0,i0)$(mapr(r0,r) and mapa(f0,i) and mapa(i0,a)), nrgCOMB(f0,i0,r0)) ;

$ontext
file xcsv / nrgComb.csv / ;
put xcsv ;
put "Var,Region,Input,Activity,Value" / ;
xcsv.pc=5 ;
xcsv.nd=9 ;

loop((f0,i0,r0),
   put "MDF",r0.tl,f0.tl,i0.tl,mdf(f0,i0,r0) / ;
   put "MMF",r0.tl,f0.tl,i0.tl,mmf(f0,i0,r0) / ;
   put "EDF",r0.tl,f0.tl,i0.tl,edf(f0,i0,r0) / ;
   put "EMF",r0.tl,f0.tl,i0.tl,emf(f0,i0,r0) / ;
   put "EAF",r0.tl,f0.tl,i0.tl,eaf(f0,i0,r0) / ;
   put "nrgComb",r0.tl,f0.tl,i0.tl,nrgComb(f0,i0,r0) / ;
) ;
loop((i,a,r),
   put "MDF1",r.tl,i.tl,a.tl,mdf1(i,a,r) / ;
   put "MMF1",r.tl,i.tl,a.tl,mmf1(i,a,r) / ;
   put "EDF1",r.tl,i.tl,a.tl,edf1(i,a,r) / ;
   put "EMF1",r.tl,i.tl,a.tl,emf1(i,a,r) / ;
) ;
loop((i,a,r),
   put "nrgComb1",r.tl,i.tl,a.tl,nrgComb1(i,a,r) / ;
) ;

putclose xcsv ;
$offtext

* ------------------------------------------------------------------------------
*
*  Load and aggregate satellite accounts if requested
*
* ------------------------------------------------------------------------------

$iftheni.nco2 "%NCO2%" == "ON"

* ------------------------------------------------------------------------------
*
*  Aggregate non-CO2 emissions data
*
* ------------------------------------------------------------------------------

*  NON-CO2 emission matrices

parameters
   NC_TRAD(NCO2, COMM, ACTS, REG)       "Non-CO2 emissions assoc. with input use.."
   NC_ENDW(NCO2, endw, ACTS, REG)       "Non-CO2 emissions assoc. with endowment .."
   NC_QO(NCO2, ACTS, REG)               "Non-CO2 emissions assoc. with output by industries-M. .."
   NC_HH(NCO2, COMM, REG)               "Non-CO2 emissions assoc. with input use by households-.."
   NC_TRAD_CEQ(NCO2, COMM, ACTS, REG)   "Non-CO2 emissions assoc. with input use.."
   NC_ENDW_CEQ(NCO2, endw, ACTS, REG)   "Non-CO2 emissions assoc. with endowment .."
   NC_QO_CEQ(NCO2, ACTS, REG)           "Non-CO2 emissions assoc. with output by industries-M. .."
   NC_HH_CEQ(NCO2, COMM, REG)           "Non-CO2 emissions assoc. with input use by households-.."
;

*  Load the data

execute_load "%gtpDir%%GTAPBASE%nco2.gdx",
   NC_TRAD, NC_ENDW, NC_QO, NC_HH, NC_TRAD_CEQ, NC_ENDW_CEQ, NC_QO_CEQ, NC_HH_CEQ
;

parameters
   NC_TRAD1(NCO2, i, a, r)          "Non-CO2 emissions assoc. with input use.."
   NC_ENDW1(NCO2, fp, a, r)         "Non-CO2 emissions assoc. with endowment .."
   NC_QO1(NCO2, a, r)               "Non-CO2 emissions assoc. with output by industries-M. .."
   NC_HH1(NCO2, i, r)               "Non-CO2 emissions assoc. with input use by households-.."
   NC_TRAD_CEQ1(NCO2, i, a, r)      "Non-CO2 emissions assoc. with input use.."
   NC_ENDW_CEQ1(NCO2, fp, a, r)     "Non-CO2 emissions assoc. with endowment .."
   NC_QO_CEQ1(NCO2, a, r)           "Non-CO2 emissions assoc. with output by industries-M. .."
   NC_HH_CEQ1(NCO2, i, r)           "Non-CO2 emissions assoc. with input use by households-.."
;

*  Aggregate the data

Agg4(NC_TRAD,NC_TRAD1,nco2,emn,mapnco2,i0,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg4(NC_ENDW,NC_ENDW1,nco2,emn,mapnco2,fp0,fp,mapf,a0,a,mapa,r0,r,mapr) ;
Agg3(NC_QO,NC_QO1,nco2,emn,mapnco2,a0,a,mapa,r0,r,mapr) ;
Agg3(NC_HH,NC_HH1,nco2,emn,mapnco2,i0,i,mapa,r0,r,mapr) ;

Agg4(NC_TRAD_CEQ,NC_TRAD_CEQ1,nco2,emn,mapnco2,i0,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg4(NC_ENDW_CEQ,NC_ENDW_CEQ1,nco2,emn,mapnco2,fp0,fp,mapf,a0,a,mapa,r0,r,mapr) ;
Agg3(NC_QO_CEQ,NC_QO_CEQ1,nco2,emn,mapnco2,a0,a,mapa,r0,r,mapr) ;
Agg3(NC_HH_CEQ,NC_HH_CEQ1,nco2,emn,mapnco2,i0,i,mapa,r0,r,mapr) ;

*  Save the data

execute_unload "%baseName%/agg/%baseName%NCO2.gdx",
   NC_TRAD1=NC_TRAD, NC_ENDW1=NC_ENDW, NC_QO1=NC_QO, NC_HH1=NC_HH,
   NC_TRAD_CEQ1=NC_TRAD_CEQ, NC_ENDW_CEQ1=NC_ENDW_CEQ, NC_QO_CEQ1=NC_QO_CEQ, NC_HH_CEQ1=NC_HH_CEQ
;

*  Save the energy and emissions data to the CSV file if requested

$batinclude "aggNRG.gms" AggGTAP 1

if(1,

*  Calculate and display the global warming potential

   nc_trad1(nco2,i,a,r)$nc_trad1(nco2,i,a,r) = NC_TRAD_CEQ1(NCO2, i, a, r)/nc_trad1(nco2,i,a,r) ;
   NC_ENDW1(NCO2, fp, a, r)$NC_ENDW1(NCO2, fp, a, r) =
      NC_ENDW_CEQ1(NCO2, fp, a, r)/NC_ENDW1(NCO2, fp, a, r) ;
   NC_QO1(NCO2, a, r)$NC_QO1(NCO2, a, r) = NC_QO_CEQ1(NCO2, a, r)/NC_QO1(NCO2, a, r) ;
   NC_HH1(NCO2, i, r)$NC_HH1(NCO2, i, r) = NC_HH_CEQ1(NCO2, i, r)/NC_HH1(NCO2, i, r) ;

   display nc_trad1, NC_ENDW1, NC_QO1, NC_HH1 ;
) ;

$endif.nco2

$iftheni.BoP "%BoP%" == "ON"

* ------------------------------------------------------------------------------
*
*  Additional BoP accounts -- from GMiG and GDyn
*
* ------------------------------------------------------------------------------

parameters
   remit(lab,reg,reg)   "Initial remittances"
   yqtf(reg)            "Initial outflow of capital income"
   yqht(reg)            "Initial inflow of capital income"
   ODAIn(reg)           "Initial ODA inflows"
   ODAOut(reg)          "Initial ODA outflows"
;

parameters
   remit1(l,s,d)        "Initial remittances"
   yqtf1(r)             "Initial outflow of capital income"
   yqht1(r)             "Initial inflow of capital income"
   ODAIn1(r)            "Initial ODA inflows"
   ODAOut1(r)           "Initial ODA outflows"
;

*  Remittances and flow of profits

$ifthen exist "%gtpDir%/%GTAPBASE%BOP.gdx"
   execute_load "%gtpDir%/%GTAPBASE%BOP.gdx", remit, yqtf, yqht, ODAIn, ODAOut ;

   Agg3(remit,remit1,lab,l,mapf,r0,s,mapr,rp0,d,mapr) ;
   Agg1(yqtf,yqtf1,r0,r,mapr) ;
   Agg1(yqht,yqht1,r0,r,mapr) ;
   Agg1(ODAIn,ODAIn1,r0,r,mapr) ;
   Agg1(ODAOut,ODAOut1,r0,r,mapr) ;

$else

   remit1(l,s,d) = 0 ;
   yqtf1(r)      = 0 ;
   yqht1(r)      = 0 ;
   ODAIn1(r)     = 0 ;
   ODAOut1(r)    = 0 ;

$endif

execute_unload "%baseName%/agg/%baseName%BoP.gdx",
   REMIT1=REMIT, YQTF1=YQTF, YQHT1=YQHT, ODAIn1=ODAIn, ODAOut1=ODAOut ;

$endif.BoP

$iftheni.elast "%ELAST%" == "ON"

parameters
   etat0(reg)           "Aggregate land elasticities"
   landmax0(reg)        "Land maximum"
   etanrf0(reg,acts)    "Natural resource elasticities"
;

parameters
   etat1(r)             "Aggregate land elasticities"
   landmax1(r)          "Land maximum"
   etanrf1(r,a)         "Natural resource elasticities"
;

*  Land parameters

$ifthen exist "%gtpDir%/%GTAPBASE%ELAST.gdx"
   execute_load "%gtpDir%/%GTAPBASE%ELAST.gdx",
      etat0, landmax0, etanrf0 ;

   loop(LAND,
      etat1(r)     = sum(r0$mapr(r0,r), sum(a0, evfb(LAND, a0, r0))) ;
      landMax1(r)  = etat1(r) ;
      etat1(r)$etat1(r) = sum(r0$mapr(r0,r), etat0(r0)*sum(a0, evfb(LAND, a0, r0)))/etat1(r) ;
      landMax1(r)$landMax1(r) = sum(r0$mapr(r0,r),
         landMax0(r0)*sum(a0, evfb(LAND,a0,r0)))/landMax1(r) ;
   ) ;

   loop(NTRS,
      etanrf1(r,a) = sum(r0$mapr(r0,r), sum(a0$mapa(a0,a), evfb(NTRS, a0, r0))) ;
      etanrf1(r,a)$etanrf1(r,a) = sum(r0$mapr(r0,r), sum(a0$mapa(a0,a),
         etanrf0(r0,a0)*evfb(NTRS, a0, r0)))/etanrf1(r,a) ;
   ) ;
   display etanrf1 ;

$else

   etat1(r)     = 0 ;
   landmax1(r)  = 1 ;
   etanrf1(r,a) = 1 ;

$endif

execute_unload "%baseName%/agg/%baseName%Elast.gdx",
   ETAT1=ETAT, LANDMAX1=LANDMAX, ETANRF1=ETANRF ;

$endif.elast

$iftheni.lab "%LAB%" == "ON"

parameters

*  Input data from ILO

   labvol(lab,acts,reg)    "Labor volumes in millions"
   wage(lab, acts, reg)    "Wages imputed from ILO"

*  Labor/VA (from GIDD)

   emplg(lg, acts, reg)    "Labor volumes emanating from GIDD"
   evfbg(lg, acts, reg)    "Labor value added at basic prices emanating from GIDD"
   evfpg(lg, acts, reg)    "Labor value added at purchasers prices emanating from GIDD"
   empl2014(reg, lg)       "Aging of GIDD volumes"

   evfbg1(l, a, r)         "Labor value added at basic prices emanating from GIDD"
   evfpg1(l, a, r)         "Labor value added at purchasers prices emanating from GIDD"
   emplg1(l, a, r)         "GIDD employment data"

   premg0(l, a, r)         "Base wage premium"
   wageBar(l, r)           "Base avg. wage"
   labShr(l, a, r)         "Labor share share of GIDD"
   tlabg(l, r)             "Total labor"

*  Output vectors

   empl1(l, a, r)         "Employment data in person years"
   wage1(l, a, r)         "Imputed wages"
   emplz(l,z,r)           "Total employment by zone"
;

file wcsv / wages.csv / ;

if(IFLABOR = noLab,

*  Just set wages to 1 and employment to evfb1

   empl1(l,a,r) = evfb1(l,a,r) ;

elseif(IFLABOR = agLab),

*  Read the labor volumes and do a two-sector aggregation

   execute_load "%gtpDir%/%GTAPBASE%Wages.gdx" labvol=q, wage=w ;
   if(0,
      put wcsv ;
      put "Region,Variable,Skill,Sector,Value" / ;
      wcsv.pc=5 ;
      wcsv.nd=9 ;
      loop((lab,acts,reg),
         put reg.tl, "LabVol", lab.tl, acts.tl, labvol(lab,acts,reg) / ;
         put reg.tl, "Wage", lab.tl, acts.tl, wage(lab,acts,reg) / ;
         put reg.tl, "VFM", lab.tl, acts.tl, evfb(lab,acts,reg) / ;
      ) ;
   ) ;

   loop(z$(not sameas(z,"nsg")),

*     Employment equals remuneration divided by average wage by zone

*     Total employment in zone z
      emplz(l,z,r) = sum(a$mapz(z,a),
         sum((lab, a0, r0)$(mapf(lab,l) and mapa(a0,a) and mapr(r0,r)), labvol(lab,a0,r0))) ;
      display emplz ;
*     Average wage in zone z (Total remuneration in z divided by total employment in z)
      emplz(l,z,r)$emplz(l,z,r) = sum(a$mapz(z,a), evfb1(l,a,r)) /  emplz(l,z,r) ;
      display emplz ;
*     And thus employment by activity
      empl1(l,a,r)$(mapz(z,a) and emplz(l,z,r)) = evfb1(l,a,r)/emplz(l,z,r) ;
      display empl1 ;
   ) ;

elseif(IFLABOR = allLab),

*  Read the labor volumes and make wages fully sector-specific

   execute_load "%gtpDir%/%GTAPBASE%Wages.gdx" labvol=q ;

   Agg3(labvol,empl1,lab,l,mapf,a0,a,mapa,r0,r,mapr) ;

elseif(IFLABOR = giddLab),

*  Read the GIDD data
*  !!!! THIS SECTION NEEDS WORK -- FOR EXAMPLE IF USING ALL 5 LABOR SKILLS IN GTAP, re-balancing, etc.

   execute_load "%giddLab%"  evfbg=vfmg, evfpg=evfag, emplg=empl ;

*  !!!! NEED TO REBALANCE EVFB AND EMPL

   Agg3(evfbg,evfbg1,lg,l,mapl,a0,a,mapa,r0,r,mapr) ;
   Agg3(evfpg,evfpg1,lg,l,mapl,a0,a,mapa,r0,r,mapr) ;
   Agg3(emplg,emplg1,lg,l,mapl,a0,a,mapa,r0,r,mapr) ;

   if(ver eq 10,

*     This is a temporary fix to wages and volumes to re-base 2011 to 2014

*     Calculate wage premium from the GIDD (calibrated to GTAP v9)

      wageBar(l,r)   = sum(a, evfpg1(l,a,r)) / sum(a, emplg1(l,a,r)) ;
      premg0(l,a,r)$emplg1(l,a,r) = (evfpg1(l,a,r)/emplg1(l,a,r)) / wageBar(l,r) ;

*     Get projected labor volumes

      execute_load "../SatAcct/GIDDV10.gdx", empl2014 ;

*     display empl2014 ;

*     Aggregate projected labor volumes

      tlabg(l, r) = sum((r0,lg)$(mapr(r0,r) and mapl(lg,l)), empl2014(r0, lg)) ;

*     Calculate labor value shares

      labshr(l,a,r) = evfb1(l,a,r) / sum(a1, evfb1(l,a1,r)) ;

*     display premg0, labshr, tlabg ;

*     Calulate employment consistent with new employment level and assuming
*     'old' wage premia

      empl1(l,a,r)$premg0(l,a,r) = tlabg(l, r)
                   * (labshr(l, a, r)/premg0(l,a,r))
                   / sum(a1$premg0(l,a1,r), labshr(l,a1,r)/premg0(l,a1,r)) ;
   else

      empl1(l,a,r) = emplg1(l,a,r) ;

   ) ;

*  Re-scale labor

   empl1(l,a,r) = 1*empl1(l,a,r) ;

) ;

file xxx / gidd.csv / ;
if(0,
   put xxx ;
   put "Var,Lab,Act,Reg,Value" / ;
   xxx.pc=5 ;
   xxx.nd=9 ;
   loop((l,a,r),
      put "Empl",  l.tl, a.tl, r.tl, empl1(l,a,r) / ;
      put "EmplG", l.tl, a.tl, r.tl, emplg1(l,a,r) / ;
      put "EVFB",  l.tl, a.tl, r.tl, evfb1(l,a,r) / ;
      put "EVFP",  l.tl, a.tl, r.tl, evfp1(l,a,r) / ;
      put "EVFBG",  l.tl, a.tl, r.tl, evfbg1(l,a,r) / ;
      put "EVFPG",  l.tl, a.tl, r.tl, evfpg1(l,a,r) / ;
      put "PREMG0", l.tl, a.tl, r.tl, premg0(l,a,r) / ;
   ) ;
   abort "Temp" ;
) ;

wage1(l,a,r)$empl1(l,a,r) = evfb1(l,a,r) / empl1(l,a,r) ;
empl1(l,a,r) = 1e6*empl1(l,a,r) ;

execute_unload "%baseName%/agg/%baseName%Wages.gdx",
   EMPL1=q, wage1=wage ;

$endif.lab

* ------------------------------------------------------------------------------
*
*  Deal with the power and water volumes
*
* ------------------------------------------------------------------------------

Parameter
*  Power data
   gwhr(a0, reg)              "Power output in Gwh"
   gwhr1(a, r)                "Power output in Gwh"

*  Water data
   h2ocrp(reg, i0)            "Water withdrawal for activities"
   h2oUse(wbnd0, reg)         "Water withdrawal for aggregate uses"
   h2ocrp1(a, r)              "Water withdrawal for activities"
   h2oUse1(wbnd0, r)          "Water withdrawal for aggregate uses"
;


$iftheni.POW %IFPOWER% == "ON"

execute_load "%gtpDir%%GTAPBASE%DAT.gdx", gwhr ;

*  Power aggregation

gwhr1(a,r) = sum((a0, r0)$(mapa(a0,a) and mapr(r0,r)), gwhr(a0, r0)) ;
if(0,
   display gwhr1, gwhr ;
   abort "Temp" ;
) ;

$else.POW

gwhr1(a,r) = 0 ;

$endif.POW

$iftheni.WAT %IFWATER% == "ON"

execute_load "%gtpDir%%GTAPBASE%DAT.gdx", h2oCrp, h2oUse ;

*  Water aggregation

h2ocrp1(a,r)     = sum((i0, r0)$(mapa(i0,a) and mapr(r0,r)), h2ocrp(r0,i0)) ;
h2oUse1(wbnd0,r) = sum(r0$mapr(r0,r), h2oUse(wbnd0, r0)) ;

if(1,

*  Check to see if value added and volume of water are consistent

   put screen ;
   put / ;
   loop((r,wat,a)$((h2ocrp1(a,r) eq 0 and evfp1(wat, a, r) ne 0) or
                   (h2ocrp1(a,r) ne 0 and evfp1(wat, a, r) eq 0)),
      put "Water warning: ", r.tl:<10, a.tl:<10, "h2o(cu.m.) = ", (1e-6*h2ocrp1(a,r)):15:4,
          " Cost($mn) = ", evfp1(wat,a,r):14:4 / ;
   ) ;
   putclose screen ;
) ;

$else.WAT

h2oCrp1(a,r)      = 0 ;
h2oUse1(wbnd0, r) = 0 ;

$endif.WAT

if(0,
   display gwhr1, h2ocrp1, h2ouse1 ;
   Abort "Temp"
) ;

execute_unload "%baseName%/agg/%baseName%Sat.gdx"
   nrgComb1=nrgComb, gwhr1=gwhr, h2ocrp1=h2ocrp, h2ouse1=h2ouse
;

* ------------------------------------------------------------------------------
*
*  Aggregate the MRIO database
*
* ------------------------------------------------------------------------------

$iftheni.MRIO "%ifMRIO%" == "ON"

set amrio "MRIO agents" /
   INT   "Intermediate demand"
   CONS  "Private and public demand"
   CGDS  "Investment demand"
/ ;

Parameter
   VIUMS(comm, amrio, reg, reg)  "Tariff inclusive value of imports by end-user"
   VIUWS(comm, amrio, reg, reg)  "Value of imports at CIF prices by end-user"

   VIUMS1(i, amrio, r, r)        "Aggregate tariff inclusive value of imports by end-user"
   VIUWS1(i, amrio, r, r)        "Aggregate value of imports at CIF prices by end-user"
;

execute_load "%gtpDir%%GTAPBASE%MRIO.gdx", VIUMS, VIUWS ;

viums1(i, amrio, s, d) =
   sum((comm,src,dst)$(mapa(comm,i) and mapr(src,s) and mapr(dst,d)), viums(comm,amrio,src,dst)) ;
viuws1(i, amrio, s, d) =
   sum((comm,src,dst)$(mapa(comm,i) and mapr(src,s) and mapr(dst,d)), viuws(comm,amrio,src,dst)) ;

execute_unload "%baseName%/agg/%baseName%MRIO.gdx"
   VIUMS1=VIUMS, VIUWS1=VIUWS ;

$endif.MRIO

* ------------------------------------------------------------------------------
*
*  Load and aggregate land use data
*
* ------------------------------------------------------------------------------

$iftheni.ifLU "%LU%" == "ON"

parameters
   AEZ_EVFA(AEZ0,ACTS,REG)              "AEZ-related land value added at agents' prices"
   AEZ_VFM(AEZ0,ACTS,REG)               "AEZ-related land value added at market prices"
   AEZ_EVOA(AEZ0,REG)                   "AEZ-related land value added net of income taxes"
   WGHT_MATRIX(AEZ0,ACTS,REG)           "AEZ weights used to share out data"
   LU_EVFA(fpa0,ACTS,REG)               "AEZ-related value added at agents' prices"
   LU_VFM(fpa0,ACTS,REG)                "AEZ-related value added at market prices"
   LU_EVOA(fpa0,REG)                    "AEZ-related value added net of income taxes"
   prod_aez(reg,aez0,acr0)              "Crop production in '000 metric tons"
   harvarea_aez(reg,aez0,acr0)          "Harvested area in '000 hectars"
   lcover(reg,aez0,LCOVER_TYPE)         "Land cover by AEZ"
   lvstck_aez(reg,aez0,rum0)            "Herd size in '000 head by aez"
;

*  Load the data

execute_load "%AEZFILE%",
   AEZ_EVFA, aez_vfm, aez_evoa, wght_matrix, lu_evfa, lu_vfm, lu_evoa, prod_aez, harvarea_aez, lcover, lvstck_aez
;

file aezcsv / aez.csv / ;
if(1,
   put aezcsv ;
   put "Var,Region,Act,LT,Value" / ;
   aezcsv.pc=5 ;
   aezcsv.nd=9 ;
   loop((aez0,a,r),
      put "aez_evfa", r.tl, a.tl, aez0.tl, (sum((acts,reg)$(mapa(acts,a) and mapr(reg,r)), AEZ_EVFA(AEZ0,ACTS,REG))) / ;
      put "aez_vfm",  r.tl, a.tl, aez0.tl, (sum((acts,reg)$(mapa(acts,a) and mapr(reg,r)), AEZ_VFM(AEZ0,ACTS,REG))) / ;
   ) ;
   loop((aez0,r),
      put "aez_evoa", r.tl, "Tot", aez0.tl, (sum((reg)$(mapr(reg,r)), AEZ_EVOA(aez0,REG))) / ;
   ) ;
   loop((fpa0,a,r),
      put "lu_evfa", r.tl, a.tl, fpa0.tl, (sum((acts,reg)$(mapa(acts,a) and mapr(reg,r)), LU_EVFA(fpa0,ACTS,REG))) / ;
      put "lu_vfm",  r.tl, a.tl, fpa0.tl, (sum((acts,reg)$(mapa(acts,a) and mapr(reg,r)), LU_VFM(fpa0,ACTS,REG))) / ;
   ) ;
   loop((fpa0,r),
      put "lu_evoa", r.tl, "Tot", fpa0.tl, (sum((reg)$(mapr(reg,r)), LU_EVOA(fpa0,REG))) / ;
   ) ;
   loop((aez0,acr0,r),
      put "prod_aez",     r.tl, acr0.tl, aez0.tl, (sum((reg)$(mapr(reg,r)), prod_aez(reg,aez0,acr0))) / ;
      put "harvarea_aez", r.tl, acr0.tl, aez0.tl, (sum((reg)$(mapr(reg,r)), harvarea_aez(reg,aez0,acr0))) / ;
   ) ;
   loop((aez0,rum0,r),
      put "lvstck_aez",     r.tl, rum0.tl, aez0.tl, (sum((reg)$(mapr(reg,r)), lvstck_aez(reg,aez0,rum0))) / ;
   ) ;
   loop((aez0,LCOVER_TYPE,r),
      put "LCOVER_TYPE",  r.tl, LCOVER_TYPE.tl, aez0.tl, (sum((reg)$(mapr(reg,r)), lcover(reg,aez0,LCOVER_TYPE))) / ;
   ) ;
   loop((fp,a,r),
      put "evfa",  r.tl, a.tl, fp.tl, evfp1(fp,a,r) / ;
      put "vfm",   r.tl, a.tl, fp.tl, evfb1(fp,a,r) / ;
      put "evoa",  r.tl, a.tl, fp.tl, evos1(fp,a,r) / ;
   ) ;
   loop((a,r),
      put "voa",  r.tl, a.tl, "Tot", voa1(a,r) ;
   ) ;
) ;

$batinclude "aggsamAEZ.gms" AggGTAPAEZ 1

$ontext

Agg4(NC_TRAD,NC_TRAD1,nco2,emn,mapnco2,i0,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg4(NC_ENDW,NC_ENDW1,nco2,emn,mapnco2,fp0,fp,mapf,a0,a,mapa,r0,r,mapr) ;
Agg3(NC_QO,NC_QO1,nco2,emn,mapnco2,a0,a,mapa,r0,r,mapr) ;
Agg3(NC_HH,NC_HH1,nco2,emn,mapnco2,i0,i,mapa,r0,r,mapr) ;

Agg4(NC_TRAD_CEQ,NC_TRAD_CEQ1,nco2,emn,mapnco2,i0,i,mapa,a0,a,mapa,r0,r,mapr) ;
Agg4(NC_ENDW_CEQ,NC_ENDW_CEQ1,nco2,emn,mapnco2,fp0,fp,mapf,a0,a,mapa,r0,r,mapr) ;
Agg3(NC_QO_CEQ,NC_QO_CEQ1,nco2,emn,mapnco2,a0,a,mapa,r0,r,mapr) ;
Agg3(NC_HH_CEQ,NC_HH_CEQ1,nco2,emn,mapnco2,i0,i,mapa,r0,r,mapr) ;

*  Save the data

execute_unload "%baseName%\Agg\%baseName%NCO2.gdx",
   NC_TRAD1=NC_TRAD, NC_ENDW1=NC_ENDW, NC_QO1=NC_QO, NC_HH1=NC_HH,
   NC_TRAD_CEQ1=NC_TRAD_CEQ, NC_ENDW_CEQ1=NC_ENDW_CEQ, NC_QO_CEQ1=NC_QO_CEQ, NC_HH_CEQ1=NC_HH_CEQ
;

$offtext
$endif.ifLU

$iftheni.DYN "%DYN%" == "ON"

$include "SSPSets.gms"

file cmap / %BaseName%CMap.txt / ;
if(1,

*  Save the regional mappings

   put cmap ;

   put 'set c "World economies" /' / ;
   loop(c,
      put '   ', c.tl:<8, '"', c.te(c), '"' / ;
   ) ;
   put "/ ;" / / ;

   put 'set r0 "GTAP Regions" /' / ;
   loop(r0,
      put '   ', r0.tl:<8, '"', r0.te(r0), '"' / ;
   ) ;
   put "/ ;" / / ;

   put 'set r "Project Regions" /' / ;
   loop(r,
      put '   ', r.tl:<8, '"', r.te(r), '"' / ;
   ) ;
   put "/ ;" / / ;

   put 'set cMap(r,c) "Mapping of countries to project regions / ' / ;
   loop((r,r0,c)$(mapr(r0,r) and mapc(c,r0)),
      put "   ", r.tl:<15, ".", c.tl / ;
   ) ;
   put "/ ;" / / ;

   put 'set rMap(r,r0) "Mapping of GTAP regions to project regions / ' / ;
   loop((r,r0)$mapr(r0,r),
      put "   ", r.tl:<15, ".", r0.tl / ;
   ) ;
   put "/ ;" / / ;
) ;

* ------------------------------------------------------------------------------
*
*  Aggregate the dynamic scenarios
*
* ------------------------------------------------------------------------------

Parameters
   tPop(scen, c, tranche, tt)
   popScen(scen, c, sex, tranche, ed, tt)
   gdpScen(mod, ssp, var, c, tt)
   popHist(c, tranche, th)
   tpop1(scen, r, tranche, tt)
   popScen1(scen, r, tranche, edj, tt)
   gdpScen1(mod, ssp, var, r, tt)
   popHist1(r, tranche, th)
;

*  Load the SSP database

execute_load "%SSPFile%", tPop=pop, popScen, gdpScen, popHist ;

*  Aggregate population (ignore gender)

tpop1(scen, r, tranche, tt)           = sum((r0,c)$(mapr(r0,r) and mapc(c,r0)), tpop(scen, c, tranche, tt)) ;
popScen1(scen, r, tranche, edj, tt)   = sum((r0,c)$(mapr(r0,r) and mapc(c,r0)), sum((sexx,ed)$mape1(edj,ed), popScen(scen, c, sexx, tranche, ed, tt))) ;
popHist1(r, tranche, th)              = sum((r0,c)$(mapr(r0,r) and mapc(c,r0)), popHist(c, tranche, th)) ;

*  Aggregate GDP

gdpScen1(mod, ssp, "gdp", r, tt)      = sum((r0,c)$(mapr(r0,r) and mapc(c,r0)), gdpScen(mod, ssp, "gdp", c, tt)) ;
gdpScen1(mod, ssp, "gdpppp05", r, tt) = sum((r0,c)$(mapr(r0,r) and mapc(c,r0)), gdpScen(mod, ssp, "gdpppp05", c, tt)) ;
gdpScen1(mod, ssp, "gdppc", r, tt)$tpop1(ssp,r,"PTOTL",tt)
   = (1e6)*gdpScen1(mod, ssp, "gdp", r, tt) / tpop1(ssp, r, "PTOTL", tt) ;

* ------------------------------------------------------------------------------
*
*  Aggregate the GIDD population/education scenarios
*
* ------------------------------------------------------------------------------

parameters
   GIDDPopProj(r0, edw, tranche, tt)
   GIDDPopProj1(r, edw, tranche, tt)
;

execute_load "%giddProj%", GIDDPopProj ;

*  Load the GIDD scenario

popScen1("GIDD", r, tranche, edj, tt) = sum(r0$mapr(r0,r), sum(edw$mape2(edj, edw), GiDDPopProj(r0, edw, tranche, tt))) ;

popScen1(scen,r,trs,"elevt",tt) = sum(edj$(not sameas(edj,"elevt")), popScen1(scen,r,trs,edj,tt)) ;
popScen1(scen,r,"ptotl",edj,tt) = sum(trs, popScen1(scen,r,trs,edj,tt)) ;
tpop1("GIDD",r,tranche,tt) = popScen1("GIDD",r,tranche,"elevt",tt) ;

execute_unload "%baseName%/agg/%baseName%Scn.gdx"
   tpop1=popscen, gdpscen1=gdpscen, popHist1=popHist, popScen1=educScen
;

$endif.DYN

* ------------------------------------------------------------------------------
*
*  Create the set definitions for the model(s)
*
* ------------------------------------------------------------------------------

file fsetAlt / "%BaseName%/alt/%BaseName%Sets.gms" / ;
file fsetMod / "%BaseName%/fnl/%BaseName%Sets.gms" / ;

*  Create the 'sets' file for AlterTax if requested

$iftheni.ifAlt "%ifAlt%" == "ON"

   put fsetAlt ;
   $$batinclude "makeset.gms" AlterTax
   putclose fsetAlt ;

$endif.ifAlt

*  Create the 'final sets' file for the requested model

$iftheni.ifGTAP %Model% == GTAP

   put fsetMod ;
   $$batinclude "makeset.gms" GTAP
   putclose fsetMod

$elseifi.ifGTAP %Model% == Env

   put fsetMod ;
   $$batinclude "makeset.gms" Env
   $$batinclude "makesetEnv.gms"
   putclose fsetMod ;

$endif.ifGTAP

* ------------------------------------------------------------------------------
*
*  Aggregate the elasticities for the Env model
*
* ------------------------------------------------------------------------------

$iftheni.ifEnv %Model% == Env

*  Set first param to 1 to override GTAP parameters
*  Set second param to 1 to override GTAP income elasticities

   $$batinclude "aggEnvElast.gms" %OVRRIDEGTAPARM% %OVRRIDEGTAPINC%

*  Prepare special sets file to convert labels in GDX file to final labels
   $$batinclude "makeAggSets.gms"

$ontext
   file fx ;
   scalar jh, status ;
*  Following need to be invoked at the end to do the conversion
   execute.ASync 'gams convertLabel --baseName=%baseName% -pw=150 -ps=9999' ;
   jh = JobHandle ; status = 1 ;
*  put_utility fx 'log' / '>>> JobHandle :' jh;
   while(status = 1,
      status = JobStatus(jh);
*     put_utility fx 'log' / '>>> Status    :' status;
   );
   abort$(status <> 2) '*** Execute.ASync gams... failed: wrong status';
   abort$errorlevel    '*** Execute.ASync gams... failed: wrong errorlevel';
$offtext

   execute 'gams convertLabel --baseName=%baseName% -pw=150 -ps=9999' ;
   abort$errorlevel    '*** Execute gams... failed: wrong errorlevel';

*  Delete temporary labels
*  NEED TO FIX FOR UNIX
*  execute 'del tmpSets.gms'
$iftheni "%OPSYS%" == "UNIX"
   execute 'rm tmpSets.gms'
$elseifi "%OPSYS%" == "DOS"
   execute 'del tmpSets.gms'
$endif

$endif.ifEnv

*  Special data handling for this aggregation

$ifthen exist "%BaseName%Spc.gms"

   $$include "%BaseName%Spc.gms"

$endif

$show
