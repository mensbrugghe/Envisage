$setGlobal REDUX 1

*  DEFINE MACROS FOR VARIABLE SUBSTITUTION

*                             (()$IFSUB + ()$(not IFSUB))
$macro PP_SUB(r,a,i,t)        ((p0(r,a,i)*p(r,a,i,t) * (1 + ptax(r,a,i,t))/pp0(r,a,i))$IFSUB + (pp(r,a,i,t))$(not IFSUB))

$macro PA_SUB(r,i,aa,t)       (((1 + paTax(r,i,aa,t))*gammaeda(r,i,aa)*pat(r,i,t)*(pat0(r,i)/pa0(r,i,aa)) + sum(em, chiEmi(em,t)*emir(r,em,i,aa)*part(r,em,i,aa)*emiTax(r,em,t)/pa0(r,i,aa)))$(ArmFlag eq 0 and IFSUB) + (pa(r,i,aa,t))$(ArmFlag or (ArmFlag eq 0 and not IFSUB)))
$macro PD_SUB(r,i,aa,t)       (((1 + pdTax(r,i,aa,t))*gammaedd(r,i,aa)*pdt(r,i,t)*(pdt0(r,i)/pd0(r,i,aa)) + sum(em, chiEmi(em,t)*emird(r,em,i,aa)*part(r,em,i,aa)*emiTax(r,em,t)/pd0(r,i,aa)))$IFSUB + (pd(r,i,aa,t))$(not IFSUB))
$macro PM_SUB(r,i,aa,t)       (((1 + pmTax(r,i,aa,t))*gammaedm(r,i,aa)*((pmt(r,i,t)*pmt0(r,i))$(not MRIO) + (pma(r,i,aa,t)*pma0(r,i,aa))$MRIO)/pm0(r,i,aa) + sum(em, chiEmi(em,t)*emirm(r,em,i,aa)*part(r,em,i,aa)*emiTax(r,em,t)/pm0(r,i,aa)))$IFSUB + (pm(r,i,aa,t))$(not IFSUB))

$macro PWE_SUB(r,i,rp,t)      (((1 + etax(r,i,rp,t) + etaxi(r,i,t))*pe(r,i,rp,t)*(pe0(r,i,rp)/pwe0(r,i,rp)))$IFSUB + (pwe(r,i,rp,t))$(not IFSUB))
$macro PWM_SUB(r,i,rp,t)      ((PWE_SUB(r,i,rp,t)*(pwe0(r,i,rp)/(lambdaw(r,i,rp,t)*pwm0(r,i,rp))) + tmarg(r,i,rp,t)*PWMG_SUB(r,i,rp,t)/(lambdaw(r,i,rp,t)*pwm0(r,i,rp)))$IFSUB + (pwm(r,i,rp,t))$(not IFSUB))
$macro PDM_SUB(r,i,rp,t)      (((1 + mtax(r,i,rp,t) + ntmAVE(r,i,rp,t))*PWM_SUB(r,i,rp,t)*(pwm0(r,i,rp)/pdm0(r,i,rp)))$IFSUB + (pdm(r,i,rp,t))$(not IFSUB))

$macro PDMA_SUB(s,i,r,aa,t)   (((1 + mtaxa(s,i,r,aa,t))*PWM_SUB(s,i,r,t)*(pwm0(s,i,r)/pdma0(s,i,r,aa)))$IFSUB + (pdma(s,i,r,aa,t))$(not IFSUB))

$macro XWMG_SUB(r,i,rp,t)     ((tmarg(r,i,rp,t)*xw(r,i,rp,t)*(xw0(r,i,rp)/xwmg0(r,i,rp)))$IFSUB + (xwmg(r,i,rp,t))$(not IFSUB))
$macro XMGM_SUB(img,r,i,rp,t) ((amgm(img,r,i,rp)*XWMG_SUB(r,i,rp,t) * (xwmg0(r,i,rp)/(lambdamg(img,r,i,rp,t)*xmgm0(img,r,i,rp))))$IFSUB + (xmgm(img,r,i,rp,t))$(not IFSUB))
$macro PWMG_SUB(r,i,rp,t)     ((sum(img, amgm(img,r,i,rp)*ptmg(img,t) * (ptmg0(img)/(lambdamg(img,r,i,rp,t)*pwmg0(r,i,rp)))))$IFSUB + (pwmg(r,i,rp,t))$(not IFSUB))

$macro PFP_SUB(r,f,a,t)       (((1 + pfTax(r,f,a,t))*pf(r,f,a,t)*(pf0(r,f,a)/pfp0(r,f,a)))$IFSUB + (pfp(r,f,a,t))$(not IFSUB))

*  Macros to fix variable lags (used in iterloop.gms)

$macro mlag0(var)             var.fx(r,tsim-1) = var.l(r,tsim-1) ;
$macro mlag1(var,i__1)        var.fx(r,i__1,tsim-1) = var.l(r,i__1,tsim-1) ;
$macro mlag2(var,i__1, i__2)  var.fx(r,i__1,i__2,tsim-1) = var.l(r,i__1,i__2,tsim-1) ;

$ontext

*  DEFINE POSSIBLE FUNCTIONAL FORMS FOR LAND AND WATER MARKETS

   KELAS    "Constant elasticity supply function"
   LOGIST   "Logistic supply function"
   HYPERB   "Generalized hyperbola supply function"
   INFTY    "Infinitely elastic supply function"

*  DEFINE POSSIBLE FUNCTIONAL FORMS FOR HOUSEHOLD UTILITY

   CD       "Cobb-Douglas"
   LES      "Linear expenditure system"
   ELES     "Extended linear expenditure system"
   AIDADS   "An Implicitly Direct Additive Demand System"
   CDE      "Constant differences in elasticity"

$offtext

acronyms KELAS, LOGIST, HYPERB, INFTY, CD, LES, ELES, AIDADS, CDE, capFlexGTAP, capFlexUSAGE, capFix, capRFix, capFlexINF ;

set rs(r)         "Region(s) to be included in simulation" ;
rs(r) = yes ;
set fixER(r)      "Regions with a fixed ER" ;
fixER(r) = no ;
alias(r,rr) ;
alias(k, kp) ; alias(k, k1) ; alias(v,vp) ;
set ixn(i)        "All non-energy commodities" ; ixn(i)$(not e(i)) = yes ;
scalar ifGbl      "Flag to determine if model is run in global mode" / 1 / ;
scalar ifNCO2     "Flag to determine if we have non-CO2 gases" ;
scalar savfFlag   "Flag determining capital account closure" ;
scalar NTMFlag    "Flag determining presence of NTMs"                / 0 / ;
scalar ifInitFlag "Flag determining whether a baseline was read in"  / 0 / ;
scalar startYear  "Year to which the sim should be initialized" ;
startYear = firstYear ;
alias(f,fp) ;

Parameters

*  Production parameters

   sigmaxp(r,a,v)       "Substitution elasticity between production and non-CO2 GHG bundle"
   aghg(r,a,v,t)        "Share parameter for non-CO2 GHG bundle"
   axp(r,a,v,t)         "Share parameter for output in production"

   sigmap(r,a,v)        "Substitution elasticity between ND1 and VA"
   and1(r,a,v,t)        "Share parameter for ND1 bundle"
   ava(r,a,v,t)         "Share parameter for VA bundle"

   sigmav(r,a,v)        "Substitution elasticity for VA bundle"
   sigmav1(r,a,v)       "Substitution elasticity for VA1 bundle"
   sigmav2(r,a,v)       "Substitution elasticity for VA2 bundle"

   alab1(r,a,v,t)       "Share parameter for LAB1 bundle"
   alab2(r,a,v,t)       "Share parameter for LAB2 bundle"
   aland(r,a,v,t)       "Share parameter for land"
   akef(r,a,v,t)        "Share parameter for KEF bundle"
   and2(r,a,v,t)        "Share parameter for ND2 bundle"
   ava1(r,a,v,t)        "Share parameter for VA1 bundle"
   ava2(r,a,v,t)        "Share parameter for VA2 bundle"

   sigmakef(r,a,v)      "Substitution elasticity between KF and XNRG"
   akf(r,a,v,t)         "Share parameter for KF bundle"
   ae(r,a,v,t)          "Share parameter for NRG bundle"

   sigmakf(r,a,v)       "Substitution elasticity between KS and NRS"
   aksw(r,a,v,t)        "Share parameter for KSW bundle"
   anrs(r,a,v,t)        "Share parameter for NRS bundle"

   sigmakw(r,a,v)       "Substitution elasticity between KS and WAT"
   aks(r,a,v,t)         "Share parameter for KS bundle"
   awat(r,a,v,t)        "Share parameter for WAT bundle"

   sigmak(r,a,v)        "Substitution elasticity between K and LAB2"
   ak(r,a,v,t)          "Share parameter for capital"
   alab2(r,a,v,t)       "Share parameter for LAB2 bundle"

   sigmaul(r,a)         "Labor substitution across unskilled types"
   sigmasl(r,a)         "Labor substitution across skilled types"

   af(r,f,a,t)          "Share parameter for primary factors"

   sigman1(r,a)         "Substitution elasticity across goods in ND1 bundle"
   sigman2(r,a)         "Substitution elasticity across goods in ND2 bundle"
   sigmawat(r,a)        "Substitution elasticity across water in XWAT bubdle"
   aio(r,i,a,t)         "Share parameter for intermediate demand"

   sigmae(r,a,v)        "Substitution elasticity between ELY and NELY bundles"
   anely(r,a,v,t)       "Share parameter for NELY bundle"
   aeio(r,e,a,v,t)      "Share parameter for energy demand"
   aNRG(r,a,NRG,v,t)    "Share parameter for NRG bundles"
   sigmanely(r,a,v)     "Substitution elasticity between COA and OLG bundles"
   aolg(r,a,v,t)        "Share parameter for OLG bundle"
   sigmaNRG(r,a,NRG,v)  "Inter-fuel substitution elasticity within bottom-level nests"

   omegas(r,a)          "Output transformation elasticity in make/use module"
   gp(r,a,i)            "CET share parameters in make/use module"
   lambdas(r,a,i,t)     "CET productivity parameter"

   sigmas(r,i)          "Output substitution elasticity in make/use module"
   as(r,a,i)            "CES share parameters in make/use module"

   apow(r,elyc)            "CES share parameter for aggregate power"
   sigmael(r,elyc)         "Substitution between power and ETD"
   apb(r,pb,elyc)          "Share parameter for power bundles"
   sigmapow(r,elyc)        "Substitution across power bundles"
   sigmapb(r,pb,elyc)      "Substitution across power activities within power bundles"
   lambdapow(r,pb,elyc,t)  "Power efficiency parameters"
   lambdapb(r,elya,elyc,t) "Sub-power efficiency parameters"

*  Income parameters

   fdepr(r,t)              "Fiscal rate of depreciation"
   ydistf(r,t)             "Share of capital income flowing to global trust"
   chiTrust(r,t)           "Share of region r in global trust"
   chiRemit(rp,l,r,t)      "Share of labor income in region r remitted to region rp"
   chiODAOut(r,t)          "GDP Share of ODA outflow"
   chiODAIn(r,t)           "Country r's share of total ODA flows"
   etaODA(r,t)             "Elasticity of ODA wrt to per capita income"
   chihNTM(s,d,t)          "Share of NTM revenue in s going to households in d"
   chigNTM(s,d,t)          "Share of NTM revenue in s going to households in d"

*  Demand parameters

   u0(r,h)                 "Scaling parameter for utility"
   Frisch(r,h,t)           "Frisch parameter"
   kron(k,kp)              "Kronecker's delta"
   acxnnrg(r,k,h)          "Non-energy bundle share parameter in consumption"
   acxnrg(r,k,h)           "Energy bundle share parameter in consumption"
   nu(r,k,h)               "Energy/non-energy substitution elasticity in consumption"

   ac(r,i,k,h)             "Share parameters in decomposition of non-energy and energy bundles"
   nunnrg(r,k,h)           "Substitution across goods in non-energy bundle"

   acnely(r,k,h,t)         "Non-electric bundle share parameter in consumption"
   acolg(r,k,h,t)          "OLG bundle share parameter in consumption"
   acNRG(r,k,h,NRG,t)      "Share parameters for NRG bundles"

   nue(r,k,h)              "Electric/non-electric substitution in consumption"
   nunely(r,k,h)           "Coal/OLG substitution in consumption"
   nuolg(r,k,h)            "Substituion between oil & gas in consumption"
   nuNRG(r,k,h,NRG)        "Substitution within NRG bundles"

   alphaac(r,i,h)          "Actual consumption share in ACES waste function"
   alphawc(r,i,h)          "Waste consumption share in ACES waste function"
   lambdaac(r,i,h,t)       "Actual consumption preference shifter in ACES waste function"
   lambdawc(r,i,h,t)       "Waste consumption preference shifter in ACES waste function"
   sigmaac(r,i,h)          "ACES substitution elasticity in waste function"

   sigmafd(r,fd)           "Other final demand substitution elasticity"
   alphafd(r,i,fd,t)       "Final demand share parameter"

*  Trade parameters

   sigmamt(r,i)            "Top level Armington CES elasticity"
   alphadt(r,i,t)          "Domestic share parameter"
   alphamt(r,i,t)          "Import share parameter"

   sigmam(r,i,aa)          "Top level Armington elasticity with agent sourcing"
   alphad(r,i,aa,t)        "Domestic share parameter with agent sourcing"
   alpham(r,i,aa,t)        "Import share parametter with agent sourcing"

   sigmaw(r,i)             "Second level Armington CES elasticity"
   alphaw(r,i,rp,t)        "Import by source share parameter"
   lambdaw(r,i,rp,t)       "Iceberg parameter"

*  !!!! MRIO
   sigmawa(r,i,aa)         "Agent-specific second level Armington CES elasticity"
   alphawa(r,i,rp,aa,t)    "Agent-specific source share parameter by agent"

   omegax(r,i)             "Top level CET transformation elasticity"
   gammad(r,i,t)           "CET domestic share parameter"
   gammae(r,i,t)           "CET export share parameter"

   omegaw(r,i)             "Second level CET transformation elasticity"
   gammaw(r,i,rp,t)        "Second level share parameters"

*  Twist parameters

   ArmMShrt1(r,i)          "Lagged import share for top level national sourcing"
   ArmMShr1(r,i,aa)        "Lagged import share for top level agent sourcing"
   ArmMShr2(i,r)           "Import share from r's targetted countries"

*  Margin parameters

   amgm(img,r,i,rp)        "Share of m in transporting from r to rp"
   sigmamg(img)            "CES substitution elasticity for sourcing tt services"
   alphatt(r,img,t)        "CES share parameters for sourcing tt services"
   lambdamg(img,r,i,rp,t)  "Efficiency factor for tt services"

*  Factor supply parameters

   uez0(r,l,z)             "Initial level of unemployment by zone"
   resWage0(r,l,z)         "Initial level of reservation wage"
   ueMinz0(r,l,z)          "Initial level of minimum unemployment by zone"
   ueMinz(r,l,z,t)         "Minimum level of UE by zone"
   omegarwg(r,l,z)         "Elasticity of reservation wage wrt to growth"
   omegarwue(r,l,z)        "Elasticity of reservation wage wrt to UE"
   omegarwp(r,l,z)         "Elasticity of reservation wage wrt to CPI"
   migr0(r,l)              "Ratio of rural migration as a share of base year rural labor supply"
   chim(r,l,t)             "Migration function shifter"
   omegam(r,l)             "Migration elasticity"
   kronm(z)                "Set to -1 for rural and to +1 for urban"

   omegak(r)               "Capital CET elasticity in CS mode"
   gammak(r,a,v,t)         "Capital CET share parameters in CS mode"
   invElas(r,a)            "Supply elasticity of Old capital in declining sectors"

   chiLand(r,t)            "Total land supply shifter"
   etat(r)                 "Total land supply elasticity"
   gammatl(r,t)            "Total land supply parameter"
   gamlb(r,lb,t)           "Share parameter for land bundles"
   gamnlb(r,t)             "Share parameter for intermediate land bundle"
   omegat(r)               "Top level land transformation elasticity"
   omeganlb(r)             "CET across land bundles (except lb1)"
   gammat(r,a,t)           "Land CET share parameters"
   omegalb(r,lb)           "CET across land within land bundles"

   etanrsx(r,a,lh)         "Kinked supply elasticities"
   chinrsp(r,a)            "Natural resource price adjustment factor"
   pwtrend(a,tt)           "Baseline price trends"
   pwshock(a,tt)           "Shock price trends"

   chih2o(r,t)             "Aggregate water supply shifter"
   etaw(r)                 "Aggregate water supply elasticity"
   gammatw(r,t)            "Aggregate water supply curvature parameter"
   gam1h2o(r,wbnd,t)       "Water allocation share parameter"
   omegaw1(r)              "Top level water allocation transformation elasticity"
   gam2h2o(r,wbnd,t)       "Water allocation share parameter"
   omegaw2(r,wbnd)         "Second level water allocation transformation elasticity"
   gam3h2o(r,a,t)          "Water allocation share parameter"
   ah2obnd(r,wbnd,t)       "Water allocation shift parameter"
   epsh2obnd(r,wbnd)       "Water bundle demand price elasticity"
   etah2obnd(r,wbnd)       "Water bundle demand scale elasticity"

*  Capital account closure parameters

   riskPrem(r,t)           "Regional risk premium"
   epsRoR(r,t)             "Sensitivity of rate-of-return expectation"
   savfBar(r,t)            "Exogenous foreign savings"

*  Parameters for emissions module

   emir(r,em,is,aa)        "Emissions per unit of consumption/output"
   emird(r,em,i,aa)        "Emissions per unit of domestic consumption"
   emirm(r,em,i,aa)        "Emissions per unit of imported consumption"
   part(r,em,i,aa)         "Level of participation: 0=none 1=full"
   gwp(em)                 "Global warming potential"

*  Parameters for energy module

   phiNRG(r,fuel,aa)       "Combustion ratio for fuel demand"

*  Parameters for price indices

   phiw(r,i,rp,t)
   chimuv
   phia(r,i,fd,t)
   chi(r,fd)
   phipw(r,a,t)

*  Miscellaneous parameters

   work                    "Working scalar"
   tvol                    "Total volume working scalar"
   tprice                  "Total price working scalar"
   vol                     "Volume working scalar"
   price                   "Price working scalar"
   rwork(r)                "Regional working vector"
   swork(r,i)              "Regional and sectoral working matrix"
   chi(r,fd)               "Shift variable for PFD"
   chimuv                  "Shift variable for MUV"
   depr(r,t)               "Physical depreciation rate"
   chiKaps0(r)             "Base year ratio of normalized capital to capital stock"
   glAddShft(r,l,a,t)      "Additive shifter in labor productivity factor"
   glMltShft(r,l,a,t)      "Multiplicative shifter in labor productivity factor"
   popT(r,tranche,t)       "Population scenario"
   educ(r,l,t)             "Size of labor by education from SSP database"
   glabT(r,l,t)            "Targeted growth rates for labor by skill"
   rgdppcT(r,t)            "Real GDP per capita scenario"
   lfpr(r,l,tranche,t)     "Labor force participation rate by skill and age cohort"
   aeei(r,e,a,v,t)         "Energy efficiency improvement in production"
   aeeic(r,e,k,h,t)        "Energy efficiency improvement in household demand"
   yexo(r,a,t)             "Exogenous improvement in yields"
   tteff(r,i,rp,t)         "Exogenous improvement in intl. trade & transport margins"
   xatNRG(r,e,t)           "Energy absorption in MTOE"
   gammaeda(r,i,aa)        "Energy price equalizer in domestic absorption"
   gammaedd(r,i,aa)        "Energy price equalizer for domestic goods with agent sourcing"
   gammaedm(r,i,aa)        "Energy price equalizer for import goods with agent sourcing"
   gammaew(r,i,rp)         "Energy price equalizer in exports"
   gammaesd(r,i)           "Energy price equalizer in domestic supply"
   gammaese(r,i)           "Energy price equalizer in export supply"
   aggLabShr(r,t)          "Aggregate share of labor in value added"
   glBaU(r,t)              "Reference labor productivity"
   xfdBaU(r,fd,t)          "Reference absorption"
   ehBaU(r,k,h,t)          "Reference eh parameter"
   bhBaU(r,k,h,t)          "Reference bh parameter"

*  Activity flags

   xpFlag(r,a)             "Flag for output of activity 'a'"
   ghgFlag(r,a)            "Flag for non-CO2 GHG bundle"

   nd1Flag(r,a)            "Flag for ND1 bundle"
   nd2Flag(r,a)            "Flag for ND2 bundle"
   lab1Flag(r,a)           "Flag for lab1 bundle"
   lab2Flag(r,a)           "Flag for lab2 bundle"
   va1Flag(r,a)            "Flag for VA1 bundle"
   va2Flag(r,a)            "Flag for VA2 bundle"
   kefFlag(r,a)            "Flag for KEF bundle"
   kfFlag(r,a)             "Flag for KF bundle"
   watFlag(r,a)            "Flag for water bundle"
   kFlag(r,a)              "Flag for capital"
   xnrgFlag(r,a)           "Flag for NRG bundle"
   xaNRGFlag(r,a,NRG)      "Flag for energy bundle bundle"
   xnelyFlag(r,a)          "Flag for NELY bundle"
   xolgFlag(r,a)           "Flag for OLG bundle"
   th2oFlag(r)             "Flag for aggregate water market"

   xfFlag(r,f,a)           "Flag for factors of production"
   xaFlag(r,i,aa)          "Flag for Armington demand by agent"
   xdFlag(r,i,aa)          "Flag for domestic demand by agent"
   xmFlag(r,i,aa)          "Flag for import demand by agent"
   xsFlag(r,i)             "Flag for domestically produced goods"

   xcFlag(r,k,h)           "Flag for household consumption"
   uFlag(r,h)              "Flag for household utility"
   xcnnrgFlag(r,k,h)       "Flag for non-energy bundle in consumption"
   xcnrgFlag(r,k,h)        "Flag for energy bundle in consumption"
   xcnelyFlag(r,k,h)       "Flag for non-electriciy bundle in consumption"
   xcolgFlag(r,k,h)        "Flag for OLG bundle in consumption"
   xacNRGFlag(r,k,h,NRG)   "Flag for NRG bundles in consumption"

   hWasteFlag(r,i,h)       "Flag for waste function in household consumption"

   xatFlag(r,i)            "Flag for aggregate Armington demand"
   xddFlag(r,i)            "Flag for XDD bundle"
   xmtFlag(r,i)            "Flag for XMT bundle"

   xwFlag(r,i,rp)          "Flag for XW"
   xwaFlag(r,i,rp,aa)      "Agent specific flag for XWA"
   xdtFlag(r,i)            "Flag for XDT bundle"
   xetFlag(r,i)            "Flag for XET bundle"
   tmgFlag(r,i,rp)         "Flag for tt services"
   xttFlag(r,i)            "Flag for domestic tt supply"

   th2oFlag(r)             "Flag for aggregate water market"
   h2obndFlag(r,wbnd)      "Flag for water bundles"

   tlabFlag(r,l)           "Flag for aggregate labor"
   tlandFlag(r)            "Flag for aggregate land"

   xnrsFlag(r,a)           "Kinked supply is active"

   ifEmiCap                "Any emissions cap regimes"
   emFlag(em)              "Emission subject to regime"
   ifEmiQuota(r)           "Regions subject to emissions quota regime"

*  Post-simulation parameters

   sam(r,is,js,t)          "Social accounting matrix"
;

scalar kink / 30 / ;

sets
   lsFlag(r,l,z)        "Flag for labor by zone"
   ueFlag(r,l,z)        "Employment regime"
   migrFlag(r,l)        "Migration flag"
;

*  Initial levels

Parameters
   px0(r,a)             "Producer price before tax"
   uc0(r,a)             "Unit cost of production by vintage pre-tax"
   pxv0(r,a)            "Unit cost of production by vintage tax/subsidy inclusive"

   xpx0(r,a)            "Production level exclusive of non-CO2 GHG bundle"
   xghg0(r,a)           "Non-CO2 GHG bundle associated with output"

   nd10(r,a)            "Demand for intermediate goods in ND1 bundle"
   va0(r,a)             "Demand for top level VA bundle"
   pxp0(r,a)            "Cost of production excl non-CO2 GHG bundle"

   pfp0(r,f,a)          "Price of factors tax inclusive"
   pf0(r,f,a)           "Market price of factors"
   xf0(r,f,a)           "Factor demand"

   lab10(r,a)           "Demand for 'unskilled' labor bundle"
   kef0(r,a)            "Demand for KEF bundle (capital+skill+energy+nrs)"
   nd20(r,a)            "Demand for intermediate goods in ND2 bundle"
   va10(r,a)            "Demand for VA1 bundle"
   va20(r,a)            "Demand for VA2 bundle"
   pva0(r,a)            "Price of VA bundle"
   pva10(r,a)           "Price of VA1 bundle"
   pva20(r,a)           "Price of VA2 bundle"

   kf0(r,a)             "Demand for KF bundle (capital+skill+nrs+water)"
   xnrg0(r,a)           "Demand for NRG bundle in production"
   pkef0(r,a)           "Price of KEF bundle"

   ksw0(r,a)            "Demand for KSW bundle (capital+skill+water)"
   pkf0(r,a)            "Price of KF bundle"

   ks0(r,a)             "Demand for KS bundle (capital+skill)"
   xwat0(r,a)           "Demand for WAT bundle"
   pksw0(r,a)           "Price of KSW bundle"

   kv0(r,a)             "Demand for K by vintage"
   lab20(r,a)           "Demand for 'skilled' labor bundle"
   pks0(r,a)            "Price of KS bundle"

   plab10(r,a)          "Price of 'unskilled' labor bundle"
   plab20(r,a)          "Price of 'skilled' labor bundle"

   pnd10(r,a)           "Price of ND1 bundle"
   pnd20(r,a)           "Price of ND2 bundle"
   pwat0(r,a)           "Price of water bundle"

   xaNRG0(r,a,NRG)      "Demand for bottome level energy bundles"
   xnely0(r,a)          "Demand for non-electric bundle"
   pnrg0(r,a)           "Price of energy bundle"

   paNRG0(r,a,NRG)      "Price of energy bundles"
   pnely0(r,a)          "Price of NELY bundle"

   xolg0(r,a)           "Demand for oil and gas bundle"
   polg0(r,a)           "Price of oil and gas bundle"

   xa0(r,i,aa)          "Armington demand for goods"

   x0(r,a,i)            "Output of good 'i' produced by activity 'a'"
   p0(r,a,i)            "Price of good 'i' produced by activity 'a'--pre-tax"
   pp0(r,a,i)           "Price of good 'i' produced by activity 'a'--post-tax"
   xp0(r,a)             "Gross sectoral output of activity 'i'"
   ps0(r,i)             "Market price of domestically produced good 'i'"

   xpow0(r,elyc)        "Aggregate power"
   ppow0(r,elyc)        "Average price of aggregate power"
   ppowndx0(r,elyc)     "Price index of aggregate power"
   xpb0(r,pb,elyc)      "Power bundles"
   ppb0(r,pb,elyc)      "Average price of power bundles"
   ppbndx0(r,pb,elyc)   "Price index of power bundles"

   deprY0(r)            "Depreciation income"
   yqtf0(r)             "Outflow of capital income"
   trustY0              "Aggregate foreign capital outflow"
   yqht0(r)             "Foreign capital income inflow"
   remit0(r,l,rp)       "Labor remittances"
   odaOut0(r)           "Outward ODA"
   odaIn0(r)            "Inward ODA"
   odaGbl0              "Global ODA"
   yh0(r)               "Household income net of depreciation"
   yd0(r)               "Disposable household income"

   supy0(r,h)           "Per capita supernumerary income"
   muc0(r,k,h)          "Marginal budget shares"
   theta0(r,k,h)        "Consumption auxiliary variable"
   xc0(r,k,h)           "Household consumption of consumer good k"
   hshr0(r,k,h)         "Household budget shares"
   u0(r,h)              "Utility level"

   xcnnrg0(r,k,h)       "Demand for non-energy bundle of consumer good k"
   xcnrg0(r,k,h)        "Demand for energy bundle of consumer good k"
   pc0(r,k,h)           "Price of consumer good k"
   pcnnrg0(r,k,h)       "Price of non-energy bundle of consumer good k"
   xcnely0(r,k,h)       "Demand for non-electric bundle of consumer good k"
   xcolg0(r,k,h)        "Demand for OLG bundle of consumer good k"
   xacNRG0(r,k,h,NRG)   "Demand for NRG bundle of consumer good k"
   pacNRG0(r,k,h,NRG)   "Price of NRG bundle of consumer good k"
   pcolg0(r,k,h)        "Price of OLG bundle of consumer good k"
   pcnely0(r,k,h)       "Price of non-electric bundle of consumer good k"
   pcnrg0(r,k,h)        "Price of energy of consumer good k"

   xaac0(r,i,h)         "Initial actual consumption"
   xawc0(r,i,h)         "Initial household waste"
   paacc0(r,i,h)        "Initial composite price of consumption"
   paac0(r,i,h)         "Initial price of actual consumption"
   pawc0(r,i,h)         "Initial price of waste"

   savh0(r,h)           "Private savings"
   aps0(r,h)            "Private savings rate out of total household income"
*  chiaps0(r)           "Economy-wide shifter for household saving"

   ygov0(r,gy)          "Government revenues"
   ntmY0(r)             "NTM revenues"

   pfd0(r,fd)           "Final demand expenditure price index"
   yfd0(r,fd)           "Value of aggregate final demand expenditures"

   xat0(r,i)            "Aggregate Armington demand"
   xdt0(r,i)            "Domestic demand for domestic production /x xtt"
   xmt0(r,i)            "Aggregate import demand"
   pat0(r,i)            "Price of aggregate Armington good"
   xd0(r,i,aa)          "Domestic sales of domestic goods with agent sourcing"
   xm0(r,i,aa)          "Domestic sales of import goods with agent sourcing"
   pd0(r,i,aa)          "End user price of domestic goods with agent sourcing"
   pm0(r,i,aa)          "End user price of import goods with agent sourcing"
   pa0(r,i,aa)          "Price of Armington good at agents' price"

   xw0(r,i,rp)          "Volume of bilateral trade"
   pmt0(r,i)            "Price of aggregate imports"

*  !!!! NEW FOR MRIO

   xwa0(r,i,rp,aa)      "Bilateral imports by agent"
   pdma0(r,i,rp,aa)     "Domestic price of bilateral imports by agent"
   pma0(r,i,aa)         "Aggregate price of imports by agent"

   pdt0(r,i)            "Producer price of goods sold on domestic markets"
   xet0(r,i)            "Aggregate exports"
   xs0(r,i)             "Domestic production of good 'i'"
   pe0(r,i,rp)          "Producer price of exports"
   pet0(r,i)            "Producer price of aggregate exports"
   pwe0(r,i,rp)         "FOB price of exports"
   pwm0(r,i,rp)         "CIF price of imports"
   pdm0(r,i,rp)         "Tariff inclusive price of imports"

   xwmg0(r,i,rp)        "Demand for tt services from r to rp"
   xmgm0(img,r,i,rp)    "Demand for tt services from r to rp for service type m"
   pwmg0(r,i,rp)        "Average price to transport good from r to rp"
   xtmg0(img)           "Total global demand for tt services m"
   xtt0(r,i)            "Supply of m by region r"
   ptmg0(img)           "The average global price of service m"

   ldz0(r,l,z)          "Labor demand by zone"
   awagez0(r,l,z)       "Average wage by zone"
   urbPrem0(r,l)        "Urban wage premium"
   resWage0(r,l,z)      "Reservation wage"
*  chirw0(r,l,z)        "Reservation wage shifter"
   ewagez0(r,l,z)       "Equilibrium wage by zone"
   twage0(r,l)          "Equilibrium wage by skill"
*  skillprem0(r,l)      "Skill premium relative to a reference wage"
   tls0(r)              "Total labor supply"
*
*  migr0(r,l)           "Level of rural to urban migration"
*  migrMult0(r,l,z)     "Migration multiplier for multi-year time steps"
   lsz0(r,l,z)          "Labor supply by zone"
   ls0(r,l)             "Aggregate labor supply by skill"
*  gtlab0(r)            "Growth rate of total labor supply"
*  glab0(r,l)           "Growth of labor supply by skill"
*  glabz0(r,l,z)        "Growth of labor supply by skill and zone"
*  wPrem0(r,l,a)        "Wage premium relative to equilibrium wage"

   pk0(r,a)             "Market price of capital by vintage and activity"
   trent0(r)            "Aggregate return to capital"

   kxRat0(r,a)          "Capital output ratio by sector"
*  rrat0(r,a)           "Ratio of return to Old wrt to New capital"
*
   k00(r,a)             "Beginning of period installed capital"
   xpv0(r,a)            "Gross sectoral output by vintage"
*
*  arent0(r)            "Average return to capital"
*
   tland0(r)            "Aggregate land supply"
   ptland0(r)           "Aggregate price index of land"
   ptlandndx0(r)        "Price index of aggregate land"
*  landMax0(r)          "Maximum available land"
   xlb0(r,lb)           "Land bundles"
   plb0(r,lb)           "Average price of land bundles"
   plbndx0(r,lb)        "Price index of land bundles"
   xnlb0(r)             "Intermediate land bundle"
   pnlb0(r)             "Price of intermediate land bundle"
   pnlbndx0(r)          "Price index of intermediate land bundle"

   th2o0(r)             "Aggregate water supply"
*  h2oMax0(r)           "Maximum available water supply"
   th2om0(r)            "Marketed water supply"
   h2obnd0(r,wbnd)      "Aggregate water bundles"
   pth2ondx0(r)         "Aggregate water price index"
   pth2o0(r)            "Aggregate market price of water"
   ph2obnd0(r,wbnd)     "Price of aggregate water bundles"
   ph2obndndx0(r,wbnd)  "Price index of aggregate water bundles"

   pkp0(r,a)            "Price of capital by vintage and activity tax inclusive"
*
*  savg0(r)             "Public savings"
*
*  Closure variables
*
*  rsg0(r)             "Real government savings"
*
*  rgovshr0(r)         "Volume share of gov. expenditure in real GDP"
*  govshr0(r)          "Value share of gov. expenditure in nominal GDP"
*  rinvshr0(r)         "Volume share of inv. expenditure in real GDP"
*  invshr0(r)          "Value share of inv. expenditure in nominal GDP"
*
   xfd0(r,fd)          "Volume of aggregate final demand expenditures"

   kstocke0(r)         "Anticipated capital stock"
   ror0(r)             "Net aggregate rate of return to capital"
   rorc0(r)            "Cost adjusted rate of return to capital"
   rore0(r)            "Expected rate of return to capital"
   rorg0               "Average expected global rate of return to capital"

   pfact0(r)            "Factor price index"
   pwfact0              "World factor price index"
*  savf0(r)            "Foreign savings"
*  pmuv0(t)            "Export price index of manufactured goods from high-income countries"
*  pwsav0(t)           "Global price of investment good"
*  pwgdp0(t)           "Global gdp deflator"
*  pnum0(t)            "Model numéraire"
*  pw0(a)              "World price of activity a"
*  walras0             "Value of Walras"
*
*  Macro variables
*
   gdpmp0(r)           "Nominal GDP at market price"
   rgdpmp0(r)          "Real GDP at market price"
   pgdpmp0(r)          "GDP at market price expenditure deflator"
   rgdppc0(r)          "Real GDP at market price per capita"
*  grrgdppc0(r)        "Growth rate of real GDP per capita"
*  gl0(r)              "Economy-wide labor productivity growth"
   klrat0(r)           "Capital labor ratio in efficiency units"
*
*  Emission variables
*
   emi0(r,em,is,aa)    "Emissions by region and driver"
   emiTot0(r,em)       "Total country emissions"
   emiGBL0(em)         "Global emissions"
*
*  Normally exogenous emission variables
*
*  emiOth0(r,em)       "Emissions from other sources"
*  emiOthGbl0(em)      "Other global emissions"
*  chiemi0(em)         "Global shifter in emissions"
*
*  Carbon tax policy variables
*
*  emiTax0(r,em)       "Emissions tax"
*  emiCap0(ra,em)      "Emissions cap by aggregate region"
*  emiRegTax0(ra,em)   "Regionwide emissions tax"
*  emiQuota0(r,em)     "Quota allocation"
*  emiQuotaY0(r,em)    "Income from quota rights"
*  chiCap0(em)         "Emissions cap shifter"
*
*  Normally exogenous variables
*
   kstock0(r)          "Non-normalized capital stock"
   tkaps0(r)           "Total normalized stock of capital"
   pop0(r)             "Population"

   ev0(r,h)             "Initial EV"
*
*  Currently non explained variables
*
   pxghg0(r,a)          "Price of non-CO2 GHG gas bundle"
*  pim0(r,a)            "Markup over marginal cost of production"
*
*  Dynamic variables
*
*  axghg0(r,a,v)       "Uniform shifter in production bundle"
*  lambdaxp0(r,a,v)    "Output shifter in production bundle"
*  lambdaghg0(r,a,v)   "GHG shifter in production bundle"
*
*  lambdak0(r,a,v)         "Capital efficiency shifter"
*  chiglab0(r,l)           "Skill bias productivity shifter"
*  lambdah2obnd0(r,wbnd)   "Water efficiency shifter in water bundle use"
*  lambdaio0(r,i,a)        "Efficiency shifter in intermediate demand"
*  lambdae0(r,e,a,v)       "Energy efficiency shifter in production"
*  lambdace0(r,e,k,h)      "Energy efficiency shifter in consumption"
*
*
*  invGFact0(r)        "Capital accumulation auxiliary variable"
*
*  Policy variables
*
*  ptax0(r,a)          "Output tax/subsidy"
*  landtax0(r,a)       "Land tax"
*  uctax0(r,a,v)       "Tax/subsidy on unit cost of production"
*  paTax0(r,i,aa)      "Sales tax on Armington consumption"
*
*  etax0(r,i,rp)       "Export tax/subsidies"
*  tmarg0(r,i,rp)      "FOB/CIF price wedge"
*  mtax0(r,i,rp)       "Import tax/subsidies"
;

variables
   px(r,a,t)               "Producer price before tax"
   uc(r,a,v,t)             "Unit cost of production by vintage pre-tax"
   pxv(r,a,v,t)            "Unit cost of production by vintage tax/subsidy inclusive"

   xpx(r,a,v,t)            "Production level exclusive of non-CO2 GHG bundle"
   xghg(r,a,v,t)           "Non-CO2 GHG bundle associated with output"

   nd1(r,a,t)              "Demand for intermediate goods in ND1 bundle"
   va(r,a,v,t)             "Demand for top level VA bundle"
   pxp(r,a,v,t)            "Cost of production excl non-CO2 GHG bundle"

   lab1(r,a,t)             "Demand for 'unskilled' labor bundle"
   kef(r,a,v,t)            "Demand for KEF bundle (capital+skill+energy+nrs)"
   nd2(r,a,t)              "Demand for intermediate goods in ND2 bundle"
   va1(r,a,v,t)            "Demand for VA1 bundle"
   va2(r,a,v,t)            "Demand for VA2 bundle"
   pva(r,a,v,t)            "Price of VA bundle"
   pva1(r,a,v,t)           "Price of VA1 bundle"
   pva2(r,a,v,t)           "Price of VA2 bundle"

   kf(r,a,v,t)             "Demand for KF bundle (capital+skill+nrs+water)"
   xnrg(r,a,v,t)           "Demand for NRG bundle in production"
   pkef(r,a,v,t)           "Price of KEF bundle"

   ksw(r,a,v,t)            "Demand for KSW bundle (capital+skill+water)"
   pkf(r,a,v,t)            "Price of KF bundle"

   ks(r,a,v,t)             "Demand for KS bundle (capital+skill)"
   xwat(r,a,t)             "Demand for WAT bundle"
   pksw(r,a,v,t)           "Price of KSW bundle"

   kv(r,a,v,t)             "Demand for K by vintage"
   lab2(r,a,t)             "Demand for 'skilled' labor bundle"
   pks(r,a,v,t)            "Price of KS bundle"

   xf(r,f,a,t)             "Demand for primary factors"

   plab1(r,a,t)            "Price of 'unskilled' labor bundle"
   plab2(r,a,t)            "Price of 'skilled' labor bundle"

   pnd1(r,a,t)             "Price of ND1 bundle"
   pnd2(r,a,t)             "Price of ND2 bundle"
   pwat(r,a,t)             "Price of water bundle"

   xaNRG(r,a,NRG,v,t)      "Demand for bottome level energy bundles"
   xnely(r,a,v,t)          "Demand for non-electric bundle"
   pnrg(r,a,v,t)           "Price of energy bundle"

   paNRG(r,a,NRG,v,t)      "Price of energy bundles"
   pnely(r,a,v,t)          "Price of NELY bundle"

   xolg(r,a,v,t)           "Demand for oil and gas bundle"
   polg(r,a,v,t)           "Price of oil and gas bundle"

   xa(r,i,aa,t)            "Armington demand for goods"
   xd(r,i,aa,t)            "Domestic demand for domestic goods"
   xm(r,i,aa,t)            "Domestic demand for import goods"

   pd(r,i,aa,t)            "User price of domestically produced goods"
   pm(r,i,aa,t)            "User price of imported goods"

   x(r,a,i,t)              "Output of good 'i' produced by activity 'a'"
   p(r,a,i,t)              "Price of good 'i' produced by activity 'a'--pre-tax"
   pp(r,a,i,t)             "Price of good 'i' produced by activity 'a'--post-tax"
   xp(r,a,t)               "Gross sectoral output of activity 'i'"
   ps(r,i,t)               "Market price of domestically produced good 'i'"

   xpow(r,elyc,t)          "Aggregate power"
   ppow(r,elyc,t)          "Average price of aggregate power"
   ppowndx(r,elyc,t)       "Price index of aggregate power"
   xpb(r,pb,elyc,t)        "Power bundles"
   ppb(r,pb,elyc,t)        "Average price of power bundles"
   ppbndx(r,pb,elyc,t)     "Price index of power bundles"

   deprY(r,t)              "Depreciation income"
   yqtf(r,t)               "Outflow of capital income"
   trustY(t)               "Aggregate foreign capital outflow"
   yqht(r,t)               "Foreign capital income inflow"
   remit(rp,l,r,t)         "Remittances to region rp from region r for skill type l"
   odaOut(r,t)             "Outward ODA"
   odaIn(r,t)              "Inward ODA"
   odaGbl(t)               "Global ODA"
   yh(r,t)                 "Household income net of depreciation"
   yd(r,t)                 "Disposable household income"

   supy(r,h,t)             "Per capita supernumerary income"
   xc(r,k,h,t)             "Household consumption of consumer good k"
   hshr(r,k,h,t)           "Household budget shares"
   u(r,h,t)                "Utility level"

   xcnnrg(r,k,h,t)         "Demand for non-energy bundle of consumer good k"
   xcnrg(r,k,h,t)          "Demand for energy bundle of consumer good k"
   pc(r,k,h,t)             "Price of consumer good k"
   pcnnrg(r,k,h,t)         "Price of non-energy bundle of consumer good k"
   xcnely(r,k,h,t)         "Demand for non-electric bundle of consumer good k"
   xcolg(r,k,h,t)          "Demand for OLG bundle of consumer good k"
   xacNRG(r,k,h,NRG,t)     "Demand for NRG bundle of consumer good k"
   pacNRG(r,k,h,NRG,t)     "Price of NRG bundle of consumer good k"
   pcolg(r,k,h,t)          "Price of OLG bundle of consumer good k"
   pcnely(r,k,h,t)         "Price of non-electric bundle of consumer good k"
   pcnrg(r,k,h,t)          "Price of energy of consumer good k"

   xaac(r,i,h,t)           "Actual consumption"
   xawc(r,i,h,t)           "Household waste"
   paacc(r,i,h,t)          "Composite price of household consumption"
   paac(r,i,h,t)           "Price of actual consumption"
   pawc(r,i,h,t)           "Price of household waste"
   pah(r,i,h,t)            "Household demand prices incl. of waste taxes"

   savh(r,h,t)             "Private savings"
   aps(r,h,t)              "Private savings rate out of total household income"
   chiaps(r,t)             "Economy-wide shifter for household saving"

   ygov(r,gy,t)            "Government revenues"
   ntmY(r,t)               "NTM revenues"

   pfd(r,fd,t)             "Final demand expenditure price index"
   yfd(r,fd,t)             "Value of aggregate final demand expenditures"

   xat(r,i,t)              "Aggregate Armington demand"
   xdt(r,i,t)              "Domestic demand for domestic production /x xtt"
   xmt(r,i,t)              "Aggregate import demand"
   pat(r,i,t)              "Price of aggregate Armington good"
   pa(r,i,aa,t)            "Price of Armington good at agents' price"

   xw(r,i,rp,t)            "Volume of bilateral trade"
   pmt(r,i,t)              "Price of aggregate imports"

*  !!!! New for MRIO

   xwa(r,i,rp,aa,t)        "Agent-specific bilateral trade"
   pdma(r,i,rp,aa,t)       "Agent-specific price of bilateral imports, tariff-inclusive"
   pma(r,i,aa,t)           "Agent-specific price of aggregate imports"

   pdt(r,i,t)              "Producer price of goods sold on domestic markets"
   xet(r,i,t)              "Aggregate exports"
   xs(r,i,t)               "Domestic production of good 'i'"
   pe(r,i,rp,t)            "Producer price of exports"
   pet(r,i,t)              "Producer price of aggregate exports"
   pwe(r,i,rp,t)           "FOB price of exports"
   pwm(r,i,rp,t)           "CIF price of imports"
   pdm(r,i,rp,t)           "End-user price of imports"

   xwmg(r,i,rp,t)          "Demand for tt services from r to rp"
   xmgm(img,r,i,rp,t)      "Demand for tt services from r to rp for service type m"
   pwmg(r,i,rp,t)          "Average price to transport good from r to rp"
   xtmg(img,t)             "Total global demand for tt services m"
   xtt(r,i,t)              "Supply of m by region r"
   ptmg(img,t)             "The average global price of service m"

   pf(r,f,a,t)             "Price of primary factors"
   pfp(r,f,a,t)            "Price of primary factors tax inclusive"

   ldz(r,l,z,t)            "Labor demand by zone"
   awagez(r,l,z,t)         "Average wage by zone"
   urbPrem(r,l,t)          "Urban wage premium"
   resWage(r,l,z,t)        "Reservation wage"
   chirw(r,l,z,t)          "Reservation wage shifter"
   ewagez(r,l,z,t)         "Equilibrium wage by zone"
   twage(r,l,t)            "Equilibrium wage by skill"
   skillprem(r,l,t)        "Skill premium relative to a reference wage"
   tls(r,t)                "Total labor supply"

   migr(r,l,t)             "Level of rural to urban migration"
   migrMult(r,l,z,t)       "Migration multiplier for multi-year time steps"
   lsz(r,l,z,t)            "Labor supply by zone"
   ls(r,l,t)               "Aggregate labor supply by skill"
   gtlab(r,t)              "Growth rate of total labor supply"
   glab(r,l,t)             "Growth of labor supply by skill"
   glabz(r,l,z,t)          "Growth of labor supply by skill and zone"
   wPrem(r,l,a,t)          "Wage premium relative to equilibrium wage"

   pk(r,a,v,t)             "Market price of capital by vintage and activity"
   trent(r,t)              "Aggregate return to capital"

   k0(r,a,t)               "Installed capital at beginning of period"
   kxRat(r,a,v,t)          "Capital output ratio by sector"
   rrat(r,a,t)             "Ratio of return to Old wrt to New capital"

   xpv(r,a,v,t)            "Gross sectoral output by vintage"

   arent(r,t)              "Average return to capital"

   tland(r,t)              "Aggregate land supply"
   ptland(r,t)             "Aggregate price index of land"
   ptlandndx(r,t)          "Price index of aggregate land"
   landMax(r,t)            "Maximum available land"
   xlb(r,lb,t)             "Land bundles"
   plb(r,lb,t)             "Average price of land bundles"
   plbndx(r,lb,t)          "Price index of land bundles"
   xnlb(r,t)               "Intermediate land bundle"
   pnlb(r,t)               "Price of intermediate land bundle"
   pnlbndx(r,t)            "Price index of intermediate land bundle"

   etanrs(r,a,t)           "Supply elasticity of natural resource"
   chinrs(r,a,t)           "Natural resource supply shifter"
   wchinrs(a,t)            "Global natural resource supply shifter"

   th2o(r,t)               "Aggregate water supply"
   h2oMax(r,t)             "Maximum available water supply"
   th2om(r,t)              "Marketed water supply"
   h2obnd(r,wbnd,t)        "Aggregate water bundles"
   pth2ondx(r,t)           "Aggregate water price index"
   pth2o(r,t)              "Aggregate market price of water"
   ph2obnd(r,wbnd,t)       "Price of aggregate water bundles"
   ph2obndndx(r,wbnd,t)    "Price index of aggregate water bundles"

   pkp(r,a,v,t)            "Price of capital by vintage and activity tax inclusive"

   pfact(r,t)              "Average price of factors, i.e. real exchange rate"
   pwfact(t)               "Global factor price index"

   savg(r,t)               "Public savings"

*  Closure variables

   rsg(r,t)                "Real government savings"

   rgovshr(r,t)            "Volume share of gov. expenditure in real GDP"
   govshr(r,t)             "Value share of gov. expenditure in nominal GDP"
   rinvshr(r,t)            "Volume share of inv. expenditure in real GDP"
   invshr(r,t)             "Value share of inv. expenditure in nominal GDP"

   kappaf(r,f,a,t)         "Income tax on factor income"
   kappah(r,t)             "Direct tax rate"
   xfd(r,fd,t)             "Volume of aggregate final demand expenditures"

   kstocke(r,t)            "Anticipated capital stock"
   ror(r,t)                "Net aggregate rate of return to capital"
   rorc(r,t)               "Cost adjusted rate of return to capital"
   rore(r,t)               "Expected rate of return to capital"
   devRoR(r,t)             "Change in rate of return"
   grK(r,t)                "Anticipated growth of the capital stock"
   rord(r,t)               "Deviations from the normal rate of return"
   savf(r,t)               "Foreign savings"
   savfRat(r,t)            "Foreign savings as a share of GDP"
   rorg(t)                 "Average expected global rate of return to capital"

   pmuv(t)                 "Export price index of manufactured goods from high-income countries"
   pwsav(t)                "Global price of investment good"
   pwgdp(t)                "Global gdp deflator"
   pnum(t)                 "Model numéraire"
   pw(a,t)                 "World price of activity a"
   walras                  "Value of Walras"

*  Macro variables

   gdpmp(r,t)              "Nominal GDP at market price"
   rgdpmp(r,t)             "Real GDP at market price"
   pgdpmp(r,t)             "GDP at market price expenditure deflator"
   rgdppc(r,t)             "Real GDP at market price per capita"
   grrgdppc(r,t)           "Growth rate of real GDP per capita"
   gl(r,t)                 "Economy-wide labor productivity growth"
   klrat(r,t)              "Capital labor ratio in efficiency units"

*  Emission variables

   emi(r,em,is,aa,t)       "Emissions by region and driver"
   emiTot(r,em,t)          "Total country emissions"
   emiGBL(em,t)            "Global emissions"

*  Normally exogenous emission variables

   emiOth(r,em,t)          "Emissions from other sources"
   emiOthGbl(em,t)         "Other global emissions"
   chiemi(em,t)            "Global shifter in emissions"

*  Carbon tax policy variables

   emiTax(r,em,t)          "Emissions tax"
   emiCap(ra,em,t)         "Emissions cap by aggregate region"
   emiRegTax(ra,em,t)      "Regionwide emissions tax"
   emiQuota(r,em,t)        "Quota allocation"
   emiQuotaY(r,em,t)       "Income from quota rights"
   chiCap(em,t)            "Emissions cap shifter"

*  Normally exogenous variables

   kstock(r,t)             "Non-normalized capital stock"
   tkaps(r,t)              "Total normalized stock of capital"
   pop(r,t)                "Population"

*  Calibrated parameters

   theta(r,k,h,t)          "Subsistence minima"
   muc(r,k,h,t)            "Marginal propensity to consume"
   mus(r,h,t)              "Marginal propensity to save"
   betac(r,h,t)            "Consumption shifter"
   aad(r,h,t)              "AIDADS utility shifter"
   alphaad(r,k,h,t)        "AIDADS MBS linear shifter"
   betaad(r,k,h,t)         "AIDADS MBS slope term"
   omegaad(r,h)            "Auxiliary AIDADS parameter for elasticities"
   etah(r,k,h,t)           "Income elasticities"
   epsh(r,k,kp,h,t)        "Own- and cross-price elasticities"
   alphah(r,k,h,t)         "CDE share parameter"
   eh(r,k,h,t)             "CDE expansion parameter"
   bh(r,k,h,t)             "CDE substitution parameter"

*  Currently non explained variables

   pxghg(r,a,v,t)          "Price of non-CO2 GHG gas bundle"
   uez(r,l,z,t)            "Unemployment rate by zone"

*  Dynamic variables

   axghg(r,a,v,t)          "Uniform shifter in production bundle"
   lambdaxp(r,a,v,t)       "Output shifter in production bundle"
   lambdaghg(r,a,v,t)      "GHG shifter in production bundle"

   lambdaf(r,f,a,t)        "Productivity parameter for primary factors"

   lambdak(r,a,v,t)        "Capital efficiency shifter"
   chiglab(r,l,t)          "Skill bias productivity shifter"
   lambdah2obnd(r,wbnd,t)  "Water efficiency shifter in water bundle use"
   lambdaio(r,i,a,t)       "Efficiency shifter in intermediate demand"
   lambdae(r,e,a,v,t)      "Energy efficiency shifter in production"
   lambdace(r,e,k,h,t)     "Energy efficiency shifter in consumption"

   invGFact(r,t)           "Capital accumulation auxiliary variable"

*  Policy variables

   ptax(r,a,i,t)           "Output tax/subsidy"
   pftax(r,f,a,t)          "Tax on primary factors"
   uctax(r,a,v,t)          "Tax/subsidy on unit cost of production"
   paTax(r,i,aa,t)         "Sales tax on Armington consumption"
   pdtax(r,i,aa,t)         "Sales tax on domestically produced goods"
   pmtax(r,i,aa,t)         "Sales tax on imported goods"

   etax(r,i,rp,t)          "Export tax/subsidies"
   etaxi(r,i,t)            "Export commodity tax uniform across destinations"
   tmarg(r,i,rp,t)         "FOB/CIF price wedge"
   mtax(r,i,rp,t)          "Import tax/subsidies"
   ntmAVE(r,i,rp,t)        "Non-tariff measure tariff equivalent"
   mtaxa(r,i,rp,aa,t)      "Agent-specific import tax rate"

   wtaxh(r,i,h,t)          "Ad valorem tax on waste"
   wtaxhx(r,i,h,t)         "Excise tax on waste"

*  Post-simulation variables
   ev(r,h,t)               "Equivalent income at base year prices"
;

equations
   pxeq(r,a,t)             "Producer price before tax"
   uceq(r,a,v,t)           "Unit cost of production by vintage pre-tax"
   pxveq(r,a,v,t)          "Unit cost of production by vintage tax/subsidy inclusive"

   xpxeq(r,a,v,t)          "Production level exclusive of non-CO2 GHG bundle"
   xghgeq(r,a,v,t)         "Non-CO2 GHG bundle associated with output"

   nd1eq(r,a,t)            "Demand for intermediate goods in ND1 bundle"
   vaeq(r,a,v,t)           "Demand for top level VA bundle"
   pxpeq(r,a,v,t)          "Cost of production excl non-CO2 GHG bundle"

   lab1eq(r,a,t)           "Demand for 'unskilled' labor bundle"
   kefeq(r,a,v,t)          "Demand for KEF bundle (capital+skill+energy+nrs)"
   nd2eq(r,a,t)            "Demand for intermediate goods in ND2 bundle"
   va1eq(r,a,v,t)          "Demand for VA1 bundle"
   va2eq(r,a,v,t)          "Demand for VA2 bundle"
   landeq(r,lnd,a,t)       "Demand for land bundle"
   pvaeq(r,a,v,t)          "Price of VA bundle"
   pva1eq(r,a,v,t)         "Price of VA1 bundle"
   pva2eq(r,a,v,t)         "Price of VA2 bundle"

   kfeq(r,a,v,t)           "Demand for KF bundle (capital+skill+nrs)"
   xnrgeq(r,a,v,t)         "Demand for NRG bundle in production"
   pkefeq(r,a,v,t)         "Price of KEF bundle"

   ksweq(r,a,v,t)          "Demand for KSW bundle (capital+skill+water)"
   xnrseq(r,nrs,a,t)       "Demand for NRS factor"
   pkfeq(r,a,v,t)          "Price of KF bundle"

   kseq(r,a,v,t)           "Demand for KS bundle (capital+skill)"
   xwateq(r,a,t)           "Demand for water bundle"
   pksweq(r,a,v,t)         "Price of KSW bundle"
   h2oeq(r,wat,a,t)        "Demand for water factor"

   kveq(r,a,v,t)           "Demand for K by vintage"
   lab2eq(r,a,t)           "Demand for 'skilled' labor bundle"
   pkseq(r,a,v,t)          "Price of KS bundle"

   ldeq(r,l,a,t)           "Demand for labor by skill and activity"
   plab1eq(r,a,t)          "Price of 'unskilled' labor bundle"
   plab2eq(r,a,t)          "Price of 'skilled' labor bundle"

   xapeq(r,i,a,t)          "Armington demand for intermediate goods"
   pnd1eq(r,a,t)           "Price of ND1 bundle"
   pnd2eq(r,a,t)           "Price of ND2 bundle"
   pwateq(r,a,t)           "Price of water bundle"

   xnelyeq(r,a,v,t)        "Demand for non-electric bundle"
   xolgeq(r,a,v,t)         "Demand for OLG bundle"
   xaNRGeq(r,a,NRG,v,t)    "Demand for bottom-level energy bundle"
   xaeeq(r,e,a,t)          "Decomposition of energy bundle with single nest"

   paNRGeq(r,a,NRG,v,t)    "Price of NRG bundles"
   polgeq(r,a,v,t)         "Price of OLG bundle"
   pnelyeq(r,a,v,t)        "Price of ELY bundle"
   pnrgeq(r,a,v,t)         "Price of energy bundle"

   peq(r,a,i,t)            "Production of good 'i' by activity 'a'"
   xpeq(r,a,t)             "Gross production of activity 'a'"
   ppeq(r,a,i,t)           "Price of good 'i' supplied by activity 'a'--post tax"
   xeq(r,a,i,t)            "Demand of good 'i' supplied by activity 'a'"
   pseq(r,i,t)             "Market price of domestically produced good 'i'"

   xetdeq(r,etd,elyc,t)    "Demand for electricity transmission and distribution services"
   xpoweq(r,elyc,t)        "Demand for aggregate power"
   pselyeq(r,elyc,t)       "Market price of electricity, incl. of ETD"
   xpbeq(r,pb,elyc,t)      "Demand for power bundles"
   ppowndxeq(r,elyc,t)     "Price index for aggregate power"
   ppoweq(r,elyc,t)        "Average price of aggregate power"
   xbndeq(r,elya,elyc,t)   "Demand for power activity elya"
   ppbndxeq(r,pb,elyc,t)   "Price index for power bundles"
   ppbeq(r,pb,elyc,t)      "Average price of power bundles"

   deprYeq(r,t)            "Depreciation income"
   ntmYeq(r,t)             "NTM revenues"
   yqtfeq(r,t)             "Outflow of capital income"
   trustYeq(t)             "Total capital income outflows"
   yqhteq(r,t)             "Foreign capital income inflows"
   odaouteq(r,t)           "Outward ODA"
   odaineq(r,t)            "Inward ODA"
   odagbleq(t)             "Global ODA"
   remiteq(rp,l,r,t)       "Remittance outflow to region rp from region r for labor skill l"
   yheq(r,t)               "Household income net of depreciation"
   ydeq(r,t)               "Household disposable income"

   ygoveq(r,gy,t)          "Government revenues"
   yfdInveq(r,inv,t)       "Investment balance"

   supyeq(r,h,t)           "Per capita supernumerary income for ELES"
   thetaeq(r,k,h,t)        "Auxiliary consumption variable for CDE"
   muceq(r,k,h,t)          "Marginal budger shares for AIDADS"
   xceq(r,k,h,t)           "Aggregate private consumption by sector in k commodity space"
   hshreq(r,k,h,t)         "Household budget shares"
   ueq(r,h,t)              "Household utility"

   xcnnrgeq(r,k,h,t)       "Consumer demand for non-energy bundle"
   xcnrgeq(r,k,h,t)        "Consumer demand for energy bundle"
   pceq(r,k,h,t)           "Consumer price for good k"
   xacnnrgeq(r,i,h,t)      "Demand for non-energy commodities in consumption"
   pcnnrgeq(r,k,h,t)       "Price of non-energy bundle in consumption"
   xcnelyeq(r,k,h,t)       "Demand for non-electric bundle in consumption"
   xcolgeq(r,k,h,t)        "Demand for OLG bundle in consumption"
   xacNRGeq(r,k,h,NRG,t)   "Demand for NRG bundles in consumption"
   xaceeq(r,e,h,t)         "Demand for energy commodities in consumption"
   pacNRGeq(r,k,h,NRG,t)   "Price of NRG bundles in consumption"
   pcolgeq(r,k,h,t)        "Price of OLG bundle in consumption"
   pcnelyeq(r,k,h,t)       "Price of non-electric bundle in consumption"
   pcnrgeq(r,k,h,t)        "Price of energy bundle in consumption"

   xaaceq(r,i,h,t)         "Actual consumption"
   xawceq(r,i,h,t)         "Household waste"
   paacceq(r,i,h,t)        "Composite price of household consumption"
   paaceq(r,i,h,t)         "Price of actual consumption"
   pawceq(r,i,h,t)         "Price of waste"
   paheq(r,i,h,t)          "Household demand prices incl. of waste taxes"

   savhELESeq(r,h,t)       "Private savings equation for ELES"
   savheq(r,h,t)           "Aggregate household saving for non-ELES or aps for ELES"

   xafeq(r,i,fdc,t)        "Other final demand for Armington good"
   pfdfeq(r,fdc,t)         "Other final demand expenditure price index"
   yfdeq(r,fd,t)           "Aggregate value of final demand expenditure"

   xateq(r,i,t)            "Total Armington demand by commodity"
   xdteq(r,i,t)            "Domestic demand for domestic production /x xtt"
   xmteq(r,i,t)            "Aggregate import demand"
   pateq(r,i,t)            "Price of aggregate Armington good"
   paeq(r,i,aa,t)          "Agent price of Armington good"

   xdeq(r,i,aa,t)          "Demand for domestic goods"
   xmeq(r,i,aa,t)          "Demand for imported goods"
   pdeq(r,i,aa,t)          "End user price of domestic goods"
   pmeq(r,i,aa,t)          "End user price of imported goods"

   xwdeq(rp,i,r,t)         "Demand for imports by region rp sourced in region r"
   pmteq(r,i,t)            "Price of aggregate imports"

*  NEW FOR MRIO

   xwaeq(rp,i,r,aa,t)      "Agent-specific demand for bilateral exports"
   pdmaeq(rp,i,r,aa,t)     "Agent-specific price of bilateral exports"
   pmaeq(r,i,aa,t)         "Agent-specific price of aggregate imports"

   pdteq(r,i,t)            "Supply of domestic goods"
   xeteq(r,i,t)            "Aggregate export supply"
   xseq(r,i,t)             "Total domestic supply"
   xwseq(r,i,rp,t)         "Supply of exports from r to rp"
   peteq(r,i,t)            "Aggregate price of exports"
   pweeq(r,i,rp,t)         "FOB price of exports"
   pwmeq(r,i,rp,t)         "CIF price of imports"
   pdmeq(r,i,rp,t)         "Tariff inclusive price of imports"

   xwmgeq(r,i,rp,t)        "Demand for tt services from r to rp"
   xmgmeq(img,r,i,rp,t)    "Demand for tt services from r to rp for service type m"
   pwmgeq(r,i,rp,t)        "Average price to transport good from r to rp"
   xtmgeq(img,t)           "Total global demand for tt services m"
   xtteq(r,img,t)          "Supply of m by region r"
   ptmgeq(img,t)           "The average global price of service m"

   ldzeq(r,l,z,t)          "Labor demand by zone equation"
   awagezeq(r,l,z,t)       "Average wage by zone"
   urbPremeq(r,l,t)        "Urban wage premium"
   resWageeq(r,l,z,t)      "Reservation wage equation"
   uezeq(r,l,z,t)          "Definition of unemployment"
   ewagezeq(r,l,z,t)       "Market clearing wage by zone"
   twageeq(r,l,t)          "Average market clearing wage"
   skillpremeq(r,l,t)      "Skill premium relative to the reference wage"
   wageeq(r,l,a,t)         "Sectoral wage level"
   lseq(r,l,t)             "Aggregate labor supply by skill"
   tlseq(r,t)              "Total labor supply"

   pkeq(r,a,v,t)           "Sectoral return to capital"
   trenteq(r,t)            "Aggregate return to capital"

   kxRateq(r,a,v,t)        "Capital output ratio"
   rrateq(r,a,t)           "Relative rate of return between Old and New capital"

   k0eq(r,a,t)             "Beginning of period installed capital"
   xpveq(r,a,v,t)          "Allocation between old and new capital"

   capeq(r,cap,a,t)        "Total capital demand by activity"
   pcapeq(r,cap,a,t)       "Average capital remuneration by activity"

   arenteq(r,t)            "Average return to capital"

   tlandeq(r,t)            "Total land supply equation"
   xlb1eq(r,lb,t)          "Supply of first land bundle"
   xnlbeq(r,t)             "Supply of intermediate land bundle"
   ptlandndxeq(r,t)        "Price index of aggregate land"
   ptlandeq(r,t)           "Aggregate price index of land"
   xlbneq(r,lb,t)          "Supply of other land bundles"
   pnlbndxeq(r,t)          "Price index of intermediate land bundle"
   pnlbeq(r,t)             "Average price of intermediate land bundle"
   plandeq(r,lnd,a,t)      "Price of land by sector"
   plbndxeq(r,lb,t)        "Price index of land bundles"
   plbeq(r,lb,t)           "Average price of land bundles"

   etanrseq(r,a,t)         "Natural resource supply elasticity"
   xnrsseq(r,nrs,a,t)      "Supply of natural resource"

   th2oeq(r,t)             "Aggregate water supply"
   h2obndeq(r,wbnd,t)      "Supply of water bundles"
   pth2ondxeq(r,t)         "Aggregate water price index"
   pth2oeq(r,t)            "Aggregate price of water"
   th2omeq(r,t)            "Market water supply"
   ph2obndndxeq(r,wbnd,t)  "Price index of water bundles"
   ph2obndeq(r,wbnd,t)     "Price of water bundles"
   ph2oeq(r,wat,a,t)       "Supply of water to activities--determines market price"

   pfpeq(r,f,a,t)          "Producer cost of factors"
   pkpeq(r,a,v,t)          "Producer cost of capital"

   savgeq(r,t)             "Nominal government savings"
   rsgeq(r,t)              "Real government savings"

   rgovshreq(r,t)          "Volume share of gov. expenditure in real GDP"
   govshreq(r,t)           "Value share of gov. expenditure in nominal GDP"
   rinvshreq(r,t)          "Volume share of inv. expenditure in real GDP"
   invshreq(r,t)           "Value share of inv. expenditure in nominal GDP"

   kstockeeq(r,t)          "Anticipated end-of-period capital stock"
   roreq(r,t)              "Net aggregate rate of return to capital"
   devRoReq(r,t)           "Change in rate of return"
   grKeq(r,t)              "Anticipated growth of the capital stock"
   rorceq(r,t)             "Cost adjusted rate of return to capital"
   roreeq(r,t)             "Expected rate of return to capital"
   savfeq(r,t)             "Capital account closure"
   savfRateq(r,t)          "Foreign saving as a share of GDP"
   rorgeq(t)               "Average global rate of return"

   pfdheq(r,h,t)           "Price consumption expenditure deflator"
   xfdheq(r,h,t)           "Nominal household expenditure"
   gdpmpeq(r,t)            "Nominal GDP at market prices"
   rgdpmpeq(r,t)           "Real GDP at market prices"
   pgdpmpeq(r,t)           "GDP at market price deflator"
   rgdppceq(r,t)           "Real GDP per capita"
   grrgdppceq(r,t)         "Growth of real GDP per capita"
   klrateq(r,t)            "Capital labor ratio in efficiency units"

   pmuveq(t)               "Export price index of manufactured goods from high-income countries"
   pfacteq(r,t)            "Factor price index"
   pwfacteq(t)             "Global factor price index"
   pwgdpeq(t)              "World GDP deflator"
   pwsaveq(t)              "Global price of investment good"
   pnumeq(t)               "Model numéraire"
   pweq(a,t)               "World price of activity a"

   walraseq                "Walras' Law"

   emiieq(r,em,i,aa,t)     "Consumption based emissions"
   emifeq(r,em,fp,a,t)     "Factor-use based emissions"
   emixeq(r,em,tot,a,t)    "Output based emissions"
   emiToteq(r,em,t)        "Total regional emissions"
   emiGbleq(em,t)          "Total global emissions"

   emiCapeq(ra,em,t)       "Emission constraint equation"
   emiTaxeq(r,em,t)        "Setting of emissions tax"
   emiQuotaYeq(r,em,t)     "Emissions quota income"

   migreq(r,l,t)           "Migration equation"
   migrmulteq(r,l,z,t)     "Migration multiplier equation"
   lszeq(r,l,z,t)          "Labor supply by zone"
   glabeq(r,l,t)           "Aggregate labor growth rate by skill"
   invGFacteq(r,t)         "Investment factor used for dynamic module"
   kstockeq(r,t)           "Capital accumulation equation"
   tkapseq(r,t)            "Capital normalization formula"
   lambdafeq(r,l,a,t)      "Labor productivity factor"

   eveq(r,h,t)             "Equivalent income at base year prices"
;

* --------------------------------------------------------------------------------------------------
*
*  PRODUCTION BLOCK
*
* --------------------------------------------------------------------------------------------------

*  Aggregate unit cost

pxeq(r,a,t)$(ts(t) and rs(r) and xpFlag(r,a))..
$ifthen %REDUX% == 1
   px(r,a,t)*xp(r,a,t) =e= (pxv0(r,a)/px0(r,a))*(xpv0(r,a)/xp0(r,a))
                        *  sum(v, pxv(r,a,v,t)*xpv(r,a,v,t)) ;
   display "redux" ;
$else
   px(r,a,t)*xp(r,a,t) =e= sum(v, (pxv0(r,a)/px0(r,a))*(xpv0(r,a)/xp0(r,a))
                        *     pxv(r,a,v,t)*xpv(r,a,v,t)) ;
$endif

px.lo(r,a,t) = 0.001 ;

*  Post-tax unit cost by vintage

pxveq(r,a,v,t)$(ts(t) and rs(r) and xpFlag(r,a))..
   pxv(r,a,v,t) =e= (uc0(r,a)/pxv0(r,a))*uc(r,a,v,t)*(1 + uctax(r,a,v,t)) ;

pxv.lo(r,a,v,t) = 0.001 ;

$ontext
   Top level nest -- CES of output (XPX) and non-CO2 GHG (XGHG)

   uc is the unit or marginal cost of production pre-tax
$offtext

*  Production by vintage excl. non-CO2 GHG

xpxeq(r,a,v,t)$(ts(t) and rs(r) and xpFlag(r,a))..
   xpx(r,a,v,t) =e= (axp(r,a,v,t)*(xpv0(r,a)/xpx0(r,a))
                 *  (uc0(r,a)/pxp0(r,a))**sigmaxp(r,a,v))
                 *  ((axghg(r,a,v,t)*lambdaxp(r,a,v,t))**(sigmaxp(r,a,v)-1))
                 *  xpv(r,a,v,t)*(uc(r,a,v,t)/pxp(r,a,v,t))**sigmaxp(r,a,v) ;

*  'Demand' for non-CO2 GHG

xghgeq(r,a,v,t)$(ts(t) and rs(r) and ghgFlag(r,a))..
   xghg(r,a,v,t) =e= (aghg(r,a,v,t)*(xpv0(r,a)/xghg0(r,a))
                  *  (uc0(r,a)/pxghg0(r,a))**sigmaxp(r,a,v))
                  *  ((axghg(r,a,v,t)*lambdaghg(r,a,v,t))**(sigmaxp(r,a,v)-1))
                  *  xpv(r,a,v,t)*(uc(r,a,v,t)/pxghg(r,a,v,t))**sigmaxp(r,a,v) ;

*  Pre-tax unit cost by vintage

uceq(r,a,v,t)$(ts(t) and rs(r) and xpFlag(r,a))..
   axghg(r,a,v,t)*uc(r,a,v,t)**(1-sigmaxp(r,a,v)) =e=
      (aghg(r,a,v,t)*(pxghg0(r,a)/uc0(r,a))**(1-sigmaxp(r,a,v)))
   *  (pxghg(r,a,v,t)/lambdaghg(r,a,v,t))**(1-sigmaxp(r,a,v))
   +  (axp(r,a,v,t)*(pxp0(r,a)/uc0(r,a))**(1-sigmaxp(r,a,v)))
   *  (pxp(r,a,v,t)/lambdaxp(r,a,v,t))**(1-sigmaxp(r,a,v)) ;

uc.lo(r,a,v,t) = 0.001 ;

$ontext
   Second level nest -- CES of non-specific inputs (ND1) and all other inputs (VA)

   In crops:             ND1 excludes energy and fertilizers (that are part of VA)
   In livestock:         ND1 excludes energy and feed (that are part of VA)
   In all other sectors: ND1 excludes energy (that is part of VA)
$offtext

nd1eq(r,a,t)$(ts(t) and rs(r) and nd1Flag(r,a))..
   nd1(r,a,t) =e= sum(v, (and1(r,a,v,t)*(xpx0(r,a)/nd10(r,a))
               *  (pxp0(r,a)/pnd10(r,a))**sigmap(r,a,v))
               *  xpx(r,a,v,t)*(pxp(r,a,v,t)/pnd1(r,a,t))**sigmap(r,a,v)) ;

vaeq(r,a,v,t)$(ts(t) and rs(r) and xpFlag(r,a))..
   va(r,a,v,t) =e= (ava(r,a,v,t)*(xpx0(r,a)/va0(r,a))*(pxp0(r,a)/pva0(r,a))**sigmap(r,a,v))
                *  xpx(r,a,v,t)*(pxp(r,a,v,t)/pva(r,a,v,t))**sigmap(r,a,v) ;

pxpeq(r,a,v,t)$(ts(t) and rs(r) and xpFlag(r,a))..
   pxp(r,a,v,t)**(1-sigmap(r,a,v))
      =e= (and1(r,a,v,t)*(pnd10(r,a)/pxp0(r,a))**(1-sigmap(r,a,v)))*pnd1(r,a,t)**(1-sigmap(r,a,v))
       +  (ava(r,a,v,t)*(pva0(r,a)/pxp0(r,a))**(1-sigmap(r,a,v)))*pva(r,a,v,t)**(1-sigmap(r,a,v)) ;

pxp.lo(r,a,v,t) = 0.001 ;

$ontext
   Middle nests -- VA
      In crops: VA is CES aggregation of LAB1 and VA1
      In livestock: VA is CES aggregation of VA1 and VA2
      In all other sectors: VA is CES aggregation of LAB1 and VA1

   VA1
      In crops: VA1 is CES aggregation of ND2 (fertilizers) and VA2
      In livestock: VA1 is aggregation of LAB1 and KEF
      In all other sectors: VA1 is aggregation of land and KEF

   VA2
      In crops: VA2 is CES aggregation of land and KEF
      In livestock: VA2 is CES aggregation of land and ND2 (feed)
      In all other sectors: There is no VA2
$offtext

*  Demand for unskilled labor bundle

lab1eq(r,a,t)$(ts(t) and rs(r) and lab1Flag(r,a))..
   lab1(r,a,t) =e= (sum(v,
                    (alab1(r,a,v,t)*(va0(r,a)/lab10(r,a))*(pva0(r,a)/plab10(r,a))**sigmav(r,a,v))
      *             va(r,a,v,t)*(pva(r,a,v,t)/plab1(r,a,t))**sigmav(r,a,v)))$acr(a)

      +            (sum(v,
                    (alab1(r,a,v,t)*(va10(r,a)/lab10(r,a))*(pva10(r,a)/plab10(r,a))**sigmav1(r,a,v))
      *              va1(r,a,v,t)*(pva1(r,a,v,t)/plab1(r,a,t))**sigmav1(r,a,v)))$alv(a)

      +            (sum(v,
                     (alab1(r,a,v,t)*(va0(r,a)/lab10(r,a))*(pva0(r,a)/plab10(r,a))**sigmav(r,a,v))
      *               va(r,a,v,t)*(pva(r,a,v,t)/plab1(r,a,t))**sigmav(r,a,v)))$ax(a)
      ;

*  Demand for KEF bundle

KEFeq(r,a,v,t)$(ts(t) and rs(r) and kefFlag(r,a))..
   kef(r,a,v,t) =e=
         ((akef(r,a,v,t)*(va20(r,a)/kef0(r,a))*((pva20(r,a)/pkef0(r,a))**sigmav2(r,a,v)))
      *   va2(r,a,v,t)*(pva2(r,a,v,t)/pkef(r,a,v,t))**sigmav2(r,a,v))$acr(a)

      +  ((akef(r,a,v,t)*(va10(r,a)/kef0(r,a))*((pva10(r,a)/pkef0(r,a))**sigmav1(r,a,v)))
      *   va1(r,a,v,t)*(pva1(r,a,v,t)/pkef(r,a,v,t))**sigmav1(r,a,v))$alv(a)

      +  ((akef(r,a,v,t)*(va10(r,a)/kef0(r,a))*((pva10(r,a)/pkef0(r,a))**sigmav1(r,a,v)))
      *   va1(r,a,v,t)*(pva1(r,a,v,t)/pkef(r,a,v,t))**sigmav1(r,a,v))$ax(a)
      ;

*  Demand for ND2 bundle (does not exist for other activities)

nd2eq(r,a,t)$(ts(t) and rs(r) and nd2Flag(r,a))..
   nd2(r,a,t) =e= (sum(v,
                    (and2(r,a,v,t)*(va10(r,a)/nd20(r,a))*(pva10(r,a)/pnd20(r,a))**sigmav1(r,a,v))
      *              va1(r,a,v,t)*(pva1(r,a,v,t)/pnd2(r,a,t))**sigmav1(r,a,v)))$acr(a)

      +           (sum(v,
                    (and2(r,a,v,t)*(va20(r,a)/nd20(r,a))*(pva20(r,a)/pnd20(r,a))**sigmav2(r,a,v))
      *              va2(r,a,v,t)*(pva2(r,a,v,t)/pnd2(r,a,t))**sigmav2(r,a,v)))$alv(a)
      ;

*  Demand for VA1 bundle

va1eq(r,a,v,t)$(ts(t) and rs(r) and va1Flag(r,a))..
   va1(r,a,v,t) =e=
            ((ava1(r,a,v,t)*(va0(r,a)/va10(r,a))*(pva0(r,a)/pva10(r,a))**sigmav(r,a,v))
      *      va(r,a,v,t)*(pva(r,a,v,t)/pva1(r,a,v,t))**sigmav(r,a,v))$acr(a)

      +     ((ava1(r,a,v,t)*(va0(r,a)/va10(r,a))*(pva0(r,a)/pva10(r,a))**sigmav(r,a,v))
      *      va(r,a,v,t)*(pva(r,a,v,t)/pva1(r,a,v,t))**sigmav(r,a,v))$alv(a)

      +     ((ava1(r,a,v,t)*(va0(r,a)/va10(r,a))*(pva0(r,a)/pva10(r,a))**sigmav(r,a,v))
      *      va(r,a,v,t)*(pva(r,a,v,t)/pva1(r,a,v,t))**sigmav(r,a,v))$ax(a)
      ;

*  Demand for VA2 bundle (does not exist for other activities)

va2eq(r,a,v,t)$(ts(t) and rs(r) and va2Flag(r,a))..
   va2(r,a,v,t) =e=
            ((ava2(r,a,v,t)*(va10(r,a)/va20(r,a))*(pva10(r,a)/pva20(r,a))**sigmav1(r,a,v))
      *      va1(r,a,v,t)*(pva1(r,a,v,t)/pva2(r,a,v,t))**sigmav1(r,a,v))$acr(a)

      +     ((ava2(r,a,v,t)*(va0(r,a)/va20(r,a))*(pva0(r,a)/pva20(r,a))**sigmav(r,a,v))
      *      va(r,a,v,t)*(pva(r,a,v,t)/pva2(r,a,v,t))**sigmav(r,a,v))$alv(a)
      ;

*  Demand for land

landeq(r,lnd,a,t)$(ts(t) and rs(r) and xfFlag(r,lnd,a))..
   xf(r,lnd,a,t) =e=
         (sum(v,(aland(r,a,v,t)*(va20(r,a)/xf0(r,lnd,a))*(pva20(r,a)/pfp0(r,lnd,a))**sigmav2(r,a,v))
      *     (lambdaf(r,lnd,a,t)**(sigmav2(r,a,v)-1))
      *      va2(r,a,v,t)*(pva2(r,a,v,t)/PFP_SUB(r,lnd,a,t))**sigmav2(r,a,v)))$(acr(a) or alv(a))

      +  (sum(v,(aland(r,a,v,t)*(va10(r,a)/xf0(r,lnd,a))*(pva10(r,a)/pfp0(r,lnd,a))**sigmav1(r,a,v))
      *     (lambdaf(r,lnd,a,t)**(sigmav1(r,a,v)-1))
      *     va1(r,a,v,t)*(pva1(r,a,v,t)/PFP_SUB(r,lnd,a,t))**sigmav1(r,a,v)))$ax(a)
      ;

*  BUNDLE PRICES

*  Price of top-level value added bundle (VA)

pvaeq(r,a,v,t)$(ts(t) and rs(r) and xpFlag(r,a))..
   pva(r,a,v,t)**(1-sigmav(r,a,v)) =e=
            ((alab1(r,a,v,t)*(plab10(r,a)/pva0(r,a))**(1-sigmav(r,a,v)))
      *       plab1(r,a,t)**(1-sigmav(r,a,v))
      +      (ava1(r,a,v,t)*(pva10(r,a)/pva0(r,a))**(1-sigmav(r,a,v)))
      *       pva1(r,a,v,t)**(1-sigmav(r,a,v)))$(acr(a) or ax(a))

      +     ((ava2(r,a,v,t)*(pva20(r,a)/pva0(r,a))**(1-sigmav(r,a,v)))
      *       pva2(r,a,v,t)**(1-sigmav(r,a,v))
      +      (ava1(r,a,v,t)*(pva10(r,a)/pva0(r,a))**(1-sigmav(r,a,v)))
      *       pva1(r,a,v,t)**(1-sigmav(r,a,v)))$alv(a)

      ;

pva.lo(r,a,v,t) = 0.001 ;

*  Price of mid-level value added bundle (VA1)

pva1eq(r,a,v,t)$(ts(t) and rs(r) and va1Flag(r,a))..
   pva1(r,a,v,t)**(1-sigmav1(r,a,v)) =e=
            ((and2(r,a,v,t)*(pnd20(r,a)/pva10(r,a))**(1-sigmav1(r,a,v)))
      *       pnd2(r,a,t)**(1-sigmav1(r,a,v))
      +      (ava2(r,a,v,t)*(pva20(r,a)/pva10(r,a))**(1-sigmav1(r,a,v)))
      *       pva2(r,a,v,t)**(1-sigmav1(r,a,v)))$acr(a)

      +     ((alab1(r,a,v,t)*(plab10(r,a)/pva10(r,a))**(1-sigmav1(r,a,v)))
      *       plab1(r,a,t)**(1-sigmav1(r,a,v))
      +      (akef(r,a,v,t)*(pkef0(r,a)/pva10(r,a))**(1-sigmav1(r,a,v)))
      *       pkef(r,a,v,t)**(1-sigmav1(r,a,v)))$alv(a)

      +     (sum(lnd,(aland(r,a,v,t)*(pfp0(r,lnd,a)/pva10(r,a))**(1-sigmav1(r,a,v)))
      *       (PFP_SUB(r,lnd,a,t)/lambdaf(r,lnd,a,t))**(1-sigmav1(r,a,v)))
      +      (akef(r,a,v,t)*(pkef0(r,a)/pva10(r,a))**(1-sigmav1(r,a,v)))
      *       pkef(r,a,v,t)**(1-sigmav1(r,a,v)))$ax(a)
      ;

pva1.lo(r,a,v,t) = 0.001 ;

*  Price of mid-level value added bundle (VA2)

pva2eq(r,a,v,t)$(ts(t) and rs(r) and va2Flag(r,a))..

   pva2(r,a,v,t)**(1-sigmav2(r,a,v)) =e=
            (sum(lnd,(aland(r,a,v,t)*(pfp0(r,lnd,a)/pva20(r,a))**(1-sigmav2(r,a,v)))
      *       (PFP_SUB(r,lnd,a,t)/lambdaf(r,lnd,a,t))**(1-sigmav2(r,a,v)))
      +      (akef(r,a,v,t)*(pkef0(r,a)/pva20(r,a))**(1-sigmav2(r,a,v)))
      *       pkef(r,a,v,t)**(1-sigmav2(r,a,v)))$acr(a)

      +     (sum(lnd,(aland(r,a,v,t)*(pfp0(r,lnd,a)/pva20(r,a))**(1-sigmav2(r,a,v)))
      *       (PFP_SUB(r,lnd,a,t)/lambdaf(r,lnd,a,t))**(1-sigmav2(r,a,v)))
      +      (and2(r,a,v,t)*(pnd20(r,a)/pva20(r,a))**(1-sigmav2(r,a,v)))
      *       pnd2(r,a,t)**(1-sigmav2(r,a,v)))$alv(a)
      ;

pva2.lo(r,a,v,t) = 0.001 ;

*  KEF disaggregation

kfeq(r,a,v,t)$(ts(t) and rs(r) and kfFlag(r,a))..
   kf(r,a,v,t) =e= akf(r,a,v,t)*(kef0(r,a)/kf0(r,a))*(pkef0(r,a)/pkf0(r,a)**sigmakef(r,a,v)
                *  kef(r,a,v,t))*(pkef(r,a,v,t)/pkf(r,a,v,t))**sigmakef(r,a,v) ;

xnrgeq(r,a,v,t)$(ts(t) and rs(r) and xnrgFlag(r,a))..
   xnrg(r,a,v,t) =e= ae(r,a,v,t)*(kef0(r,a)/xnrg0(r,a)*(pkef0(r,a)/pnrg0(r,a))**sigmakef(r,a,v)
                  *  kef(r,a,v,t))*(pkef(r,a,v,t)/pnrg(r,a,v,t))**sigmakef(r,a,v) ;

pkefeq(r,a,v,t)$(ts(t) and rs(r) and kefFlag(r,a))..
   pkef(r,a,v,t)**(1-sigmakef(r,a,v)) =e=
      (akf(r,a,v,t)*(pkf0(r,a)/pkef0(r,a))**(1-sigmakef(r,a,v)))*pkf(r,a,v,t)**(1-sigmakef(r,a,v))
   +  (ae(r,a,v,t)*(pnrg0(r,a)/pkef0(r,a))**(1-sigmakef(r,a,v)))*pnrg(r,a,v,t)**(1-sigmakef(r,a,v))
   ;

pkef.lo(r,a,v,t) = 0.001 ;

*  KF disaggregation

ksweq(r,a,v,t)$(ts(t) and rs(r) and kFlag(r,a))..
   ksw(r,a,v,t) =e= (aksw(r,a,v,t)*(kf0(r,a)/ksw0(r,a))*(pkf0(r,a)/pksw0(r,a))**sigmakf(r,a,v))
                 *  kf(r,a,v,t)*(pkf(r,a,v,t)/pksw(r,a,v,t))**sigmakf(r,a,v) ;

xnrseq(r,nrs,a,t)$(ts(t) and rs(r) and xfFlag(r,nrs,a))..
   xf(r,nrs,a,t) =e= sum(v, (anrs(r,a,v,t)*(kf0(r,a)/xf0(r,nrs,a))
                *    (pkf0(r,a)/pfp0(r,nrs,a))**sigmakf(r,a,v))
                *    (lambdaf(r,nrs,a,t)**(sigmakf(r,a,v)-1))
                *    kf(r,a,v,t)*(pkf(r,a,v,t)/PFP_SUB(r,nrs,a,t))**sigmakf(r,a,v)) ;

pkfeq(r,a,v,t)$(ts(t) and rs(r) and kfFlag(r,a))..
   pkf(r,a,v,t)**(1-sigmakf(r,a,v)) =e=
      (aksw(r,a,v,t)*(pksw0(r,a)/pkf0(r,a))**(1-sigmakf(r,a,v)))*pksw(r,a,v,t)**(1-sigmakf(r,a,v))
   +  sum(nrs, (anrs(r,a,v,t)*(pfp0(r,nrs,a)/pkf0(r,a))**(1-sigmakf(r,a,v)))
   *     (PFP_SUB(r,nrs,a,t)/lambdaf(r,nrs,a,t))**(1-sigmakf(r,a,v))) ;

pkf.lo(r,a,v,t) = 0.001 ;

*  KSW disaggregation

kseq(r,a,v,t)$(ts(t) and rs(r) and kFlag(r,a))..
   ks(r,a,v,t) =e= (aks(r,a,v,t)*(ksw0(r,a)/ks0(r,a))*(pksw0(r,a)/pks0(r,a))**sigmakw(r,a,v))
                *  ksw(r,a,v,t)*(pksw(r,a,v,t)/pks(r,a,v,t))**sigmakw(r,a,v) ;

xwateq(r,a,t)$(ts(t) and rs(r) and watFlag(r,a))..
   xwat(r,a,t) =e= sum(v, (awat(r,a,v,t)*(ksw0(r,a)/xwat0(r,a))
                *    (pksw0(r,a)/pwat0(r,a))**sigmakw(r,a,v))
                *  ksw(r,a,v,t)*(pksw(r,a,v,t)/pwat(r,a,t))**sigmakw(r,a,v)) ;

pksweq(r,a,v,t)$(ts(t) and rs(r) and kFlag(r,a))..
   pksw(r,a,v,t)**(1-sigmakw(r,a,v)) =e=
      (aks(r,a,v,t)*(pks0(r,a)/pksw0(r,a))**(1-sigmakw(r,a,v)))*pks(r,a,v,t)**(1-sigmakw(r,a,v))
   +  (awat(r,a,v,t)*(pwat0(r,a)/pksw0(r,a))**(1-sigmakw(r,a,v)))*pwat(r,a,t)**(1-sigmakw(r,a,v)) ;

pksw.lo(r,a,v,t) = 0.001 ;

*  Demand for the water factor

h2oeq(r,wat,a,t)$(ts(t) and rs(r) and xfFlag(r,wat,a))..
   xf(r,wat,a,t) =e= (af(r,wat,a,t)*(xwat0(r,a)/xf0(r,wat,a))
                  *   (pwat0(r,a)/pfp0(r,wat,a))**sigmawat(r,a)
                  *   (lambdaf(r,wat,a,t)**(sigmawat(r,a)-1)))
                  *  xwat(r,a,t)*(pwat(r,a,t)/PFP_SUB(r,wat,a,t))**sigmawat(r,a) ;

*  KS disaggregation

kveq(r,a,v,t)$(ts(t) and rs(r) and kFlag(r,a))..
   kv(r,a,v,t) =e= (ak(r,a,v,t)*(ks0(r,a)/kv0(r,a))*(pks0(r,a)/pkp0(r,a))**sigmak(r,a,v))
                *  (lambdak(r,a,v,t)**(sigmak(r,a,v)-1))
                *  ks(r,a,v,t)*(pks(r,a,v,t)/pkp(r,a,v,t))**sigmak(r,a,v) ;

lab2eq(r,a,t)$(ts(t) and rs(r) and lab2Flag(r,a))..
   lab2(r,a,t) =e= sum(v, (alab2(r,a,v,t)*(ks0(r,a)/lab20(r,a))
                *  (pks0(r,a)/plab20(r,a))**sigmak(r,a,v))
                *  ks(r,a,v,t)*(pks(r,a,v,t)/plab2(r,a,t))**sigmak(r,a,v)) ;

pkseq(r,a,v,t)$(ts(t) and rs(r) and kFlag(r,a))..
   pks(r,a,v,t)**(1-sigmak(r,a,v)) =e=
         (ak(r,a,v,t)*(pkp0(r,a)/pks0(r,a))**(1-sigmak(r,a,v)))
      *  (pkp(r,a,v,t)/lambdak(r,a,v,t))**(1-sigmak(r,a,v))
      +  (alab2(r,a,v,t)*(plab20(r,a)/pks0(r,a))**(1-sigmak(r,a,v)))
      *   plab2(r,a,t)**(1-sigmak(r,a,v)) ;

pks.lo(r,a,v,t) = 0.001 ;

*  LAB1 & LAB2 disaggregation

ldeq(r,l,a,t)$(ts(t) and rs(r) and xfFlag(r,l,a))..
   xf(r,l,a,t) =e= ((af(r,l,a,t)*(lab10(r,a)/xf0(r,l,a))
                *   (plab10(r,a)/pfp0(r,l,a))**sigmaul(r,a))
                *   (lambdaf(r,l,a,t)**(sigmaul(r,a)-1))
                *    lab1(r,a,t)*(plab1(r,a,t)/PFP_SUB(r,l,a,t))**sigmaul(r,a))$ul(l)

                +  ((af(r,l,a,t)*(lab20(r,a)/xf0(r,l,a))
                *   (plab20(r,a)/pfp0(r,l,a))**sigmasl(r,a))
                *   (lambdaf(r,l,a,t)**(sigmasl(r,a)-1))
                *    lab2(r,a,t)*(plab2(r,a,t)/PFP_SUB(r,l,a,t))**sigmasl(r,a))$sl(l)
                ;

plab1eq(r,a,t)$(ts(t) and rs(r) and lab1Flag(r,a))..
   plab1(r,a,t)**(1-sigmaul(r,a))
      =e= sum(ul, (af(r,ul,a,t)*(pfp0(r,ul,a)/plab10(r,a))**(1-sigmaul(r,a)))
       *          (PFP_SUB(r,ul,a,t)/lambdaf(r,ul,a,t))**(1-sigmaul(r,a))) ;

plab2eq(r,a,t)$(ts(t) and rs(r) and lab2Flag(r,a))..
   plab2(r,a,t)**(1-sigmasl(r,a))
      =e= sum(sl, (af(r,sl,a,t)*(pfp0(r,sl,a)/plab20(r,a))**(1-sigmasl(r,a)))
       *          (PFP_SUB(r,sl,a,t)/lambdaf(r,sl,a,t))**(1-sigmasl(r,a))) ;

plab1.lo(r,a,t) = 0.001 ;
plab2.lo(r,a,t) = 0.001 ;

*  ND1 & ND2 disaggregation

xapeq(r,i,a,t)$(ts(t) and rs(r) and xaFlag(r,i,a) and (mapi1(i,a) or mapi2(i,a) or iw(i)))..
   xa(r,i,a,t) =e= ((aio(r,i,a,t)*(nd10(r,a)/xa0(r,i,a))*(pnd10(r,a)/pa0(r,i,a))**sigman1(r,a))
                *   (lambdaio(r,i,a,t)**(sigman1(r,a)-1))
                *    nd1(r,a,t)*(pnd1(r,a,t)/PA_SUB(r,i,a,t))**sigman1(r,a))$mapi1(i,a)

                +  ((aio(r,i,a,t)*(nd20(r,a)/xa0(r,i,a))*(pnd20(r,a)/pa0(r,i,a))**sigman2(r,a))
                *   (lambdaio(r,i,a,t)**(sigman2(r,a)-1))
                *    nd2(r,a,t)*(pnd2(r,a,t)/PA_SUB(r,i,a,t))**sigman2(r,a))$mapi2(i,a)

                +  ((aio(r,i,a,t)*(xwat0(r,a)/xa0(r,i,a))*(pwat0(r,a)/pa0(r,i,a))**sigmawat(r,a))
                *   (lambdaio(r,i,a,t)**(sigmawat(r,a)-1))
                *    xwat(r,a,t)*(pwat(r,a,t)/PA_SUB(r,i,a,t))**sigmawat(r,a))$iw(i)
                ;

pnd1eq(r,a,t)$(ts(t) and rs(r) and nd1Flag(r,a))..
   pnd1(r,a,t)**(1-sigman1(r,a)) =e= sum(i$mapi1(i,a),
         (aio(r,i,a,t)*(pa0(r,i,a)/pnd10(r,a))**(1-sigman1(r,a)))
      *  (PA_SUB(r,i,a,t)/lambdaio(r,i,a,t))**(1-sigman1(r,a))) ;

pnd2eq(r,a,t)$(ts(t) and rs(r) and nd2Flag(r,a))..
   pnd2(r,a,t)**(1-sigman2(r,a)) =e= sum(i$mapi2(i,a),
         (aio(r,i,a,t)*(pa0(r,i,a)/pnd20(r,a))**(1-sigman2(r,a)))
      *  (PA_SUB(r,i,a,t)/lambdaio(r,i,a,t))**(1-sigman2(r,a))) ;

pwateq(r,a,t)$(ts(t) and rs(r) and watFlag(r,a))..
   pwat(r,a,t)**(1-sigmawat(r,a)) =e= sum(i$iw(i),
         (aio(r,i,a,t)*(pa0(r,i,a)/pwat0(r,a))**(1-sigmawat(r,a)))
      *  (PA_SUB(r,i,a,t)/lambdaio(r,i,a,t))**(1-sigmawat(r,a)))
      +  sum(wat, (af(r,wat,a,t)*(pfp0(r,wat,a)/pwat0(r,a))**(1-sigmawat(r,a)))
      *  (PFP_SUB(r,wat,a,t)/lambdaf(r,wat,a,t))**(1-sigmawat(r,a))) ;
      ;

pnd1.lo(r,a,t) = 0.001 ;
pnd2.lo(r,a,t) = 0.001 ;
pwat.lo(r,a,t) = 0.001 ;

*  NRG bundle disaggregation -- single and multiple nests

xnelyeq(r,a,v,t)$(ts(t) and rs(r) and xnelyFlag(r,a) and ifNRGNest)..
   xnely(r,a,v,t) =e= (anely(r,a,v,t)*(xnrg0(r,a)/xnely0(r,a))
                   *  (pnrg0(r,a)/pnely0(r,a))**sigmae(r,a,v))
                   *   xnrg(r,a,v,t)*(pnrg(r,a,v,t)/pnely(r,a,v,t))**sigmae(r,a,v) ;

xolgeq(r,a,v,t)$(ts(t) and rs(r) and xolgFlag(r,a) and ifNRGNest)..
   xolg(r,a,v,t) =e= (aolg(r,a,v,t)*(xnely0(r,a)/xolg0(r,a))
                  *  (pnely0(r,a)/polg0(r,a))**sigmanely(r,a,v))
                  *   xnely(r,a,v,t)*(pnely(r,a,v,t)/polg(r,a,v,t))**sigmanely(r,a,v) ;

xaNRGeq(r,a,NRG,v,t)$(ts(t) and rs(r) and xaNRGFlag(r,a,NRG) and ifNRGNest)..
   xaNRG(r,a,NRG,v,t) =e=
         ((aNRG(r,a,NRG,v,t)*(xnrg0(r,a)/xaNRG0(r,a,NRG))
      *  (pnrg0(r,a)/paNRG0(r,a,NRG))**sigmae(r,a,v))
      *   xnrg(r,a,v,t)*(pnrg(r,a,v,t)/paNRG(r,a,NRG,v,t))**sigmae(r,a,v))$ely(nrg)

      +  ((aNRG(r,a,NRG,v,t)*(xnely0(r,a)/xaNRG0(r,a,NRG))
      *  (pnely0(r,a)/paNRG0(r,a,NRG))**sigmanely(r,a,v))
      *   xnely(r,a,v,t)*(pnely(r,a,v,t)/paNRG(r,a,NRG,v,t))**sigmanely(r,a,v))$coa(nrg)

      +  ((aNRG(r,a,NRG,v,t)*(xolg0(r,a)/xaNRG0(r,a,NRG))
      *  (polg0(r,a)/paNRG0(r,a,NRG))**sigmaolg(r,a,v))
      *   xolg(r,a,v,t)*(polg(r,a,v,t)/paNRG(r,a,NRG,v,t))**sigmaolg(r,a,v))$oil(nrg)

      +  ((aNRG(r,a,NRG,v,t)*(xolg0(r,a)/xaNRG0(r,a,NRG))
      *  (polg0(r,a)/paNRG0(r,a,NRG))**sigmaolg(r,a,v))
      *   xolg(r,a,v,t)*(polg(r,a,v,t)/paNRG(r,a,NRG,v,t))**sigmaolg(r,a,v))$gas(nrg)
      ;

xaeeq(r,e,a,t)$(ts(t) and rs(r) and xaFlag(r,e,a))..
   xa(r,e,a,t) =e= (sum(v, (aeio(r,e,a,v,t)*(xnrg0(r,a)/xa0(r,e,a))
                *    (pnrg0(r,a)/pa0(r,e,a))**sigmae(r,a,v))
                *    (lambdae(r,e,a,v,t)**(sigmae(r,a,v)-1))
                *    xnrg(r,a,v,t)*(pnrg(r,a,v,t)/PA_SUB(r,e,a,t))**sigmae(r,a,v)))
                $(not ifNRGNest)

                +  (sum(v, sum(NRG$mape(NRG,e), (aeio(r,e,a,v,t)*(xaNRG0(r,a,NRG)/xa0(r,e,a))
                *   (paNRG0(r,a,NRG)/pa0(r,e,a))**sigmaNRG(r,a,NRG,v))
                *   (lambdae(r,e,a,v,t)**(sigmaNRG(r,a,NRG,v)-1))
                *   xaNRG(r,a,NRG,v,t)*(paNRG(r,a,NRG,v,t)/PA_SUB(r,e,a,t))**sigmaNRG(r,a,NRG,v))))
                $(ifNRGNest)
                ;

paNRGeq(r,a,NRG,v,t)$(ts(t) and rs(r) and xaNRGFlag(r,a,NRG) and ifNRGNest)..
   paNRG(r,a,NRG,v,t)**(1-sigmaNRG(r,a,NRG,v)) =e=
      sum(e$mape(NRG,e), (aeio(r,e,a,v,t)*(pa0(r,e,a)/paNRG0(r,a,NRG))**(1-sigmaNRG(r,a,NRG,v)))
         *(PA_SUB(r,e,a,t)/lambdae(r,e,a,v,t))**(1-sigmaNRG(r,a,NRG,v))) ;

paNRG.lo(r,a,NRG,v,t) = 0.001 ;

polgeq(r,a,v,t)$(ts(t) and rs(r) and xolgFlag(r,a) and ifNRGNest)..
   polg(r,a,v,t)**(1-sigmaolg(r,a,v)) =e=
      (aNRG(r,a,"GAS",v,t)*(paNRG0(r,a,"GAS")/polg0(r,a))**(1-sigmaolg(r,a,v)))
   *   paNRG(r,a,"GAS",v,t)**(1-sigmaolg(r,a,v))
   +  (aNRG(r,a,"OIL",v,t)*(paNRG0(r,a,"OIL")/polg0(r,a))**(1-sigmaolg(r,a,v)))
   *   paNRG(r,a,"OIL",v,t)**(1-sigmaolg(r,a,v)) ;

polg.lo(r,a,v,t) = 0.001 ;

pnelyeq(r,a,v,t)$(ts(t) and rs(r) and xnelyFlag(r,a) and ifNRGNest)..
   pnely(r,a,v,t)**(1-sigmanely(r,a,v)) =e=
      (aNRG(r,a,"COA",v,t)*(paNRG0(r,a,"COA")/pnely0(r,a))**(1-sigmanely(r,a,v)))
   *   paNRG(r,a,"COA",v,t)**(1-sigmanely(r,a,v))
   +  (aolg(r,a,v,t)*(polg0(r,a)/pnely0(r,a))**(1-sigmanely(r,a,v)))
   *   polg(r,a,v,t)**(1-sigmanely(r,a,v)) ;

pnely.lo(r,a,v,t) = 0.001 ;

pnrgeq(r,a,v,t)$(ts(t) and rs(r) and xnrgFlag(r,a))..
   pnrg(r,a,v,t)**(1-sigmae(r,a,v)) =e=
      (sum(e, (aeio(r,e,a,v,t)*(pa0(r,e,a)/pnrg0(r,a))**(1-sigmae(r,a,v)))
   *     (PA_SUB(r,e,a,t)/lambdae(r,e,a,v,t))**(1-sigmae(r,a,v))))$(not ifNRGNest)

   +  ((aNRG(r,a,"ELY",v,t)*(paNRG0(r,a,"ELY")/pnrg0(r,a))**(1-sigmae(r,a,v)))
   *    paNRG(r,a,"ELY",v,t)**(1-sigmae(r,a,v))
   +   (anely(r,a,v,t)*(pnely0(r,a)/pnrg0(r,a))**(1-sigmae(r,a,v)))
   *    pnely(r,a,v,t)**(1-sigmae(r,a,v)))$ifNRGNest ;

pnrg.lo(r,a,v,t) = 0.001 ;

* --------------------------------------------------------------------------------------------------
*
*  DOMESTIC SUPPLY BLOCK -- commodity make and use matrix
*
* --------------------------------------------------------------------------------------------------

*  Each activity 'a' can produce one or more commodities 'i'

peq(r,a,i,t)$(ts(t) and rs(r) and gp(r,a,i) ne 0)..
   0 =e= (x(r,a,i,t) - (gp(r,a,i)/lambdas(r,a,i,t))*(xp0(r,a)/x0(r,a,i))
      *                ((p0(r,a,i)/(lambdas(r,a,i,t)*px0(r,a)))**omegas(r,a))
      *                xp(r,a,t)*(p(r,a,i,t)/px(r,a,t))**omegas(r,a))$(omegas(r,a) ne inf)
      +  (p(r,a,i,t) - (px0(r,a)/p0(r,a,i))*px(r,a,t))$(omegas(r,a) eq inf)
      ;
p.lo(r,a,i,t) = 0.001 ;

xpeq(r,a,t)$(ts(t) and rs(r) and xpFlag(r,a))..
   px(r,a,t)*xp(r,a,t) =e= sum(i$gp(r,a,i), ((p0(r,a,i)/px0(r,a))*(x0(r,a,i)/xp0(r,a)))
                            *    p(r,a,i,t)*x(r,a,i,t)) ;

ppeq(r,a,i,t)$(ts(t) and rs(r) and gp(r,a,i) ne 0 and not IFSUB)..
   pp(r,a,i,t) =e= (1 + ptax(r,a,i,t))*p(r,a,i,t)*(p0(r,a,i)/pp0(r,a,i)) ;

pp.lo(r,a,i,t) = 0.001 ;

*  Domestic supply of good 'i' can be purchased from one or more activities 'a'

*
*  Specification for standard single nested CES
*

xeq(r,a,i,t)$(ts(t) and rs(r) and as(r,a,i) ne 0 and (not (IFPOWER and elya(a))))..
   0 =e= (x(r,a,i,t) - (as(r,a,i)*(xs0(r,i)/x0(r,a,i))*(ps0(r,i)/pp0(r,a,i))**sigmas(r,i))
      *                 xs(r,i,t)*(ps(r,i,t)/PP_SUB(r,a,i,t))**sigmas(r,i))
      $(sigmas(r,i) ne inf)
      +  (PP_SUB(r,a,i,t) - (ps0(r,i)/pp0(r,a,i))*ps(r,i,t))
      $(sigmas(r,i) eq inf) ;


pseq(r,i,t)$(ts(t) and rs(r) and xsFlag(r,i) and (not (IFPOWER and elyc(i))))..
   ps(r,i,t)*xs(r,i,t) =e=
      sum(a$as(r,a,i), ((pp0(r,a,i)/ps0(r,i))*(x0(r,a,i)/xs0(r,i)))
         * PP_SUB(r,a,i,t)*x(r,a,i,t)) ;

ps.lo(r,i,t) = 0.001 ;

$ontext

   Electricity aggregation

                  XS(ELY)
                   /\
                  /  \
                 /    \
                /      \
              ETD     POWER
                       /|\
                      / | \
                     /  |  \
                    /   |   \
                  Power bundles
                  /|\       /|\
                 / | \     / | \
                /  |  \   /  |  \
                   X         X

$offtext

*  Demand for etd -- electricity and distribution

xetdeq(r,etd,elyc,t)$(ts(t) and rs(r) and as(r,etd,elyc) and IFPOWER)..
   x(r,etd,elyc,t) =e= (as(r,etd,elyc)*(xs0(r,elyc)/x0(r,etd,elyc))
                    *  (ps0(r,elyc)/pp0(r,etd,elyc))**sigmael(r,elyc))
                    *   xs(r,elyc,t)*(ps(r,elyc,t)/PP_SUB(r,etd,elyc,t))
                    **sigmael(r,elyc) ;

*  Demand for power

xpoweq(r,elyc,t)$(ts(t) and rs(r) and apow(r,elyc) and IFPOWER)..
   xpow(r,elyc,t) =e= (apow(r,elyc)*(xs0(r,elyc)/xpow0(r,elyc))
                   *  (ps0(r,elyc)/ppow0(r,elyc))**sigmael(r,elyc))
                   *   xs(r,elyc,t)*(ps(r,elyc,t)/ppow(r,elyc,t))**sigmael(r,elyc) ;

*  Aggregate price of electricity supply

pselyeq(r,elyc,t)$(ts(t) and rs(r) and xsFlag(r,elyc) and IFPOWER)..
   ps(r,elyc,t)**(1-sigmael(r,elyc)) =e=
      sum(etd, (as(r,etd,elyc)*(pp0(r,etd,elyc)/ps0(r,elyc))**(1-sigmael(r,elyc)))
   *     PP_SUB(r,etd,elyc,t)**(1-sigmael(r,elyc)))
   +  (apow(r,elyc)*(ppow0(r,elyc)/ps0(r,elyc))**(1-sigmael(r,elyc)))
   *   ppow(r,elyc,t)**(1-sigmael(r,elyc)) ;

*  Demand for power bundles

xpbeq(r,pb,elyc,t)$(ts(t) and rs(r) and apb(r,pb,elyc) and IFPOWER)..
   xpb(r,pb,elyc,t) =e= (apb(r,pb,elyc)*(xpow0(r,elyc)/xpb0(r,pb,elyc))
                     *   (lambdapow(r,pb,elyc,t)**(-sigmapow(r,elyc)))
                     *   (ppowndx0(r,elyc)/ppb0(r,pb,elyc))**sigmapow(r,elyc))
                     *  xpow(r,elyc,t)*(ppowndx(r,elyc,t)/ppb(r,pb,elyc,t))**sigmapow(r,elyc) ;

*  Price index for power

ppowndxeq(r,elyc,t)$(ts(t) and rs(r) and apow(r,elyc) and IFPOWER)..
   ppowndx(r,elyc,t)**(-sigmapow(r,elyc)) =e= sum(pb$apb(r,pb,elyc), (apb(r,pb,elyc)
         *  (lambdapow(r,pb,elyc,t)*ppb0(r,pb,elyc)/ppowndx0(r,elyc))**(-sigmapow(r,elyc)))
         *   ppb(r,pb,elyc,t)**(-sigmapow(r,elyc))) ;

*  Average price of power

ppoweq(r,elyc,t)$(ts(t) and rs(r) and apow(r,elyc) and IFPOWER)..
   ppow(r,elyc,t)*xpow(r,elyc,t) =e= sum(pb$apb(r,pb,elyc),
         ((ppb0(r,pb,elyc)/ppow0(r,elyc))*(xpb0(r,pb,elyc)/xpow0(r,elyc)))
   *  ppb(r,pb,elyc,t)*xpb(r,pb,elyc,t)) ;

ppowndx.lo(r,elyc,t) = 0.001 ;
ppow.lo(r,elyc,t) = 0.001 ;

*  Decomposition of power bundles

xbndeq(r,elya,elyc,t)$(ts(t) and rs(r) and (not etd(elya)) and as(r,elya,elyc) and IFPOWER)..
   x(r,elya,elyc,t) =e= sum(pb$mappow(pb,elya),
         (as(r,elya,elyc)*(xpb0(r,pb,elyc)/x0(r,elya,elyc))
      *   (lambdapb(r,elya,elyc,t)**(-sigmapb(r,pb,elyc)))
      *   (ppbndx0(r,pb,elyc)/pp0(r,elya,elyc))**sigmapb(r,pb,elyc))
      *  xpb(r,pb,elyc,t)*(ppbndx(r,pb,elyc,t)/PP_SUB(r,elya,elyc,t))
      **sigmapb(r,pb,elyc)) ;

*  Price index for power bundles

ppbndxeq(r,pb,elyc,t)$(ts(t) and rs(r) and apb(r,pb,elyc) and IFPOWER)..
   ppbndx(r,pb,elyc,t)**(-sigmapb(r,pb,elyc)) =e= sum(elya$(mappow(pb,elya) and as(r,elya,elyc)),
         (as(r,elya,elyc)
      *     (lambdapb(r,elya,elyc,t)*pp0(r,elya,elyc)/ppbndx0(r,pb,elyc))**(-sigmapb(r,pb,elyc)))
      *     PP_SUB(r,elya,elyc,t)**(-sigmapb(r,pb,elyc))) ;

*  Average price for power bundles

ppbeq(r,pb,elyc,t)$(ts(t) and rs(r) and apb(r,pb,elyc) and IFPOWER)..
   ppb(r,pb,elyc,t)*xpb(r,pb,elyc,t) =e= sum(elya$(mappow(pb,elya) and as(r,elya,elyc)),
         ((pp0(r,elya,elyc)/ppb0(r,pb,elyc))*(x0(r,elya,elyc)/xpb0(r,pb,elyc)))
      *  PP_SUB(r,elya,elyc,t)*x(r,elya,elyc,t)) ;

ppbndx.lo(r,pb,elyc,t) = 0.001 ;
ppb.lo(r,pb,elyc,t) = 0.001 ;

* --------------------------------------------------------------------------------------------------
*
*  INCOME BLOCK
*
* --------------------------------------------------------------------------------------------------

*  Depreciation allowance

deprYeq(r,t)$(ts(t) and rs(r) and deprY0(r))..
   deprY(r,t) =e= sum(inv, (pfd0(r, inv)*kstock0(r)/deprY0(r))
               *        fdepr(r,t)*pfd(r, inv, t)*kstock(r,t)) ;

*  Revenues from NTM AVE

ntmYeq(r,t)$(ts(t) and rs(r) and NTMFlag)..
   ntmY0(r)*ntmY(r,t)
      =e= sum((s,i), ntmAVE(s,i,r,t)*pwm_sub(s,i,r,t)*pwm0(s,i,r)*lambdaw(s,i,r,t)*xw(s,i,r,t)*xw0(s,i,r)) ;

*  Outflow of capital income

yqtfeq(r,t)$(rs(r) and ts(t) and yqtf0(r))..
   yqtf(r,t) =e= ydistf(r,t)
      * sum((a,cap), pf0(r,cap,a)*xf0(r,cap,a)*(1 - kappaf(r,cap,a,t))*pf(r,cap,a,t)*xf(r,cap,a,t))
      / yqtf0(r) ;

*  Total outflows of capital income

trustYeq(t)$(ts(t) and trustY0 and ifGbl)..
   trustY(t) =e= sum(r, (yqtf0(r)/trustY0)*yqtf(r,t)) ;

*  Inflow of capital income

yqhteq(r,t)$(rs(r) and ts(t) and yqht0(r))..
   yqht(r,t) =e= chiTrust(r,t)*(trustY0/yqht0(r))*trustY(t) ;

*  Remittance outflows
*  !!!! Might want to do this after-tax

remiteq(rp,l,r,t)$(rs(r) and ts(t) and remit0(rp,l,r))..
   remit(rp,l,r,t) =e= (chiRemit(rp,l,r,t)/remit0(rp,l,r))
                    *   sum(a, (pf0(r,l,a)*xf0(r,l,a)
                    *      (1-kappaf(r,l,a,t))*pf(r,l,a,t)*xf(r,l,a,t))) ;

*  ODA outflows

ODAOuteq(r,t)$(rs(r) and ts(t) and ODAOut0(r))..
   ODAOut(r,t) =e= chiODAOut(r,t)*GDPMP(r,t)*(GDPMP0(r)/ODAOut0(r))*rgdppc(r,t)**etaODA(r,t) ;

*  Total ODA

ODAGbleq(t)$(ts(t) and ODAGbl0 and ifGbl)..
   ODAGbl(t) =e= sum(r, ODAOut(r,t)*ODAOut0(r))/ODAGbl0 ;

*  ODA inflows

ODAIneq(r,t)$(rs(r) and ts(t) and ODAIn0(r))..
   ODAIn(r,t) =e= chiODAIn(r,t)*(ODAGbl0/ODAIn0(r))*ODAGbl(t) ;

*  Household income

yheq(r,t)$(ts(t) and rs(r))..
   yh(r,t) =e= sum((f,a)$xfFlag(r,f,a), (1-kappaf(r,f,a,t))
            *              pf(r,f,a,t)*xf(r,f,a,t)*(pf0(r,f,a)*xf0(r,f,a)/yh0(r)))
            +  ((yqht0(r)/yh0(r))*yqht(r,t) - (yqtf0(r)/yh0(r))*yqtf(r,t))
            +  (sum((l,rp), (remit0(r,l,rp)/yh0(r))*remit(r,l,rp,t)
            -               (remit0(rp,l,r)/yh0(r))*remit(rp,l,r,t)))
            - deprY0(r)*deprY(r,t)/yh0(r)
            + sum(s, chihNTM(s,r,t)*ntmY0(s)*ntmY(s,t)) ;
            ;

ydeq(r,t)$(ts(t) and rs(r))..
   yd(r,t) =e= (1 - kappah(r,t))*yh(r,t)*(yh0(r)/yd0(r)) ;

*  Government income

ygoveq(r,gy,t)$(ts(t) and rs(r) and ygov0(r,gy))..
   ygov(r,gy,t) =e=

*  Output tax

      (sum((a,i), ptax(r,a,i,t)*p(r,a,i,t)*x(r,a,i,t)*(p0(r,a,i)*x0(r,a,i)))/ygov0(r,gy)
   +   sum((a,v), uctax(r,a,v,t)*uc(r,a,v,t)*xpv(r,a,v,t)*(uc0(r,a)*xpv0(r,a)))/ygov0(r,gy))$ptx(gy)

*  Factor use tax

   +  (sum((f,a)$xfFlag(r,f,a),
         pfTax(r,f,a,t)*pf(r,f,a,t)*xf(r,f,a,t)*(pf0(r,f,a)*xf0(r,f,a)/ygov0(r,gy))))$vtx(gy)

*  Sales tax

   +  (sum((i,aa)$xaFlag(r,i,aa), paTax(r,i,aa,t)*gammaeda(r,i,aa)*pat(r,i,t)*xa(r,i,aa,t)
         *  (pat0(r,i)*xa0(r,i,aa)/ygov0(r,gy))))$(ArmFlag eq 0 and itx(gy))
   +  (sum((i,aa)$xdFlag(r,i,aa), pdTax(r,i,aa,t)*gammaedd(r,i,aa)*pdt(r,i,t)*xd(r,i,aa,t)
         *  (pdt0(r,i)*xd0(r,i,aa)/ygov0(r,gy)))
   +   sum((i,aa)$xmFlag(r,i,aa), pmTax(r,i,aa,t)*gammaedm(r,i,aa)
         *  ((pmt0(r,i)*pmt(r,i,t))$(not MRIO) + (pma0(r,i,aa)*pma(r,i,aa,t))$MRIO)
         *  xm0(r,i,aa)*xm(r,i,aa,t)/ygov0(r,gy)))
         $(ArmFlag and itx(gy))

*  Import tax

   +  (sum((i,s)$xwFlag(s,i,r),
         mtax(s,i,r,t)*PWM_SUB(s,i,r,t)*lambdaw(s,i,r,t)*xw(s,i,r,t)
   *     (pwm0(s,i,r)*xw0(s,i,r)/ygov0(r,gy))))$(mtx(gy) and not MRIO)

   +  (sum((s,i,aa)$xwaFlag(s,i,r,aa),
         mtaxa(s,i,r,aa,t)*PWM_SUB(s,i,r,t)*xwa(s,i,r,aa,t)
   *     (pwm0(s,i,r)*xwa0(s,i,r,aa)/ygov0(r,gy))))$(mtx(gy) and MRIO)

*  Export tax

   +  (sum((i,rp)$xwFlag(r,i,rp), (etax(r,i,rp,t)+etaxi(r,i,t))*pe(r,i,rp,t)*xw(r,i,rp,t)
   *     (pe0(r,i,rp)*xw0(r,i,rp)/ygov0(r,gy))))$etx(gy)

*  Income tax

   +  (sum((f,a)$xfFlag(r,f,a), kappaf(r,f,a,t)*pf(r,f,a,t)*xf(r,f,a,t)
         *(pf0(r,f,a)*xf0(r,f,a)/ygov0(r,gy)))
   +   kappah(r,t)*yh(r,t)*(yh0(r)/ygov0(r,gy)))$dtx(gy)

*  Add the waste tax(es)

   +   ((sum((i,h)$hWasteFlag(r,i,h), (xawc0(r,i,h)*xawc(r,i,h,t))*(pa0(r,i,h)*pa_sub(r,i,h,t)*wtaxh(r,i,h,t)
   +     wtaxhx(r,i,h,t)*pfd0(r,h)*pfd(r,h,t))))/ygov0(r,gy))$wtx(gy)

*  Carbon tax

   +  (sum((em,i,aa), chiEmi(em,t)*emir(r,em,i,aa)*part(r,em,i,aa)*emiTax(r,em,t)*xa(r,i,aa,t)
   *     (xa0(r,i,aa)/ygov0(r,gy))))$(ArmFlag eq 0 and ctx(gy))
   +  (sum((em,i,aa), chiEmi(em,t)*emird(r,em,i,aa)*part(r,em,i,aa)*emiTax(r,em,t)*xd(r,i,aa,t)
   *     (xd0(r,i,aa)/ygov0(r,gy)))
   +   sum((em,i,aa), chiEmi(em,t)*emirm(r,em,i,aa)*part(r,em,i,aa)*emiTax(r,em,t)*xm(r,i,aa,t)
   *     (xm0(r,i,aa)/ygov0(r,gy))))$(ArmFlag and ctx(gy))
   ;

*  Investment income

yfdInveq(r,inv,t)$(ts(t) and rs(r) and ((ifGbl and not rres(r)) or (not ifGbl)))..
   yfd(r,inv,t) =e= sum(h, savh(r,h,t)*savh0(r,h)/yfd0(r,inv))
                 +         savg(r,t)/yfd0(r,inv)
                 +         pwsav(t)*savf(r,t)/yfd0(r,inv)
                 +         deprY0(r)*deprY(r,t)/yfd0(r,inv)
                 ;

* --------------------------------------------------------------------------------------------------
*
*  FINAL DEMAND BLOCK
*
* --------------------------------------------------------------------------------------------------

*  Supernumery income

supyeq(r,h,t)$(ts(t) and rs(r)
      and (%utility%=CD or %utility%=LES or %utility%=ELES or %utility%=AIDADS))..
   supy(r,h,t) =e= ((yd(r,t)-(savh(r,h,t)*(savh0(r,h)/yd0(r)))
                $    (%utility%=CD or %utility%=LES or %utility%=AIDADS))
                /    pop(r,t))*(yd0(r)/(pop0(r)*supy0(r,h)))
                -  sum(k, pc(r,k,h,t)*theta(r,k,h,t)*pc0(r,k,h)*theta0(r,k,h)/supy0(r,h)) ;

*  CDE auxiliary variable

thetaeq(r,k,h,t)$(ts(t) and rs(r) and xcFlag(r,k,h) and %utility%=CDE)..
   theta(r,k,h,t) =e= alphah(r,k,h,t)*bh(r,k,h,t)
                   *    ((pc(r,k,h,t)*u(r,h,t)**eh(r,k,h,t))**bh(r,k,h,t))
                   *    ((yd(r,t) - (savh0(r,h)/yd0(r))*savh(r,h,t))**(-bh(r,k,h,t)))
                   *    ((pc0(r,k,h)*pop0(r)*pop(r,t)*u0(r,h)**eh(r,k,h,t))**bh(r,k,h,t))
                   *    ((yd0(r)**(-bh(r,k,h,t)))/theta0(r,k,h))
                   ;

*  Household consumption in household commodity space

xceq(r,k,h,t)$(ts(t) and rs(r) and xcFlag(r,k,h))..
   0 =e= (xc(r,k,h,t) - (pop0(r)*pop(r,t)*(theta(r,k,h,t)*theta0(r,k,h)/xc0(r,k,h)
                      + (betac(r,h,t)*muc(r,k,h,t)*supy(r,h,t)/pc(r,k,h,t))
                      * (muc0(r,k,h)*supy0(r,h)/(pc0(r,k,h)*xc0(r,k,h))))))
                      $(%utility%=CD or %utility%=LES or %utility%=ELES or %utility%=AIDADS)

      +  (hshr(r,k,h,t) - (theta(r,k,h,t)*theta0(r,k,h)/hshr0(r,k,h))
      /     sum(kp$xcFlag(r,kp,h), theta0(r,kp,h)*theta(r,kp,h,t)))$(%utility%=CDE) ;

*  Household budget share (out of expenditures on goods and services)

hshreq(r,k,h,t)$(ts(t) and rs(r) and xcFlag(r,k,h))..
   hshr(r,k,h,t) =e= (pc(r,k,h,t)*xc(r,k,h,t)/(yd(r,t)-(savh0(r,h)/yd0(r))*savh(r,h,t)))
                  *  (pc0(r,k,h)*xc0(r,k,h)/(hshr0(r,k,h)*yd0(r))) ;

*  Marginal budget share for AIDADS

muceq(r,k,h,t)$(ts(t) and rs(r) and xcFlag(r,k,h) and %utility%=AIDADS)..
   muc(r,k,h,t) =e= ((alphaAD(r,k,h,t) + betaAD(r,k,h,t)*exp(u(r,h,t)*u0(r,h)))
                 /  (1+exp(u(r,h,t)*u0(r,h))))/muc0(r,k,h) ;

*  Utility definition

*  !!!! Currently potential problems with ELES

ueq(r,h,t)$(ts(t) and rs(r))..
   0 =e= (u0(r,h)*u(r,h,t) - 1)$(%utility%=ELES and not uFlag(r,h))

      +  (u(r,h,t)*u0(r,h) - (supy(r,h,t)*supy0(r,h)
            / (prod(k$xcFlag(r,k,h), (pc(r,k,h,t)*pc0(r,k,h)/(muc0(r,k,h)*muc(r,k,h,t)))
            **(muc0(r,k,h)*muc(r,k,h,t)))
            * ((pfd(r,h,t)*pfd0(r,h)/mus(r,h,t))**mus(r,h,t)))))$(%utility%=ELES and uFlag(r,h))

      +  (u(r,h,t)*u0(r,h) + 1 + log(aad(r,h,t))
      -   sum(k$xcFlag(r,k,h), muc0(r,k,h)*muc(r,k,h,t)*
            log(xc(r,k,h,t)*xc0(r,k,h)/(pop0(r)*pop(r,t)) - theta0(r,k,h)*theta(r,k,h,t))))
      $(%utility%=CD or %utility%=LES or %utility%=AIDADS)

      +  (1 - sum(k$xcFlag(r,k,h), theta0(r,k,h)*theta(r,k,h,t)/bh(r,k,h,t)))$(%utility%=CDE)
      ;

*  Demand for non-energy bundle by households

xcnnrgeq(r,k,h,t)$(ts(t) and rs(r) and xcnnrgFlag(r,k,h))..
   xcnnrg(r,k,h,t) =e= (acxnnrg(r,k,h)
                    *  (xc0(r,k,h)/xcnnrg0(r,k,h))*(pc0(r,k,h)/pcnnrg0(r,k,h))**nu(r,k,h))
                    *   xc(r,k,h,t)*(pc(r,k,h,t)/pcnnrg(r,k,h,t))**nu(r,k,h) ;

*  Demand for energy bundle by households

xcnrgeq(r,k,h,t)$(ts(t) and rs(r) and xcnrgFlag(r,k,h))..
   xcnrg(r,k,h,t) =e= (acxnrg(r,k,h)
                   *  (xc0(r,k,h)/xcnrg0(r,k,h))*(pc0(r,k,h)/pcnrg0(r,k,h))**nu(r,k,h))
                   *   xc(r,k,h,t)*(pc(r,k,h,t)/pcnrg(r,k,h,t))**nu(r,k,h) ;

*  Price of consumer good k

pceq(r,k,h,t)$(ts(t) and rs(r) and xcFlag(r,k,h))..
   pc(r,k,h,t)**(1-nu(r,k,h)) =e= (acxnnrg(r,k,h)*(pcnnrg0(r,k,h)/pc0(r,k,h))**(1-nu(r,k,h)))
                               *    pcnnrg(r,k,h,t)**(1-nu(r,k,h))
                               +  (acxnrg(r,k,h)*(pcnrg0(r,k,h)/pc0(r,k,h))**(1-nu(r,k,h)))
                               *    pcnrg(r,k,h,t)**(1-nu(r,k,h)) ;

pc.lo(r,k,h,t) = 0.001 ;

*  Decomposition of non-energy bundle by households

xacnnrgeq(r,ixn,h,t)$(ts(t) and rs(r) and xaFlag(r,ixn,h))..
   xa(r,ixn,h,t) =e= sum(k$ac(r,ixn,k,h), (ac(r,ixn,k,h)*(xcnnrg0(r,k,h)/xa0(r,ixn,h))
                  *    (pcnnrg0(r,k,h)/pa0(r,ixn,h))**nunnrg(r,k,h))
                  *     xcnnrg(r,k,h,t)*(pcnnrg(r,k,h,t)/pah(r,ixn,h,t))**nunnrg(r,k,h)) ;

pcnnrgeq(r,k,h,t)$(ts(t) and rs(r) and xcnnrgFlag(r,k,h))..
   pcnnrg(r,k,h,t)**(1-nunnrg(r,k,h)) =e= sum(ixn$ac(r,ixn,k,h),
         (ac(r,ixn,k,h)*(pa0(r,ixn,h)/pcnnrg0(r,k,h))**(1-nunnrg(r,k,h)))
      *   pah(r,ixn,h,t)**(1-nunnrg(r,k,h))) ;

pcnnrg.lo(r,k,h,t) = 0.001 ;

*  NRG bundle disaggregation -- single and multiple nests

xcnelyeq(r,k,h,t)$(ts(t) and rs(r) and xcnelyFlag(r,k,h) and ifNRGNest)..
   xcnely(r,k,h,t) =e= (acnely(r,k,h,t)*(xcnrg0(r,k,h)/xcnely0(r,k,h))
                    *   (pcnrg0(r,k,h)/pcnely0(r,k,h))**nue(r,k,h))
                    *    xcnrg(r,k,h,t)*(pcnrg(r,k,h,t)/pcnely(r,k,h,t))**nue(r,k,h) ;

xcolgeq(r,k,h,t)$(ts(t) and rs(r) and xcolgFlag(r,k,h) and ifNRGNest)..
   xcolg(r,k,h,t) =e= (acolg(r,k,h,t)*(xcnely0(r,k,h)/xcolg0(r,k,h))
                   *  (pcnely0(r,k,h)/pcolg0(r,k,h))**nunely(r,k,h))
                   *   xcnely(r,k,h,t)*(pcnely(r,k,h,t)/pcolg(r,k,h,t))**nunely(r,k,h) ;

xacNRGeq(r,k,h,NRG,t)$(ts(t) and rs(r) and xacNRGFlag(r,k,h,NRG) and ifNRGNest)..
   xacNRG(r,k,h,NRG,t) =e= ((acNRG(r,k,h,NRG,t)*(xcnrg0(r,k,h)/xacNRG0(r,k,h,NRG))
                        *     (pcnrg0(r,k,h)/pacNRG0(r,k,h,NRG))**nue(r,k,h))
                        *      xcnrg(r,k,h,t)*(pcnrg(r,k,h,t)/pacNRG(r,k,h,NRG,t))**nue(r,k,h))
                        $ely(nrg)

                        +  ((acNRG(r,k,h,NRG,t)*(xcnely0(r,k,h)/xacNRG0(r,k,h,NRG))
                        *     (pcnely0(r,k,h)/pacNRG0(r,k,h,NRG))**nunely(r,k,h))
                        *      xcnely(r,k,h,t)*(pcnely(r,k,h,t)/pacNRG(r,k,h,NRG,T))**nunely(r,k,h))
                        $coa(nrg)

                        +  ((acNRG(r,k,h,NRG,t)*(xcolg0(r,k,h)/xacNRG0(r,k,h,NRG))
                        *     (pcolg0(r,k,h)/pacNRG0(r,k,h,NRG))**nuolg(r,k,h))
                        *      xcolg(r,k,h,t)*(pcolg(r,k,h,t)/pacNRG(r,k,h,NRG,T))**nuolg(r,k,h))
                        $gas(nrg)

                        +  ((acNRG(r,k,h,NRG,t)*(xcolg0(r,k,h)/xacNRG0(r,k,h,NRG))
                        *     (pcolg0(r,k,h)/pacNRG0(r,k,h,NRG))**nuolg(r,k,h))
                        *      xcolg(r,k,h,t)*(pcolg(r,k,h,t)/pacNRG(r,k,h,NRG,T))**nuolg(r,k,h))
                        $oil(nrg)
                        ;

xaceeq(r,e,h,t)$(ts(t) and rs(r) and xaFlag(r,e,h))..
   xa(r,e,h,t) =e= (sum(k, (ac(r,e,k,h)*(xcnrg0(r,k,h)/xa0(r,e,h))
                *    (pcnrg0(r,k,h)/pa0(r,e,h))**nue(r,k,h))
                *    ((lambdace(r,e,k,h,t))**(nue(r,k,h)-1))
                *    xcnrg(r,k,h,t)*(pcnrg(r,k,h,t)/pah(r,e,h,t))**nue(r,k,h)))
                $(not ifNRGNest)

                +  (sum(k, sum(NRG$mape(NRG,e), (ac(r,e,k,h)*(xacNRG0(r,k,h,NRG)/xa0(r,e,h))
                *    (pacNRG0(r,k,h,NRG)/pa0(r,e,h))**nuNRG(r,k,h,NRG))
                *    ((lambdace(r,e,k,h,t))**(nuNRG(r,k,h,NRG)-1))
                *    xacNRG(r,k,h,NRG,t)*(pacNRG(r,k,h,NRG,t)/pah(r,e,h,t))**nuNRG(r,k,h,NRG))))
                $(ifNRGNest)
                ;

pacNRGeq(r,k,h,NRG,t)$(ts(t) and rs(r) and xacNRGFlag(r,k,h,NRG) and ifNRGNest)..
   pacNRG(r,k,h,NRG,t)**(1-nuNRG(r,k,h,NRG)) =e= sum(e$mape(NRG,e),
         (ac(r,e,k,h)*(pa0(r,e,h)/pacNRG0(r,k,h,NRG))**(1-nuNRG(r,k,h,NRG)))
      *  (pah(r,e,h,t)/lambdace(r,e,k,h,t))**(1-nuNRG(r,k,h,NRG))) ;

pacNRG.lo(r,k,h,NRG,t) = 0.001 ;

pcolgeq(r,k,h,t)$(ts(t) and rs(r) and xcolgFlag(r,k,h) and ifNRGNest)..
   pcolg(r,k,h,t)**(1-nuolg(r,k,h)) =e=
         (acNRG(r,k,h,"GAS",t)*(pacNRG0(r,k,h,"GAS")/pcolg0(r,k,h))**(1-nuolg(r,k,h)))
      *  pacNRG(r,k,h,"GAS",t)**(1-nuolg(r,k,h))
      +  (acNRG(r,k,h,"OIL",t)*(pacNRG0(r,k,h,"OIL")/pcolg0(r,k,h))**(1-nuolg(r,k,h)))
      *  pacNRG(r,k,h,"OIL",t)**(1-nuolg(r,k,h)) ;

pcolg.lo(r,k,h,t) = 0.001 ;

pcnelyeq(r,k,h,t)$(ts(t) and rs(r) and xcnelyFlag(r,k,h) and ifNRGNest)..
   pcnely(r,k,h,t)**(1-nunely(r,k,h)) =e=
         (acNRG(r,k,h,"COA",t)*(pacNRG0(r,k,h,"COA")/pcnely0(r,k,h))**(1-nunely(r,k,h)))
      *  pacNRG(r,k,h,"COA",t)**(1-nunely(r,k,h))
      +  (acolg(r,k,h,t)*(pcolg0(r,k,h)/pcnely0(r,k,h))**(1-nunely(r,k,h)))
      *  pcolg(r,k,h,t)**(1-nunely(r,k,h)) ;

pcnely.lo(r,k,h,t) = 0.001 ;

pcnrgeq(r,k,h,t)$(ts(t) and rs(r) and xcnrgFlag(r,k,h))..
   pcnrg(r,k,h,t)**(1-nue(r,k,h)) =e=
      (sum(e, (ac(r,e,k,h)*(pa0(r,e,h)/pcnrg0(r,k,h))**(1-nue(r,k,h)))
   *          (pah(r,e,h,t)/lambdace(r,e,k,h,t))**(1-nue(r,k,h))))$(not ifNRGNest)

   +  ((acNRG(r,k,h,"ELY",t)*(pacNRG0(r,k,h,"ELY")/pcnrg0(r,k,h))**(1-nue(r,k,h)))
   *     pacNRG(r,k,h,"ELY",t)**(1-nue(r,k,h))
   +   (acnely(r,k,h,t)*(pcnely0(r,k,h)/pcnrg0(r,k,h))**(1-nue(r,k,h)))
   *     pcnely(r,k,h,t)**(1-nue(r,k,h)))$ifNRGNest ;

pcnrg.lo(r,k,h,t) = 0.001 ;

*  Waste module

xaaceq(r,i,h,t)$(ts(t) and rs(r) and xaac0(r,i,h))..
   xaac(r,i,h,t) =e= ((alphaac(r,i,h)*(xa0(r,i,h)/xaac0(r,i,h))
                  *  (paacc0(r,i,h)/paac0(r,i,h))**sigmaac(r,i,h))
                  *  xa(r,i,h,t)
                  *  (paacc(r,i,h,t)/(lambdaac(r,i,h,t)*paac(r,i,h,t)))**sigmaac(r,i,h))
                  $  (hWasteFlag(r,i,h))
                  +  (xa0(r,i,h)*xa(r,i,h,t)/xaac0(r,i,h))$(hWasteFlag(r,i,h) ne 1) ;

xawceq(r,i,h,t)$(ts(t) and rs(r) and hWasteFlag(r,i,h) and xawc0(r,i,h))..
   xawc(r,i,h,t) =e= (alphawc(r,i,h)*(xa0(r,i,h)/xawc0(r,i,h))
                  *  (paacc0(r,i,h)/pawc0(r,i,h))**sigmaac(r,i,h))
                  *  xa(r,i,h,t)
                  *  (paacc(r,i,h,t)/(lambdawc(r,i,h,t)*pawc(r,i,h,t)))**sigmaac(r,i,h) ;

paacceq(r,i,h,t)$(ts(t) and rs(r) and hWasteFlag(r,i,h))..
   (paacc0(r,i,h)*paacc(r,i,h,t))**(-sigmaac(r,i,h)) =e=
      alphaac(r,i,h)*(lambdaac(r,i,h,t)*(paac0(r,i,h)*paac(r,i,h,t)))**(-sigmaac(r,i,h))
   +  alphawc(r,i,h)*(lambdawc(r,i,h,t)*(pawc0(r,i,h)*pawc(r,i,h,t)))**(-sigmaac(r,i,h)) ;

paaceq(r,i,h,t)$(ts(t) and rs(r) and xaac0(r,i,h))..
   pa0(r,i,h)*pa_sub(r,i,h,t) =e= paac0(r,i,h)*paac(r,i,h,t) ;

paheq(r,i,h,t)$(ts(t) and rs(r) and xaac0(r,i,h))..
   0 =e= (pa0(r,i,h)*pah(r,i,h,t)*xa0(r,i,h)*xa(r,i,h,t) -
            (paac0(r,i,h)*paac(r,i,h,t)*xaac0(r,i,h)*xaac(r,i,h,t)
      +      pawc0(r,i,h)*pawc(r,i,h,t)*xawc0(r,i,h)*xawc(r,i,h,t)))$hWasteFlag(r,i,h)
      +  (pah(r,i,h,t) - pa_sub(r,i,h,t))$(not hWasteFlag(r,i,h)) ;
 ;

pawceq(r,i,h,t)$(ts(t) and rs(r) and hWasteFlag(r,i,h))..
   pawc0(r,i,h)*pawc(r,i,h,t) =e= pa0(r,i,h)*pa_sub(r,i,h,t)*(1 + wtaxh(r,i,h,t))
                               +    wtaxhx(r,i,h,t)*pfd0(r,h)*pfd(r,h,t) ;

*  Household saving for ELES

savhELESeq(r,h,t)$(ts(t) and rs(r) and %utility% = ELES)..
   savh(r,h,t) =e= yd(r,t)*(yd0(r)/savh0(r,h))
                -    sum(k, pc(r,k,h,t)*xc(r,k,h,t)*(pc0(r,k,h)*xc0(r,k,h)/savh0(r,h))) ;

*  Household saving for non-ELES, or aps for ELES

savheq(r,h,t)$(ts(t) and rs(r))..
   savh(r,h,t) =e= chiaps(r,t)*aps(r,h,t)*yd(r,t)*(aps0(r,h)*yd0(r)/savh0(r,h)) ;

*  Other final demand -- investment and government

xafeq(r,i,fdc,t)$(ts(t) and rs(r) and xa0(r,i,fdc))..
   xa(r,i,fdc,t) =e= (alphafd(r,i,fdc,t)*(xfd0(r,fdc)/xa0(r,i,fdc))
                  *     (pfd0(r,fdc)/pa0(r,i,fdc))**sigmafd(r,fdc))
                  *  xfd(r,fdc,t)* (pfd(r,fdc,t)/PA_SUB(r,i,fdc,t))**sigmafd(r,fdc) ;

pfdfeq(r,fdc,t)$(ts(t) and rs(r))..
   pfd(r,fdc,t)**(1-sigmafd(r,fdc)) =e= sum(i,
         (alphafd(r,i,fdc,t)*(pa0(r,i,fdc)/pfd0(r,fdc))**(1-sigmafd(r,fdc)))
      *  PA_SUB(r,i,fdc,t)**(1-sigmafd(r,fdc))) ;

pfd.lo(r,fd,t) = 0.001 ;

$macro mQFD(r,fd,tp,tq) (sum(i, (pa0(r,i,fd)*xa0(r,i,fd))*pah(r,i,fd,tp)*xa(r,i,fd,tq)))

pfdheq(r,h,t)$(ts(t) and rs(r))..
$iftheni "%simType%" == "compStat"
   pfd(r,h,t) =e= sum(t0, pfd(r,h,t0)
              *   sqrt((mQFD(r,h,t,t0)/mQFD(r,h,t0,t0))
              *        (mQFD(r,h,t,t)/mQFD(r,h,t0,t)))) ;
$else
   pfd(r,h,t) =e= pfd(r,h,t-1)
              *   sqrt((mQFD(r,h,t,t-1)/mQFD(r,h,t-1,t-1))
              *        (mQFD(r,h,t,t)/mQFD(r,h,t-1,t))) ;
$endif

xfdheq(r,h,t)$(ts(t) and rs(r))..
   yfd(r,h,t) =e= sum(i, pah(r,i,h,t)*xa(r,i,h,t)*(pa0(r,i,h)*xa0(r,i,h)/yfd0(r,h))) ;

yfdeq(r,fd,t)$(ts(t) and rs(r))..
   yfd(r,fd,t) =e= pfd(r,fd,t)*xfd(r,fd,t)*(pfd0(r,fd)*xfd0(r,fd)/yfd0(r,fd)) ;

* --------------------------------------------------------------------------------------------------
*
*  ARMINGTON BLOCK
*
* --------------------------------------------------------------------------------------------------

*  Top level -- Armington decomposition: national sourcing

xateq(r,i,t)$(ts(t) and rs(r) and xatFlag(r,i) and not ArmFlag)..
   xat(r,i,t) =e= sum(aa, gammaeda(r,i,aa)*xa(r,i,aa,t)*(xa0(r,i,aa)/xat0(r,i))) ;

pateq(r,i,t)$(ts(t) and rs(r) and xatFlag(r,i) and not ArmFlag)..
   pat(r,i,t)**(1-sigmamt(r,i)) =e=
      (alphadt(r,i,t)*((pdt0(r,i)/pat0(r,i))**(1-sigmamt(r,i))))*pdt(r,i,t)**(1-sigmamt(r,i))
   +  (alphamt(r,i,t)*((pmt0(r,i)/pat0(r,i))**(1-sigmamt(r,i))))*pmt(r,i,t)**(1-sigmamt(r,i)) ;

pat.lo(r,i,t) = 0.001 ;

xdteq(r,i,t)$(ts(t) and rs(r) and xdtFlag(r,i))..
   xdt(r,i,t)

*           National sourcing

      =e= ((alphadt(r,i,t)*(xat0(r,i)/xdt0(r,i))*(pat0(r,i)/pdt0(r,i))**sigmamt(r,i))
       *   xat(r,i,t)*(pat(r,i,t)/pdt(r,i,t))**sigmamt(r,i))$(ArmFlag eq 0 and xddFlag(r,i))

*           Agent sourcing

       +  (sum(aa, gammaedd(r,i,aa)*xd(r,i,aa,t)
       *    (xd0(r,i,aa)/xdt0(r,i))))$(ArmFlag and xddFlag(r,i))

*           Domestic supply of ITT services

       +   xtt(r,i,t)*(xtt0(r,i)/xdt0(r,i))
       ;

xmteq(r,i,t)$(ts(t) and rs(r) and xmtFlag(r,i) and not MRIO)..
   xmt(r,i,t)

*           National sourcing

      =e= ((alphamt(r,i,t)*(xat0(r,i)/xmt0(r,i))*(pat0(r,i)/pmt0(r,i))**sigmamt(r,i))
               *  xat(r,i,t)*(pat(r,i,t)/pmt(r,i,t))**sigmamt(r,i))$(ArmFlag eq 0)

*           Agent sourcing

      +   (sum(aa, gammaedm(r,i,aa)*xm(r,i,aa,t)*(xm0(r,i,aa)/xmt0(r,i))))$(ArmFlag)
      ;

paeq(r,i,aa,t)$(ts(t) and rs(r) and xaFlag(r,i,aa) and (ArmFlag or (ArmFlag eq 0 and not ifSUB)))..
   pa(r,i,aa,t)

*           National sourcing

      =e= ((1 + paTax(r,i,aa,t))*gammaeda(r,i,aa)*pat(r,i,t)*(pat0(r,i)/pa0(r,i,aa))
       +   sum(em, chiEmi(em,t)*emir(r,em,i,aa)*part(r,em,i,aa)*emiTax(r,em,t)/pa0(r,i,aa)))
       $(ArmFlag eq 0)

*           Agent sourcing

       + (((alphad(r,i,aa,t)*(pd0(r,i,aa)/pa0(r,i,aa))**(1-sigmam(r,i,aa)))
       *    PD_SUB(r,i,aa,t)**(1-sigmam(r,i,aa))
       +  (alpham(r,i,aa,t)*(pm0(r,i,aa)/pa0(r,i,aa))**(1-sigmam(r,i,aa)))
       *    PM_SUB(r,i,aa,t)**(1-sigmam(r,i,aa)))**(1/(1-sigmam(r,i,aa))))$ArmFlag
       ;

pa.lo(r,i,aa,t) = 0.001 ;

*  Top level -- Armington decomposition: agent sourcing

xdeq(r,i,aa,t)$(ts(t) and rs(r) and xdFlag(r,i,aa) and ArmFlag)..
   xd(r,i,aa,t) =e= (alphad(r,i,aa,t)
                 * (xa0(r,i,aa)/xd0(r,i,aa))*(pa0(r,i,aa)/pd0(r,i,aa))**sigmam(r,i,aa))
                 * xa(r,i,aa,t)*(pa(r,i,aa,t)/PD_SUB(r,i,aa,t))**sigmam(r,i,aa) ;

xmeq(r,i,aa,t)$(ts(t) and rs(r) and xmFlag(r,i,aa) and ArmFlag)..
   xm(r,i,aa,t) =e= (alpham(r,i,aa,t)
                 * (xa0(r,i,aa)/xm0(r,i,aa))*(pa0(r,i,aa)/pm0(r,i,aa))**sigmam(r,i,aa))
                 * xa(r,i,aa,t)*(pa(r,i,aa,t)/PM_SUB(r,i,aa,t))**sigmam(r,i,aa) ;

pdeq(r,i,aa,t)$(ts(t) and rs(r) and xdFlag(r,i,aa) and ArmFlag and not ifSUB)..
   pd(r,i,aa,t)
      =e= (1 + pdtax(r,i,aa,t))*gammaedd(r,i,aa)*pdt(r,i,t)*(pdt0(r,i)/pd0(r,i,aa))
       +  sum(em, chiEmi(em,t)*emird(r,em,i,aa)*part(r,em,i,aa)*emiTax(r,em,t)/pd0(r,i,aa)) ;

pd.lo(r,i,aa,t) = 0.001 ;

pmeq(r,i,aa,t)$(ts(t) and rs(r) and xmFlag(r,i,aa) and ArmFlag and not ifSUB)..
   pm(r,i,aa,t)
      =e= ((1 + pmtax(r,i,aa,t))*gammaedm(r,i,aa)
       *    ((pmt0(r,i)*pmt(r,i,t))$(not MRIO) + (pma0(r,i,aa)*pma(r,i,aa,t))$MRIO)/pm0(r,i,aa)
       +  sum(em, chiEmi(em,t)*emirm(r,em,i,aa)*part(r,em,i,aa)*emiTax(r,em,t)/pm0(r,i,aa)))
       ;

pm.lo(r,i,aa,t) = 0.001 ;

*  Second level Armington

xwaeq(s,i,r,aa,t)$(ts(t) and rs(r) and xwaFlag(s,i,r,aa) and MRIO)..
   xwa(s,i,r,aa,t) =e= ((alphawa(s,i,r,aa,t))
                    *   (xm0(r,i,aa)/xwa0(s,i,r,aa))
                    *   (pma0(r,i,aa)/pdma0(s,i,r,aa))**sigmawa(r,i,aa))
                    *   xm(r,i,aa,t)*(pma(r,i,aa,t)/PDMA_SUB(s,i,r,aa,t))**sigmawa(r,i,aa) ;

pmaeq(r,i,aa,t)$(ts(t) and rs(r) and xmFlag(r,i,aa) and MRIO)..
   xm(r,i,aa,t)*pma(r,i,aa,t) =e= sum(s$xwaFlag(s,i,r,aa),
         (pdma0(s,i,r,aa)*xwa0(s,i,r,aa))*PDMA_SUB(s,i,r,aa,t)*xwa(s,i,r,aa,t))
         / (xm0(r,i,aa)*pma0(r,i,aa)) ;

pma.lo(r,i,aa,t) = 0.001 ;

pdmaeq(s,i,r,aa,t)$(ts(t) and rs(r) and xwaFlag(s,i,r,aa) and MRIO and not ifSUB)..
   pdma(s,i,r,aa,t) =e= (1 + mtaxa(s,i,r,aa,t))*PWM_SUB(s,i,r,t)*(pwm0(s,i,r)/pdma0(s,i,r,aa)) ;

pdma.lo(s,i,r,aa,t) = 0.001 ;

$ontext
mtaxeq(s,i,d,t)$(ts(t) and rs(r) and xwFlag(s,i,d) and trqFlag(s,i,d))..
   mtax(s,i,d,t) =e= mtax_in(s,i,d,t) + mtax_pr(s,i,d,t) ;

xw_inqeq(s,i,d,t)$(ts(t) and rs(r) and xwFlag(s,i,d) and trqFlag(s,i,d))..
   xw_inq(s,i,d,t) =l= xw_quota(s,i,d,t) ;

mtax_pr.lo(s,i,d,t)$(ts(t) and rs(r) and xwFlag(s,i,d) and trqFlag(s,i,d)) = 0 ;

mtax_preq(s,i,d,t)$(ts(t) and rs(r) and xwFlag(s,i,d) and trqFlag(s,i,d))..
   mtax_out(s,i,d,t) =g= mtax_in(s,i,d,t) + mtax_pr(s,i,d,t) ;

xw_out.lo(s,i,d,t)$(ts(t) and rs(r) and xwFlag(s,i,d) and trqFlag(s,i,d)) = 0 ;

xw_outqeq(s,i,d,t)$(ts(t) and rs(r) and xwFlag(s,i,d) and trqFlag(s,i,d))..
   lambdaw(s,i,d,t)*xw(s,i,d,t) =e= xw_inq(s,i,d,t) + xw_outq(s,i,d,t) ;
$offtext

xwdeq(s,i,r,t)$(ts(t) and rs(r) and xwFlag(s,i,r))..
   xw(s,i,r,t) =e= (((alphaw(s,i,r,t)/lambdaw(s,i,r,t))
                 *   (xmt0(r,i)/xw0(s,i,r))*(pmt0(r,i)/pdm0(s,i,r))**sigmaw(r,i))
                 *   xmt(r,i,t)*(pmt(r,i,t)/PDM_SUB(s,i,r,t))**sigmaw(r,i))$(not MRIO)
                 +  (sum(aa, xwa(s,i,r,aa,t)*xwa0(s,i,r,aa)/(xw0(s,i,r)*lambdaw(s,i,r,t))))$MRIO
                 ;

pmteq(r,i,t)$(ts(t) and rs(r) and xmtFlag(r,i) and not MRIO)..
   pmt(r,i,t)**(1-sigmaw(r,i)) =e= sum(rp,
         (alphaw(rp,i,r,t)*(pdm0(rp,i,r)/pmt0(r,i))**(1-sigmaw(r,i)))
      *  PDM_SUB(rp,i,r,t)**(1-sigmaw(r,i))) ;

pmt.lo(r,i,t) = 0.001 ;

* --------------------------------------------------------------------------------------------------
*
*   DOMESTIC AND EXPORT SUPPLY BLOCK
*
* --------------------------------------------------------------------------------------------------

pdteq(r,i,t)$(ts(t) and rs(r) and xdtFlag(r,i))..
   0 =e=

*        Finite transformation

         (xdt(r,i,t) - (gammad(r,i,t)*(xs0(r,i)/xdt0(r,i))
      *     (pdt0(r,i)/ps0(r,i))**omegax(r,i))
      *     (gammaesd(r,i)**(-1-omegax(r,i)))
      *     xs(r,i,t)*(pdt(r,i,t)/ps(r,i,t))**omegax(r,i))$(omegax(r,i) ne inf)

*        Perfect transformation

      +  (pdt(r,i,t) - gammaesd(r,i)*ps(r,i,t)*(ps0(r,i)/pdt0(r,i)))$(omegax(r,i) eq inf) ;

pdt.lo(r,i,t) = 0.001 ;

xeteq(r,i,t)$(ts(t) and rs(r) and xetFlag(r,i))..
   0 =e=

*        Finite transformation

         (xet(r,i,t) - (gammae(r,i,t)*(xs0(r,i)/xet0(r,i))
      *     (pet0(r,i)/ps0(r,i))**omegax(r,i))
      *     (gammaese(r,i)**(-1-omegax(r,i)))
      *     xs(r,i,t)*(pet(r,i,t)/ps(r,i,t))**omegax(r,i))$(omegax(r,i) ne inf)

*        Perfect transformation

      +  (pet(r,i,t) - gammaese(r,i)*ps(r,i,t)*(ps0(r,i)/pet0(r,i)))$(omegax(r,i) eq inf) ;

* pet.lo(r,i,t) = 0.001 ;

xseq(r,i,t)$(ts(t) and rs(r) and xsFlag(r,i))..
   0 =e=

*        Finite transformation

         (ps(r,i,t)**(1+omegax(r,i))
      -     ((gammad(r,i,t)*(pdt0(r,i)/ps0(r,i))**(1+omegax(r,i)))
      *        (pdt(r,i,t)/gammaesd(r,i))**(1+omegax(r,i))
      +      (gammae(r,i,t)*(pet0(r,i)/ps0(r,i))**(1+omegax(r,i)))
      *        (pet(r,i,t)/gammaese(r,i))**(1+omegax(r,i))))$(omegax(r,i) ne inf)

*        Perfect transformation

      +  (xs(r,i,t) - (gammaesd(r,i)*xdt(r,i,t)*(xdt0(r,i)/xs0(r,i))
      +                gammaese(r,i)*xet(r,i,t)*(xet0(r,i)/xs0(r,i))))
      $(omegax(r,i) eq inf)
      ;

ps.lo(r,i,t) = 0.001 ;

xwseq(r,i,rp,t)$(ts(t) and rs(r) and xwFlag(r,i,rp)
               and (ifGbl or (not ifGbl and omegaw(r,i) ne inf)))..
   0 =e= (xw(r,i,rp,t) - (gammaw(r,i,rp,t)*(xet0(r,i)/xw0(r,i,rp))
      *   (pe0(r,i,rp)/pet0(r,i))**omegaw(r,i))
      *   (gammaew(r,i,rp)**(-1-omegaw(r,i)))
      *    xet(r,i,t)*(pe(r,i,rp,t)/pet(r,i,t))**omegaw(r,i))$(omegaw(r,i) ne inf)

      +  (pe(r,i,rp,t) - gammaew(r,i,rp)*pet(r,i,t)*(pet0(r,i)/pe0(r,i,rp)))$(omegaw(r,i) eq inf) ;

peteq(r,i,t)$(ts(t) and rs(r) and xetFlag(r,i))..
   0 =e= (xet(r,i,t) - sum(rp$xwFlag(r,i,rp), (xw0(r,i,rp)/xet0(r,i))*gammaew(r,i,rp)*xw(r,i,rp,t)))
      $(omegaw(r,i) eq inf)

      +  (pet(r,i,t)**(1+omegaw(r,i)) - (sum(rp$xwFlag(r,i,rp),
            (gammaw(r,i,rp,t)*(pe0(r,i,rp)/pet0(r,i))**(1+omegaw(r,i)))
      *     (pe(r,i,rp,t)/gammaew(r,i,rp))**(1+omegaw(r,i)))))
      $(omegaw(r,i) ne inf)
      ;

*  Other bilateral prices

pweeq(r,i,rp,t)$(ts(t) and rs(r) and xwFlag(r,i,rp) and not ifSUB)..
   pwe(r,i,rp,t) =e= (1 + etax(r,i,rp,t) + etaxi(r,i,t))*pe(r,i,rp,t)*(pe0(r,i,rp)/pwe0(r,i,rp)) ;

pwmeq(r,i,rp,t)$(ts(t) and rs(r) and xwFlag(r,i,rp) and not ifSUB)..
   pwm(r,i,rp,t) =e=
      pwe(r,i,rp,t)*(pwe0(r,i,rp)/(lambdaw(r,i,rp,t)*pwm0(r,i,rp)))
   +  tmarg(r,i,rp,t)*PWMG_SUB(r,i,rp,t)/(lambdaw(r,i,rp,t)*pwm0(r,i,rp)) ;

pdmeq(r,i,rp,t)$(ts(t) and rs(r) and xwFlag(r,i,rp) and not ifSUB and not MRIO)..
   pdm(r,i,rp,t) =e= (1 + mtax(r,i,rp,t) + ntmAVE(r,i,rp,t))*pwm(r,i,rp,t)*(pwm0(r,i,rp)/pdm0(r,i,rp)) ;

pe.lo(r,i,rp,t) = 0.001 ;

* --------------------------------------------------------------------------------------------------
*
*   TRADE MARGINS BLOCK
*
* --------------------------------------------------------------------------------------------------

*  Total demand for TT services from r to rp for good i

xwmgeq(r,i,rp,t)$(ts(t) and rs(r) and tmgFlag(r,i,rp) and not ifSUB)..
   xwmg(r,i,rp,t) =e= tmarg(r,i,rp,t)*xw(r,i,rp,t)*(xw0(r,i,rp)/xwmg0(r,i,rp)) ;

*  Demand for TT services using m from r to rp for good i

xmgmeq(img,r,i,rp,t)$(ts(t) and rs(r) and amgm(img,r,i,rp) ne 0 and not ifSUB)..
   xmgm(img,r,i,rp,t) =e= amgm(img,r,i,rp)*xwmg(r,i,rp,t)
                       *   (xwmg0(r,i,rp)/(lambdamg(img,r,i,rp,t)*xmgm0(img,r,i,rp))) ;

*  The aggregate price of transporting i between r and rp
*  Note--the price per transport mode is uniform globally

pwmgeq(r,i,rp,t)$(ts(t) and rs(r) and tmgFlag(r,i,rp) and not ifSUB)..
   pwmg(r,i,rp,t) =e= sum(img, amgm(img,r,i,rp)*ptmg(img,t)
                   *    (ptmg0(img)/(lambdamg(img,r,i,rp,t)*pwmg0(r,i,rp)))) ;

*  Global demand for TT services of type m

xtmgeq(img,t)$(ts(t))..
   xtmg(img,t) =e= sum((r,i,rp)$xmgm0(img,r,i,rp),
      XMGM_SUB(img,r,i,rp,t)*(xmgm0(img,r,i,rp)/xtmg0(img))) ;

*  Allocation across regions

xtteq(r,img,t)$(ts(t) and rs(r) and xttFlag(r,img) ne 0)..
   xtt(r,img,t) =e= (alphatt(r,img,t)*(xtmg0(img)/xtt0(r,img))
                 *      (ptmg0(img)/pdt0(r,img))**sigmamg(img))
                 *   xtmg(img,t)*(ptmg(img,t)/pdt(r,img,t))**sigmamg(img) ;

*  The average global price of mode m

ptmgeq(img,t)$(ts(t))..
   ptmg(img,t)*xtmg(img,t) =e= sum(r, pdt(r,img,t)*xtt(r,img,t)
                            * (pdt0(r,img)*xtt0(r,img)/(ptmg0(img)*xtmg0(img)))) ;

* --------------------------------------------------------------------------------------------------
*
*   FACTOR MARKETS
*
* --------------------------------------------------------------------------------------------------

*  Labor market

*  Labor demand by zone

ldzeq(r,l,z,t)$(ts(t) and rs(r) and lsFlag(r,l,z))..
   ldz(r,l,z,t) =e= sum(a$mapz(z,a), (xf(r,l,a,t)*(xf0(r,l,a)/ldz0(r,l,z)))) ;

*  Reservation wage -- depends on GDP growth, unemployment rate and CPI

resWageeq(r,l,z,t)$(ts(t) and rs(r) and ueFlag(r,l,z))..
$iftheni "%simType%" == "compStat"
   resWage(r,l,z,t) =e= sum(t0, (chirw(r,l,z,t)/resWage0(r,l,z))
                     *  ((1+0.01*grrgdppc(r,t))**omegarwg(r,l,z))
*                    *  ((uez(r,l,z,t)/uez(r,l,z,t-1))**omegarwue(r,l,z))
                     *  (((1-uez(r,l,z,t))/(1-uez(r,l,z,t0)))**omegarwue(r,l,z))
                     *  (sum(h, pfd(r,h,t)/pfd(r,h,t0))**omegarwp(r,l,z)))
$else
   resWage(r,l,z,t) =e= (chirw(r,l,z,t)/resWage0(r,l,z))
                     *  ((1+0.01*grrgdppc(r,t))**omegarwg(r,l,z))
*                    *  ((uez(r,l,z,t)/uez(r,l,z,t-1))**omegarwue(r,l,z))
                     *  (((1-uez(r,l,z,t))/(1-uez(r,l,z,t-1)))**omegarwue(r,l,z))
                     *  (sum(h, pfd(r,h,t)/pfd(r,h,t-1))**omegarwp(r,l,z))
$endif
                     ;

*  Equilibrium wage in each zone -- MCP with lower limit on UE

ewagezeq(r,l,z,t)$(ts(t) and rs(r) and ueFlag(r,l,z))..
   ewagez(r,l,z,t) =g= resWage(r,l,z,t)*(resWage0(r,l,z)/ewagez0(r,l,z)) ;

*  'Equilibrium condition' -- also defines UE

uezeq(r,l,z,t)$(ts(t) and rs(r) and lsFlag(r,l,z))..
   uez(r,l,z,t) =e= 1 - (ldz(r,l,z,t)/lsz(r,l,z,t))*(ldz0(r,l,z)/lsz0(r,l,z)) ;

*  Definition of sectoral wage net of tax

wageeq(r,l,a,t)$(ts(t) and rs(r) and xfFlag(r,l,a))..
   pf(r,l,a,t) =e= sum(z$(mapz(z,a) and lsFlag(r,l,z)),
      wPrem(r,l,a,t)*ewagez(r,l,z,t)*(ewagez0(r,l,z)/pf0(r,l,a))) ;

pf.lo(r,f,a,t) = 0.001 ;

*  Average wage in each zone

awagezeq(r,l,z,t)$(ts(t) and rs(r) and lsFlag(r,l,z))..
   awagez(r,l,z,t) =e= sum(a$mapz(z,a), pf(r,l,a,t)*xf(r,l,a,t)
                    *      (pf0(r,l,a)*xf0(r,l,a)/awagez0(r,l,z)))
                    /  sum(a$mapz(z,a), (xf0(r,l,a)*xf(r,l,a,t))) ;

*  Expected urban premium

urbPremeq(r,l,t)$(ts(t) and rs(r) and tLabFlag(r,l) and (omegam(r,l) ne inf))..
   urbPrem(r,l,t)*sum(rur, (1-uez(r,l,rur,t))*awagez(r,l,rur,t)*(urbprem0(r,l)*awagez0(r,l,rur)))
      =e= sum(urb, (1-uez(r,l,urb,t))*awagez(r,l,urb,t)*awagez0(r,l,urb)) ;

*  Average economy-wide wage per skill (should equal awagez with no segmentation)

twageeq(r,l,t)$(ts(t) and rs(r) and tlabFlag(r,l))..
   twage(r,l,t) =e= sum(a, pf(r,l,a,t)*xf(r,l,a,t)*(pf0(r,l,a)*xf0(r,l,a)/twage0(r,l)))
                 /  sum(a, (xf0(r,l,a)*xf(r,l,a,t))) ;

*  Definition of skill premium relative to 'skill' bundle

skillpremeq(r,l,t)$(ts(t) and rs(r) and tlabFlag(r,l))..
   (1 + skillprem(r,l,t))*twage(r,l,t)
      =e= sum(lr, twage(r,lr,t)*ls(r,lr,t)*((twage0(r,lr)*ls0(r,lr))/twage0(r,l)))
       /  sum(lr, ls(r,lr,t)*ls0(r,lr)) ;

*  Definition of aggregate labor supply by skill

lseq(r,l,t)$(ts(t) and rs(r) and tlabFlag(r,l))..
   ls(r,l,t) =e= sum(z$lsFlag(r,l,z), lsz(r,l,z,t)*lsz0(r,l,z)/ls0(r,l)) ;

*  Definition of aggregate labor supply

tlseq(r,t)$(ts(t) and rs(r))..
   tls(r,t) =e= sum(l, ls(r,l,t)*(ls0(r,l)/tls0(r))) ;

*  Capital market

pkeq(r,a,v,t)$(ts(t) and rs(r) and kflag(r,a))..
   0 =e= (kv(r,a,v,t) - (gammak(r,a,v,t)*(tkaps0(r)/kv0(r,a))*(pk0(r,a)/trent0(r))**omegak(r))
      *        tkaps(r,t)*(pk(r,a,v,t)/trent(r,t))**omegak(r))$((not ifVint) and omegak(r) ne inf)

      +  (pk(r,a,v,t) - trent(r,t)*(trent0(r)/pk0(r,a)))$((not ifVint) and omegak(r) eq inf)

      +  (pk(r,a,v,t) - rrat(r,a,t)*trent(r,t)*(trent0(r)/pk0(r,a)))$ifVint
      ;

pk.lo(r,a,v,t) = 0.001 ;

trenteq(r,t)$(ts(t) and rs(r))..
   tkaps(r,t) =e= (sum((a,v), pk(r,a,v,t)*kv(r,a,v,t)
               *     (pk0(r,a)*kv0(r,a)/(trent0(r)*tkaps0(r))))/trent(r,t))$(not ifVint)

               +  (sum((a,v), kv(r,a,v,t)*(kv0(r,a)/tkaps0(r))))$(ifVint) ;

*  Capital market -- dynamics

kxRateq(r,a,vOld,t)$(ts(t) and rs(r) and ifVint and kFlag(r,a))..
   kxRat(r,a,vOld,t) =e= (kv(r,a,vOld,t)/xpv(r,a,vOld,t))
                      *  (kv0(r,a)/(kxRat0(r,a)*xpv0(r,a))) ;

rrateq(r,a,t)$(ts(t) and rs(r) and ifVint and kflag(r,a))..
   rrat(r,a,t)**invElas(r,a) =l= sum(vOld, kxrat(r,a,vOld,t))*xp(r,a,t)
                                        *  (kxRat0(r,a)*xp0(r,a)/(k00(r,a)*k0(r,a,t))) ;

rrat.up(r,a,t) = 1 ;

k0eq(r,a,t)$(ts(t) and ifVint and kFlag(r,a))..
   k0(r,a,t) =e= sum(v, (kv0(r,a)/k00(r,a))*kv(r,a,v,t-1))*power(1-depr(r,t-1), gap(t)) ;

*  Vintage output allocation

xpveq(r,a,v,t)$(ts(t) and rs(r) and xpFlag(r,a))..

*     The first condition is only used for the vintage model

   0 =e= (xpv(r,a,v,t)*kxrat(r,a,v,t)
      -     (rrat(r,a,t)**invElas(r,a))*(k0(r,a,t)*k00(r,a)/(xpv0(r,a)*kxRat0(r,a))))
      $(vOld(v) and ifVint)

*     The following condition is good for CS and Vintage

      +  (xp(r,a,t) - sum(vp, xpv(r,a,vp,t)*(xpv0(r,a)/xp0(r,a))))
      $vNew(v) ;

xpv.lo(r,a,vOld,t) = 0.001 ;

*  Capital aggregation

capeq(r,cap,a,t)$(ts(t) and rs(r) and xfFlag(r,cap,a))..
   xf(r,cap,a,t) =e= sum(v, (kv0(r,a)/xf0(r,cap,a))*kv(r,a,v,t)) ;

pcapeq(r,cap,a,t)$(ts(t) and rs(r) and xfFlag(r,cap,a))..
   pf(r,cap,a,t) =e= sum(vOld, (pk0(r,a)/pf0(r,cap,a))*pk(r,a,vOld,t)) ;

arenteq(r,t)$(ts(t) and rs(r))..
   arent(r,t) =e= sum((a,v,t0), pk(r,a,v,t)*kv(r,a,v,t0)*(pk0(r,a)*kv0(r,a)))
               /  sum((a,v,t0), pk(r,a,v,t0)*kv(r,a,v,t0)*(pk0(r,a)*kv0(r,a))) ;

*  Land markets

*  Land supply

tlandeq(r,t)$(ts(t) and rs(r) and tlandFlag(r))..
   0 =e= (tland(r,t) - (chiLand(r,t)/tland0(r))
      *     ((ptland(r,t)/pgdpmp(r,t))*(ptland0(r)/pgdpmp0(r)))**etat(r))
      $(%TASS% eq KELAS)

      +  (tland(r,t) - ((LandMax(r,t)/tland0(r))
      /     (1 + chiLand(r,t)
      *        exp(-gammatl(r,t)*(ptland(r,t)/pgdpmp(r,t))*(ptland0(r)/pgdpmp0(r))))))
      $(%TASS% eq LOGIST)

      +  (tland(r,t) - ((LandMax(r,t)/tland0(r)) - (chiLand(r,t)/tland0(r))
      *     (ptland(r,t)/pgdpmp(r,t))*(ptland0(r)/pgdpmp0(r))**(-gammatl(r,t))))
      $(%TASS% eq HYPERB)

      +  (ptland(r,t) - pgdpmp(r,t)*(pgdpmp0(r)/ptland0(r)))$(%TASS% eq INFTY)
      ;

$ontext


                     TLAND
                      / \
                     /   \
                    /     \
                   /       \
                 LB(1)    NLB
                          /|\
                         / | \
                        /  |  \
                       /   |   \
                    LB(2) LB(3) LB(4)

                       Land by activity


$offtext

*  Top level nest

xlb1eq(r,lb,t)$(ts(t) and rs(r) and lb1(lb) and gamlb(r,lb,t) ne 0)..
   0 =e= (plb(r,lb,t) - ptland0(r)*(ptland(r,t)/plb0(r,lb)))$(omegat(r) eq inf)

      +  (xlb(r,lb,t) - (gamlb(r,lb,t)*(tland0(r)/xlb0(r,lb))*(plb0(r,lb)/ptlandndx0(r))**omegat(r))
      *     tland(r,t)*(plb(r,lb,t)/ptlandndx(r,t))**omegat(r))$(omegat(r) ne inf)
      ;

xnlbeq(r,t)$(ts(t) and rs(r) and gamnlb(r,t) ne 0)..
   0 =e= (pnlb(r,t) - ptland(r,t)*(ptland0(r)/pnlb0(r)))$(omegat(r) eq inf)

      +  (xnlb(r,t) - (gamnlb(r,t)*(tland0(r)/xnlb0(r))*(pnlb0(r)/ptlandndx0(r))**omegat(r))
      *     tland(r,t)*(pnlb(r,t)/ptlandndx(r,t))**omegat(r))$(omegat(r) ne inf)
      ;

ptlandndxeq(r,t)$(ts(t) and rs(r) and tlandFlag(r) and omegat(r) ne inf)..
   0 =e= (ptlandndx(r,t)**(1+omegat(r)) - (sum(lb1,
            (gamlb(r,lb1,t)*(plb0(r,lb1)/ptlandndx0(r))**(1+omegat(r)))
      *        plb(r,lb1,t)**(1+omegat(r)))
      +     (gamnlb(r,t)*(pnlb0(r)/ptlandndx0(r))**(1+omegat(r)))
      *        pnlb(r,t)**(1+omegat(r))))
      $(ifLandCET)

      +  (ptlandndx(r,t)**omegat(r) - (sum(lb1,
            (gamlb(r,lb1,t)*(plb0(r,lb1)/ptlandndx0(r))**omegat(r))*plb(r,lb1,t)**omegat(r))
      +      (gamnlb(r,t)*(pnlb0(r)/ptlandndx0(r))**omegat(r))*pnlb(r,t)**omegat(r)))
      $(not ifLandCET)
      ;

ptlandeq(r,t)$(ts(t) and rs(r) and tlandFlag(r))..
   ptland(r,t)*tland(r,t) =e=
         sum(lb1, plb(r,lb1,t)*xlb(r,lb1,t)*(plb0(r,lb1)*xlb0(r,lb1)/(ptland0(r)*tland0(r))))
      +  pnlb(r,t)*xnlb(r,t)*(pnlb0(r)*xnlb0(r)/(ptland0(r)*tland0(r))) ;

ptland.lo(r,t) = 0.001 ;

*  Second level nest

xlbneq(r,lb,t)$(ts(t) and rs(r) and (not lb1(lb)) and gamlb(r,lb,t) ne 0)..
   0 =e= (plb(r,lb,t) - pnlb(r,t)*(pnlb0(r)/plb0(r,lb)))$(omeganlb(r) eq inf)

      +  (xlb(r,lb,t) - (gamlb(r,lb,t)*(xnlb0(r)/xlb0(r,lb))*(plb0(r,lb)/pnlbndx0(r))**omeganlb(r))
      *     xnlb(r,t)*(plb(r,lb,t)/pnlbndx(r,t))**omeganlb(r))$(omeganlb(r) ne inf)
      ;

pnlbndxeq(r,t)$(ts(t) and rs(r) and gamnlb(r,t) ne 0 and omeganlb(r) ne inf)..
   0 =e= (pnlbndx(r,t)**(1+omeganlb(r))
      -     (sum(lb$(not lb1(lb)), (gamlb(r,lb,t)*(plb0(r,lb)/pnlbndx0(r))**(1+omeganlb(r)))
      *      plb(r,lb,t)**(1+omeganlb(r)))))$(ifLandCET)

      +  (pnlbndx(r,t)**omeganlb(r)
      -     (sum(lb$(not lb1(lb)), (gamlb(r,lb,t)*(plb0(r,lb)/pnlbndx0(r))**omeganlb(r))
      *      plb(r,lb,t)**omeganlb(r))))$(not ifLandCET)
      ;

pnlbndx.lo(r,t) = 0.001 ;

pnlbeq(r,t)$(ts(t) and rs(r) and gamnlb(r,t) ne 0)..
   pnlb(r,t)*xnlb(r,t) =e=  sum(lb$(not lb1(lb)), plb(r,lb,t)*xlb(r,lb,t)
                        *     ((plb0(r,lb)*xlb0(r,lb))/(pnlb0(r)*xnlb0(r)))) ;

*  Bottom nests

plandeq(r,lnd,a,t)$(ts(t) and rs(r) and xfFlag(r,lnd,a))..
   0 =e= sum(lb$maplb(lb,a),
            (pf(r,lnd,a,t) - plb(r,lb,t)*(plb0(r,lb)/pf0(r,lnd,a)))$(omegalb(r,lb) eq inf)

         +  (xf(r,lnd,a,t) - (gammat(r,a,t)
         *     (xlb0(r,lb)/xf0(r,lnd,a))*(pf0(r,lnd,a)/plbndx0(r,lb))**omegalb(r,lb))
         *      xlb(r,lb,t)*(pf(r,lnd,a,t)/plbndx(r,lb,t))**omegalb(r,lb))$(omegalb(r,lb) ne inf)
      ) ;

pfp.lo(r,f,a,t) = 0.001 ;

plbndxeq(r,lb,t)$(ts(t) and rs(r) and gamlb(r,lb,t) ne 0 and omegalb(r,lb) ne inf)..
   0 =e= (plbndx(r,lb,t)**(1+omegalb(r,lb))
      -     (sum((lnd,a)$maplb(lb,a),
               (gammat(r,a,t)*(pf0(r,lnd,a)/plbndx0(r,lb))**(1+omegalb(r,lb)))
      *        pf(r,lnd,a,t)**(1+omegalb(r,lb)))))$(ifLandCET)

      +  (plbndx(r,lb,t)**omegalb(r,lb)
      -     (sum((lnd,a)$maplb(lb,a), (gammat(r,a,t)*(pf0(r,lnd,a)/plbndx0(r,lb))**omegalb(r,lb))
      *        pf(r,lnd,a,t)**omegalb(r,lb))))$(not ifLandCET)
      ;

plbndx.lo(r,lb,t) = 0.001 ;

plbeq(r,lb,t)$(ts(t) and rs(r) and gamlb(r,lb,t) ne 0)..
   plb(r,lb,t)*xlb(r,lb,t) =e= sum((lnd,a)$maplb(lb,a), pf(r,lnd,a,t)*xf(r,lnd,a,t)
                            *    (pf0(r,lnd,a)*xf0(r,lnd,a)/(plb0(r,lb)*xlb0(r,lb)))) ;

plb.lo(r,lb,t) = 0.001 ;

*  Market for natural resources

etanrseq(r,a,t)$(xnrsFlag(r,a) ne 0 and xnrsFlag(r,a) ne inf and ts(t) and rs(r))..
$iftheni "%simType%" == "compStat"
   etanrs(r,a,t) =e= sum(t0, etanrsx(r,a,"lo") + (etanrsx(r,a,"hi") - etanrsx(r,a,"lo"))
                  *  sigmoid(kink*(sum(nrs, xf(r,nrs,a,t)/xf(r,nrs,a,t0))-1))) ;
$else
   etanrs(r,a,t) =e= etanrsx(r,a,"lo") + (etanrsx(r,a,"hi") - etanrsx(r,a,"lo"))
                  *  sigmoid(kink*(sum(nrs, xf(r,nrs,a,t)/xf(r,nrs,a,t-1))-1)) ;
$endif

xnrsseq(r,nrs,a,t)$(ts(t) and rs(r) and xfFlag(r,nrs,a))..
$iftheni "%simType%" == "compStat"
   0 =e= (xf(r,nrs,a,t) - sum(t0, wchinrs(a,t)*(xf(r,nrs,a,t0)*chinrs(r,a,t))
      *     (chinrsp(r,a)*(pf(r,nrs,a,t)/pgdpmp(r,t))
      /                   (pf(r,nrs,a,t0)/pgdpmp(r,t0)))**etanrs(r,a,t)))
      $(xfFlag(r,nrs,a) ne inf)

      +  (chinrsp(r,a)*pf(r,nrs,a,t) - pgdpmp(r,t)*(pgdpmp0(r)/pf0(r,nrs,a)))
      $(xfFlag(r,nrs,a) eq inf) ;
$else
   0 =e= (xf(r,nrs,a,t) - wchinrs(a,t)*(xf(r,nrs,a,t-1)*chinrs(r,a,t))
      *     (chinrsp(r,a)*(pf(r,nrs,a,t)/pgdpmp(r,t))
      /                   (pf(r,nrs,a,t-1)/pgdpmp(r,t-1)))**etanrs(r,a,t))
      $(xfFlag(r,nrs,a) ne inf)

      +  (chinrsp(r,a)*pf(r,nrs,a,t) - pgdpmp(r,t)*(pgdpmp0(r)/pf0(r,nrs,a)))
      $(xfFlag(r,nrs,a) eq inf) ;
$endif

*  Market for water

$ontext


                     TH2OM = TH2O - ENV - GRD
                     /   \
                    /     \
                   /       \
                  /         \
               AGR           NAG
              /   \         /   \
             /     \       /     \
            /       \     /       \
          CRP       LVS  IND     MUN
         / | \
        /  |  \
       /   |   \
      Water demand
   by irrigated crops

$offtext

*  Total water supply

th2oeq(r,t)$(ts(t) and rs(r) and th2oFlag(r))..
   0 =e= (th2o(r,t) - (chih2o(r,t)/th2o0(r))*((pth2o(r,t)/pgdpmp(r,t))
      *                                       (pth2o0(r)/pgdpmp0(r)))**etaw(r))
      $(%WASS% eq KELAS)

      +  (th2o(r,t) - ((H2OMax(r,t)/th2o0(r))
      /     (1 + chih2o(r,t)*exp(-gammatw(r,t)*((pth2o(r,t)/pgdpmp(r,t))*(pth2o0(r)/pgdpmp0(r)))))))
      $(%WASS% eq LOGIST)

      +  (th2o(r,t) - ((H2OMax(r,t)/th2o0(r)) - (chih2o(r,t)/th2o0(r))
      *  ((pth2o(r,t)/pgdpmp(r,t))*(pth2o0(r)/pgdpmp0(r)))**(-gammatw(r,t))))
      $(%WASS% eq HYPERB)

      +  (pth2o(r,t) - pgdpmp(r,t)*(pgdpmp0(r)/pth2o0(r)))
      $(%WASS% eq INFTY)
      ;

*  Marketed water is equal to total water less exogenous demand

th2omeq(r,t)$(ts(t) and rs(r) and th2oFlag(r))..
   th2o(r,t) =e= th2om(r,t)*th2om0(r)/th2o0(r)
              +   sum(wbndEx, h2obnd(r,wbndEx,t)*h2obnd0(r,wbndEx)/th2o0(r)) ;

*  Demand for marketed water bundles -- both top level (wbnd1) and bottom level (wbnd2)

h2obndeq(r,wbnd,t)$(ts(t) and rs(r) and h2obndFlag(r,wbnd))..

*  Top level bundle

   0 =e= (h2obnd(r,wbnd,t) - (gam1h2o(r,wbnd,t)*(th2om0(r)/h2obnd0(r,wbnd))
      *     (ph2obnd0(r,wbnd)/pth2ondx0(r))**omegaw1(r))
      *     th2om(r,t)*(ph2obnd(r,wbnd,t)/pth2ondx(r,t))**omegaw1(r))
      $(wbnd1(wbnd) and omegaw1(r) ne inf)

      +  (ph2obnd(r,wbnd,t) - pth2o(r,t)*(pth2o0(r)/ph2obnd0(r,wbnd)))
      $(wbnd1(wbnd) and omegaw1(r) eq inf)

*  Second level bundle

      +  (sum(wbnd1$mapw1(wbnd1, wbnd),
            (h2obnd(r,wbnd,t)  - (gam2h2o(r,wbnd,t)*(h2obnd0(r,wbnd1)/h2obnd0(r,wbnd))
      *        (ph2obnd0(r,wbnd)/ph2obndndx0(r,wbnd1))**omegaw2(r,wbnd1))
      *        h2obnd(r,wbnd1,t)*(ph2obnd(r,wbnd,t)/ph2obndndx(r,wbnd1,t))**omegaw2(r,wbnd1))
      $(omegaw2(r,wbnd1) ne inf)

      +     (ph2obnd(r,wbnd,t) - ph2obnd(r,wbnd1,t)*(ph2obnd0(r,wbnd1)/ph2obnd0(r,wbnd)))
      $(omegaw2(r,wbnd1) eq inf)))$wbnd2(wbnd)
      ;

pth2ondxeq(r,t)$(ts(t) and rs(r) and th2oFlag(r) and omegaw1(r) ne inf)..
   0 =e= (pth2ondx(r,t)**omegaw1(r)
      -     sum(wbnd1, (gam1h2o(r,wbnd1,t)*(ph2obnd0(r,wbnd1)/pth2ondx0(r))**omegaw1(r))
      *        ph2obnd(r,wbnd1,t)**omegaw1(r))) ;

pth2oeq(r,t)$(ts(t) and rs(r) and th2oFlag(r))..
   pth2o(r,t)*th2om(r,t) =e= sum(wbnd1, ph2obnd(r,wbnd1,t)*h2obnd(r,wbnd1,t)
                          *   ((ph2obnd0(r,wbnd1)*h2obnd0(r,wbnd1))/(pth2o0(r)*th2om0(r)))) ;

*  Price index of 2nd and 3rd level bundles -- resp. wbnd1 and wbnda

ph2obndndxeq(r,wbnd,t)$(ts(t) and rs(r) and h2obndFlag(r,wbnd))..
   0 =e= (ph2obndndx(r,wbnd,t)**omegaw2(r,wbnd) - sum(wbnd2$mapw1(wbnd,wbnd2),
            (gam2h2o(r,wbnd2,t)*(ph2obnd0(r,wbnd2)/ph2obndndx0(r,wbnd))**omegaw2(r,wbnd))
      *     ph2obnd(r,wbnd2,t)**omegaw2(r,wbnd)))$(wbnd1(wbnd) and omegaw2(r,wbnd) ne inf)

      +  (ph2obndndx(r,wbnd,t)**omegaw2(r,wbnd) - sum((wat,a)$mapw2(wbnd,a),
            (gam3h2o(r,a,t)*(pf0(r,wat,a)/ph2obndndx0(r,wbnd))**omegaw2(r,wbnd))
      *     pf(r,wat,a,t)**omegaw2(r,wbnd)))$(wbnda(wbnd) and omegaw2(r,wbnd) ne inf)
      ;

*  Price of 2nd and 3rd level bundles:
*     Second level (wbnd1)
*     Third level when mapped to activities (wbnda)
*     Third level when mapped to aggregate sectoral output (wbndi)

ph2obndeq(r,wbnd,t)$(ts(t) and rs(r) and h2obndFlag(r,wbnd))..

*  Top level bundle price

   0 =e= (ph2obnd(r,wbnd,t)*h2obnd(r,wbnd,t)
      -     sum(wbnd2$mapw1(wbnd,wbnd2), ph2obnd(r,wbnd2,t)*h2obnd(r,wbnd2,t)
      *        ((ph2obnd0(r,wbnd2)*h2obnd0(r,wbnd2))/(ph2obnd0(r,wbnd)*h2obnd0(r,wbnd)))))
      $wbnd1(wbnd)

*  Second level bundle price (when bundle is mapped to activities)

      +  (ph2obnd(r,wbnd,t)*h2obnd(r,wbnd,t)
      -     sum((wat,a)$mapw2(wbnd,a), pf(r,wat,a,t)*xf(r,wat,a,t)
      *        ((pf0(r,wat,a)*xf0(r,wat,a))/(ph2obnd0(r,wbnd)*h2obnd0(r,wbnd)))))
      $(wbnda(wbnd))

*  Second level bundle price (when bundle is mapped to an output index)

      +  (h2obnd(r,wbnd,t) - (ah2obnd(r,wbnd,t)/(lambdah2obnd(r,wbnd,t)*h2obnd0(r,wbnd)))
      *   (((ph2obnd(r,wbnd,t)/pgdpmp(r,t))*(ph2obnd0(r,wbnd)/pgdpmp0(r)))**(-epsh2obnd(r,wbnd)))
      *   (sum((a,t0)$mapw2(wbnd,a), px(r,a,t0)*xp(r,a,t)*(px0(r,a)*xp0(r,a)))
      /    sum((a,t0)$mapw2(wbnd,a), px(r,a,t0)*xp(r,a,t0)*(px0(r,a)*xp0(r,a))))
      **etah2obnd(r,wbnd))
      $(wbndi(wbnd))
      ;

*  Third level bundle -- agriculture only

ph2oeq(r,wat,a,t)$(ts(t) and rs(r) and xfFlag(r,wat,a))..
   0 =e= sum(wbnd2$(wbnda(wbnd2) and mapw2(wbnd2,a)),
            (xf(r,wat,a,t) - (gam3h2o(r,a,t)*(h2obnd0(r,wbnd2)/xf0(r,wat,a))
      *        (pf0(r,wat,a)/ph2obndndx0(r,wbnd2))**omegaw2(r,wbnd2))
      *        h2obnd(r,wbnd2,t)*(pf(r,wat,a,t)/ph2obndndx(r,wbnd2,t))**omegaw2(r,wbnd2))
      $(omegaw2(r,wbnd2) ne inf)

      -     (pf(r,wat,a,t) - ph2obnd(r,wbnd2,t)*(pf0(r,wat,a)/ph2obnd0(r,wbnd2)))
      $(omegaw2(r,wbnd2) eq inf)) ;

*  Producer prices

pfpeq(r,f,a,t)$(ts(t) and rs(r) and xfFlag(r,f,a) and not ifSUB)..
   pfp(r,f,a,t) =e= (1 + pfTax(r,f,a,t))*pf(r,f,a,t)*(pf0(r,f,a)/pfp0(r,f,a)) ;

pkpeq(r,a,v,t)$(ts(t) and rs(r) and kFlag(r,a))..
   pkp(r,a,v,t) =e= (1 + sum(cap, pfTax(r,cap,a,t)))*pk(r,a,v,t)*(pk0(r,a)/pkp0(r,a)) ;

pkp.lo(r,a,v,t) = 0.001 ;

* --------------------------------------------------------------------------------------------------
*
*   GDP definitions
*
* --------------------------------------------------------------------------------------------------

$macro mQGDP(r,tp,tq) (sum((fd,i), (pa0(r,i,fd)*xa0(r,i,fd))*PA_SUB(r,i,fd,tp)*xa(r,i,fd,tq)) \
      + sum((i,d)$xwFlag(r,i,d), (pwe0(r,i,d)*xw0(r,i,d))*PWE_SUB(r,i,d,tp)*xw(r,i,d,tq)) \
      - sum((i,s)$xwFlag(s,i,r), (pwm0(s,i,r)*xw0(s,i,r))*PWM_SUB(s,i,r,tp)*lambdaw(s,i,r,tq)*xw(s,i,r,tq)) \
      + sum(img, (pdt0(r,img)*xtt0(r,img))*pdt(r,img,tp)*xtt(r,img,tq)))

gdpmpeq(r,t)$(ts(t) and rs(r))..
   gdpmp(r,t) =e= mQGDP(r,t,t)/gdpmp0(r) ;

pgdpmpeq(r,t)$(ts(t) and rs(r))..
$iftheni "%simType%" == "compStat"
   pgdpmp(r,t) =e= sum(t0, pgdpmp(r,t0)*sqrt((mQGDP(r,t,t0)/gdpmp(r,t0))*(gdpmp(r,t)/mQGDP(r,t0,t)))) ;
$else
   pgdpmp(r,t) =e= pgdpmp(r,t-1)*sqrt((mQGDP(r,t,t-1)/gdpmp(r,t-1))*(gdpmp(r,t)/mQGDP(r,t-1,t))) ;
$endif

rgdpmpeq(r,t)$(ts(t) and rs(r))..
   rgdpmp(r,t) =e= (gdpmp(r,t)/pgdpmp(r,t))*(gdpmp0(r)/(pgdpmp0(r)*rgdpmp0(r))) ;

rgdppceq(r,t)$(ts(t) and rs(r))..
   rgdppc(r,t) =e= (rgdpmp(r,t)/pop(r,t))*(rgdpmp0(r)/(pop0(r)*rgdppc0(r))) ;

grrgdppceq(r,t)$(ts(t) and rs(r))..
$iftheni "%simType%" == "compStat"
   rgdppc(r,t) =e= power(1 + 0.01*grrgdppc(r,t), gap(t))*sum(t0, rgdppc(r,t0)) ;
$else
   rgdppc(r,t) =e= power(1 + 0.01*grrgdppc(r,t), gap(t))*rgdppc(r,t-1) ;
$endif

klrateq(r,t)$(ts(t) and rs(r))..
   klrat(r,t) =e= sum((a,v), (pk0(r,a)*kv0(r,a)/klrat0(r))*lambdak(r,a,v,t)*kv(r,a,v,t))
               /  sum((a,l), (pf0(r,l,a)*xf0(r,l,a))*lambdaf(r,l,a,t)*xf(r,l,a,t)) ;

* --------------------------------------------------------------------------------------------------
*
*   MODEL CLOSURE
*
* --------------------------------------------------------------------------------------------------

savgeq(r,t)$(ts(t) and rs(r))..
   savg(r,t) =e= sum(gy, ygov0(r,gy)*ygov(r,gy,t)) + sum(em,emiQuotaY(r,em,t))
              +  ntmY0(r)*ntmY(r,t)*(1 - sum(s$(not sameas(s,r)), chigNTM(s,r,t)) - sum(s, chihNTM(s,r,t)))
              +  sum(s$(not sameas(s,r)), chigNTM(s,r,t)*ntmY0(s)*ntmY(s,t))
              +  ODAIn0(r)*ODAIn(r,t) - ODAOut0(r)*ODAOut(r,t)
              -  sum(gov, yfd0(r,gov)*yfd(r,gov,t)) ;

rsgeq(r,t)$(ts(t) and rs(r))..
   rsg(r,t)*pgdpmp(r,t)*pgdpmp0(r) =e= savg(r,t) ;

rgovshreq(r,t)$(ts(t) and rs(r))..
   rgovshr(r,t)*rgdpmp(r,t) =e= sum(gov, xfd(r,gov,t)*(xfd0(r,gov)/rgdpmp0(r))) ;

govshreq(r,t)$(ts(t) and rs(r))..
   govshr(r,t)*gdpmp(r,t) =e= sum(gov, yfd(r,gov,t)*(yfd0(r,gov)/gdpmp0(r))) ;

rinvshreq(r,t)$(ts(t) and rs(r))..
   rinvshr(r,t)*rgdpmp(r,t) =e= sum(inv, xfd(r,inv,t)*(xfd0(r,inv)/rgdpmp0(r))) ;

invshreq(r,t)$(ts(t) and rs(r))..
   invshr(r,t)*gdpmp(r,t) =e= sum(inv, yfd(r,inv,t)*(yfd0(r,inv)/gdpmp0(r))) ;

kstockeeq(r,t)$(ts(t) and rs(r))..
   kstocke(r,t) =e= (1-depr(r,t))*kstock(r,t) + sum(inv, xfd(r,inv,t)*xfd0(r,inv)/kstock0(r)) ;

roreq(r,t)$(ts(t) and rs(r))..
   ror(r,t)*ror0(r) =e= sum((a,cap,v),(1-kappaf(r,cap,a,t))*pk(r,a,v,t)*kv(r,a,v,t)*pk0(r,a)*kv0(r,a))
                     /    (kstock(r,t)*kstock0(r)) ;

rorceq(r,t)$(ts(t) and rs(r))..
   rorc(r,t)*rorc0(r) =e= ror(r,t)*ror0(r)/sum(inv, pfd(r,inv,t)*pfd0(r,inv)) - depr(r,t) ;

roreeq(r,t)$(ts(t) and rs(r))..
   rore(r,t)*rore0(r) =e= (rorc(r,t)*rorc0(r)*(kstocke(r,t)/kstock(r,t))**(-epsRor(r,t)))
                       $(savfFlag eq capFlexGTAP or savfFlag eq capFix or savfFlag eq capRFix or savfFlag eq capFlexINF)
                       +  ((ror(r,t)*ror0(r)/sum(inv,pfd(r,inv,t)*pfd0(r,inv))
                       +      (1 - depr(r,t)))/(1+intRate) - 1)
                       $(savfFlag eq capFlexUSAGE) ;
                       ;

devRoReq(r,t)$(ts(t) and rs(r) and savfFlag eq capFlexUSAGE)..
   devRoR(r,t) =e= rore(r,t)*rore0(r) - rorn(r,t) - rord(r,t) - rorg(t) ;

grKeq(r,t)$(ts(t) and rs(r))..
   sum(inv, xfd(r,inv,t)*xfd0(r,inv)) =e= kstock(r,t)*kstock0(r)*(grK(r,t) + depr(r,t)) ;

$macro logasc(r,t) ((grKMax(r,t) - grKTrend(r,t))/(grkTrend(r,t) - grKMin(r,t)))

savfeq(r,t)$(ts(t) and rs(r))..
   0 =e= (riskPrem(r,t)*rore(r,t)*rore0(r) - rorg(t)*rorg0)$(savfFlag eq capFlexGTAP)
      +  (riskPrem(r,t)*rorc(r,t)*rorc0(r) - rorg(t)*rorg0)$(savfFlag eq capFlexINF)
*     +  (riskPrem(r,t)*trent(r,t)*trent0(r) - rorg(t)*rorg0)$(savfFlag eq capFlexINF)
      +  (savf(r,t) - savfBar(r,t))$((savfFlag eq capFix and not rres(r) and not fixER(r)) or (not ifGBL))
      +  (pwsav(t)*savf(r,t) - savfRat(r,t)*gdpmp(r,t)*gdpmp0(r))$(savfFlag eq capRFix and not rres(r))
      +  (sum(rp, savf(rp,t)))$((savfFlag eq capFix or savfFlag eq capRFix) and rres(r) and ifGBL)
      +  (grk(r,t) - (grKMax(r,t)*exp(chigrK(r,t)*devRoR(r,t)) + grKMin(r,t)*logasc(r,t))
                   /  (exp(chigrK(r,t)*devRoR(r,t)) + logasc(r,t)))$(savfFlag eq capFlexUSAGE)
      ;

savfRateq(r,t)$(ts(t) and rs(r) and savfFlag ne capRFix and ifGbl)..
   pwsav(t)*savf(r,t) =e= savfRat(r,t)*gdpmp(r,t)*gdpmp0(r) ;

$macro netInvShr(r,t) (sum(inv, yfd(r,inv,t)*yfd0(r,inv) - pfd(r,inv,t)*pfd0(r,inv)*depr(r,t)*kstock(r,t)*kstock0(r))/sum((rp,inv), yfd(rp,inv,t)*yfd0(rp,inv) - pfd(rp,inv,t)*pfd0(rp,inv)*depr(rp,t)*kstock(rp,t)*kstock0(rp)))

rorgeq(t)$(ts(t) and ifGbl)..
   0 =e= (sum(r, savf(r,t)))$(savfFlag ne capFix and savfFlag ne capRFix)
      +  (rorg(t)*rorg0 - sum(r, netInvShr(r,t)*rore(r,t)*rore0(r)))$(savfFlag eq capFix or savfFlag eq capRFix) ;

$macro mQMUV(tp,tq) (sum((s,i,d)$(rmuv(s) and imuv(i)), (pwe0(s,i,d)*xw0(s,i,d))*PWE_SUB(s,i,d,tp)*xw(s,i,d,tq)))

pmuveq(t)$ts(t)..
$iftheni "%simType%" == "compStat"
   pmuv(t) =e= sum(t0, (pmuv(t0)*sqrt((mQMUV(t,t0)/mQMUV(t0,t0))
            *                  (mQMUV(t,t)/mQMUV(t0,t)))))$ifGbl

            +  (pnum(t))$(not ifGbl) ;
$else
   pmuv(t) =e= (pmuv(t-1)*sqrt((mQMUV(t,t-1)/mQMUV(t-1,t-1))
            *                  (mQMUV(t,t)/mQMUV(t-1,t))))$ifGbl

            +  (pnum(t))$(not ifGbl) ;
$endif

*  Factor price index

$macro mQFACT(r,tp,tq) (sum((f,a), pf(r,f,a,tp)*xf(r,f,a,tq)))

pfacteq(r,t)$(ts(t) and rs(r))..
$iftheni "%simType%" == "compStat"
   pfact(r,t) =e= sum(t0, pfact(r,t0)
               *     sqrt((mQFACT(r,t,t0)/mQFACT(r,t0,t0))*(mQFACT(r,t,t)/mQFACT(r,t0,t)))) ;
$else
   pfact(r,t) =e= pfact(r,t-1)
               *     sqrt((mQFACT(r,t,t-1)/mQFACT(r,t-1,t-1))*(mQFACT(r,t,t)/mQFACT(r,t-1,t))) ;
$endif

$macro mQFACTw(tp,tq) (sum((r,f,a), pf(r,f,a,tp)*xf(r,f,a,tq)))

pwfacteq(t)$ts(t)..
$iftheni "%simType%" == "compStat"
   pwfact(t) =e= sum(t0, pwfact(t0)
              *   sqrt((mqfactw(t,t0)/mqfactw(t0,t0))
              *        (mqfactw(t,t)/mqfactw(t0,t)))) ;
$else
   pwfact(t) =e= pwfact(t-1)
              *   sqrt((mqfactw(t,t-1)/mqfactw(t-1,t-1))
              *        (mqfactw(t,t)/mqfactw(t-1,t))) ;
$endif

pwgdpeq(t)$(ts(t) and ifGbl)..
   pwgdp(t) =e= sum(r, gdpmp(r,t))/sum(r, rgdpmp(r,t)) ;

pwsaveq(t)$ts(t)..
   pwsav(t) =e= pmuv(t) ;

pnumeq(t)$(ts(t) and ifGbl)..
   pnum(t) =e= 0*pwfact(t) + 1*pwgdp(t) ;

$macro mQX(a,tp,tq) (sum(r, (px0(r,a)*xp0(r,a))*px(r,a,tp)*xp(r,a,tq)))

pweq(a,t)$(ts(t) and ifGbl)..
$iftheni "%simType%" == "compStat"
   pw(a,t) =e= sum(t0, pw(a,t0)*sqrt((mQX(a,t,t0)/mQX(a,t0,t0))
            *                 (mQX(a,t,t)/mQX(a,t0,t)))) ;
$else
   pw(a,t) =e= pw(a,t-1)*sqrt((mQX(a,t,t-1)/mQX(a,t-1,t-1))
            *                 (mQX(a,t,t)/mQX(a,t-1,t))) ;
$endif

walraseq..
   walras =e= (sum(t$ts(t), sum(rres, sum(inv, yfd(rres,inv,t)*yfd0(rres,inv))
           -  (sum(h, savh(rres,h,t)*savh0(rres,h)) + savg(rres,t)
           +      pwsav(t)*savf(rres,t) + deprY0(rres)*deprY(rres,t)))))
           $ifGbl

           +  (sum(t$ts(t),
                  sum(r$rs(r), sum((i,rp), pwe0(r,i,rp)*PWE_SUB(r,i,rp,t)*xw0(r,i,rp)*xw(r,i,rp,t)
           -      pwm0(rp,i,r)*PWM_SUB(rp,i,r,t)*lambdaw(rp,i,r,t)*xw0(rp,i,r)*xw(rp,i,r,t))
           +      sum(img, (pdt0(r,img)*pdt(r,img,t))*xtt(r,img,t)*xtt0(r,img)) + pwsav(t)*savf(r,t)
           +      yqht0(r)*yqht(r,t) - yqtf0(r)*yqtf(r,t)
           +      ODAIn0(r)*ODAIn(r,t) - ODAOut0(r)*ODAOut(r,t)
           +      sum((rp,l),remit0(r,l,rp)*remit(r,l,rp,t)-remit0(rp,l,r)*remit(rp,l,r,t)))))
           $(not ifGBL) ;

* --------------------------------------------------------------------------------------------------
*
*   EMISSIONS MODULE
*
* --------------------------------------------------------------------------------------------------

*  Calculate emissions from all drivers

*  Consumption based emissions

emiieq(r,em,i,aa,t)$(ts(t) and rs(r) and emir(r,em,i,aa) ne 0)..
   emi(r,em,i,aa,t) =e= (chiEmi(em,t)*emir(r,em,i,aa)*xa(r,i,aa,t)*(xa0(r,i,aa)/emi0(r,em,i,aa)))
                     $(ArmFlag eq 0)
                     +  (chiEmi(em,t)*emird(r,em,i,aa)*xd(r,i,aa,t)*(xd0(r,i,aa)/emi0(r,em,i,aa))
                     +   chiEmi(em,t)*emirm(r,em,i,aa)*xm(r,i,aa,t)*(xm0(r,i,aa)/emi0(r,em,i,aa)))
                     $(ArmFlag)
                     ;

*  Factor-use based emissions

emifeq(r,em,f,a,t)$(ts(t) and rs(r) and emir(r,em,f,a) ne 0)..
   emi(r,em,f,a,t) =e= chiEmi(em,t)*emir(r,em,f,a)*xf(r,f,a,t)*(xf0(r,f,a)/emi0(r,em,f,a)) ;

*  Output based emissions

emixeq(r,em,tot,a,t)$(ts(t) and rs(r) and emir(r,em,tot,a) ne 0)..
   emi(r,em,tot,a,t) =e= chiEmi(em,t)*emir(r,em,tot,a)*xp(r,a,t)*(xp0(r,a)/emi0(r,em,tot,a)) ;

*  Calculate aggregate emissions including any exogenous emissions

emiToteq(r,em,t)$(ts(t) and rs(r) and emiTot0(r,em))..
   emiTot(r,em,t) =e= emiOth(r,em,t)/emiTot0(r,em)
      + sum((is,aa)$emir(r,em,is,aa), emi(r,em,is,aa,t)*emi0(r,em,is,aa)/emiTot0(r,em)) ;

*  Global atmospheric carbon emissions

emiGbleq(em, t)$(ts(t) and ifGbl and emiGbl0(em))..
   emiGbl(em, t) =e= sum(r, emiTot(r, em,t)*(emiTot0(r,em)/emiGbl0(em)))
                  +  emiOthGbl(em,t)/emiGbl0(em) ;

*  -----------------------------------------------------------------------------
*
*     Carbon policy regimes
*
*     Emission caps, tradable quotas, etc.
*     !!!! Need to review when including other gases
*
*  -----------------------------------------------------------------------------

*  Calculates carbon tax when cap imposed

emiCapeq(rq,em,t)$(ts(t) and ifGbl and ifEmiCap and emFlag(em))..
   chiCap(em,t)*emiCap(rq,em,t) =g= sum(r$mapr(rq,r), emiTot(r,em,t)*emiTot0(r,em)) ;

*  Sets tax for region r that is a member of rq

emiTaxeq(r,em,t)$(ts(t) and ifGbl and emFlag(em) and ifEmiCap)..
   emiTax(r,em,t) =e= sum(rq$mapr(rq,r), emiRegTax(rq,em,t)) ;

*  Calculates quota rents

emiQuotaYeq(r,em,t)$(ts(t) and ifGbl and ifEmiCap and emFlag(em) and ifEmiQuota(r))..
   emiQuotaY(r,em,t) =e= emiTax(r,em,t)*(emiQuota(r,em,t) - emiTot(r,em,t)*emiTot0(r,em)) ;

* --------------------------------------------------------------------------------------------------
*
*   MODEL DYNAMICS
*
* --------------------------------------------------------------------------------------------------

*  Migration level

migreq(r,l,t)$(ts(t) and rs(r) and migrFlag(r,l))..
   migr(r,l,t) =e= ((chim(r,l,t)/migr0(r,l))*urbPrem0(r,l)**omegam(r,l))
                *    urbPrem(r,l,t)**omegam(r,l) ;

*  Labor supply in each zone

*  Migration factor to for multi-year specification

migrMulteq(r,l,z,t)$(ts(t) and rs(r) and migrFlag(r,l))..
   migrMult(r,l,z,t)*((1 + 0.01*glabz(r,l,z,t))
      *  (urbPrem(r,l,t-1)/urbPrem(r,l,t))**(omegam(r,l)/gap(t))-1) =e=
         power(1 + 0.01*glabz(r,l,z,t), gap(t))*(urbPrem(r,l,t-1)/urbPrem(r,l,t))**omegam(r,l) - 1 ;

*  Labor supply by zone

lszeq(r,l,z,t)$(ts(t) and rs(r) and lsFlag(r,l,z))..
   lsz(r,l,z,t) =e= power(1 + 0.01*glabz(r,l,z,t), gap(t))*lsz(r,l,z,t-1)
                 +      kronm(z)*migrMult(r,l,z,t)*migr(r,l,t)*(migr0(r,l)/lsz0(r,l,z)) ;

*  Aggregate growth of labor supply by skill

glabeq(r,l,t)$(ts(t) and rs(r) and tlabFlag(r,l))..
   ls(r,l,t) =e= power(1 + 0.01*glab(r,l,t), gap(t))*ls(r,l,t-1) ;

invGFacteq(r,t)$(ts(t) and rs(r) and gap(t) gt 1)..
   invGFact(r,t)*((sum(inv,
      (xfd0(r,inv)*xfd(r,inv,t))
   /  (xfd0(r,inv)*xfd(r,inv,t-1))))**(1/gap(t)) - 1 + depr(r,t))
      =e= 1 ;
*  sum(inv, xfd(r,inv,t)) =e= sum(inv, xfd(r,inv,t-1))*power(1 + invGFact(r,t), gap(t)) ;

kstockeq(r,t)$(ts(t) and rs(r))..
   kstock(r,t) =e= (power(1 - depr(r,t), gap(t)) * (kstock(r,t-1)
                -   invGFact(r,t)*sum(inv, xfd(r,inv,t-1)*(xfd0(r,inv)/kstock0(r))))
                +   invGFact(r,t)*sum(inv, xfd(r,inv,t)*(xfd0(r,inv)/kstock0(r))))
                $(gap(t) gt 1)
$ontext
   kstock(r,t) =e= (power(1 - depr(r,t), gap(t)) * kstock(r,t-1)
                +  ((power(1 + invGFact(r,t), gap(t)) - power(1 - depr(r,t), gap(t)))
                /  (invGFact(r,t) + depr(r,t)))
                *  sum(inv, xfd(r,inv,t-1)*(xfd0(r,inv)/kstock0(r))))
                $(gap(t) gt 1)
$offtext

                + ((1 - depr(r,t))*kstock(r,t-1)
                + sum(inv, xfd(r,inv,t-1)*(xfd0(r,inv)/kstock0(r))))
                $(gap(t) eq 1) ;

tkapseq(r,t)$(ts(t) and rs(r))..
   tkaps(r,t) =e= chiKaps0(r)*kstock(r,t)*(kstock0(r)/tkaps0(r)) ;

lambdafeq(r,l,a,t)$(ts(t) and rs(r) and xfFlag(r,l,a))..
   lambdaf(r,l,a,t) =e= lambdaf(r,l,a,t-1)
      * power(1 + chiglab(r,l,t) + glAddShft(r,l,a,t) + glMltShft(r,l,a,t)*gl(r,t), gap(t)) ;

*  Equivalent variation at base year prices
*  !!!! Check formulas for non-CDE

eveq(r,h,t)$(1 and ts(t) and rs(r))..
   0 =e= (1e0 - sum(k$xcFlag(r,k,h), (1e0*alphah(r,k,h,t)
      *           (u0(r,h)**(eh(r,k,h,t)*bh(r,k,h,t)))
      *           (pc0(r,k,h)*pop0(r)/ev0(r,h))**bh(r,k,h,t))
      *        (u(r,h,t)**(eh(r,k,h,t)*bh(r,k,h,t)))
      *        (pop(r,t)*sum(t0, pc(r,k,h,t0))/ev(r,h,t))**bh(r,k,h,t)))
      $(%utility%=CDE)

      +  (1 - sum(k$xcFlag(r,k,h), muc0(r,k,h)*muc(r,k,h,t)
      *     log(muc0(r,k,h)*muc(r,k,h,t)/(pc0(r,k,h)*sum(t0,pc(r,k,h,t0)))))
      -   (mus(r,h,t)*log(mus(r,h,t)/((pfd0(r,h)*sum(t0,pfd(r,h,t0)))))))
      $(%utility%=ELES and uFlag(r,h))

      +  (1 - log(ev0(r,h)*ev(r,h,t)/(pop0(r)*pop(r,t))
      -     sum(k$xcFlag(r,k,h), pc0(r,k,h)*sum(t0,pc(r,k,h,t0))*theta(r,k,h,t)*theta0(r,k,h)))
      +    log(aad(r,h,t)) + u(r,h,t)*u0(r,h))
      $(%utility% ne CDE and %utility% ne ELES)
      ;

*  !!!! Pairings are not complete as some depend on closure. To look into.

model core /

   pxeq.px, uceq.uc, pxveq.pxv,
   xpxeq.xpx, xghgeq.xghg,
   nd1eq.nd1, vaeq.va, pxpeq.pxp,

   lab1eq.lab1, kefeq.kef, nd2eq.nd2,
   va1eq.va1, va2eq.va2, landeq.xf,
   pvaeq.pva, pva1eq.pva1, pva2eq.pva2

   kfeq.kf, xnrgeq.xnrg, pkefeq.pkef,

   ksweq.ksw, xnrseq.xf, pkfeq.pkf,

   kseq.ks, xwateq.xwat, pksweq.pksw, h2oeq.xf,

   kveq.kv, lab2eq.lab2, pkseq.pks,

   ldeq.xf, plab1eq.plab1, plab2eq.plab2,

   xapeq.xa, pnd1eq.pnd1, pnd2eq.pnd2, pwateq.pwat,
   xnelyeq.xnely, xolgeq.xolg, xaNRGeq.xaNRG, xaeeq.xa,
   paNRGeq.paNRG, polgeq.polg, pnelyeq.pnely, pnrgeq.pnrg,

   peq.p, xpeq.xp, ppeq.pp, xeq.x, pseq.ps,
   xetdeq.x, xpoweq.xpow, pselyeq.ps, xpbeq.xpb, ppowndxeq.ppowndx, ppoweq.ppow,
   xbndeq.x, ppbndxeq.ppbndx, ppbeq.ppb,

   deprYeq.deprY, yqtfeq.yqtf, trustYeq.trustY, yqhteq.yqht, ntmYeq.ntmY,
   ODAIneq.ODAIn, ODAOuteq.ODAOut, ODAGbleq.ODAGbl, remiteq.remit,
   yheq.yh, ydeq.yd,
   ygoveq.ygov, yfdInveq.xfd,

*  supyeq.supy, thetaeq.theta, xceq.xc, hshreq.hshr,
   supyeq.supy, thetaeq.theta, xceq.xc, hshreq.hshr, muceq.muc, ueq.u,
   xcnnrgeq.xcnnrg, xcnrgeq.xcnrg, pceq.pc,
   xacnnrgeq.xa, pcnnrgeq.pcnnrg,
   xcnelyeq.xcnely, xcolgeq.xcolg, xacNRGeq.xacNRG, xaceeq.xa,
   pacNRGeq.pacNRG, pcolgeq.pcolg, pcnelyeq.pcnely, pcnrgeq.pcnrg,
   xaaceq, xawceq, paacceq, paaceq, paheq, pawceq,
*  xaaceq.xaac, xawceq.xawc, paacceq.paacc, paaceq.paac, pawceq.pawc,

   savhELESeq.aps, savheq.savh,

   xafeq.xa, pfdfeq.pfd, yfdeq.yfd,

   xateq.xat, xdteq.xdt, xmteq.xmt, pateq.pat, paeq.pa,
   xdeq.xd, xmeq.xm, pdeq.pd, pmeq.pm,
   xwdeq.xw, pmteq.pmt,
   xwaeq.xwa, pdmaeq.pdma, pmaeq.pma,
*  pdteq.pdt, xeteq.xet, xseq.xs, xwseq.pe, peteq.pet,
   pdteq.pdt, xeteq.xet, xseq.xs, xwseq.pe, peteq,
   pweeq.pwe, pwmeq.pwm, pdmeq.pdm,

   xwmgeq.xwmg, xmgmeq.xmgm, pwmgeq.pwmg, xtmgeq.xtmg,
   xtteq.xtt, ptmgeq.ptmg,

   ldzeq.ldz, awagezeq.awagez, urbPremeq.urbPrem, resWageeq.resWage
   uezeq, ewagezeq.uez, twageeq.twage, wageeq.pf,
   skillpremeq, lseq.ls, tlseq.tls,

   pkeq.pk, trenteq.trent,
*  kxRateq.kxRat, rrateq.rrat, trentVinteq.trent, pkVinteq.pk,
   kxRateq.kxRat, rrateq.rrat,
   k0eq.k0, xpveq.xpv, arenteq.arent, capeq.xf, pcapeq.pf,

   tlandeq.tland,
   xlb1eq.xlb, xnlbeq.xnlb, ptlandndxeq.ptlandndx, ptlandeq.ptland,
   xlbneq.xlb, pnlbndxeq.pnlbndx, pnlbeq.pnlb,
   plandeq.pf, plbndxeq.plbndx, plbeq.plb,

   etanrseq.etanrs, xnrsseq.pf,

   th2oeq.th2o, h2obndeq.h2obnd, pth2ondxeq.pth2ondx, pth2oeq.pth2o, th2omeq.th2om,
   ph2obndndxeq.ph2obndndx, ph2obndeq.ph2obnd, ph2oeq.pf,

   pfpeq.pfp, pkpeq.pkp,

   pfdheq.pfd, xfdheq.xfd, gdpmpeq.gdpmp, rgdpmpeq.rgdpmp, pgdpmpeq.pgdpmp,
   rgdppceq.rgdppc,

   savgeq.savg, rsgeq.kappah,
   rgovshreq.rgovshr, govshreq.govshr, rinvshreq, invshreq.invshr,
   kstockeeq.kstocke, roreq.ror, rorceq.rorc, roreeq.rore, savfeq, savfRateq, rorgeq,
   devRoReq.devRoR, grkeq.grK,
   pmuveq.pmuv, pfacteq, pwfacteq, pwgdpeq.pwgdp, pwsaveq.pwsav, pnumeq, pweq,

   emiieq.emi, emifeq.emi, emixeq.emi, emiToteq.emiTot, emiGbleq.emiGbl,
   emiCapeq.emiRegTax, emiTaxeq.emiTax, emiQuotaYeq.emiQuotaY,

   eveq.ev,

   walraseq
/ ;

core.holdfixed = 1 ;

model coreBau /
   core +
   grrgdppceq.gl, klrateq.klrat,
   migreq.migr, migrMulteq.migrMult, lszeq.lsz, glabeq.glab,
   invGFacteq.invGFact, kstockeq.kstock, tkapseq.tkaps, lambdafeq.lambdaf
/ ;
coreBaU.holdfixed = 1 ;

model coreDyn /
   core +
   grrgdppceq, klrateq.klrat,
   migreq.migr,  migrMulteq.migrMult, lszeq.lsz, glabeq.glab,
   invGFacteq.invGFact, kstockeq.kstock, tkapseq.tkaps, lambdafeq.lambdaf
/ ;
coreDyn.holdfixed = 1 ;
