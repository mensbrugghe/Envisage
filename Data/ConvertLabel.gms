$include "%baseName%/Fnl/%baseName%Sets.gms"
$include "tmpSets.gms"

set v / Old, New / ;

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
   sigmael0(r,elycf)       "Substitution between power and distribution and transmission"
   sigmapow0(r,elycf)      "Substitution across power bundles"
   sigmapb0(r,pb,elycf)    "Substitution across power activities within power bundles"

*  Final demand elasticities

   incElas0(kf,r)          "Income elasticities"
   eh0(kf,r)               "CDE expansion parameter"
   bh0(kf,r)               "CDE substitution parameter"
   nu0(r,kf,h)             "Elasticity of subsitution between energy and non-energy bundles in HH consumption"
   nunnrg0(r,kf,h)         "Substitution elasticity across non-energy commodities in the non-energy bundle"
   nue0(r,kf,h)            "Substitution elasticity between ELY and NELY bundle"
   nunely0(r,kf,h)         "Substitution elasticity beteen COL and OLG bundle"
   nuolg0(r,kf,h)          "Substitution elasticity between OIL and GAS bundle"
   nuNRG0(r,kf,h,NRG)      "Substitution elasticity within NRG bundles"
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

execute_loaddc "%baseName%/Agg/%baseName%Prm.gdx"
   sigmaxp0, sigmap0, sigman10, sigman20, sigmawat0,
   sigmav0, sigmav10, sigmav20,
   sigmakef0, sigmakf0, sigmakw0, sigmak0,
   sigmaul0, sigmasl0,
   sigmae0, sigmanely0, sigmaolg0, sigmaNRG0,
   omegas0, sigmas0,
   sigmael0, sigmapow0, sigmapb0,
   incElas0, eh0, bh0, nu0, nunnrg0, nue0, nunely0, nuolg0, nuNRG0, sigmafd0
   sigmam0, sigmaw0, omegax0, omegaw0, sigmamg0
   omegak0, invElas0, etat0, landMax00,
   omegat0, omeganlb0, omegalb0,
   etanrf0, omegam0
;

parameters

*  Production elasticities

   sigmaxp(r,a,v)      "CES between GHG and XP"
   sigmap(r,a,v)       "CES between ND1 and VA"
   sigmav(r,a,v)       "CES between LAB1 and VA1 in crops and other, VA1 and VA2 in livestock"
   sigmav1(r,a,v)      "CES between ND2 (fert) and VA2 in crops, LAB1 and KEF in livestock and land and KEF in other"
   sigmav2(r,a,v)      "CES between land and KEF in crops, land and ND2 (feed) in livestock. Not used in other"
   sigmakef(r,a,v)     "CES between KF and NRG"
   sigmakf(r,a,v)      "CES between KSW and NRF"
   sigmakw(r,a,v)      "CES between KS and XWAT"
   sigmak(r,a,v)       "CES between LAB2 and K"
   sigmaul(r,a)        "CES across unskilled labor"
   sigmasl(r,a)        "CES across skilled labor"
   sigman1(r,a)        "CES across intermediate demand in ND1 bundle"
   sigman2(r,a)        "CES across intermediate demand in ND2 bundle"
   sigmawat(r,a)       "CES across intermediate demand in XWAT bundle"
   sigmae(r,a,v)       "CES between ELY and NELY in energy bundle"
   sigmanely(r,a,v)    "CES between COA and OLG in energy bundle"
   sigmaolg(r,a,v)     "CES between OIL and GAS in energy bundle"
   sigmaNRG(r,a,NRG,v) "CES within each of the NRG bundles"

*  Make matrix elasticities (incl. power)

   omegas(r,a)         "Make matrix transformation elasticities: one activity --> many commodities"
   sigmas(r,i)        "Make matrix substitution elasticities: one commodity produced by many activities"
   sigmael(r,elyc)        "Substitution between power and distribution and transmission"
   sigmapow(r,elyc)       "Substitution across power bundles"
   sigmapb(r,pb,elyc)     "Substitution across power activities within power bundles"

*  Final demand elasticities

   incElas(k,r)           "Income elasticities"
   eh(k,r)                "CDE expansion parameter"
   bh(k,r)                "CDE substitution parameter"
   nu(r,k,h)              "Elasticity of subsitution between energy and non-energy bundles in HH consumption"
   nunnrg(r,k,h)          "Substitution elasticity across non-energy commodities in the non-energy bundle"
   nue(r,k,h)             "Substitution elasticity between ELY and NELY bundle"
   nunely(r,k,h)          "Substitution elasticity beteen COL and OLG bundle"
   nuolg(r,k,h)           "Substitution elasticity between OIL and GAS bundle"
   nuNRG(r,k,h,NRG)       "Substitution elasticity within NRG bundles"
   sigmafd(r,fd)          "CES expenditure elasticity for other final demand"

*  Trade elasticities

   sigmam(r,i)        "Top level Armington elasticity"
   sigmaw(r,i)        "Second level Armington elasticity"
   omegax(r,i)        "Top level CET export elasticity"
   omegaw(r,i)        "Second level CET export elasticity"
   sigmamg(i)         "CES 'Make' elasticity for intl. trade and transport services"

*  Factor supply elasticities

   omegak(r)              "CET capital mobility elasticity in comp. stat. model"
   etat(r)                "Aggregate land supply elasticity"
   landMax0(r)            "Initial ratio of land maximum wrt to land use"
   omegat(r)              "Land elasticity between intermed. land bundle and first land bundle"
   omeganlb(r)            "Land elasticity across intermediate land bundles"
   omegalb(r,lb)          "Land elasticity within land bundles"
   etanrf(r,a)         "Natural resource supply elasticity"
   invElas(r,a)        "Dis-investment elasticity"

   omegam(r,l)            "Elasticity of migration"
;

$macro convav(sigma,sufx)    sigma(r,a,v) = sum(actf$mapact(a,actf), &sigma&sufx(r,actf,v))
$macro conva(sigma,sufx)     sigma(r,a) = sum(actf$mapact(a,actf), &sigma&sufx(r,actf))
$macro convavn(sigma,sufx)   sigma(r,a,NRG,v) = sum(actf$mapact(a,actf), &sigma&sufx(r,actf,NRG,v))
$macro convi0(sigma,sufx)    sigma(i) = sum(commf$mapcomm(i,commf), &sigma&sufx(commf))
$macro convi(sigma,sufx)     sigma(r,i) = sum(commf$mapcomm(i,commf), &sigma&sufx(r,commf))
$macro conve(sigma,sufx)     sigma(r,elyc) = sum(elycf$mapcomm(elyc,elycf), &sigma&sufx(r,elycf))
$macro convep(sigma,sufx)    sigma(r,pb,elyc) = sum(elycf$mapcomm(elyc,elycf), &sigma&sufx(r,pb,elycf))
$macro convk(sigma,sufx)     sigma(k,r) = sum(kf$mapkcomm(k,kf), &sigma&sufx(kf,r))
$macro convkh(sigma,sufx)    sigma(r,k,h) = sum(kf$mapkcomm(k,kf), &sigma&sufx(r,kf,h))
$macro convkhn(sigma,sufx)   sigma(r,k,h,NRG) = sum(kf$mapkcomm(k,kf), &sigma&sufx(r,kf,h,NRG))

convav(sigmaxp,0) ;
convav(sigmap,0) ;
convav(sigmav,0) ;
convav(sigmav1,0) ;
convav(sigmav2,0) ;
convav(sigmakef,0) ;
convav(sigmakf,0) ;
convav(sigmakw,0) ;
convav(sigmak,0) ;
conva(sigmaul,0) ;
conva(sigmasl,0) ;
conva(sigman1,0) ;
conva(sigman2,0) ;
conva(sigmawat,0) ;
convav(sigmae,0) ;
convav(sigmanely,0) ;
convav(sigmaolg,0) ;
convavn(sigmaNRG,0) ;

conva(omegas,0) ;
convi(sigmas,0) ;
conve(sigmael,0) ;
conve(sigmapow,0) ;
convep(sigmapb,0) ;

convk(incElas,0) ;
convk(eh,0) ;
convk(bh,0) ;
convkh(nu,0) ;
convkh(nunnrg,0) ;
convkh(nue,0) ;
convkh(nunely,0) ;
convkh(nuolg,0) ;
convkhn(nuNRG,0) ;

sigmafd(r,fd) = sigmafd0(r,fd) ;

convi(sigmam,0) ;
convi(sigmaw,0) ;
convi(omegax,0) ;
convi(omegaw,0) ;
convi0(sigmamg,0) ;

omegak(r)     = omegak0(r) ;
etat(r)       = etat0(r) ;
landMax0(r)   = landMax00(r) ;
omegat(r)     = omegat0(r) ;
omeganlb(r)   = omeganlb0(r) ;
omegalb(r,lb) = omegalb0(r,lb) ;

conva(etanrf,0) ;
conva(invElas,0) ;

omegam(r,l) = omegam0(r,l) ;

execute_unload "%baseName%/agg/%baseName%Prm.gdx"
   sigmaxp=sigmaxp0, sigmap=sigmap0, sigman1=sigman10, sigman2=sigman20, sigmawat=sigmawat0,
   sigmav=sigmav0, sigmav1=sigmav10, sigmav2=sigmav20,
   sigmakef=sigmakef0, sigmakf=sigmakf0, sigmakw=sigmakw0, sigmak=sigmak0,
   sigmaul=sigmaul0, sigmasl=sigmasl0,
   sigmae=sigmae0, sigmanely=sigmanely0, sigmaolg=sigmaolg0, sigmaNRG=sigmaNRG0
   omegas=omegas0, sigmas=sigmas0,
   sigmael=sigmael0, sigmapow=sigmapow0, sigmapb=sigmapb0,
   incElas=incElas0, eh=eh0, bh=bh0, nu=nu0, nunnrg=nunnrg0, nue=nue0, nunely=nunely0, nuolg=nuolg0, nuNRG=nuNRG0,
   sigmafd=sigmafd0,
   sigmam=sigmam0, sigmaw=sigmaw0, omegax=omegax0, omegaw=omegaw0, sigmamg=sigmamg0
   omegak=omegak0, invElas=invElas0, etat=etat0, landMax0=landMax00,
   omegat=omegat0, omeganlb=omeganlb0, omegalb=omegalb0,
   etanrf=etanrf0, omegam=omegam0
;

*  Delete the temporary sets file
