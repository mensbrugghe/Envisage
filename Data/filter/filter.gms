*-----------------------------------------------------------------------------------------
$ontext

   Envisage 10 project -- Data preparation modules

   GAMS file : Filter.gms

   @purpose  : Filter out small values from SAMS and trade matrices and
               rebalance database

   @author   : Tom Rutherford, with modifications by Wolfgang Britz
               and adjustments for Env10 by Dominique van der Mensbrugghe
   @date     : 21.10.16
   @since    :
   @refDoc   :
   @seeAlso  :
   @calledBy : loadData.gms
   @Options  :

$offtext
*-----------------------------------------------------------------------------------------

*  At this point, we should have read in the aggregated database, so initialize filtering

*  Save the SAM if requested

file csv / "%BaseName%/flt/%baseName%Flt.csv" / ;

*  !!!! check/implement

option LP=%system.nlp% ;

Parameters

*  Auxiliary matrices

   ftrv(fp, i, r)    "Taxes on factor use"
   fbep(fp, i, r)    "Subsidies on factor use"
   osep(a,r)         "Output tax"
   vdm(i,r)          "Aggregate demand for domestic output",
   vom(i,r)          "Total supply at market prices",
   voa(i,r)          "Output at producer prices"
   vim(i,r)          "Aggregate imports"
   vmip0(i,r)        "Investment demand for imported goods at agents' prices"
   vdip0(i,r)        "Investment demand for domestic goods at agents' prices"
   tvpm(r)           "Aggregate private demand"
   tvpmm(r)          "Aggregate private demand for imports"
   tvgm(r)           "Aggregate gov demand"
   tvgmm(r)          "Aggregate gov demand for imports"
   tvim(r)           "Aggregate inv demand"
   tvimm(r)          "Aggregate inv demand for imports"
   vxt(i)            "Total world trade scaling factor"

   rto(i,r)          "Output (or income) subsidy rates"
   rtf(fp,i,r)       "Primary factor and commodity rates taxes"
   rtpd(i,r)         "Private domestic consumption taxes"
   rtpm(i,r)         "Private import consumption tax rates"
   rtgd(i,r)         "Government domestic rates"
   rtgm(i,r)         "Government import tax rates"
   rtid(i,r)         "Investment domestic rates"
   rtim(i,r)         "Investment import tax rates"
   rtfd(i,j,r)       "Firms domestic tax rates"
   rtfm(i,j,r)       "Firms import tax rates"
   rtxs(i,r,s)       "Export subsidy rates"
   rtms(i,r,s)       "Import taxes rates"
   rtva(fp,r)        "Direct tax rate on factor income"
;

*  Initialize the auxiliary matrices

vdip0(i,r)   = vdip(i,r) ;
vmip0(i,r)   = vmip(i,r) ;

vdm(i,r)     = sum(j, vdfb(i,j,r)) + vdpb(i,r) + vdgb(i,r) + vdib(i,r) ;
vom(i,r)     = vdm(i,r) + sum(s, vxsb(i,r,s)) + vst(i,r) ;
voa(j,r)     = sum(fp, evfp(fp,j,r)) + sum(i, vdfp(i,j,r) + vmfp(i,j,r)) ;
vim(i,r)     = sum(j, vmfb(i,j,r)) + vmpb(i,r) + vmgb(i,r) + vmib(i,r) ;
*  21-Oct-2016 DvdM  Change from original code -- initialize vdib with investment expenditures
osep(j,r)    = voa(j,r) - vom(j,r) ;
ftrv(fp,j,r) = evfp(fp,j,r) - evfb(fp,j,r) ;
fbep(fp,j,r) = 0 ;

$batinclude "aggsam.gms"  "BEFORE"

put msglog ;

*
* --- calculate tax rates in starting point
*

rto(i,r)    $ vom(i,r)    = 1 - voa(i,r)/vom(i,r) ;
rtf(fp,i,r) $ evfb(fp,i,r) = evfp(fp,i,r)/evfb(fp,i,r) - 1 ;
rtpd(i,r)   $ vdpb(i,r)   = vdpp(i,r)/vdpb(i,r) - 1;
rtpm(i,r)   $ vmpb(i,r)   = vmpp(i,r)/vmpb(i,r) - 1;
rtgd(i,r)   $ vdgb(i,r)   = vdgp(i,r)/vdgb(i,r) - 1;
rtgm(i,r)   $ vmgb(i,r)   = vmgp(i,r)/vmgb(i,r) - 1;
rtid(i,r)   $ vdib(i,r)   = vdip(i,r)/vdib(i,r) - 1;
rtim(i,r)   $ vmib(i,r)   = vmip(i,r)/vmib(i,r) - 1;
rtfd(i,j,r) $ vdfb(i,j,r) = vdfp(i,j,r)/vdfb(i,j,r) - 1;
rtfm(i,j,r) $ vmfb(i,j,r) = vmfp(i,j,r)/vmfb(i,j,r) - 1;
rtxs(i,r,s) $ vfob(i,r,s) = 1-vfob(i,r,s)/vxsb(i,r,s);
rtms(i,r,s) $ vcif(i,r,s) = vmsb(i,r,s)/vcif(i,r,s) - 1;

*  14-May-2016: DvdM

*  !!!! DANGEROUS--assumes uniform tax rate across activities
rtva(fp,r)$(sum(a, evfb(fp,a,r))) = (sum(a, evfb(fp,a,r)) - sum(a, evos(fp,a,r)))
                                  / (sum(a, evfb(fp,a,r))) ;

tvpm(r)  = sum(i, vdpb(i,r)*(1+rtpd(i,r))  + vmpb(i,r)*(1+rtpm(i,r)));
tvpmm(r) = sum(i, vmpb(i,r)*(1+rtpm(i,r))) + eps ;

tvgm(r)  = sum(i, vdgb(i,r)*(1+rtgd(i,r))  + vmgb(i,r)*(1+rtgm(i,r)));
tvgmm(r) = sum(i, vmgb(i,r)*(1+rtgm(i,r))) + eps ;

tvim(r)  = sum(i, vdib(i,r)*(1+rtid(i,r))  + vmib(i,r)*(1+rtim(i,r)));
tvimm(r) = sum(i, vmib(i,r)*(1+rtim(i,r))) + eps ;

vxt(i)  = sum((r,s), vxsb(i,r,s)) ;

*  Declare mirror matrices

parameters
   evfb0(fp, j, r)   "Primary factor purchases, by firms, at market prices"
   vdfb0(i, j, r)    "Domestic purchases, by firms, at market prices"
   vmfb0(i, j, r)    "Import purchases, by firms, at market prices"
   vdpb0(i, r)       "Domestic purchases, by households, at market prices"
   vmpb0(i, r)       "Import purchases, by households, at market prices"
   vdgb0(i, r)       "Domestic purchases, by government, at market prices"
   vmgb0(i, r)       "Import purchases, by government, at market prices"
   vdib0(i, r)       "Domestic purchases, by investment, at market prices"
   vmib0(i, r)       "Import purchases, by investment, at market prices"
   vst0(i, r)        "Margin exports"
   vxsb0(i, r, d)    "Non-margin exports, at market prices"
   vfob0(i, r, d)    "Non-margin exports at border (FOB) prices"

   vdm0(i,r)         "Aggregate demand for domestic output"
   vom0(i,r)         "Aggregate output at market prices"
   vim0(i,r)         "Aggregate imports"
   vdib0(i,r)        "Aggregate investment demand"
   vxm0(i,r)         "Total exports"
   vxt0(i)           "Total world trade scaling factor"
   evfbTot0(fp,r)    "Aggregate factor remuneration"
   rtms0(r)          "Aggregate tariff revenue"
   Total
;

vim0(i,r) = sum(j, vmfb(i,j,r)) + vmpb(i,r) + vmgb(i,r) + vmib(i,r) ;
vxm0(i,r) = sum(s, vxsb(i,r,s)) + vst(i,r) ;
vxt0(i)   = sum((r,s), vxsb(i,r,s));
vom0(i,r) = vom(i,r) ;

*
* --- calculate tax income in starting point
*

rtms0(r) = sum((i,s), vmsb(i,s,r) - vcif(i,s,r)) ;

vst0(i,r)      = vst(i,r);
vdm0(i,r)      = vdm(i,r);
vdpb0(i,r)     = vdpb(i,r);
vmpb0(i,r)     = vmpb(i,r);
vdgb0(i,r)     = vdgb(i,r);
vmgb0(i,r)     = vmgb(i,r);
vdib0(i,r)     = vdib(i,r);
vmib0(i,r)     = vmib(i,r);
evfb0(fp,i,r)  = evfb(fp,i,r);
evfbTot0(fp,r) = sum(i,evfb(fp,i,r));
vdfb0(i,j,r)   = vdfb(i,j,r);
vmfb0(i,j,r)   = vmfb(i,j,r);
vxsb0(i,r,s)   = vxsb(i,r,s);
vfob0(i,r,s)   = vfob(i,r,s);

parameter
   dirTax(r)   "Tax revenues"
   bop0(r)     "Balance of payments"
   factY(r)    "Factor remuneration net of taxes"
   gdp(r)      "GDP"
   gdpTot      "World GDP"
;

dirTax(r)
*  Government expenditures
   = sum(i, vdgb(i,r)*(1+rtgd(i,r)) + vmgb(i,r) * (1+rtgm(i,r)))
*  Government revenues
   - sum(i, sum(fp, ftrv(fp,i,r) - fbep(fp,i,r)) - osep(i,r)
   +         vdpb(i,r) * rtpd(i,r) + vmpb(i,r) * rtpm(i,r)
   +         vdgb(i,r) * rtgd(i,r) + vmgb(i,r) * rtgm(i,r)
   +         vdib(i,r) * rtid(i,r) + vmib(i,r) * rtim(i,r)
   +  sum(j, vdfb(i,j,r) * rtfd(i,j,r) + vmfb(i,j,r) * rtfm(i,j,r))
   +  sum((s)$vxsb0(i,s,r), vmsb(i,s,r) - vcif(i,s,r))
   +  sum((s), vfob(i,r,s) - vxsb(i,r,s)) )
   -  sum((fp,i), evfb(fp,i,r)) + sum((fp,a), evos(fp,a,r)) ;

* !!!! What about VST ????
bop0(r)  = -sum((i,s), vfob(i,r,s)) + sum((i,s), vcif(i,s,r)) ;
factY(r) = sum((fp,a), evfb(fp,a,r)) ;

*
* --- total gdp
*

* !!!! NO NET TRADE ????

gdp(r) = sum(i, vdpb(i,r) + vmpb(i,r) + vdgb(i,r) + vmgb(i,r) + vdib(i,r) + vmib(i,r)) ;
gdpTot = sum(r, gdp(r)) ;

parameter
   vxm(a,r)    "Export volume"
   nz          "Count of non-zeros"
   trace       "Submatrix totals"
   ndropped    "Number of nonzeros dropped"
;

ndropped("prod")    = 0 ;
ndropped("imports") = 0 ;

set
   dropexports(i,r)  "Logical flag for set vxm(td,r) to zero"
   dropimports(i,r)  "Logical flag for set vim(td,r) to zero"
   dropprod(i,r)     "Logical flag for set vom(td,r) to zero"
   droptrade(i,r,s)  "Logical flag for set vxsb(td,r) to zero"
   rb(r)             "Region to be balanced"
;

dropexports(i,r) = no ;
dropimports(i,r) = no ;
dropprod(i,r)    = no ;
droptrade(i,r,s) = no ;

alias (r,rrr);

set keepItem / factyBop, evfb, set.fp, GDP, yg, yp, yi, int / ;

variables
   obj                  "Objective function"
   vz                   "Value of desired zero values"
   keepCor(keepItem,r)  "Difference between factor income plus BOP before and after"
;

positive variables
   vdm_(i,r)      "Calibrated value of vdm"
   vdfb_(i,j,r)   "Calibrated value of vdfb"
   vmfb_(i,j,r)   "Calibrated value of vmfb"
   vdpb_(i,r)     "Calibrated value of vdpb"
   vmpb_(i,r)     "Calibrated value of vmpb"
   vdgb_(i,r)     "Calibrated value of vdgb"
   vmgb_(i,r)     "Calibrated value of vmgb"
   vdib_(i,r)     "Calibrated value of vdib"
   vmib_(i,r)     "Calibrated value of vmib"
   evfb_(fp,a,r)   "Calibrated value of evfb"
;

scalar
   lsqr     / 1 /
   entropy  / 0 /
   bigM     / 1000 /
   penalty  / 1000 /
   tiny     / 1e-8 /
;

equations
   objbaleq
   vzdefeq
   profiteq
   vaeq
   ndeq
   dommkteq
   impmkteq
   evfbkeepeq
   evfbTotKeepeq
   factinceq
   gdpKeepeq
   ypeq
   ygeq
   yieq
   intKeepeq
;

objbaleq..
   obj =e= sum((r,i)$rb(r), (1/gdp(r))
        * ((sqr(vdpb_(i,r)-vdpb0(i,r))/(vdpb0(i,r)+tiny))$(vdpb(i,r) ne 0)
        +  (sqr(vmpb_(i,r)-vmpb0(i,r))/(vmpb0(i,r)+tiny))$(vmpb(i,r) ne 0)
        +  (sqr(vdgb_(i,r)-vdgb0(i,r))/(vdgb0(i,r)+tiny))$(vdgb(i,r) ne 0)
        +  (sqr(vmgb_(i,r)-vmgb0(i,r))/(vmgb0(i,r)+tiny))$(vmgb(i,r) ne 0)
        +  (sqr(vdib_(i,r)-vdib0(i,r))/(vdib0(i,r)+tiny))$(vdib(i,r) ne 0)
        +  (sqr(vmib_(i,r)-vmib0(i,r))/(vmib0(i,r)+tiny))$(vmib(i,r) ne 0)
        +   sum(fp$(evfb(fp,i,r) ne 0), sqr(evfb_(fp,i,r)-evfb0(fp,i,r))/(evfb0(fp,i,r)+tiny))
        +   sum(j$(vdfb(i,j,r) ne 0), sqr(vdfb_(i,j,r)-vdfb0(i,j,r))/(vdfb0(i,j,r)+tiny))
        +   sum(j$(vmfb(i,j,r) ne 0), sqr(vmfb_(i,j,r)-vmfb0(i,j,r))/(vmfb0(i,j,r)+tiny))))
        + penalty * vz
        + sum((rb,keepItem), sqr(KeepCor(keepItem,rb)/(10 - 9 $ sameas(keepItem,"GDP"))))
        ;

*  Use linear penalty term to impose sparsity:
*     (sum of items which are desired to be zero)

vzdefeq..
   vz =e= sum((r,i)$rb(r), 1/gdp(r)
       *  [vdpb_(i,r)$((vdpb(i,r) eq 0)$vdpb0(i,r))
       +   vmpb_(i,r)$((vmpb(i,r) eq 0)$vmpb0(i,r))
       +   vdgb_(i,r)$((vdgb(i,r) eq 0)$vdgb0(i,r))
       +   vmgb_(i,r)$((vmgb(i,r) eq 0)$vmgb0(i,r))
       +   vdib_(i,r)$((vdib(i,r) eq 0)$vdib0(i,r))
       +   vmib_(i,r)$((vmib(i,r) eq 0)$vmib0(i,r))
       +  sum(fp$evfb0(fp,i,r), evfb_(fp,i,r)$(evfb(fp,i,r) eq 0))
       +  sum(j, vdfb_(i,j,r)$((vdfb(i,j,r) eq 0)$vdfb0(i,j,r))
       +         vmfb_(i,j,r)$((vmfb(i,j,r) eq 0)$vmfb0(i,j,r)))
          ]) ;

*
*  --- revenue exhaustion (output value = value of inputs)
*
profiteq(j,r)$(rb(r) and (vom(j,r) ne 0))..
   (vdm_(j,r) + vxm(j,r)) * (1-rto(j,r))
      =e= sum(i, vdfb_(i,j,r)*(1+rtfd(i,j,r))$vdfb0(i,j,r)
       +         vmfb_(i,j,r)*(1+rtfm(i,j,r))$vmfb0(i,j,r))
       +  sum(fp, evfb_(fp,j,r)*(1+rtf(fp,j,r))$evfb0(fp,j,r)) ;

*
*  --- "BigM" equations for factor use and intermediate input use
*      (i.e. if production -> va,nd )
*
vaeq(j,fp,r)$(rb(r) and (evfb0(fp,j,r)*bigM*100) > vom(j,r) and (vom(j,r) ne 0)  and bigM)..
   (vdm_(j,r) + vxm(j,r)) * (1-rto(j,r)) =L= evfb_(fp,j,r)*(1+rtf(fp,j,r)) * bigM ;

ndeq(j,r)$(rb(r) and (sum(i, vdfb0(i,j,r) + vmfb0(i,j,r))*bigm*100 > vom(j,r)) and (vom(j,r) ne 0) and bigM)..
   (vdm_(j,r) + vxm(j,r)) * (1-rto(j,r))
      =L=  sum(i,vdfb_(i,j,r)*(1+rtfd(i,j,r))$vdfb0(i,j,r)
       +         vmfb_(i,j,r)*(1+rtfm(i,j,r))$vmfb0(i,j,r)) * bigM ;
*
* --- domestic market
*

*  ???? DvdM I think there are errors here and double counting...

dommkteq(i,r)$(rb(r) and (vdm(i,r) ne 0))..
   vdm_(i,r) =e= vdpb_(i,r)$vdpb0(i,r)
              +  vdgb_(i,r)$vdgb0(i,r)
              +  vdib_(i,r)$vdib0(i,r)
              +  sum(j$vdfb0(i,j,r), vdfb_(i,j,r)) ;
*
* --- import market
*
impmkteq(i,r)$(rb(r) and (vim(i,r) ne 0))..
   vim(i,r) =e= vmpb_(i,r)$vmpb0(i,r)
             +  vmgb_(i,r)$vmgb0(i,r)
             +  vmib_(i,r)$vmib0(i,r)
             +  sum(j$vmfb0(i,j,r), vmfb_(i,j,r)) ;
*
* --- try to maintain benchmark intermediate consumption
*
intKeepeq(r)$(rb(r) and ifKeepIntermediateConsumption)..
   sum((i,j)$vom(j,r), vdfb_(i,j,r)$vdfb0(i,j,r) + vmfb_(i,j,r)$vmfb0(i,j,r))
      =E= sum((i,j), vdfb0(i,j,r) + vmfb0(i,j,r)) * (1 + keepCor("int",r)/100) ;

*
* --- try to maintain at least benchmark gpd
*
gdpKeepeq(r)$(rb(r) and ifGDPKeep)..
   gdp(r)*(1 + keepCor("gdp",r)/100)
      =E= sum(i, vdpb_(i,r) $ vdpb0(i,r)
       +         vdgb_(i,r) $ vdgb0(i,r)
       +         vdib_(i,r) $ vdib0(i,r)
       +         vmpb_(i,r) $ vmpb0(i,r)
       +         vmgb_(i,r) $ vmgb0(i,r)
       +         vmib_(i,r) $ vmib0(i,r)
         ) ;
*
* --- try to maintain  benchmark factor income plus BOP
*
factinceq(r)$(rb(r) and ifKeepFactorincomeplusbop)..
   (facty(r) + bop0(r) - sum(i,vst0(i,r))) * (1 +  keepCor("factyBop",r)/100)
      =E= sum((fp,i)$evfb0(fp,i,r), evfb_(fp,i,r))
       -  sum((i,s)$vxsb0(i,r,s), vxsb(i,r,s)*(1-rtxs(i,r,s)))
       +  sum((i,s)$vxsb0(i,s,r), vcif(i,s,r) * vxsb(i,s,r)/vxsb0(i,s,r))
       -  sum(i, vst(i,r)) ;
*
* --- try to maintain  benchmark factor income plus BOP
*
evfbKeepeq(fp,r)$(rb(r) and ifKeepFactorincomeplusbop)..
   sum(j, evfb0(fp,j,r)*(1+rtf(fp,j,r))) * (1 + sum(sameas(keepItem,fp), keepCor(keepItem,r)/100))
      =E= sum(j$evfb0(fp,j,r), evfb_(fp,j,r) * (1+rtf(fp,j,r))) ;

evfbTotKeepeq(r)$(rb(r) and ifKeepFactorincomeplusbop)..
   sum((fp,j), evfb0(fp,j,r)*(1+rtf(fp,j,r))) * (1 + keepCor("evfb",r)/100)
      =E= sum((fp,j)$evfb0(fp,j,r), evfb_(fp,j,r) * (1+rtf(fp,j,r))) ;

*
* --- try to maintain benchmark private consumption total
*
*  !!!! WHY SUM OVER FP ????

ypeq(r)$(rb(r) and ifKeepPrivateconsumption)..
   sum(i, vdpb_(i,r)*(1+rtpd(i,r))$vdpb0(i,r) + vmpb_(i,r)*(1+rtpm(i,r))$vmpb0(i,r))
      =E= sum(i, vdpb0(i,r)*(1+rtpd(i,r)) + vmpb0(i,r)*(1+rtpm(i,r))) * (1 + keepCor("yp",r)/100) ;
*
* --- try to maintain benchmark gov consumption total
*
*  !!!! WHY SUM OVER FP ????
ygeq(r)$(rb(r) and ifKeepGovernmentconsumption) ..
   sum(i, vdgb_(i,r)*(1+rtgd(i,r))$vdgb0(i,r) + vmgb_(i,r)*(1+rtgm(i,r))$vmgb0(i,r))
      =E= sum(i, vdgb0(i,r)*(1+rtgd(i,r)) + vmgb0(i,r)*(1+rtgm(i,r))) * (1 + keepCor("yg",r)/100) ;

*
* --- try to maintain benchmark investments -- due it at agents' price as in the others????
*
yieq(r)$(rb(r)and ifKeepInvestments)..
   sum(i, vdib_(i,r)*(1+rtid(i,r))$vdib0(i,r) + vmib_(i,r)*(1+rtim(i,r))$vmib0(i,r))
      =E= sum(i, vdib0(i,r)*(1+rtid(i,r)) + vmib0(i,r)*(1+rtim(i,r))) * (1 + keepCor("yi",r)/100) ;

*
* --- linear version, only sparsity in objective
*

model lpfeas / impmkteq, dommkteq, profiteq, vaeq, ndeq, vzdefeq,
               gdpKeepeq, factInceq, evfbKeepeq, evfbTotKeepeq, ypeq, ygeq, yieq, intKeepeq / ;

*
* --- full calibration model
*

model calib / lpfeas + objbaleq / ;

calib.holdfixed = yes ;
calib.solvelink = 5 ;
calib.optfile   = 1 ;
calib.domlim    = 1000 ;
calib.reslim    = 120 ;

lpfeas.holdfixed = 2 ;
lpfeas.solvelink = 5 ;
lpfeas.optfile   = 1 ;
lpfeas.domlim    = 1000 ;
lpfeas.reslim    = 120 ;

$eval maxiter nsteps + 10

set
   dummy
      / start , absFilt /
   itr      "Calibration steps"
      / itr1*itr%maxiter% /
   dsitem   "Data set items to be balanced"
      / vom, evfb, vxsb, vtwr, vdfb, vmfb, vdpb, vmpb, vdgb, vmgb, vdib, vmib, gdp, total/
;

parameter
   itrlog            "Iteration log"
   nzcountStart      "Non-zero count"        / 0 /
   nzcountEnd        "Non-zero count"        / 0 /
   nzcountRep        "Non-zero count"        / 0 /
   solvefeas         "Solve the feasibility" / 0 /
   bilatTradeScale
;

*
* --- remove tiny values before further rebalancing work
*
$batinclude 'filter/itrlog.gms' before
$batinclude 'filter/itrlog.gms' count

itrlog("nonzeros","start",dsitem) = nz(dsitem,"count");
itrlog("nonzeros","start",r)      = nz(r,"count");
itrlog("nonzeros","start",i)      = nz(i,"count");

$include 'filter/remTinyValues.gms'

$batinclude 'filter/itrlog.gms' after

itrlog("nonzeros","absFilt",dsitem) = nz(dsitem,"count");
itrlog("change","absFilt",dsitem)   = nz(dsitem,"change");
itrlog("trace","absFilt",dsitem)    = sum(r,trace(dsitem,r,"before"));
itrlog("trace","start",dsitem)      = sum(r,trace(dsitem,r,"before"));
itrlog(r,"absFilt",dsitem)          = trace(dsitem,r,"before");
itrlog(r,"start",dsitem)            = trace(dsitem,r,"before");

*
* --- start with 10% of the desired final tolerance,
*     will be stepwise increased
*
parameters
   curRelTol(a,r)
   curAbsTol
   startRelTol(i,r)
;
curRelTol(i,r) = relTol;
curAbsTol = absTol / nSteps ;

$onempty

$if not setglobal excRegs $setglobal excRegs
set excRegs(r) / %excRegs%/;
$if not setglobal excSecs $setglobal excSecs
set excSecs(i) / %excSecs%/;

$offempty

*  !!!! NEED TO DISCUSS HOW THESE FLAGS ARE USED AND WHAT ARE REASONABLE TOLERANCE LEVELS

$iftheni.excCombined "%excCombined%"==on

   curRelTol(excSecs,excRegs) = relTolRed ;

$else.excCombined

   curRelTol(excSecs,r) = relTolRed ;
   curRelTol(a,excRegs) = relTolRed ;

$endif.excCombined

startRelTol(i,r) = curRelTol(i,r) ;
curRelTol(i,r)   = curRelTol(i,r) / nSteps ;

*
* --- ensure some minimum for the totals to be kept
*
keepCor.lo(keepItem,r)    = -50;
keepCor.lo(keepItem,r) $ sum(sameas(keepItem,fp),1)  = -100;
keepCor.lo(KeepItem,r) $ sum(sameas(keepItem,cap),1) = -50;
*
* --- small corridor around factor income. GDP works not well as
*     some countries such a XNA have an enormous trade deficit
*     which might be strongly affected by filtering out small trade flows
*
keepCor.lo("evfb",r)    = -2;
keepCor.up("evfb",r)    = +2;
option kill=vdm_;

Parameter
   rcount   "Keep count of treated regions"
;

loop(itr$(
*
*  --- continue with iteration as long as:
*
*  if there is a change in total non-zero transaction > 0.1%
      ((abs(nzcountStart-nzCountEnd)>0.001*nzcountStart)
*  or not yet the final tolerance reached
         or(smax((i,r), curRelTol(i,r)) < relTol))
*
*      --- and the desired minium number of transaction is not undercut
*
         and ((nzCountEnd > minNumTransactions) or (not nzCountEnd)) ),

*
*  count non zeros
*
   nzcountStart = card(vxsb) + card(vtwr) + card(vdfb) + card(vmfb)
                + card(vdpb) + card(vdgb) + card(vdib) + card(vmpb) + card(vmgb) + card(vmib) + card(evfb) ;

*  Aggregate value of imports:

   vim(i,r) = sum(s,(vxsb(i,s,r)*(1-rtxs(i,s,r))+sum(j,vtwr(j,i,s,r)))*(1+rtms(i,s,r))) ;

*  Rescale transport demand:

   vst(i,r) $ sum(s, vst(i,s)) = vst(i,r) * sum((j,s,rrr), vtwr(i,j,s,rrr)) / sum(s, vst(i,s)) ;

*  Value of exports:

   vxm(i,r) =  sum(s, vxsb(i,r,s)) + vst(i,r) ;

*  Production for the domestic market:

   vdm(i,r) = vdpb(i,r) + vdgb(i,r) + sum(j, vdfb(i,j,r)) + vdib(i,r) ;

*  Aggregate production:

   vom(i,r) = vdm(i,r) + vxm(i,r) ;

*  Record nonzero counts:

   $$batinclude 'filter/itrlog.gms' count

*
*  --- delete very small trade margins / trade flows
*      (absolute tolerance)
*
   if(abstol ne 1.E-10,
      vtwr(j,i,r,s) $ (vtwr(j,i,r,s) le curAbsTol) = 0;
      vxsb(i,r,s)   $ (vxsb(i,r,s)   le curAbsTol) = 0;

      vtwr(j,i,r,s) $ (not vxsb(i,r,s)) = 0;
      rtxs(i,r,s)   $ (not vxsb(i,r,s)) = 0;
      rtms(i,r,s)   $ (not vxsb(i,r,s)) = 0;
   ) ;

*  Filter small values here, commodity specific demand on total

*
*  --- aggregate total import and domestic demand per product
*
   vim(i,r) = sum(j,vmfb(i,j,r)) + vmpb(i,r) + vmgb(i,r) + vmib(i,r) ;
   vdm(i,r) = sum(j,vdfb(i,j,r)) + vdpb(i,r) + vdgb(i,r) + vdib(i,r) ;
*
   if(relTol > 1.E-10,
*
*     --- delete intermediate demands if cost share (approx) is
*         below tolerance times total output values
*
      vdfb(i,j,r) $ ((vdfb(i,j,r) < min(curRelTol(i,r),curRelTol(i,r))/100 * (vom(j,r)-sum(fp,evfb(fp,j,r)))) $ vdfb(i,j,r)) = 0 ;
      vmfb(i,j,r) $ ((vmfb(i,j,r) < min(curRelTol(i,r),curRelTol(i,r))/100 * (vom(j,r)-sum(fp,evfb(fp,j,r)))) $ vmfb(i,j,r)) = 0 ;
*
*     --- delete import and domestic private demand for products
*         if below tolerance times total private demand
*
      vmpb(i,r)   $ ((vmpb(i,r) < curRelTol(i,r)/100 * tvpm(r)  *  tvpmm(r)/tvpm(r)   ) $ vmpb(i,r)) = 0;
      vdpb(i,r)   $ ((vdpb(i,r) < curRelTol(i,r)/100 * tvpm(r)  * (1-tvpmm(r)/tvpm(r))) $ vdpb(i,r)) = 0;
*
*     --- delete import and domestic gov demand for products
*         if below tolerance times total gov demand
*
      vmgb(i,r)   $ ((vmgb(i,r) < curRelTol(i,r)/100 * tvgm(r) *  tvgmm(r)/tvgm(r)   ) $ vmgb(i,r))   = 0;
      vdgb(i,r)   $ ((vdgb(i,r) < curRelTol(i,r)/100 * tvgm(r) * (1-tvgmm(r)/tvgm(r))) $ vdgb(i,r))   = 0;
*
*     --- delete import and domestic inv demand for products
*         if below tolerance times total inv demand
*
      vmib(i,r)   $ ((vmib(i,r) < curRelTol(i,r)/100 * tvim(r) *  tvimm(r)/tvim(r)   ) $ vmib(i,r))   = 0;
      vdib(i,r)   $ ((vdib(i,r) < curRelTol(i,r)/100 * tvim(r) * (1-tvimm(r)/tvim(r))) $ vdib(i,r))   = 0;
   );

*  Decide whether to drop trade and production:

*
*  --- aggregate total import and domestic demand per product
*
   vim(i,r) = sum(j,vmfb(i,j,r)) + vmpb(i,r) + vmgb(i,r) + vmib(i,r) ;
   vdm(i,r) = sum(j,vdfb(i,j,r)) + vdpb(i,r) + vdgb(i,r) + vdib(i,r) ;

*
*  --- drop export of product if share on total exports and
*      max. import share on total import demand of product at destination is below threshold
*
   if (relTol > 1.E-10,
      dropexports(i,r)$(vxm(i,r) < curRelTol(i,r)/100*sum(j,vxm(j,r)) and
                (sum(s $
                   (  ( ((vxsb(i,r,s)*(1-rtxs(i,r,s))+sum(j,vtwr(j,i,r,s)))*(1+rtms(i,r,s)) /
                             vim(i,s)) < curRelTol(i,s)/100) $ vim(i,s)),1) eq sum(s $ vim(i,s),1)) and vxm(i,r)) = YES;
   ) ;

   vxsb(i,r,s)     $ dropexports(i,r) = 0 ;
   vtwr(j,i,r,s)   $ dropexports(i,r) = 0 ;
   rtxs(i,r,s)     $ dropexports(i,r) = 0 ;
   rtms(i,r,s)     $ dropexports(i,r) = 0 ;

*
*        --- drop import of product if share on total imports and
*            max. export share on output at destination is below threshold
*
   if (relTol > 1.E-10,
      dropimports(i,r)$((vim(i,r) < curRelTol(i,r)/100*sum(j,vim(j,r))) and
                   (sum(s$(( (vxsb(i,s,r)/vom(i,s)) < curRelTol(i,s)/100) $ vom(i,s)),1) eq sum(s $ vom(i,s),1)) and vim(i,r)) = yes;
   ) ;
*
*  --- drop imports if no import demand
*
   dropimports(i,r) $ (vmpb(i,r)+vmgb(i,r)+vmib(i,r)+sum(j,vmfb(i,j,r)) eq 0) = yes;
   dropimports(i,r) $ (not vdm_.range(i,r))= no;

   vim(i,r) $ dropimports(i,r) = 0;
*
*  --- drop production if share of output net of own intermediate consumption
*      is below threshold on total output net of own intermediate consumption
*      and share on total factor use is below threshold
*
   if (relTol > 1.E-10,
      dropprod(i,r) $ ((vom(i,r)-vdfb(i,i,r)<curRelTol(i,r)/100*sum(j,vom(j,r)-vdfb(j,j,r)))
                            $ vom(i,r))= yes;
   );
*
*  --- drop producion if no domestic and export demand
*
   dropprod(i,r) $ (vxm(i,r)+vdpb(i,r)+vdgb(i,r)+vdib(i,r)
                     + sum(j$(not sameas(i,j)),vdfb(i,j,r)) eq 0) = yes;

   while((ndropped("prod")    <> card(dropprod)) and
         (ndropped("imports") <> card(dropimports)),

      ndropped("prod")    = card(dropprod);
      ndropped("imports") = card(dropimports);

      vdm(i,r)        $ dropprod(i,r) = 0;
      vdpb(i,r)       $ dropprod(i,r) = 0;
      vdgb(i,r)       $ dropprod(i,r) = 0;
      vdib(i,r)       $ dropprod(i,r) = 0;
      vxsb(i,r,s)     $ dropprod(i,r) = 0;
      vtwr(j,i,r,s)   $ dropprod(i,r) = 0;
      rtxs(i,r,s)     $ dropprod(i,r) = 0;
      rtms(i,r,s)     $ dropprod(i,r) = 0;
      vst(i,r)        $ dropprod(i,r) = 0;
      evfb(fp,i,r)    $ dropprod(i,r) = 0;
      vdfb(j,i,r)     $ dropprod(i,r) = 0;
      vmfb(j,i,r)     $ dropprod(i,r) = 0;
      vdfb(i,j,r)     $ dropprod(i,r) = 0;
*
*     --- drop total imports if no use of import good
*
      dropimports(i,r) $ (not dropimports(i,r))
                     = yes $ (vmpb(i,r)+vmgb(i,r)+vmib(i,r)+sum(j,vmfb(i,j,r)) eq 0);

      vxm(i,r) = sum(s, vxsb(i,r,s)) + vst(i,r);
      vxsb(i,s,r)      $ dropimports(i,r) = 0;
      vtwr(j,i,s,r)    $ dropimports(i,r) = 0;
      rtxs(i,s,r)      $ dropimports(i,r) = 0;
      rtms(i,s,r)      $ dropimports(i,r) = 0;
      vmpb(i,r)        $ dropimports(i,r) = 0;
      vmgb(i,r)        $ dropimports(i,r) = 0;
      vmib(i,r)        $ dropimports(i,r) = 0;
      vmfb(i,a,r)      $ dropimports(i,r) = 0;
*
*     --- drop production if no use of domestically produced good and no exports
*
      dropprod(i,r) $ (not dropprod(i,r))
               = yes $ (vxm(i,r)+vdgb(i,r)+vdpb(i,r)+vdib(i,r)
                        +sum(j $ (not sameas(j,i)),vdfb(i,j,r)) eq 0);
   );

   if(calib.solprint eq 1, display ndropped ; ) ;

*
*  --- aggregate exports, domestic use and imports (including trade magrins)
*
*  !!!! WHAT ABOUT VDIM????

   vxm(i,r) = sum(s, vxsb(i,r,s)) + vst(i,r) ;
   vdm(i,r) = vdpb(i,r) + vdgb(i,r) + vdib(i,r) + sum(j,vdfb(i,j,r)) ;
   vim(i,r) = sum(s,(vxsb(i,s,r)*(1-rtxs(i,s,r))+sum(j,vtwr(j,i,s,r)))*(1+rtms(i,s,r))) ;
*
*  --- drop bilateral trade flow if value net of trade margins and taxes is below
*         thresholds both of exports and imports

   if (relTol > 1.E-10,
      droptrade(i,r,s) $ vxsb(i,r,s) = yes $ (vxsb(i,r,s)<min(curRelTol(i,s),curRelTol(i,r))/100 * min( vxm(i,r), vim(i,s)));
   ) ;

*
*  --- if dropped, also delete related trade margin and export/import taxes
*
   vxsb(i,r,s)     $ droptrade(i,r,s) = 0;
   vtwr(j,i,r,s)   $ droptrade(i,r,s) = 0;
   rtxs(i,r,s)     $ droptrade(i,r,s) = 0;
   rtms(i,r,s)     $ droptrade(i,r,s) = 0;
*
*  --- aggregate value of imports and exports after dropping trade
*
   vxm(i,r) = sum(s, vxsb(i,r,s)) + vst(i,r);
   vim(i,r) = sum(s,(vxsb(i,s,r)*(1-rtxs(i,s,r))+sum(j,vtwr(j,i,s,r)))*(1+rtms(i,s,r)));
*
*  --- rescale vxsb to match approx. old exports of exporter and imports of importer
*
   bilatTradeScale(r,s) = (sum(j,vxm0(j,r))/sum(j,vxm(j,r))
                        +  sum(j,vim0(j,s))/sum(j,vim(j,s)))/2;
   vxsb(i,r,s)   $ vxsb(i,r,s)   = vxsb(i,r,s)     * bilatTradeScale(r,s);
   vtwr(j,i,r,s) $ vtwr(j,i,r,s) = vtwr(j,i,r,s) * bilatTradeScale(r,s);
*
*  --- rescale global trade (up to 20%)
*
   vxt(i)        = sum((r,s), vxsb(i,r,s));
   vxt(i)$vxt(i) = min(1.2,vxt0(i)/vxt(i));
   vxsb(i,r,s) $ vxsb(i,r,s) = vxsb(i,r,s) * vxt(i);
*
*  --- apply same scalar to trade margins
*
   vtwr(j,i,r,s) $ vtwr(j,i,r,s) = vtwr(j,i,r,s) * vxt(i);
*
*  --- rescale import and tax revenuves
*
   total(r,"new") = sum((i,s), (vxsb(i,s,r)*(1-rtxs(i,s,r))+sum(j,vtwr(j,i,s,r)))*(rtms(i,s,r)));
   rtms(i,s,r) $ rtms(i,s,r) = rtms(i,s,r) * rtms0(r) / total(r,"new");

   vim(i,r) = sum(s,(vxsb(i,s,r)*(1-rtxs(i,s,r))+sum(j,vtwr(j,i,s,r)))*(1+rtms(i,s,r)));
   vim(i,r) $ (sum(s,vxsb(i,s,r)) eq 0) = 0;
   vmpb(i,r)     $ (vim(i,r) eq 0) = 0;
   vmgb(i,r)     $ (vim(i,r) eq 0) = 0;
   vmib(i,r)     $ (vim(i,r) eq 0) = 0;
   vmfb(i,j,r)   $ (vim(i,r) eq 0) = 0;

*  Rescale transport demand:

   vst(i,r) $ vst(i,r) = vst(i,r) * sum((j,s,rrr), vtwr(i,j,s,rrr)) / sum(s, vst(i,s));
   vxm(i,r) =  sum(s, vxsb(i,r,s)) + vst(i,r);

*  Aggregate production:

   vom(j,r) = vdm(j,r) + vxm(j,r);

*  Record current value of aggregate transactions
   $$batinclude 'filter/itrlog.gms' before

   vdm_.l(i,r)      = vdm(i,r);
   evfb_.l(fp,i,r)   = evfb(fp,i,r);
   vdfb_.l(i,j,r)   = vdfb(i,j,r);
   vmfb_.l(i,j,r)   = vmfb(i,j,r);
   vdpb_.l(i,r)     = vdpb(i,r);
   vdgb_.l(i,r)     = vdgb(i,r);
   vdib_.l(i,r)     = vdib(i,r);
   vmpb_.l(i,r)     = vmpb(i,r);
   vmgb_.l(i,r)     = vmgb(i,r);
   vmib_.l(i,r)     = vmib(i,r);

*  Set some bounds to avoid numerical problems (Arne keeps us on a short leash):

   vdm_.lo(i,r)      $ vdm_.range(i,r)      = 0;      vdm_.up(i,r)      $ vdm_.range(i,r)      = gdp(r);
   evfb_.lo(fp,i,r)   $ evfb_.range(fp,i,r)   = 0;      evfb_.up(fp,i,r)   $ evfb_.range(fp,i,r)   = gdp(r);
   vdfb_.lo(i,j,r)   $ vdfb_.range(i,j,r)   = 0;      vdfb_.up(i,j,r)   $ vdfb_.range(i,j,r)   = gdp(r);
   vmfb_.lo(i,j,r)   $ vmfb_.range(i,j,r)   = 0;      vmfb_.up(i,j,r)   $ vmfb_.range(i,j,r)   = gdp(r);
   vdpb_.lo(i,r)     $ vdpb_.range(i,r)     = 0;      vdpb_.up(i,r)     $ vdpb_.range(i,r)     = gdp(r);
   vdgb_.lo(i,r)     $ vdgb_.range(i,r)     = 0;      vdgb_.up(i,r)     $ vdgb_.range(i,r)     = gdp(r);
   vdib_.lo(i,r)     $ vdib_.range(i,r)     = 0;      vdib_.up(i,r)     $ vdib_.range(i,r)     = gdp(r);
   vmpb_.lo(i,r)     $ vmpb_.range(i,r)     = 0;      vmpb_.up(i,r)     $ vmpb_.range(i,r)     = gdp(r);
   vmgb_.lo(i,r)     $ vmgb_.range(i,r)     = 0;      vmgb_.up(i,r)     $ vmgb_.range(i,r)     = gdp(r);
   vmib_.lo(i,r)     $ vmib_.range(i,r)     = 0;      vmib_.up(i,r)     $ vmib_.range(i,r)     = gdp(r);

*  Fix to zero any flows associated with omitted markets:

   vdm_.fx(i,r)      $ (vdm(i,r)  eq 0) = 0;
   vdfb_.fx(i,j,r)   $ (vdm(i,r)  eq 0) = 0;
   vdpb_.fx(i,r)     $ (vdm(i,r)  eq 0) = 0;
   vdgb_.fx(i,r)     $ (vdm(i,r)  eq 0) = 0;
   vdib_.fx(i,r)     $ (vdm(i,r)  eq 0) = 0;

   vdm_.fx(i,r)      $ (vom(i,r)  eq 0) = 0;
   evfb_.fx(fp,i,r)   $ (vom(i,r)  eq 0) = 0;
   vdfb_.fx(i,j,r)   $ (vom(j,r)  eq 0) = 0;
   vmfb_.fx(i,j,r)   $ (vom(j,r)  eq 0) = 0;
   vdfb_.fx(i,j,r)   $ (vom(i,r)  eq 0) = 0;

   vmfb_.fx(i,j,r)   $ (vim(i,r)  eq 0) = 0;
   vmpb_.fx(i,r)     $ (vim(i,r)  eq 0) = 0;
   vmgb_.fx(i,r)     $ (vim(i,r)  eq 0) = 0;
   vmib_.fx(i,r)     $ (vim(i,r)  eq 0) = 0;

   rcount = 0 ;
   loop(rrr,

      rb(rrr) = yes;
      rcount  = rcount + 1 ;

*     Update the title bar with the status prior to the solve:
      nzcountRep = card(vxsb) + card(vtwr) + card(vdfb) + card(vmfb)
                 + card(vdpb) + card(vdgb) + card(vdib) + card(vmpb) + card(vmgb) + card(vmib) + card(evfb) ;

      $$batinclude "filter/title.gms" "'Filtering iteration : '" itr.pos:0:0 "' ('" card(itr):0:0 "'), region '" rrr.tl:0 "' ('" (round(100*(rcount-1)/card(rrr))):0:0 "' % of regions), # of non-zeros: '" nzCountRep:0:0  "', cur rel. tolerance % '" smax((a,r),curRelTol(a,r)):0 "' %'"

*     If necessary, we can begin at a feasible point:

      bigM = 1000;

      options limcol=300,limrow=300, solprint=on ;
      solve lpfeas using lp minimizing vz;
      execerror = 0 ;
      while (((lpfeas.solvestat<>1) or (lpfeas.modelstat>2)) and (bigM < 1.E+5),
         bigM = bigM * 10;
         solve lpfeas using lp minimizing vz;
         execerror = 0 ;
      ) ;
      if((lpfeas.solvestat<>1) or
         (lpfeas.modelstat>2),
         lpfeas.solprint = 1;
         solve lpfeas using lp minimizing vz;
         put_utility 'log' / "Feasibility model fails for region: ",rrr.tl," you might have used to aggressive thresholds";
         abort "Feasibility model fails:", rb, bigM, facty, bop0, gdp ;
      );
      solve calib using nlp minimizing obj ;
      if((calib.suminfes ne 0) or (calib.numinfes > 0),
         calib.solprint = 1;
         solve calib using nlp minimizing obj;
         put_utility 'log' / "Calibration model fails for region: ",rrr.tl," you might have used to aggressive thresholds";
         abort "Calibration model fails:", rb, facty, bop0, gdp ;
      ) ;
      if((calib.solvestat <> 1) or (calib.modelstat > 2),
         solve calib using nlp minimizing obj ;
         execerror = 0 ;
      );

      vdm(i,rb)      = vdpb_.l(i,rb) + vdgb_.l(i,rb) + vdib_.l(i,rb) + sum(j,vdfb_.l(i,j,rb)) ;
      evfb(fp,i,rb)   = evfb_.l(fp,i,rb);
      vdfb(i,j,rb)   = vdfb_.l(i,j,rb);
      vmfb(i,j,rb)   = vmfb_.l(i,j,rb);
      vdpb(i,rb)     = vdpb_.l(i,rb);
      vdgb(i,rb)     = vdgb_.l(i,rb);
      vdib(i,rb)     = vdib_.l(i,rb);
      vmpb(i,rb)     = vmpb_.l(i,rb);
      vmgb(i,rb)     = vmgb_.l(i,rb);
      vmib(i,rb)     = vmib_.l(i,rb);
      vom(i,rb)      = vdm(i,rb) + sum(s, vxsb(i,rb,s)) + vst(i,rb);
      vxm(i,rb)      = sum(s, vxsb(i,rb,s)) + vst(i,rb);

      if(sum((fp,i,rb), evfb(fp,i,rb)) eq 0,
         calib.solprint = 1;
         solve calib using nlp minimizing obj ;
         abort "No factor income left" ;
      );

      rb(rrr) = no;
   );

*  Record resulting value of aggregate transactions and change in non-zeros
   $$batinclude 'filter/itrlog.gms' after

   option nz:0;
   if (calib.solprint eq 1, display nz) ;

   option trace:3:1:1;
   if(calib.solprint eq 1, display trace ; ) ;

   itrlog("nonzeros",itr,dsitem)       = nz(dsitem,"count");
   itrlog("nonzeros",itr,r)            = nz(r,"count");
   itrlog("nonzeros",itr,i)            = nz(i,"count");
   itrlog("nonzeros",itr,"curRelTol")  = smax((i,r), curRelTol(i,r));
   itrlog("nonzeros",itr,"curAbsTol")  = curAbsTol;
   itrlog("change",itr,dsitem)         = nz(dsitem,"change");
   itrlog("change",itr,"curRelTol")    = smax((i,r),curRelTol(i,r));
   itrlog("change",itr,"curAbsTol")    = curAbsTol;
   itrlog("trace",itr,dsitem)          = sum(r,trace(dsitem,r,"before"));
   itrlog("trace",itr,"curRelTol")     = smax((i,r),curRelTol(i,r));
   itrlog("trace",itr,"curAbsTol")     = curAbsTol;
   itrlog(r,itr,dsitem)                = trace(dsitem,r,"before");

   if (curAbsTol < absTol*0.999, curAbsTol = curAbsTol + absTol/nSteps);
   if (smax((i,r), curRelTol(i,r)) < relTol*0.999, curRelTol(i,r) = curRelTol(i,r) + startRelTol(i,r)/nSteps) ;

   curRelTol(i,r) = round(curRelTol(i,r),8);

   if (relTol eq 1.E-10, curRelTol(i,r) = 1.E-10);

   nzcountEnd = card(vxsb) + card(vtwr) + card(vdfb) + card(vmfb)
              + card(vdpb) + card(vdgb) + card(vdib) + card(vmpb) + card(vmgb) + card(vmib) + card(evfb) ;
*  End of iteration (itr)
);

itrlog(r,"done",dsitem)          = trace(dsitem,r,"after");
itrlog("trace","done",dsitem)    = sum(r,trace(dsitem,r,"after"));
$batinclude 'filter/itrlog.gms' count
itrlog("nonZeros","done",dsitem) = nz(dsitem,"count");
itrlog("nonZeros","done",r)      = nz(r,"count");
itrlog("nonZeros","done",i)      = nz(i,"count");

set aggItr / set.itr, start, absFilt, done / ;
itrLog("nonZeros",aggItr,"total") = sum(dsItem, itrLog("nonZeros",aggItr,dsItem)) ;

dsItem(r) = YES;
dsItem(i) = YES;
itrLog("nonZeros","delta",dsItem) = itrlog("nonZeros","done",dsitem) - itrlog("nonzeros","start",dsitem);
itrLog("nonZeros","delta (%)",dsItem) $ itrlog("nonZeros","Start",dsitem)
     = itrLog("nonZeros","delta",dsItem) / itrlog("nonZeros","start",dsitem) * 100;
dsItem(r) = no ;
dsItem(i) = no ;

itrLog("trace","delta",dsItem) = itrlog("trace","done",dsitem) - itrlog("trace","start",dsitem);
itrLog("trace","delta (%)",dsItem) $ itrlog("trace","start",dsitem)
   = itrLog("trace","delta",dsItem) / itrlog("trace","start",dsitem) * 100;

itrLog(r,"delta",dsItem) = itrlog(r,"done",dsitem) - itrlog(r,"start",dsitem);
itrLog(r,"delta (%)",dsItem) $ itrlog(r,"start",dsitem)
    = itrLog(r,"delta",dsItem) / itrlog(r,"start",dsitem) * 100;

put logfile ; put / ;
put  " " / ;
put  "* --- value of transactions " / ;
put  " " / ;
put  "item":25,"start":10,"end":10,"abs diff ":10,"rel diff":10 / ;
loop(dsitem $ itrLog("trace","start",dsitem),
   put  dsItem.tl:20,
      itrLog("trace","start",dsitem):10:0," ",
      itrLog("trace","done",dsitem):10:0," ",
      itrLog("trace","delta",dsitem):10:0," ",
      itrLog("trace","delta (%)",dsitem):10," %" / ;
);
put  " " / ;
put  "* --- non-zero items " / ;
put  " " / ;
dsItem(r) = YES ;
dsItem(i) = YES ;
put  "item":25,"start":10,"end":10,"abs diff ":10,"rel diff":10 / ;
loop(dsitem $ itrLog("nonZeros","start",dsitem),
   put  dsItem.tl:20,
      itrLog("nonZeros","start",dsitem):10:0," ",
      itrLog("nonZeros","done",dsitem):10:0," ",
      itrLog("nonZeros","delta",dsitem):10:0," ",
      itrLog("nonZeros","delta (%)",dsitem):10," %" / ;
);
dsItem(r) = NO;
dsItem(i) = NO;
put  " " / ;

parameter
   checkDim
   check
;
checkDim(r,"vdib","before")  = sum(i, vdib(i,r))  ;
checkDim(r,"vmib","before")  = sum(i, vmib(i,r))  ;
checkDim(r,"vdep","before")  = vdep(r);
checkDim(r,"vkb","before")   = vkb(r);
checkDim(r,"fdepr","before") = vdep(r)/vkb(r);
checkDim(r,"save","before")  = save(r);
checkDim(r,"fsav","before")  = -sum((i,s), vfob(i,r,s)) + sum( (i,s),  vcif(i,s,r)) - sum(i, vst(i,r));
checkDim(r,"xft","before")   = sum((cap,i), evfb0(cap,i,r));

*
* ---- update vmsb and vcif
*

vcif(i,r,s) $ vcif(i,r,s) = vcif(i,r,s) * vxsb(i,r,s)/vxsb0(i,r,s);
vmsb(i,r,s) $ vmsb(i,r,s) = vcif(i,r,s) * (1+rtms(i,r,s)) ;
vfob(i,r,s) $ vfob(i,r,s) = vxsb(i,r,s) * (1-rtxs(i,r,s));

check(r,"evfp","before") = sum((fp,a), evfp(fp,a,r)) ;

*
* --- update transaction at agent prices, using tax rates
*

evfp(fp,j,r) = evfb(fp,j,r)  * (1+rtf(fp,j,r));
check(r,"evfp","after")  = sum((fp,j), evfp(fp,j,r));
check(r,"ftrv","before") = sum((fp,j), ftrv(fp,j,r));
ftrv(fp,j,r) $ evfb0(fp,j,r) = ftrv(fp,j,r) * evfb(fp,j,r)/evfb0(fp,j,r);
ftrv(fp,j,r) $ (not evfb0(fp,j,r)) = 0;
check(r,"ftrv","after") = sum((fp,j), ftrv(fp,j,r));

*
* --- update tax income flows
*
check(r,"fbep","before") = sum((fp,j), fbep(fp,j,r));
fbep(fp,j,r) $ evfb0(fp,j,r) = -evfp(fp,j,r) + evfb(fp,j,r) + ftrv(fp,j,r) ;
fbep(fp,j,r) $ (not evfb0(fp,j,r)) = 0;
check(r,"fbep","after")  = sum((fp,j), fbep(fp,j,r));

check(r,"osep","before") = sum(j, osep(j,r));
osep(j,r) = -rto(j,r) * (vdm(j,r)  + vxm(j,r) ) $ vom(j,r);
check(r,"osep","after") = sum(j, osep(j,r));

vdpp(i,r)     = vdpb(i,r)   * (1+rtpd(i,r));
vmpp(i,r)     = vmpb(i,r)   * (1+rtpm(i,r));
vdgp(i,r)     = vdgb(i,r)   * (1+rtgd(i,r));
vmgp(i,r)     = vmgb(i,r)   * (1+rtgm(i,r));
vdip(i,r)     = vdib(i,r)   * (1+rtid(i,r));
vmip(i,r)     = vmib(i,r)   * (1+rtim(i,r));
vdfp(i,j,r)   = vdfb(i,j,r) * (1+rtfd(i,j,r));
vmfp(i,j,r)   = vmfb(i,j,r) * (1+rtfm(i,j,r));

*
* --- update depreciation and initial capital stock
*     (not necessary for consistency, but might keep depreciation rates etc.
*      in more plausbile ranges)
*
*  14-May-2016: DvdM--I don't believe this adjustment belongs here as it changes the macro SAM and
*                     is not part of the filtering process.
*
parameter
   scaleCap
;

*  Agents' prices????
if(ifAdjDepr,
   scaleCap(r) = sqrt(sum((fp,cap,j) $ sameas(fp,cap), evfb(fp,j,r))/sum((fp,cap,j) $ sameas(fp,cap), evfb0(fp,j,r))
               *      sum(i, vdip(i,r)+vmip(i,r))/sum(i, vdip0(i,r)+vmip0(i,r))) ;

   vdep(r) =  vdep(r) * scaleCap(r);
   vkb(r)  =  vkb(r)  * scaleCap(r);

*
*  --- calculate saving residually -- should be at agents' prices
*
   SAVE(r) = sum(i, vdip(i,r)+vmip(i,r))
           - [-sum((i,s), vfob(i,r,s)) + sum((i,s), vcif(i,s,r)) - sum(i, vst(i,r))]
           - vdep(r) ;

*
*  ---- increase capital stock (to dampen effect of changes in foreign saving on return to capital)
*         if share of savings on investment expenditures < 50%
*
*  vkb(r) $ (  (save(r) / sum(i, vdip(i,r)+vdip(i,r))) < 0.2)
*     = vkb(r) * 1/max(0.2,save(r) / sum(i, vdib(i,r)+vdip(i,r)));
*
*  ---- ensure at least 20% savings on total investment expenditures
*
   SAVE(r)$((save(r)/sum(i, vdip(i,r)+vmip(i,r))) < 0.20) = 0.20 * sum(i, vdip(i,r)+vmip(i,r)) ;
*
*  --- calculate depreciation residually (only necessary if 20% threshold kicked in)
*        but maintain 50% of original level
*
   vdep(r) = max(0.5 * vdep(r),
               sum(i, vdip(i,r)+vmip(i,r))
           -  [-sum((i,s), vfob(i,r,s)) + sum((i,s), vcif(i,s,r)) - sum(i, vst(i,r))]
           -  save(r)) ;
*
*  --- recalculate savings
*
   SAVE(r) = sum(i, vdip(i,r)+vmip(i,r))
           -   [-sum((i,s), vfob(i,r,s)) + sum((i,s), vcif(i,s,r)) - sum(i, vst(i,r))]
           -   vdep(r) ;

   if(sum(r $ (vdep(r) < 0),1),

      put logfile ;
      put   "Implied changes so large that depreciation became negative after corrections, please reduce thresholds" / ;
      abort "Implied changes so large that depreciation became negative after corrections, please reduce thresholds", vdep ;
   ) ;
) ;

alias(fp,fp1); alias(a,a1) ;

checkDim(r,"vdib","after")   = sum(i, vdib(i,r)) ;
checkDim(r,"vmib","after")   = sum(i, vmib(i,r)) ;
checkDim(r,"vdep","after")  = vdep(r) ;
checkDim(r,"vkb","after")   = vkb(r) ;
checkDim(r,"fdepr","after") = vdep(r)/vkb(r) ;
checkDim(r,"save","after")  = save(r) ;
checkDim(r,"fsav","after")  = -sum((i,s), vfob(i,r,s)) + sum((i,s), vcif(i,s,r)) - sum(i, vst(i,r)) ;
checkDim(r,"xft","after")   = sum((fp,cap,a) $ sameas(fp,cap), evfb(fp,a,r)) ;

set dimCheck / vdib, vmib, vdep, save, fsav, xft, vkb, fdepr / ;
checkDim(r,dimCheck,"delta") = checkDim(r,dimCheck,"after") - checkDim(r,dimCheck,"before");
checkDim(r,dimCheck,"% delta") $ checkDim(r,dimCheck,"before") = checkDim(r,dimCheck,"delta")/checkDim(r,dimCheck,"before")*100;
display checkDim;

*
* --- update direct taxes on factors
* !!!! May want to re-visit with new evos matrix
*
parameter
   evosNew(r)
;

check(r,"evos","before") = sum((fp,a), evos(fp,a,r));

*  14-May-2016: DvdM

* $ontext
evosNew(r) = dirtax(r)
           - [sum(i, vdgb(i,r)*(1+rtgd(i,r)) + vmgb(i,r)*(1+rtgm(i,r)))
           -  sum(j, sum(fp, ftrv(fp,j,r) - fbep(fp,j,r)) -  osep(j,r))
           -  sum(i,
           +   vdpb(i,r) * rtpd(i,r) + vmpb(i,r) * rtpm(i,r)
           +   vdgb(i,r) * rtgd(i,r) + vmgb(i,r) * rtgm(i,r)
           +   vdib(i,r) * rtid(i,r) + vmib(i,r) * rtim(i,r)
           +   sum(j, vdfb(i,j,r) * rtfd(i,j,r) + vmfb(i,j,r) * rtfm(i,j,r))
           +   sum(s, vmsb(i,s,r) - vcif(i,s,r))
           +   sum(s, vfob(i,r,s) - vxsb(i,r,s)))
           -   sum ((fp,cap,j) $ sameas(fp,cap), evfb(fp,j,r)) ] ;

check(r,"evos","after") = sum((fp,a), evos(fp,a,r)) ;

evos(fp,a,r) $ evos(fp,a,r) = evos(fp,a,r) * evosNew(r) / sum((fp1,a1), evos(fp1,a1,r)) ;

*$offtext

evos(fp,a,r) = (1 - rtva(fp,r))*evfb(fp,a,r) ;
check(r,"evos","after") = sum((fp,a), evos(fp,a,r)) ;
set checkItems / evos, fbep, osep, evfp, ftrv / ;
check(r,checkItems,"delta") = check(r,checkItems,"after")  - check(r,checkItems,"before") ;
check(r,checkItems,"%") $  check(r,checkItems,"before")
   = check(r,checkItems,"delta")/check(r,checkItems,"before") * 100;

display check, keepCor.l;

$batinclude "aggsam.gms"  "AFTER"

*  Re-initialize make matrices

vdm(i,r)     = sum(j, vdfb(i,j,r)) + vdpb(i,r) + vdgb(i,r) + vdib(i,r) ;
vom(i,r)     = vdm(i,r) + sum(s, vxsb(i,r,s)) + vst(i,r) ;
voa(j,r)     = sum(fp, evfp(fp,j,r)) + sum(i, vdfp(i,j,r) + vmfp(i,j,r)) ;
osep(j,r)    = voa(j,r) - vom(j,r) ;

maks(i,i,r)  = voa(i,r) ;
makb(i,i,r)  = vom(i,r) ;
ptax(i,i,r)  = vom(i,r) - voa(i,r) ;

execute_unload "%baseName%/flt/%baseName%Dat.gdx",
   vdfb, vdfp, vmfb, vmfp,
   vdpb, vdpp, vmpb, vmpp,
   vdgb, vdgp, vmgb, vmgp,
   vdib, vdip, vmib, vmip,
   evfb, evfp, evos,
   vxsb, vfob, vcif, vmsb,
   vst,  vtwr,
   save, vdep,
   vkb,  pop,
   maks, makb, ptax
;

;

scalar emiCount / 0 / ;

$ifthen exist "%baseName%/agg/%baseName%Emiss.gdx"
   execute_load "%baseName%/agg/%baseName%Emiss.gdx",
      mdf, mmf, mdp, mmp, mdg, mmg, mdi, mmi ;

   emiCount = emiCount + 1 ;
$endif

$ifthen exist "%baseName%/agg/%baseName%Vole.gdx"
   execute_load  "%baseName%/agg/%baseName%Vole.gdx",
      EDF, EMF, EDP, EMP, EDG, EMG, EDI, EMI, EXIDAG ;

   emiCount = emiCount + 1 ;
$endif

$iftheni.nco2 "%NCO2%" == "ON"
   $$ifthen exist "%baseName%/agg/%baseName%NCO2.gdx"

      execute_load  "%baseName%/agg/%baseName%NCO2.gdx",
         NC_TRAD, NC_ENDW, NC_QO, NC_HH, NC_TRAD_CEQ, NC_ENDW_CEQ, NC_QO_CEQ, NC_HH_CEQ ;

      emiCount = emiCount + 1 ;

   $$else

      $$setGlobal NCO2 OFF

   $$endif
$endif.nco2

if(emiCount ge 2,
$batinclude "aggNRG.gms" BEFORE
) ;

$ifthen exist "%baseName%/agg/%baseName%Emiss.gdx"

Parameters
   mdp0(i,r), mmp0(i,r), mdg0(i,r), mmg0(i,r), mdi0(i,r), mmi0(i,r), mdf0(i,a,r), mmf0(i,a,r) ;
   mdp0(i,r) = mdp(i,r) ;
   mmp0(i,r) = mmp(i,r) ;
   mdg0(i,r) = mdg(i,r) ;
   mmg0(i,r) = mmg(i,r) ;
   mdi0(i,r) = mdi(i,r) ;
   mmi0(i,r) = mmi(i,r) ;
   mdf0(i,a,r) = mdf(i,a,r) ;
   mmf0(i,a,r) = mmf(i,a,r) ;

*
* --- scale emissions commodity specific emissions to recover totals
*

   if(1,

*     Scale individual cells first

      mdp(i,r)$vdpb0(i,r) = (mdp0(i,r)/vdpb0(i,r))*vdpb(i,r) ;
      mmp(i,r)$vmpb0(i,r) = (mmp0(i,r)/vmpb0(i,r))*vmpb(i,r) ;
      mdg(i,r)$vdgb0(i,r) = (mdg0(i,r)/vdgb0(i,r))*vdgb(i,r) ;
      mmg(i,r)$vmgb0(i,r) = (mmg0(i,r)/vmgb0(i,r))*vmgb(i,r) ;
      mdi(i,r)$vdib0(i,r) = (mdi0(i,r)/vdib0(i,r))*vdib(i,r) ;
      mmi(i,r)$vmib0(i,r) = (mmi0(i,r)/vmib0(i,r))*vmib(i,r) ;
      mdf(i,j,r)$vdfb0(i,j,r) = (mdf0(i,j,r)/vdfb0(i,j,r))*vdfb(i,j,r) ;
      mmf(i,j,r)$vmfb0(i,j,r) = (mmf0(i,j,r)/vmfb0(i,j,r))*vmfb(i,j,r) ;

   ) ;

   if(1,
      total("old",r) = sum(i, mdp0(i,r)) ;
      total("new",r) = sum(i $ vdpb(i,r), mdp(i,r)) ;
      mdp(i,r) $ total("new",r) = (mdp(i,r) * total("old",r)/total("new",r)) $ vdpb(i,r);

      total("old",r) = sum(i, mmp0(i,r));
      total("new",r) = sum(i $ vmpb(i,r), mmp(i,r));
      mmp(i,r) $ total("new",r) = (mmp(i,r) * total("old",r)/total("new",r)) $ vmpb(i,r);

      total("old",r) = sum(i, mdg0(i,r));
      total("new",r) = sum(i $ vdgb(i,r), mdg(i,r));
      mdg(i,r) $ total("new",r) = (mdg(i,r) * total("old",r)/total("new",r)) $ vdgb(i,r);

      total("old",r) = sum(i, mmg0(i,r));
      total("new",r) = sum(i $ vmgb(i,r), mmg(i,r));
      mmg(i,r) $ total("new",r) = (mmg(i,r) * total("old",r)/total("new",r)) $ vmgb(i,r);

      total("old",r) = sum(i, mdi0(i,r));
      total("new",r) = sum(i $ vdib(i,r), mdi(i,r));
      mdi(i,r) $ total("new",r) = (mdi(i,r) * total("old",r)/total("new",r)) $ vdib(i,r);

      total("old",r) = sum(i, mmi0(i,r));
      total("new",r) = sum(i $ vmib(i,r), mmi(i,r));
      mmi(i,r) $ total("new",r) = (mmi(i,r) * total("old",r)/total("new",r)) $ vmib(i,r);

      total("old",r) = sum((i,a), mdf0(i,a,r));
      total("new",r) = sum((i,a) $ vdfb(i,a,r), mdf(i,a,r));
      mdf(i,a,r)$ total("new",r) = (mdf(i,a,r) * total("old",r)/total("new",r)) $ vdfb(i,a,r);

      total("old",r) = sum((i,a), mmf0(i,a,r));
      total("new",r) = sum((i,a) $ vmfb(i,a,r), mmf(i,a,r) );
      mmf(i,a,r) $ total("new",r) = (mmf(i,a,r) * total("old",r)/total("new",r)) $ vmfb(i,a,r);
   ) ;

   execute_unload "%baseName%/flt/%baseName%Emiss.gdx",
      mdf, mmf, mdp, mmp, mdg, mmg, mdi, mmi ;

$endif

$ifthen exist "%baseName%/agg/%baseName%Vole.gdx"

Parameters
   edp0(i,r), emp0(i,r), edg0(i,r), emg0(i,r), edi0(i,r), emi0(i,r), edf0(i,a,r), emf0(i,a,r), exidag0(i,r,d) ;
   edp0(i,r) = edp(i,r) ;
   emp0(i,r) = emp(i,r) ;
   edg0(i,r) = edg(i,r) ;
   emg0(i,r) = emg(i,r) ;
   edi0(i,r) = edi(i,r) ;
   emi0(i,r) = emi(i,r) ;
   edf0(i,a,r) = edf(i,a,r) ;
   emf0(i,a,r) = emf(i,a,r) ;
   exidag0(i,r,d) = exidag(i,r,d) ;

   if(1,

*     Scale individual cells first

      edp(i,r)$vdpb0(i,r) = (edp0(i,r)/vdpb0(i,r))*vdpb(i,r) ;
      emp(i,r)$vmpb0(i,r) = (emp0(i,r)/vmpb0(i,r))*vmpb(i,r) ;
      edg(i,r)$vdgb0(i,r) = (edg0(i,r)/vdgb0(i,r))*vdgb(i,r) ;
      emg(i,r)$vmgb0(i,r) = (emg0(i,r)/vmgb0(i,r))*vmgb(i,r) ;
      edi(i,r)$vdib0(i,r) = (edi0(i,r)/vdib0(i,r))*vdib(i,r) ;
      emi(i,r)$vmib0(i,r) = (emi0(i,r)/vmib0(i,r))*vmib(i,r) ;
      edf(i,j,r)$vdfb0(i,j,r) = (edf0(i,j,r)/vdfb0(i,j,r))*vdfb(i,j,r) ;
      emf(i,j,r)$vmfb0(i,j,r) = (emf0(i,j,r)/vmfb0(i,j,r))*vmfb(i,j,r) ;
      exidag(i,r,d)$vfob0(i,r,d) = (exidag0(i,r,d)/vfob0(i,r,d))*vfob(i,r,d) ;
   ) ;

*
* --- scale energy volumes to recover totals
*
   total("old",r) = sum(i, edp0(i,r)) ;
   total("new",r) = sum(i $ vdpb(i,r), edp(i,r)) ;
   edp(i,r) $ total("new",r) = (edp(i,r) * total("old",r)/total("new",r)) $ vdpb(i,r);

   total("old",r) = sum(i, emp0(i,r));
   total("new",r) = sum(i $ vmpb(i,r), emp(i,r));
   emp(i,r) $ total("new",r) = (emp(i,r) * total("old",r)/total("new",r)) $ vmpb(i,r);

   total("old",r) = sum(i, edg0(i,r));
   total("new",r) = sum(i $ vdgb(i,r), edg(i,r));
   edg(i,r) $ total("new",r) = (edg(i,r) * total("old",r)/total("new",r)) $ vdgb(i,r);

   total("old",r) = sum(i, emg0(i,r));
   total("new",r) = sum(i $ vmgb(i,r), emg(i,r));
   emg(i,r) $ total("new",r) = (emg(i,r) *total("old",r)/total("new",r)) $ vmgb(i,r);

   total("old",r) = sum(i, edi0(i,r));
   total("new",r) = sum(i $ vdib(i,r), edi(i,r));
   edi(i,r) $ total("new",r) = (edi(i,r) * total("old",r)/total("new",r)) $ vdib(i,r);

   total("old",r) = sum(i, emi0(i,r));
   total("new",r) = sum(i $ vmib(i,r), emi(i,r));
   emi(i,r) $ total("new",r) = (emi(i,r) *total("old",r)/total("new",r)) $ vmib(i,r);

   total("old",r) = sum((i,a), edf0(i,a,r));
   total("new",r) = sum((i,a) $ vdfb(i,a,r), edf(i,a,r));
   edf(i,a,r)$ total("new",r) = (edf(i,a,r) * total("old",r)/total("new",r)) $ vdfb(i,a,r);

   total("old",r) = sum((i,a), emf0(i,a,r));
   total("new",r) = sum((i,a) $ vmfb(i,a,r), emf(i,a,r));
   emf(i,a,r) $ total("new",r) = (emf(i,a,r) * total("old",r)/total("new",r)) $ vmfb(i,a,r);

   loop(i,
      total("old",r) = sum(rp, exidag0(i,r,rp));
      total("new",r) = sum(rp $ vfob(i,r,rp), exidag(i,r,rp));
      exidag(i,r,rp) $ total("new",r) = (exidag(i,r,rp) * total("old",r)/total("new",r)) $ vfob(i,r,rp) ;
   ) ;

   execute_unload "%baseName%/flt/%baseName%Vole.gdx",
      EDF, EMF, EDP, EMP, EDG, EMG, EDI, EMI, EXIDAG ;

$endif

$$iftheni.nco2 "%NCO2%" == "ON"
   $$ifthen exist "%baseName%/agg/%baseName%NCO2.gdx"

      Parameters
         NC_HH0(nco2,i,r), NC_HH_CEQ0(nco2,i,r), NC_TRAD0(nco2,i,a,r), NC_TRAD_CEQ0(nco2,i,a,r),
            NC_ENDW0(nco2,fp,a,r), NC_ENDW_CEQ0(nco2,fp,a,r), NC_QO0(nco2,j,r), NC_QO_CEQ0(nco2,j,r) ;
      NC_HH0(nco2,i,r)          = NC_HH(nco2,i,r) ;
      NC_HH_CEQ0(nco2,i,r)      = NC_HH_CEQ(nco2,i,r) ;
      NC_TRAD0(nco2,i,a,r)      = NC_TRAD(nco2,i,a,r) ;
      NC_TRAD_CEQ0(nco2,i,a,r)  = NC_TRAD_CEQ(nco2,i,a,r) ;
      NC_ENDW0(nco2,fp,j,r)     = NC_ENDW(nco2,fp,j,r) ;
      NC_ENDW_CEQ0(nco2,fp,j,r) = NC_ENDW_CEQ(nco2,fp,j,r) ;
      NC_QO0(nco2,j,r)          = NC_QO(nco2,j,r) ;
      NC_QO_CEQ0(nco2,j,r)      = NC_QO_CEQ(nco2,j,r) ;

      if(1,
*        Scale individual cells first

         NC_HH(nco2,i,r)$(vdpb0(i,r) + vmpb0(i,r)) = (NC_HH0(nco2,i,r)/(vdpb0(i,r) + vmpb0(i,r)))*(vdpb(i,r) + vmpb(i,r)) ;
         NC_HH_CEQ(nco2,i,r)$(vdpb0(i,r) + vmpb0(i,r)) = (NC_HH_CEQ0(nco2,i,r)/(vdpb0(i,r) + vmpb0(i,r)))*(vdpb(i,r) + vmpb(i,r)) ;

         NC_TRAD(nco2,i,j,r)$(vdfb0(i,j,r) + vmfb0(i,j,r)) = (NC_TRAD0(nco2,i,j,r)/(vdfb0(i,j,r) + vmfb0(i,j,r)))*(vdfb(i,j,r) + vmfb(i,j,r)) ;
         NC_TRAD_CEQ(nco2,i,j,r)$(vdfb0(i,j,r) + vmfb0(i,j,r)) = (NC_TRAD_CEQ0(nco2,i,j,r)/(vdfb0(i,j,r) + vmfb0(i,j,r)))*(vdfb(i,j,r) + vmfb(i,j,r)) ;

         NC_ENDW(nco2,fp,j,r)$(evfb0(fp,j,r)) = (NC_ENDW0(nco2,fp,j,r)/evfb0(fp,j,r))*evfb(fp,j,r) ;
         NC_ENDW_CEQ(nco2,fp,j,r)$(evfb0(fp,j,r)) = (NC_ENDW_CEQ0(nco2,fp,j,r)/evfb0(fp,j,r))*evfb(fp,j,r) ;

         NC_QO(nco2,j,r)$(vom0(j,r)) = (NC_QO0(nco2,j,r)/vom0(j,r))*vom(j,r) ;
         NC_QO_CEQ(nco2,j,r)$(vom0(j,r)) = (NC_QO_CEQ0(nco2,j,r)/vom0(j,r))*vom(j,r) ;

      ) ;

*
* --- scale nco2 levels to recover totals

      loop(nco2,

*        Households

         total("old",r) = sum(i, NC_HH0(nco2,i,r)) ;
         total("new",r) = sum(i $ (vdpb(i,r) + vmpb(i,r)), NC_HH(nco2,i,r)) ;
         NC_HH(nco2,i,r) $ total("new",r) = (NC_HH(nco2,i,r) * total("old",r)/total("new",r)) $ (vdpb(i,r) + vmpb(i,r)) ;

         total("old",r) = sum(i, NC_HH_CEQ0(nco2,i,r)) ;
         total("new",r) = sum(i $ (vdpb(i,r) + vmpb(i,r)), NC_HH_CEQ(nco2,i,r)) ;
         NC_HH_CEQ(nco2,i,r) $ total("new",r) = (NC_HH_CEQ(nco2,i,r) * total("old",r)/total("new",r)) $ (vdpb(i,r) + vmpb(i,r)) ;

*        Firms

         total("old",r) = sum((i,a), NC_TRAD0(nco2,i,a,r));
         total("new",r) = sum((i,a) $ (vdfb(i,a,r) + vmfb(i,a,r)), NC_TRAD(nco2,i,a,r));
         NC_TRAD(nco2,i,a,r)$ total("new",r) = (NC_TRAD(nco2,i,a,r) * total("old",r)/total("new",r)) $ (vdfb(i,a,r) + vmfb(i,a,r)) ;

         total("old",r) = sum((i,a), NC_TRAD_CEQ0(nco2,i,a,r));
         total("new",r) = sum((i,a) $ (vdfb(i,a,r) + vmfb(i,a,r)), NC_TRAD_CEQ(nco2,i,a,r));
         NC_TRAD_CEQ(nco2,i,a,r)$ total("new",r) = (NC_TRAD_CEQ(nco2,i,a,r) * total("old",r)/total("new",r)) $ (vdfb(i,a,r) + vmfb(i,a,r)) ;

*        Endowments

         total("old",r) = sum((fp,a), NC_ENDW0(nco2,fp,a,r));
         total("new",r) = sum((fp,a) $ (evfb(fp,a,r)), NC_ENDW(nco2,fp,a,r));
         NC_ENDW(nco2,fp,a,r)$ total("new",r) = (NC_ENDW(nco2,fp,a,r) * total("old",r)/total("new",r)) $ (evfb(fp,a,r)) ;

         total("old",r) = sum((fp,a), NC_ENDW_CEQ0(nco2,fp,a,r));
         total("new",r) = sum((fp,a) $ (evfb(fp,a,r)), NC_ENDW_CEQ(nco2,fp,a,r));
         NC_ENDW_CEQ(nco2,fp,a,r)$ total("new",r) = (NC_ENDW_CEQ(nco2,fp,a,r) * total("old",r)/total("new",r)) $ (evfb(fp,a,r)) ;

*        Output

         total("old",r) = sum(j, NC_QO0(nco2,j,r)) ;
         total("new",r) = sum(j $ vom(j,r), NC_QO(nco2,j,r)) ;
         NC_QO(nco2,j,r) $ total("new",r) = (NC_QO(nco2,j,r) * total("old",r)/total("new",r)) $ vom(j,r) ;

         total("old",r) = sum(j, NC_QO_CEQ0(nco2,j,r)) ;
         total("new",r) = sum(j $ vom(j,r), NC_QO_CEQ(nco2,j,r)) ;
         NC_QO_CEQ(nco2,j,r) $ total("new",r) = (NC_QO_CEQ(nco2,j,r) * total("old",r)/total("new",r)) $ vom(j,r) ;
      ) ;

      execute_unload "%baseName%/flt/%baseName%NCO2.gdx",
         NC_TRAD, NC_ENDW, NC_QO, NC_HH, NC_TRAD_CEQ, NC_ENDW_CEQ, NC_QO_CEQ, NC_HH_CEQ ;

   $$endif

$endif.nco2

*  Re-scale labor volumes

$ifthen exist "%baseName%\agg\%baseName%Wages.gdx"

   Parameters
      q(l,a,r)       "Initial labor volumes"
      wage(l,a,r)    "Initial wage"
      q0(l,a,r)      "Adjusted labor volume"
      wage0(l,a,r)   "Adusted wage"
   ;

   execute_load "%baseName%/agg/%baseName%Wages.gdx",
      q, wage ;

   q0(l,a,r)    = q(l,a,r) ;
   wage0(l,a,r) = wage(l,a,r) ;

*
* --- scale labor volume--keeping wage the same
*

   if(1,

      q(l,a,r)$wage(l,a,r) = evfb(l,a,r)/wage(l,a,r) ;

   ) ;

   execute_unload "%baseName%/flt/%baseName%Wages.gdx",
      q, wage ;

$endif

execute_unload "filter.gdx"
$show

if(emiCount eq 3,
$batinclude "aggNRG.gms" AFTER
) ;
