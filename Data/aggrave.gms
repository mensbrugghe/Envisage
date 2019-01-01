loop((r,actf),
   denom = sum((r0,a0,i)$(mapr(r0,r) and mapa(a0,i) and mapaf(i, actf)), %2(r0,a0)) ;
   %3(r,actf,nrg,v)$denom = sum((r0,a0,i)$(mapr(r0,r) and mapa(a0,i) and mapaf(i, actf)), %2(r0,a0)*%1(r0,a0,nrg,v))/denom ;
) ;
