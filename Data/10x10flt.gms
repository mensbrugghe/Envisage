$setGlobal excCombined  1

scalars
   ifKeepIntermediateConsumption / 1 /
   ifKeepPrivateconsumption      / 1 /
   ifKeepGovernmentconsumption   / 1 /
   ifKeepInvestments             / 1 /
   ifGDPKeep                     / 1 /
   ifKeepFactorincomeplusbop     / 1 /
   ifAdjDepr                     / 1 /
   abstol                        / 1e-10 /
   relTol                        / 0.005 /
   relTolRed                     / 1e-6  /
   nsteps                        / 5 /
   minNumTransactions            / 50000 /
;

file log / %baseName%flt.log / ;
put log ;
