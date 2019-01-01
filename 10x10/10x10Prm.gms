*  Parameters contained in the parameter data file

set v0 / Old, New / ;

parameters

*  Production elasticities

   sigmaxp0(r,a,v0)        "CES between GHG and XP"
   sigmap0(r,a,v0)         "CES between ND1 and VA"
   sigmav0(r,a,v0)         "CES between LAB1 and VA1 in crops and other, VA1 and VA2 in livestock"
   sigmav10(r,a,v0)        "CES between ND2 (fert) and VA2 in crops, LAB1 and KEF in livestock and land and KEF in other"
   sigmav20(r,a,v0)        "CES between land and KEF in crops, land and ND2 (feed) in livestock. Not used in other"
   sigmakef0(r,a,v0)       "CES between KF and NRG"
   sigmakf0(r,a,v0)        "CES between KSW and NRF"
   sigmakw0(r,a,v0)        "CES between KS and XWAT"
   sigmak0(r,a,v0)         "CES between LAB2 and K"
   sigmaul0(r,a)           "CES across unskilled labor"
   sigmasl0(r,a)           "CES across skilled labor"
   sigman10(r,a)           "CES across intermediate demand in ND1 bundle"
   sigman20(r,a)           "CES across intermediate demand in ND2 bundle"
   sigmawat0(r,a)          "CES across intermediate demand in WAT bundle"
   sigmae0(r,a,v0)         "CES between ELY and NELY in energy bundle"
   sigmanely0(r,a,v0)      "CES between COA and OLG in energy bundle"
   sigmaolg0(r,a,v0)       "CES between OIL and GAS in energy bundle"
   sigmaNRG0(r,a,NRG,v0)   "CES within each of the NRG bundles"

*  Make matrix elasticities (incl. power)

   omegas0(r,a)            "Make matrix transformation elasticities: one activity --> many commodities"
   sigmas0(r,i)            "Make matrix substitution elasticities: one commodity produced by many activities"
   sigmael0(r,elyc)        "Substitution between power and distribution and transmission"
   sigmapow0(r,elyc)       "Substitution across power bundles"
   sigmapb0(r,pb,elyc)     "Substitution across power activities within power bundles"

*  Final demand elasticities

   incElas0(k,r)           "Income elasticities"
   eh0(k,r)                "CDE expansion parameter"
   bh0(k,r)                "CDE substitution parameter"
   nu0(r,k,h)              "Elasticity of subsitution between energy and non-energy bundles in HH consumption"
   nunnrg0(r,k,h)          "Substitution elasticity across non-energy commodities in the non-energy bundle"
   nue0(r,k,h)             "Substitution elasticity between ELY and NELY bundle"
   nunely0(r,k,h)          "Substitution elasticity beteen COL and OLG bundle"
   nuolg0(r,k,h)           "Substitution elasticity between OIL and GAS bundle"
   nuNRG0(r,k,h,NRG)       "Substitution elasticity within NRG bundles"
   sigmafd0(r,fd)          "CES expenditure elasticity for other final demand"

*  Trade elasticities

   sigmamt0(r,i)           "Top level Armington elasticity"
   sigmaw0(r,i)            "Second level Armington elasticity"
   omegax0(r,i)            "Top level CET export elasticity"
   omegaw0(r,i)            "Second level CET export elasticity"
   sigmamg0(img)           "CES 'Make' elasticity for intl. trade and transport services"

*  Factor supply elasticities

   omegak0(r)              "CET capital mobility elasticity in comp. stat. model"
   etat0(r)                "Aggregate land supply elasticity"
   landMax00(r)            "Initial ratio of land maximum wrt to land use"
   omegat0(r)              "Land elasticity between intermed. land bundle and first land bundle"
   omeganlb0(r)            "Land elasticity across intermediate land bundles"
   omegalb0(r,lb)          "Land elasticity within land bundles"
*  !!!! TO BE FIXED
*  etanrs0(r,a)            "Natural resource supply elasticity"

   etaw0(r)                "Supply elasticity of aggregate water"
   H2OMax00(r)             "Maximum water supply"
   omegaw10(r)             "Top level water CET elasticity"
   omegaw20(r,wbnd)        "Second/third level water CET elasticities"
   epsh2obnd0(r,wbnd)      "Price elasticity of demand for water bundles"
   epsh2obnd0(r,wbnd)      "Price elasticity of demand for water bundles"
   etah2obnd0(r,wbnd)      "Water bundle demand scale elasticity"

   invElas0(r,a)           "Dis-investment elasticity"

   epsRor0(r,t)            "Elasticity of expected rate-of-return"

   grkMin0(r,t)            "Lower bound on investment growth"
   grkMax0(r,t)            "Upper bound on investment growth"
   grkTrend0(r,t)          "Long-term trend for investment growth"
   chigrK0(r,t)            "Elasticity parameter in growth of capital"
   RoRn0(r,t)              "Normal rate of return"

   omegam0(r,l)            "Elasticity of migration"

   etaODA0(r,t)            "Elasticity of ODA wrt to per capita income"
;

*  Read in the base elasticities

execute_load "%BASENAME%Prm.gdx"
   sigmaxp0, sigmap0, sigman10, sigman20, sigmawat0,
   sigmav0, sigmav10, sigmav20,
   sigmakef0, sigmakf0, sigmakw0, sigmak0,
   sigmaul0, sigmasl0,
   sigmae0, sigmanely0, sigmaolg0, sigmaNRG0,
   omegas0, sigmas0,
   sigmael0, sigmapow0, sigmapb0,
   incElas0, eh0, bh0, nu0, nunnrg0, nue0, nunely0, nuolg0, nuNRG0, sigmafd0
   sigmamt0=sigmam0, sigmaw0, omegax0, omegaw0, sigmamg0
   omegak0, invElas0, etat0, landMax00,
   omegat0, omeganlb0, omegalb0,
*  !!!! TO BE FIXED
*  etanrs0, omegam0
   omegam0
;

*  Overrides

sigmaxp0(r,a,v0) = 0 ;
sigmap0(r,a,v0)  = 0 ;
sigmav0(r,a,"Old") = 0.12$(not aenergy(a)) + 0$aenergy(a) ;
sigmav0(r,a,"New") = 1.01$(not aenergy(a)) + 0$aenergy(a) ;
sigmav10(r,a,"Old") = 0.12$(not aenergy(a)) + 0$aenergy(a) ;
sigmav10(r,a,"New") = 1.01$(not aenergy(a)) + 0$aenergy(a) ;
sigmav20(r,a,"Old") = 0.12$(not aenergy(a)) + 0$aenergy(a) ;
sigmav20(r,a,"New") = 1.01$(not aenergy(a)) + 0$aenergy(a) ;
sigmakef0(r,a,"Old") = 0.00$(not aenergy(a)) + 0$aenergy(a) ;
sigmakef0(r,a,"New") = 0.80$(not aenergy(a)) + 0$aenergy(a) ;
sigmakf0(r,a,"Old") = 0.25$(not aenergy(a)) + 0.25$aenergy(a) ;
sigmakf0(r,a,"New") = 0.25$(not aenergy(a)) + 0.25$aenergy(a) ;
sigmakw0(r,a,"Old") = 0.1$(not aenergy(a)) + 0$aenergy(a) ;
sigmakw0(r,a,"New") = 0.1$(not aenergy(a)) + 0$aenergy(a) ;
sigmak0(r,a,"Old") = 0.12$(not aenergy(a)) + 0$aenergy(a) ;
sigmak0(r,a,"New") = 1.01$(not aenergy(a)) + 0$aenergy(a) ;
sigmaul0(r,a)      = 0.5 ;
sigmasl0(r,a)      = 0.5 ;
sigman10(r,a)      = 0.0 ;
sigman20(r,a)      = 0.5 ;
sigmawat0(r,a)     = 0.0 ;
sigmae0(r,a,"Old") = 0.25$(not aenergy(a)) + 0$aenergy(a) ;
sigmae0(r,a,"New") = 2.00$(not aenergy(a)) + 0$aenergy(a) ;
sigmanely0(r,a,"Old") = 0.25$(not aenergy(a)) + 0$aenergy(a) ;
sigmanely0(r,a,"New") = 2.00$(not aenergy(a)) + 0$aenergy(a) ;
sigmaolg0(r,a,"Old") = 0.25$(not aenergy(a)) + 0$aenergy(a) ;
sigmaolg0(r,a,"New") = 2.00$(not aenergy(a)) + 0$aenergy(a) ;
sigmaNRG0(r,a,NRG,"Old") = 0.25$(not aenergy(a)) + 0$aenergy(a) ;
sigmaNRG0(r,a,NRG,"New") = 2.00$(not aenergy(a)) + 0$aenergy(a) ;

sigmael0(r,elyc) = 0 ;
sigmapow0(r,elyc) = 1.5 ;
sigmapb0(r,pb,elyc) = 3.0 ;

nue0(r,k,h) = 1.2 ;
nunely0(r,k,h) = 1.2 ;
nuolg0(r,k,h) = 1.2 ;
nuNRG0(r,k,h,NRG) = 1.2 ;

omegax0(r,i) = inf ;
omegaw0(r,i) = inf ;

*omegax0(r,i) = 2 ;
*omegaw0(r,i) = 4 ;

etaODA0(r,t) = 0 ;

Parameters
   esubd(i0,r)
   esubm(i0,r)
   incpar(i0,r)
   subpar(i0,r)
   etanrsx0(r,a0,lh)
;

execute_load "%BASENAME%PAR.gdx", esubd, esubm, incpar, subpar ;
*execute_load "%BASENAME%PRM.gdx", etanrs0 = etanrs0 ;

*  !!!! NEW WATER PARAMETERS NEED TO BE INCLUDED IN AGGREGATION

etaw0(r)         = 1 ;
H2OMax00(r)      = 2 ;
omegaw10(r)      = 1 ;
omegaw20(r,wbnd) = 2 ;
epsh2obnd0(r,wbnd) = 1 ;
etah2obnd0(r,wbnd) = 1 ;

* !!!! Let's make natural resources quite elastic

Table etanrsx0(r,a0,lh)

                            lo   hi

Oceania     .extraction      4    2
EastAsia    .extraction      4    2
SEAsia      .extraction      4    2
SouthAsia   .extraction      2    1
NAmerica    .extraction      4    2
LatinAmer   .extraction      6    3
EU_28       .extraction      2    1
MENA        .extraction      8    4
SSA         .extraction      6    3
RestofWorld .extraction      2    1
;

etanrsx0(r,a0,lh) = 2 ;

$ontext
Table etanrsovr(r,a0)

           frs       fsh        coa       oil       gas       omn

CHN        0.5       0.25      4.00      1.00      1.00      3.00
HYA        0.5       0.25      4.00      1.00      1.00      3.00
XEA        0.5       0.25      4.00      1.00      1.00      3.00
SAS        0.5       0.25      4.00      1.00      1.00      3.00
USA        0.5       0.25      4.00      2.00      2.00      3.00
XNA        0.5       0.25      2.00      2.50      2.50      3.00
LAC        0.5       0.25      2.00      2.50      2.50      3.00
WEU        0.5       0.25      2.00      1.50      1.50      3.00
ECA        0.5       0.25      4.00      2.00      2.00      3.00
MNA        0.5       0.25      2.00      4.00      4.00      3.00
SSA        0.5       0.25      2.00      2.00      2.00      3.00
;

etanrs0(r,a0) = etanrsovr(r,a0) ;
$offtext

epsRor0(r,t) = 10 ;

Table kGrowthData0(r,*)
              Min     Max  Trend     Elas        RoRn

Oceania       -0.07  0.10   0.04   7.727272      0.05
EastAsia      -0.07  0.10   0.04   7.727272      0.05
SEAsia        -0.07  0.10   0.04   7.727272      0.05
SouthAsia     -0.07  0.10   0.04   7.727272      0.05
NAmerica      -0.07  0.10   0.04   7.727272      0.05
LatinAmer     -0.07  0.10   0.04   7.727272      0.05
EU_28         -0.07  0.10   0.04   7.727272      0.05
MENA          -0.07  0.10   0.04   7.727272      0.05
SSA           -0.07  0.10   0.04   7.727272      0.05
RestofWorld   -0.07  0.10   0.04   7.727272      0.05
;

grKMin0(r,t)   = kGrowthData0(r,"Min") ;
grKMax0(r,t)   = kGrowthData0(r,"Max") ;
grKTrend0(r,t) = kGrowthData0(r,"Trend") ;
chigrK0(r,t)   = kGrowthData0(r,"Elas") ;
RoRn0(r,t)     = kGrowthData0(r,"RoRn") ;

*  Declare model parameters

parameters

*  Production elasticities

   sigmaxp(r,a,v)          "CES between GHG and XP"
   sigmap(r,a,v)           "CES between ND1 and VA"
   sigmav(r,a,v)           "CES between LAB1 and VA1 in crops and other, VA1 and VA2 in livestock"
   sigmav1(r,a,v)          "CES between ND2 (fert) and VA2 in crops, LAB1 and KEF in livestock and land and KEF in other"
   sigmav2(r,a,v)          "CES between land and KEF in crops, land and ND2 (feed) in livestock. Not used in other"
   sigmakef(r,a,v)         "CES between KF and NRG"
   sigmakf(r,a,v)          "CES between KSW and NRF"
   sigmakw(r,a,v)          "CES between KS and XWAT"
   sigmak(r,a,v)           "CES between LAB2 and K"
   sigmaul(r,a)            "CES across unskilled labor"
   sigmasl(r,a)            "CES across skilled labor"
   sigman1(r,a)            "CES across intermediate demand in ND1 bundle"
   sigman2(r,a)            "CES across intermediate demand in ND2 bundle"
   sigmawat(r,a)           "CES across intermediate demand in XWAT bundle"
   sigmae(r,a,v)           "CES between ELY and NELY in energy bundle"
   sigmanely(r,a,v)        "CES between COA and OLG in energy bundle"
   sigmaolg(r,a,v)         "CES between OIL and GAS in energy bundle"
   sigmaNRG(r,a,NRG,v)     "CES within each of the NRG bundles"

*  Make matrix elasticities (incl. power)

   omegas(r,a)             "Make matrix transformation elasticities: one activity --> many commodities"
   sigmas(r,i)             "Make matrix substitution elasticities: one commodity produced by many activities"
   sigmael(r,elyc)         "Substitution between power and distribution and transmission"
   sigmapow(r,elyc)        "Substitution across power bundles"
   sigmapb(r,pb,elyc)      "Substitution across power activities within power bundles"

*  Final demand elasticities

   incElas(k,r)            "Income elasticities"
   nu(r,k,h)               "Elasticity of subsitution between energy and non-energy bundles in HH consumption"
   nunnrg(r,k,h)           "Substitution elasticity across non-energy commodities in the non-energy bundle"
   nue(r,k,h)              "Substitution elasticity between ELY and NELY bundle"
   nunely(r,k,h)           "Substitution elasticity beteen COL and OLG bundle"
   nuolg(r,k,h)            "Substitution elasticity between OIL and GAS bundle"
   nuNRG(r,k,h,NRG)        "Substitution elasticity within NRG bundles"
   sigmafd(r,fd)           "CES expenditure elasticity for other final demand"

*  Trade elasticities

   sigmamt(r,i)            "Top level Armington elasticity"
   sigmam(r,i,aa)          "Top level Armington elasticity by agent"
   sigmaw(r,i)             "Second level Armington elasticity"
   omegax(r,i)             "Top level CET export elasticity"
   omegaw(r,i)             "Second level CET export elasticity"
   sigmamg(img)            "CES 'Make' elasticity for intl. trade and transport services"

*  Factor supply elasticities

   omegak(r)               "CET capital mobility elasticity in comp. stat. model"
   etat(r)                 "Aggregate land supply elasticity"
   landMax0(r)             "Initial ratio of land maximum wrt to land use"
   omegat(r)               "Land elasticity between intermed. land bundle and first land bundle"
   omeganlb(r)             "Land elasticity across intermediate land bundles"
   omegalb(r,lb)           "Land elasticity within land bundles"

   etaw(r)                 "Supply elasticity of aggregate water"
   H2OMax0(r)              "Maximum water supply"
   omegaw1(r)              "Top level water CET elasticity"
   omegaw2(r,wbnd)         "Second/third level water CET elasticities"
   epsh2obnd(r,wbnd)       "Price elasticity of demand for water bundles"
   etah2obnd(r,wbnd)       "Water bundle demand scale elasticity"

   invElas(r,a)            "Dis-investment elasticity"

   epsRor(r,t)             "Elasticity of expected rate of return"

   grkMin(r,t)             "Lower bound on investment growth"
   grkMax(r,t)             "Upper bound on investment growth"
   grkTrend(r,t)           "Long-term trend for investment growth"
   chigrK(r,t)             "Elasticity parameter in growth of capital"
   RoRn(r,t)               "Normal rate of return"

   omegam(r,l)             "Elasticity of migration"

   etaODA(r,t)             "Elasticity of ODA wrt to per capita income"
;

*  User set parameters

Parameter
   wgt(v,v0)     Weight matrix
;

if(ifvint,

   wgt(v,v0)$(ord(v) eq ord(v0)) = 1 ;

else

*  For comp stat model, weigh the 'Old' and 'New' elasticities

   wgt("Old","Old") = 0.8 ;
   wgt("Old","New") = 0.2 ;

) ;

sigmaxp(r,a,v)       = sum(v0, wgt(v,v0)*sigmaxp0(r,a,v0)) ;
sigmap(r,a,v)        = sum(v0, wgt(v,v0)*sigmap0(r,a,v0)) ;
sigmav(r,a,v)        = sum(v0, wgt(v,v0)*sigmav0(r,a,v0)) ;
sigmav1(r,a,v)       = sum(v0, wgt(v,v0)*sigmav10(r,a,v0)) ;
sigmav2(r,a,v)       = sum(v0, wgt(v,v0)*sigmav20(r,a,v0)) ;
sigmakef(r,a,v)      = sum(v0, wgt(v,v0)*sigmakef0(r,a,v0)) ;
sigmakf(r,a,v)       = sum(v0, wgt(v,v0)*sigmakf0(r,a,v0)) ;
sigmakw(r,a,v)       = sum(v0, wgt(v,v0)*sigmakw0(r,a,v0)) ;
sigmak(r,a,v)        = sum(v0, wgt(v,v0)*sigmak0(r,a,v0)) ;
sigmaul(r,a)         = sigmaul0(r,a) ;
sigmasl(r,a)         = sigmasl0(r,a) ;
sigman1(r,a)         = sigman10(r,a) ;
sigman2(r,a)         = sigman20(r,a) ;
sigmawat(r,a)        = sigmawat0(r,a) ;
sigmae(r,a,v)        = sum(v0, wgt(v,v0)*sigmae0(r,a,v0)) ;
sigmanely(r,a,v)     = sum(v0, wgt(v,v0)*sigmanely0(r,a,v0)) ;
sigmaolg(r,a,v)      = sum(v0, wgt(v,v0)*sigmaolg0(r,a,v0)) ;
sigmaNRG(r,a,NRG,v)  = sum(v0, wgt(v,v0)*sigmaNRG0(r,a,NRG,v0)) ;

omegas(r,a)          = omegas0(r,a) ;
sigmas(r,i)          = sigmas0(r,i) ;
sigmael(r,elyc)      = sigmael0(r,elyc) ;
sigmapow(r,elyc)     = sigmapow0(r,elyc) ;
sigmapb(r,pb,elyc)   = sigmapb0(r,pb,elyc) ;

incElas(k,r)         = incElas0(k,r) ;
nu(r,k,h)            = nu0(r,k,h) ;
nunnrg(r,k,h)        = nunnrg0(r,k,h) ;
nue(r,k,h)           = nue0(r,k,h) ;
nunely(r,k,h)        = nunely0(r,k,h) ;
nuolg(r,k,h)         = nuolg0(r,k,h) ;
nuNRG(r,k,h,NRG)     = nuNRG0(r,k,h,NRG) ;
sigmafd(r,fd)        = sigmafd0(r,fd) ;

sigmamt(r,i)         = sigmamt0(r,i) ;
sigmam(r,i,aa)       = sigmamt0(r,i) ;
sigmaw(r,i)          = sigmaw0(r,i) ;
omegax(r,i)          = omegax0(r,i) ;
omegaw(r,i)          = omegaw0(r,i) ;
sigmamg(img)         = sigmamg0(img) ;

omegak(r)            = omegak0(r) ;
etat(r)              = etat0(r) ;
landMax0(r)          = landMax00(r) ;
omegat(r)            = omegat0(r) ;
omeganlb(r)          = omeganlb0(r) ;
omegalb(r,lb)        = omegalb0(r,lb) ;
*  !!!! TO BE FIXED
*etanrs(r,a)          = etanrs0(r,a) ;

etaw(r)              = etaw0(r) ;
H2OMax0(r)           = H2OMax00(r) ;
omegaw1(r)           = omegaw10(r) ;
omegaw2(r,wbnd)      = omegaw20(r,wbnd) ;
epsh2obnd(r,wbnd)    = epsh2obnd0(r,wbnd) ;
etah2obnd(r,wbnd)    = etah2obnd0(r,wbnd) ;

invElas(r,a)         = invElas0(r,a) ;
omegam(r,l)          = omegam0(r,l) ;

epsRor(r,t)          = epsRor0(r,t) ;

grKMin(r,t)   = grKMin0(r,t)   ;
grKMax(r,t)   = grKMax0(r,t)   ;
grKTrend(r,t) = grKTrend0(r,t) ;
chigrK(r,t)   = chigrK0(r,t)   ;
RoRn(r,t)     = RoRn0(r,t)   ;

etaODA(r,t)   = etaODA0(r,t) ;

Parameters
   alphawc(r,i,h)       "Waste share of consumption"
   sigmaac(r,i,h)       "Substitution elasticity"
;

alphawc(r,i,h) = 0 ;
sigmaac(r,i,h) = 2 ;

*  Overrides

*  User set parameters

Parameters
   ifLSeg(r,l)          "Labor market segmentation flag"
   uez0(r,l,z)          "Initial level of unemployment by zone"
   migr0(r,l)           "Ratio of rural to urban migration as a share of base year rural labor supply"
;

*  Labor segmentation assumptions

$ontext
   omegam:        Migration elasticity (infinity <==> no segmentation)
   migr0:         Level of migration (percent of rural labor force)
   uezRur0:       Initial level of unemployment (rural-percent, ignored if no segmentation)
   ueMinzRur0:    Natural rate of unemployment (rural-percent, ignored if no segmentation)
   uezUrb0:       Initial level of unemployment (urban-percent)
   ueMinzUrb0:    Natural rate of unemployment (urban-percent)
   resWageRur0:   Reservation wage (wrt to initial wage, rural, ignored if no segmentation)
   resWageRur0:   Reservation wage (wrt to initial wage, urban)
   omegarwg:      Elasticity of reservation wage wrt to growth
   omegarwue:     Elasticity of reservation wage wrt to unemployment rate (normally negative)
                  Model is framed in terms of 1-UE (to avoid divide by zero problem)
                  Thus the input elasticity should be with respect to 1-UE
                  eta = -omegarwue*(1-UE)/UE
   omegarwp:      Elasticity of reservation wage wrt to CPI
$offtext

parameter labHyp(r,l,*) ;
labHyp(r,l,"omegam")      = inf ;
labHyp(r,l,"migr0")       = 0 ;
labHyp(r,l,"uezRur0")     = 0 ;
labHyp(r,l,"uezUrb0")     = 0 ;
labHyp(r,l,"ueMinzRur0")  = 0 ;
labHyp(r,l,"ueMinzUrb0")  = 0 ;
labHyp(r,l,"resWageRur0") = na ;
labHyp(r,l,"resWageUrb0") = na ;
labHyp(r,l,"omegarwg")    = 0 ;
labHyp(r,l,"omegarwue")   = 0 ;
labHyp(r,l,"omegarwp")    = 0 ;


$ontext
table labHyp(r,l,*)
         omegam  migr0    uezRur0  uezUrb0 ueMinzRur0  ueMinzUrb0  resWageRur0  resWageUrb0 omegarwg omegarwue omegarwp
chn.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
xea.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
usa.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
xna.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
HYA.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
SAS.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
LAC.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
WEU.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
ECA.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
MNA.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
SSA.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0

chn.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
xea.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
usa.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
xna.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
HYA.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
SAS.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
LAC.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
WEU.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
ECA.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
MNA.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
SSA.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
;

table labHyp(r,l,*)
         omegam  migr0    uezRur0  uezUrb0 ueMinzRur0  ueMinzUrb0  resWageRur0  resWageUrb0 omegarwg omegarwue omegarwp
chn.nsk    1.0     1.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
xea.nsk    1.0     1.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
usa.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
xna.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
HYA.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
SAS.nsk    1.0     1.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
LAC.nsk    1.0     0.5     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
WEU.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
ECA.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
MNA.nsk    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
SSA.nsk    1.0     2.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0

chn.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
xea.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
usa.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
xna.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
HYA.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
SAS.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
LAC.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
WEU.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
ECA.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
MNA.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
SSA.skl    inf     0.0     0.0      0.0      0.0          0.0          na           na        0.0       0.0       0.0
;
$offtext

omegam(r,l) = labHyp(r,l,"omegam") ;
ifLSeg(r,l) = 0 ;
ifLSeg(r,l)$(omegam(r,l) ne inf) = 1 ;

sigmapow(r,elyc)     = 1.2 ;
sigmapb(r,pb,elyc)   = 1.2 ;

*  Overrides

parameter cap_out_Ratio0(r) /
Oceania      1
EU_28        1
NAmerica     1
EastAsia     1
SEAsia       1
SouthAsia    1
MENA         1
SSA          1
LatinAmer    1
RestofWorld  1
/ ;


Parameter deprT(r,t) ;
deprT(r,t) = 0.04 ;
deprT(r,t)$mapr("lmy",r) = 0.05$(years(t) le 2030) + 0.05$(years(t) gt 2030) ;
deprT(r,t)$(sameas(r,"EastAsia") or sameas(r,"SEASia"))
          = 0.06$(years(t) le 2030)
          + 0.06$(years(t) gt 2030 and years(t) le 2040)
          + 0.06$(years(t) gt 2040)
          ;

$ontext
$iftheni "%simType%" == "RcvDyn"

Parameter invTarget0(r,t) /
Oceania    .2030    25
EU_28      .2030    20
NAmerica   .2030    20
EastAsia   .2030    25
SEAsia     .2030    25
SouthAsia  .2030    25
MENA       .2030    25
SSA        .2030    28
LatinAmer  .2030    25
RestofWorld.2030    25
/ ;

$else

Parameter invTarget0(r,t) ; invTarget0(r,t) = 0 ;

$endif
$offtext

Parameters
   twt1(r,i,t)          "Twist parameter for top level national sourcing"
   tw1(r,i,aa,t)        "Twist parameter for top level agent sourcing"
   tw2(r,i,t)           "Twist parameter for second level sourcing wrt to targetted countries"
;

*  Introduce twist assumptions

twt1(r,i,t)   = 0 ;
tw1(r,i,aa,t) = 0 ;
tw2(r,i,t)    = 0 ;

set rtwtgt(rp,r)  "Targets for twist exporters (rp) for region r" ;
rtwtgt(rp,r) = no ;

*  Dangerous, this should be in the opt file
*twt1("EastAsia",i,t)$(years(t) ge 2012) = 0.02 ;
*tw1("EastAsia",i,aa,t)$(years(t) ge 2012) = 0.02 ;
*tw2("EastAsia",i,t)$(years(t) ge 2012)  = 0.02 ;
*rtwtgt("Oceania", "EastAsia") = yes ;
*rtwtgt("RestofWorld", "EastAsia") = yes ;
