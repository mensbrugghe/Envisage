* ------------------------------------------------------------------------------
*
*  Aggregate the parameters
*
* ------------------------------------------------------------------------------

sets
   v     "Vintages"     / Old, New /
;

alias(l0, lab) ; alias(cap0, capt) ; alias(lnd0, land) ; alias(nrf0, ntrs) ;alias(e0, erg) ;

*  To override GTAP parameters set following two flags to 1

scalars
   OVRRIDEGTAPARM    / %1 /
   OVRRIDEGTAPINC    / %2 /
;

parameters

*  Production elasticities

   sigmaxp(r0,a0,v)        "CES between GHG and XP"
   sigmap(r0,a0,v)         "CES between ND1 and VA"
   sigmav(r0,a0,v)         "CES between LAB1 and VA1 in crops and other, VA1 and VA2 in livestock"
   sigmav1(r0,a0,v)        "CES between ND2 (fert) and VA2 in crops, LAB1 and KEF in livestock and land and KEF in other"
   sigmav2(r0,a0,v)        "CES between land and KEF in crops, land and ND2 (feed) in livestock. Not used in other"
   sigmakef(r0,a0,v)       "CES between KF and NRG"
   sigmakf(r0,a0,v)        "CES between KSW and NRF"
   sigmakw(r0,a0,v)        "CES between KS and XWAT"
   sigmak(r0,a0,v)         "CES between LAB2 and K"
   sigmaul(r0,a0)          "CES across unskilled labor"
   sigmasl(r0,a0)          "CES across skilled labor"
   sigman1(r0,a0)          "CES across intermediate demand in ND1 bundle"
   sigman2(r0,a0)          "CES across intermediate demand in ND2 bundle"
   sigmawat(r0,a0)         "CES across intermediate demand in WAT bundle"
   sigmae(r0,a0,v)         "CES between ELY and NELY in energy bundle"
   sigmanely(r0,a0,v)      "CES between COA and OLG in energy bundle"
   sigmaolg(r0,a0,v)       "CES between OIL and GAS in energy bundle"
   sigmaNRG(r0,a0,NRG,v)   "CES within each of the NRG bundles"

*  Make matrix elasticities (incl. power)

   omegas(r0,a0)           "Make matrix transformation elasticities: one activity --> many commodities"
   sigmas(r0,i0)           "Make matrix substitution elasticities: one commodity produced by many activities"
   sigmael(r0)             "Substitution between power and distribution and transmission"
   sigmapow(r0)            "Substitution across power bundles"
   sigmapb(r0)             "Substitution across power activities within power bundles"

*  Final demand elasticities

   incElas(r0,i0)          "Income elasticities"
   nu(r0)                  "Elasticity of subsitution between energy and non-energy bundles in HH consumption"
   nunnrg(r0)              "Substitution elasticity across non-energy commodities in the non-energy bundle"
   nue(r0)                 "Substitution elasticity between ELY and NELY bundle"
   nunely(r0)              "Substitution elasticity beteen COL and OLG bundle"
   nuolg(r0)               "Substitution elasticity between OIL and GAS bundle"
   nuNRG(r0,NRG)           "Substitution elasticity within NRG bundles"
   sigma_gov(r0)           "CES expenditure elasticity for government"
   sigma_inv(r0)           "CES expenditure elasticity for investment"

*  Trade elasticities

   sigmam(r0,i0)           "Top level Armington elasticity"
   sigmaw(r0,i0)           "Second level Armington elasticity"
   omegax(r0,i0)           "Top level CET export elasticity"
   omegaw(r0,i0)           "Second level CET export elasticity"
   sigmamg(i0)             "CES 'Make' elasticity for intl. trade and transport services"

*  Factor supply elasticities

   omegak(r0)              "CET capital mobility elasticity in comp. stat. model"
   etat(r0)                "Aggregate land supply elasticity"
   landMax(r0)             "Initial ratio of land maximum wrt to land use"
   omegat(r0)              "Land elasticity between intermed. land bundle and first land bundle"
   omeganlb(r0)            "Land elasticity across intermediate land bundles"
   omegalb(r0,lb0)         "Land elasticity within land bundles"
   etanrf(r0,a0)           "Natural resource supply elasticity"
   invElas(r0,a0)          "Dis-investment elasticity"

   omegam(r0)              "Elasticity of migration"
;

*  Load the disaggregated elasticities

execute_load "%EnvElast%"
   sigmaxp=sigmaxp0, sigmap=sigmap0, sigman1=sigman10, sigman2=sigman20, sigmawat=sigmawat0,
   sigmav=sigmav0, sigmav1=sigmav10, sigmav2=sigmav20,
   sigmakef=sigmakef0, sigmakf=sigmakf0, sigmakw=sigmakw0, sigmak=sigmak0,
   sigmaul=sigmaul0, sigmasl=sigmasl0,
   sigmae=sigmae0, sigmanely=sigmanely0, sigmaolg=sigmaolg0, sigmaNRG=sigmaNRG0
   omegas=omegas0, sigmas=sigmas0,
   sigmael=sigmael0, sigmapow=sigmapow0, sigmapb=sigmapb0,
   incElas=incElas0, nu=nu0, nunnrg=nunnrg0,nue=nue0, nunely=nunely0, nuolg=nuolg0, nuNRG=nuNRG0
   sigma_gov=sigma_gov0, sigma_inv=sigma_inv0
   sigmam=sigmam0, sigmaw=sigmaw0, omegax=omegax0, omegaw=omegaw0, sigmamg=sigmamg0
   omegak=omegak0, invElas=invElas0, etat=etat0, landMax=landMax0,
   omegat=omegat0, omeganlb=omeganlb0, omegalb=omegalb0,
   etanrf=etanrf0, omegam=omegam0
;
display sigmaNRG ;

parameters

*  Production elasticities

   sigmaxp0(r,actf,v)      "CES between GHG and XP"
   sigmap0(r,actf,v)       "CES between ND1 and VA"
   sigmav0(r,actf,v)       "CES between LAB1 and VA1 in crops and other, VA1 and VA2 in livestock"
   sigmav10(r,actf,v)      "CES between ND2 (fert) and VA2 in crops, LAB1 and KEF in livestock and land and KEF in other"
   sigmav20(r,actf,v)      "CES between land and KEF in crops, land and ND2 (feed) in livestock. Not used in other"
   sigmakef0(r,actf,v)     "CES between KF and NRG"
   sigmakf0(r,actf,v)      "CES between KSW and NRF"
   sigmakw0(r,actf,v)      "CES between KS and XWAT"
   sigmak0(r,actf,v)       "CES between LAB2 and K"
   sigmaul0(r,actf)        "CES across unskilled labor"
   sigmasl0(r,actf)        "CES across skilled labor"
   sigman10(r,actf)        "CES across intermediate demand in ND1 bundle"
   sigman20(r,actf)        "CES across intermediate demand in ND2 bundle"
   sigmawat0(r,actf)       "CES across intermediate demand in XWAT bundle"
   sigmae0(r,actf,v)       "CES between ELY and NELY in energy bundle"
   sigmanely0(r,actf,v)    "CES between COA and OLG in energy bundle"
   sigmaolg0(r,actf,v)     "CES between OIL and GAS in energy bundle"
   sigmaNRG0(r,actf,NRG,v) "CES within each of the NRG bundles"

*  Make matrix elasticities (incl. power)

   omegas0(r,actf)         "Make matrix transformation elasticities: one activity --> many commodities"
   sigmas0(r,commf)        "Make matrix substitution elasticities: one commodity produced by many activities"
   sigmael0(r,elyc)        "Substitution between power and distribution and transmission"
   sigmapow0(r,elyc)       "Substitution across power bundles"
   sigmapb0(r,pb,elyc)     "Substitution across power activities within power bundles"

*  Final demand elasticities

   incElas0(k,r)           "Income elasticities"
   nu0(r,k,h)              "Elasticity of subsitution between energy and non-energy bundles in HH consumption"
   nunnrg0(r,k,h)          "Substitution elasticity across non-energy commodities in the non-energy bundle"
   nue0(r,k,h)             "Substitution elasticity between ELY and NELY bundle"
   nunely0(r,k,h)          "Substitution elasticity beteen COL and OLG bundle"
   nuolg0(r,k,h)           "Substitution elasticity between OIL and GAS bundle"
   nuNRG0(r,k,h,NRG)       "Substitution elasticity within NRG bundles"
   sigmafd0(r,fd)          "CES expenditure elasticity for other final demand"

*  Trade elasticities

   sigmam0(r,commf)        "Top level Armington elasticity"
   sigmaw0(r,commf)        "Second level Armington elasticity"
   omegax0(r,commf)        "Top level CET export elasticity"
   omegaw0(r,commf)        "Second level CET export elasticity"
   sigmamg0(commf)         "CES 'Make' elasticity for intl. trade and transport services"

*  Factor supply elasticities

   omegak0(r)              "CET capital mobility elasticity in comp. stat. model"
   etat0(r)                "Aggregate land supply elasticity"
   landMax00(r)            "Initial ratio of land maximum wrt to land use"
   omegat0(r)              "Land elasticity between intermed. land bundle and first land bundle"
   omeganlb0(r)            "Land elasticity across intermediate land bundles"
   omegalb0(r,lb)          "Land elasticity within land bundles"
   etanrf0(r,actf)         "Natural resource supply elasticity"
   invElas0(r,actf)        "Dis-investment elasticity"

   omegam0(r,l)            "Elasticity of migration"
;

*  Calculate weights
*  !!!! NEED TO REVIEW AGGREGATION AND WEIGHTS

Parameters
   xp0(r0,a0)        Production weights
   xpp0(r0,elya0)    Power production weights
   va0(r0,a0)        VA weights
   kap0(r0,a0)       K weights
   lab0(r0,a0)       Total labor weights
   nrg0(r0,a0)       Total energy weights
   nd0(r0,a0)        Intermediate weights
   nrg0(r0,a0)       Energy weights
   denom             Working variable
;

xp0(r0,a0)  = voa(a0,r0) ;
va0(r0,a0)  = sum(endw, evfp(endw, a0, r0)) ;
lab0(r0,a0) = sum(l0, evfp(l0,a0,r0)) ;
kap0(r0,a0) = sum(cap0, evfp(cap0, a0, r0)) ;

*  Production elasticities

$batinclude aggrav sigmaxp  xp0  sigmaxp0
$batinclude aggrav sigmap   xp0  sigmap0
$batinclude aggrav sigmav   va0  sigmav0
$batinclude aggrav sigmav   va0  sigmav0
$batinclude aggrav sigmav1  va0  sigmav10
$batinclude aggrav sigmav2  va0  sigmav10
$batinclude aggrav sigmakef va0  sigmakef0
$batinclude aggrav sigmakf  va0  sigmakf0
$batinclude aggrav sigmakw  va0  sigmakf0
$batinclude aggrav sigmak   va0  sigmak0
$batinclude aggra  sigmaul  lab0 sigmaul0
$batinclude aggra  sigmasl  lab0 sigmasl0

nd0(r0,a0) = sum((i0,i,commf)$(mapa(i0,i) and mapif(i, commf) and not frt(commf) and not e(commf)), vdfp(i0,a0,r0) + vmfp(i0,a0,r0))$acr0(a0)
           + sum((i0,i,commf)$(mapa(i0,i) and mapif(i, commf) and not feed(commf) and not e(commf)), vdfp(i0,a0,r0) + vmfp(i0,a0,r0))$alv0(a0)
           + sum((i0,i,commf)$(mapa(i0,i) and mapif(i, commf) and not e(commf)), vdfp(i0,a0,r0) + vmfp(i0,a0,r0))$(not acr0(a0) and not alv0(a0))
           ;
$batinclude aggra sigman1  nd0 sigman10

nd0(r0,a0) = sum((i0,i,commf)$(mapa(i0,i) and mapif(i, commf) and frt(commf)), vdfp(i0,a0,r0) + vmfp(i0,a0,r0))$acr0(a0)
           + sum((i0,i,commf)$(mapa(i0,i) and mapif(i, commf) and feed(commf)), vdfp(i0,a0,r0) + vmfp(i0,a0,r0))$alv0(a0)
           + 0$(not acr0(a0) and not alv0(a0))
           ;
$batinclude aggra sigman2  nd0 sigman20

nd0(r0,a0) = sum((i0,i,commf)$(mapa(i0,i) and mapif(i, commf) and iw(commf)), vdfp(i0,a0,r0) + vmfp(i0,a0,r0)) ;

$batinclude aggra sigmawat  nd0 sigmawat0

nrg0(r0,a0) = sum((e0,i,e)$(mapa(e0,i) and mapif(i, e)), vdfp(e0,a0,r0) + vmfp(e0,a0,r0)) ;

$batinclude aggrav sigmae nrg0 sigmae0

nrg0(r0,a0) = sum((e0,i,e)$(mapa(e0,i) and mapif(i, e) and not mape("ely",e)), vdfp(e0,a0,r0) + vmfp(e0,a0,r0)) ;

display nrg0, sigmanely ;
$batinclude aggrav sigmanely nrg0 sigmanely0
display sigmanely0 ;

nrg0(r0,a0) = sum((e0,i,e)$(mapa(e0,i) and mapif(i, e) and mape("oil",e) and mape("gas",e)), vdfp(e0,a0,r0) + vmfp(e0,a0,r0)) ;

$batinclude aggrav sigmaolg nrg0 sigmaolg0

loop(nrg,
   nrg0(r0,a0) = sum((e0,i,e)$(mapa(e0,i) and mapif(i, e) and mape(nrg,e)), vdfp(e0,a0,r0) + vmfp(e0,a0,r0)) ;
$batinclude aggrave sigmaNRG nrg0 sigmaNRG0
) ;

*  Make matrix elasticities including power

* !!!! There are no standard elasticities for 'make' matrix for the moment

omegas0(r,actf) = 2 ;
sigmas0(r,commf) = 2 ;

*  !!!! There are no standard elasticities for 'power' bundle

xpp0(r0,elya0) = sum(fp0, evfp(fp0, elya0, r0)) + sum(i0, vdfp(i0, elya0, r0) + vmfp(i0, elya0, r0)) ;
loop((r,elyc),
*  Calculate weight for power across regions
   denom = sum((r0,elya0)$mapr(r0,r), xpp0(r0,elya0)) ;
   sigmael0(r,elyc)$denom  = sum((r0,elya0)$mapr(r0,r), xpp0(r0,elya0)*sigmael(r0))/denom ;
   sigmapow0(r,elyc)$denom = sum((r0,elya0)$mapr(r0,r), xpp0(r0,elya0)*sigmapow(r0))/denom ;
   sigmapb0(r,pb,elyc)$denom = sum((r0,elya0)$mapr(r0,r), xpp0(r0,elya0)*sigmapb(r0))/denom ;
) ;


*  Final demand elasticities

*  Calculate the GTAP-based income elasticities

Parameters
   b_c(k,r)       "Substitution parameter for final disaggregation"
   e_c(k,r)       "Expansion parameter for final disaggregation"
   s_c(k,r)       "Share parameter for final disaggregation"
   incElasG(k,r)  "GTAP income elasticity"
;

alias(k,kp) ;

s_c(k,r) = sum((i0,i,commf,r0)$(mapa(i0,i) and mapif(i,commf) and mapk(commf,k) and mapr(r0,r)), vdpp(i0,r0) + vmpp(i0,r0)) ;
e_c(k,r)$s_c(k,r)
          = sum((i0,i,commf,r0)$(mapa(i0,i) and mapif(i,commf) and mapk(commf,k) and mapr(r0,r)), incPar(i0,r0)*(vdpp(i0,r0) + vmpp(i0,r0)))
          / s_c(k,r) ;
b_c(k,r)$s_c(k,r)
          = sum((i0,i,commf,r0)$(mapa(i0,i) and mapif(i,commf) and mapk(commf,k) and mapr(r0,r)), subPar(i0,r0)*(vdpp(i0,r0) + vmpp(i0,r0)))
          / s_c(k,r) ;

s_c(k,r) = s_c(k,r) / sum((i0,r0)$mapr(r0,r), vdpp(i0,r0) + vmpp(i0,r0)) ;

incElasG(k,r) = (e_c(k,r)*b_c(k,r) - sum(kp, s_c(kp,r)*e_c(kp,r)*b_c(kp,r)))
              / sum(kp, s_c(kp,r)*e_c(kp,r))
              - (b_c(k,r)-1) + sum(kp, s_c(kp,r)*b_c(kp,r)) ;

*  Aggregate the income elasticity in the default ENV parameter file

incElas0(k,r) = sum((i0,i,commf,r0)$(mapa(i0,i) and mapif(i, commf) and mapk(commf,k) and mapr(r0,r)), vdpp(i0, r0) + vmpp(i0, r0)) ;
incElas0(k,r)$incElas0(k,r) = sum((i0,i,commf,r0)$(mapa(i0,i) and mapif(i, commf) and mapk(commf,k) and mapr(r0,r)), incElas(r0,i0)*(vdpp(i0, r0) + vmpp(i0, r0)))/incElas0(k,r) ;

* display b_c, e_c, s_c, incElasG, incElas0 ;

if(OVRRIDEGTAPINC,
   incElasG(k,r) = incElas0(k,r) ;
else
   incElas0(k,r) = incElasG(k,r) ;
) ;

loop(r,
   denom = sum((r0,i0)$(mapr(r0,r)), vdpp(i0,r0) + vmpp(i0,r0)) ;
   nu0(r,k,h)$denom = sum((r0,i0)$(mapr(r0,r)), (vdpp(i0,r0) + vmpp(i0,r0))*nu(r0))/denom ;
   denom = sum((r0,i0)$(mapr(r0,r) and not e0(i0)), vdpp(i0,r0) + vmpp(i0,r0)) ;
   nunnrg0(r,k,h)$denom = sum((r0,i0)$(mapr(r0,r) and not e0(i0)), (vdpp(i0,r0) + vmpp(i0,r0))*nunnrg(r0))/denom ;
   denom = sum((r0,e0)$(mapr(r0,r)), vdpp(e0,r0) + vmpp(e0,r0)) ;
   nue0(r,k,h)$denom = sum((r0,e0)$(mapr(r0,r)), (vdpp(e0,r0) + vmpp(e0,r0))*nue(r0))/denom ;
   denom = sum((r0,e0,e)$(mapr(r0,r) and not mape("ely",e)), vdpp(e0,r0) + vmpp(e0,r0)) ;
   nunely0(r,k,h)$denom = sum((r0,e0,e)$(mapr(r0,r) and not mape("ely",e)), (vdpp(e0,r0) + vmpp(e0,r0))*nunely(r0))/denom ;
   denom = sum((r0,e0,e)$(mapr(r0,r) and (mape("oil",e) or mape("gas",e))), vdpp(e0,r0) + vmpp(e0,r0)) ;
   nuolg0(r,k,h)$denom = sum((r0,e0,e)$(mapr(r0,r) and (mape("oil",e) or mape("gas",e))), (vdpp(e0,r0) + vmpp(e0,r0))*nuolg(r0))/denom ;
   loop(NRG,
      denom = sum((r0,e0,e)$(mapr(r0,r) and mape(nrg,e)), vdpp(e0,r0) + vmpp(e0,r0)) ;
      nuNRG0(r,k,h,NRG)$denom = sum((r0,e0,e)$(mapr(r0,r) and mape(nrg,e)), (vdpp(e0,r0) + vmpp(e0,r0))*nuNRG(r0,NRG))/denom ;
   ) ;
) ;

loop(r,
*  Government
   denom = sum((r0,i0)$(mapr(r0,r)), vdgp(i0,r0) + vmgp(i0,r0)) ;
   sigmafd0(r,gov)$denom = sum((r0,i0)$(mapr(r0,r)), (vdgp(i0,r0) + vmgp(i0,r0))*sigma_gov(r0))/denom ;

*  Investment
   denom = sum((r0,i0)$(mapr(r0,r)), vdip(i0,r0) + vmip(i0,r0)) ;
   sigmafd0(r,inv)$denom = sum((r0,i0)$(mapr(r0,r)), (vdip(i0,r0) + vmip(i0,r0))*sigma_inv(r0))/denom ;
) ;

*  Trade elasticities

*  Top level Armington -- weight is domestic and import demand at agents' price

sigmam0(r,commf) = sum((r0,i0,i)$(mapa(i0,i) and mapif(i,commf) and mapr(r0,r)),
   sum(a0, (vdfp(i0,a0,r0)+ vmfp(i0,a0,r0))) + (vdpp(i0,r0) + vmpp(i0,r0)) + (vdgp(i0, r0) + vmgp(i0, r0))) ;

sigmam0(r,commf)$sigmam0(r,commf) = sum((r0,i0,i)$(mapa(i0,i) and mapif(i,commf) and mapr(r0,r)), sigmam(r0,i0)*
   (sum(a0, (vdfp(i0,a0,r0)+ vmfp(i0,a0,r0))) + (vdpp(i0,r0) + vmpp(i0,r0)) + (vdgp(i0, r0) + vmgp(i0, r0))))/sigmam0(r,commf) ;

*  Second level Armington -- weight is import demand at agents' price

sigmaw0(r,commf) = sum((r0,i0,i)$(mapa(i0,i) and mapif(i,commf) and mapr(r0,r)), sum(a0, vmfp(i0,a0,r0)) + vmpp(i0,r0) + vmgp(i0, r0)) ;
sigmaw0(r,commf)$sigmaw0(r,commf) =
   sum((r0,i0,i)$(mapa(i0,i) and mapif(i,commf) and mapr(r0,r)), sigmaw(r0,i0)*(sum(a0, vmfp(i0,a0,r0)) + vmpp(i0,r0) + vmgp(i0, r0)))/sigmaw0(r,commf) ;

*  !!!! LETS REVIEW -- We probably don't want to override here...
$ontext
if(OVRRIDEGTAPARM,
   esubd1(commf,r) = sigmam0(r,commf) ;
   esubm1(commf,r) = sigmaw0(r,commf) ;
else
   sigmam0(r,commf) = esubd1(commf,r) ;
   sigmaw0(r,commf) = esubm1(commf,r) ;
) ;
$offtext

display omegax ;
loop((r,commf),

*  Top level CET -- weight is domestic demand at market price + exports at market price + exports of TT services

   denom = sum((r0,i0,i)$(mapa(i0,i) and mapif(i,commf) and mapr(r0,r)),
               sum(a0, vdfb(i0,a0,r0)) + vdpb(i0,r0) + vdgb(i0, r0) + vdib(i0, r0) + sum(rp0, vxsb(i0,r0,rp0)))
         + sum((r0,marg,i)$(mapa(marg,i) and mapif(i,commf) and mapr(r0,r)), vst(marg,r0)) ;
   if(denom,
      omegax0(r,commf) = sum((r0,i0,i)$(mapa(i0,i) and mapif(i,commf) and mapr(r0,r)),
         (omegax(r0,i0)$(omegax(r0,i0) ne inf))*(sum(a0, vdfb(i0,a0,r0)) + vdpb(i0,r0) + vdgb(i0, r0) + vdib(i0, r0) + sum(rp0, vxsb(i0,r0,rp0)))
         +  inf$(omegax(r0,i0) eq inf))
         + sum((r0,marg,i)$(mapa(marg,i) and mapif(i,commf) and mapr(r0,r)), omegax(r0,marg)*vst(marg,r0)
         + inf$(omegax(r0,marg) eq inf)) ;
      if(omegax0(r,commf) ne inf,
         omegax0(r,commf) = omegax0(r,commf)/denom ;
      ) ;
   ) ;

*  Second level CET -- weight is exports at market price

   denom = sum((r0,i0,i)$(mapa(i0,i) and mapif(i,commf) and mapr(r0,r)), sum(rp0, vxsb(i0,r0,rp0))) ;
   if(denom,
      omegaw0(r,commf) = sum((r0,i0,i)$(mapa(i0,i) and mapif(i,commf) and mapr(r0,r)), (omegaw(r0,i0)$(omegaw(r0,i0) ne inf))*sum(rp0, vxsb(i0,r0,rp0))
                   +    inf$(omegaw(r0,i0) eq inf)) ;
      if(omegaw0(r,commf) ne inf,
         omegaw0(r,commf) = omegaw0(r,commf)/denom ;
      ) ;
   ) ;
) ;
display omegax0 ;

*  Intl. trade margins 'make' elasticity -- weight is aggregate TT services

sigmamg0(commf) = sum((r0,marg,i)$(mapa(marg,i) and mapif(i,commf)), vst(marg,r0)) ;
sigmamg0(commf)$sigmamg0(commf) = sum((r0,marg,i)$(mapa(marg,i) and mapif(i,commf)),
   sigmamg(marg)*vst(marg,r0))/sigmamg0(commf) ;

*  Factor supply elasticities

*  Capital mobility for comp. stat. model -- weight is capital remuneration

loop(r,
   denom = sum((r0,a0)$(mapr(r0,r)), kap0(r0,a0)) ;
   if(denom,
      omegak0(r) = sum((r0,a0)$(mapr(r0,r)), (omegak(r0)*kap0(r0,a0))$(omegak(r0) ne inf) + (inf)$(omegak(r0) eq inf)) ;
      if(omegak0(r) ne inf,
         omegak0(r) = omegak0(r)/denom ;
      ) ;
   ) ;
) ;

*  Land elasticity -- weight is total land remuneration

etat0(r) = sum((r0,a0,lnd0)$(mapr(r0,r)), evfp(lnd0,a0,r0)) ;
etat0(r)$etat0(r) = sum((r0,a0,lnd0)$(mapr(r0,r)), etat(r0)*evfp(lnd0,a0,r0))/etat0(r) ;

*  Land potential -- weight is total land remuneration

landMax00(r) = sum((r0,a0,lnd0)$(mapr(r0,r)), evfp(lnd0,a0,r0)) ;
landMax00(r)$landMax00(r) = sum((r0,a0,lnd0)$(mapr(r0,r)), landMax(r0)*evfp(lnd0,a0,r0))/landMax00(r) ;

*  Top level land allocation elasticity -- weight is total land remuneration

loop(r,
   denom = sum((r0,a0,lnd0)$(mapr(r0,r)), evfp(lnd0,a0,r0)) ;
   if(denom,
      omegat0(r) = sum((r0,a0,lnd0)$(mapr(r0,r)), (omegat(r0)*evfp(lnd0,a0,r0))$(omegat(r0) ne inf) + (inf)$(omegat(r0) eq inf)) ;
      if(omegat0(r) ne inf,
         omegat0(r) = omegat0(r)/denom ;
      ) ;
   ) ;
) ;

* Intermediate land bundle -- weight is total land remuneration for land not in bundle 1

loop(r,
   denom = sum((r0,a0,lnd0,i,actf,lb1)$(mapr(r0,r) and mapa(a0,i) and mapaf(i,actf) and not maplb(lb1,actf)), evfp(lnd0,a0,r0)) ;
   if(denom,
      omeganlb0(r) = sum((r0,a0,lnd0,i,actf,lb1)$(mapr(r0,r) and mapa(a0,i) and mapaf(i,actf) and not maplb(lb1,actf)), omeganlb(r0)*evfp(lnd0,a0,r0)) ;
      if(omeganlb0(r) ne inf,
         omeganlb0(r) = omeganlb0(r)/denom ;
      ) ;
   ) ;
) ;

*  Bottom level land bundles -- weight is total land remuneration of the bundles

display omegalb ;

loop((r,lb),
   denom = sum((r0,a0,lnd0,i,actf)$(mapr(r0,r) and mapa(a0,i) and mapaf(i,actf) and maplb(lb,actf)), evfp(lnd0,a0,r0)) ;
   if(denom,
      omegalb0(r,lb) = sum((r0,a0,lnd0,i,actf,lb0)$(mapr(r0,r) and mapa(a0,i) and mapaf(i,actf) and maplb(lb,actf) and maplb0(lb,lb0)), omegalb(r0,lb0)*evfp(lnd0,a0,r0)) ;
      if(omegalb0(r,lb) ne inf,
         omegalb0(r,lb) = omegalb0(r,lb)/denom ;
      ) ;
   ) ;
) ;

*  Elasticity of supply of natural resources -- weight is total natl. res. remuneration

loop((r,actf),
   denom = sum((r0,a0,nrf0,i)$(mapr(r0,r) and mapa(a0,i) and mapaf(i,actf)), evfp(nrf0,a0,r0)) ;
   etanrf0(r,actf)$denom = sum((r0,a0,nrf0,i)$(mapr(r0,r) and mapa(a0,i) and mapaf(i,actf)), etanrf(r0,a0)*evfp(nrf0,a0,r0))/denom ;
) ;

*  Dis-investment elasticity -- weight is capital remuneration

display evfp ;
loop((r,actf),
   denom = sum((r0,a0,cap0,i)$(mapr(r0,r) and mapa(a0,i) and mapaf(i,actf)), evfp(cap0,a0,r0)) ;
   invElas0(r,actf)$denom = sum((r0,a0,cap0,i)$(mapr(r0,r) and mapa(a0,i) and mapaf(i,actf)), invElas(r0,a0)*evfp(cap0,a0,r0))/denom ;
$ontext
   if(0 and sameas("nuc", actf),
      put screen ;
      loop((r0,a0,i)$(mapr(r0,r) and mapa(a0,i) and mapaf(i,actf)),
         loop(cap0,
            put r.tl, actf.tl, r0.tl, a0.tl, evfp(cap0, a0, r0):15:9, denom:15:4, InvElas(r0,a0):10:4, invElas0(r,actf):10:4 / ;
         ) ;
      ) ;
   ) ;
$offtext
) ;

*  Migration elasticity -- weight is labor remuneration in rural activities

omegam0(r,l) = sum((r0,l0,a0,i,actf,rur)
             $(mapr(r0,r) and mapa(a0,i) and mapaf(i,actf) and mapzf(rur,actf) and mapf(l0,l)),
                  evfb(l0,a0,r0)) ;
omegam0(r,l)$omegam0(r,l) = sum((r0,l0,a0,i,actf,rur)
             $(mapr(r0,r) and mapa(a0,i) and mapaf(i,actf) and mapzf(rur,actf) and mapf(l0,l)),
                  omegam(r0)*evfb(l0,a0,r0))/omegam0(r,l) ;

execute_unload "%baseName%/agg/%baseName%Prm.gdx"
   sigmaxp0, sigmap0, sigman10, sigman20, sigmawat0,
   sigmav0, sigmav10, sigmav20,
   sigmakef0, sigmakf0, sigmakw0, sigmak0,
   sigmaul0, sigmasl0,
   sigmae0, sigmanely0, sigmaolg0, sigmaNRG0,
   omegas0, sigmas0,
   sigmael0, sigmapow0, sigmapb0,
   incElas0, e_c=eh0, b_c=bh0, nu0, nunnrg0, nue0, nunely0, nuolg0, nuNRG0, sigmafd0
   sigmam0, sigmaw0, omegax0, omegaw0, sigmamg0
   omegak0, invElas0, etat0, landMax00,
   omegat0, omeganlb0, omegalb0,
   etanrf0, omegam0
;

display sigmanrg0 ;
