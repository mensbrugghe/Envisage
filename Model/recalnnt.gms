$ontext

$batinclude "recalnnt.gms" va1 xf   pva1   pfd  aland sigmav1 ax  lambdaf factor
                            1   2    3      4     5       6    7     8      9

Arguments
   1     CES aggregate volume
   2     Component volume (has vintage)
   3     CES aggregate price
   4     Component price
   5     Component share parameter
   6     Elasticity of substitution
   7     Sectors
   8     Component tech progress
   9     Factor

$offtext

$setargs tvol vol tprice price shrParm elast index prodfact fact
*          1   2     3     4      5      6     7      8      9

loop((r,%fact%,%index%),

   tvol = sum(v, %tvol%.l(r,%index%,v,tsim-1)) ;

   if(tvol ne 0,

      tprice = sum(v, %tprice%.l(r,%index%,v,tsim-1) * %tvol%.l(r,%index%,v,tsim-1)) / tvol ;

      vol = %vol%.l(r,%fact%,%index%,tsim-1) ;

      if(vol ne 0,

         price = %price%.l(r,%fact%,%index%,tsim-1) ;

         %shrParm%(r,%index%,vOld,tsim)
            = (%prodfact%.l(r,%fact%,%index%,tsim-1)**(1-%elast%(r,%index%,vOld)))
            * ((%vol%0(r,%fact%,%index%)/%tvol%0(r,%index%))
            * (%price%0(r,%fact%,%index%)/%tprice%0(r,%index%))**(%elast%(r,%index%,vOld)))
            * (vol/tvol)
            * (price/tprice)**%elast%(r,%index%,vOld) ;
      ) ;
   ) ;
) ;
