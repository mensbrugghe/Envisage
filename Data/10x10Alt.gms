*  Altertax shock
*
*  If new policy needs to be phased in, the basic implementation is
*
*     p(it) = pfinal*(it/n) + pinitial*(1-it/n)
*
*  See below for an example
*
*  Set the number of iterations on the command line, for example --niter=4

$ontext

*  Cut initial tariffs by 50%

if(niter(tsim) eq 1,

*  No phase in of cuts

   imptx.fx(r,i,rp,tsim) = 0.5*imptx.l(r,i,rp,"base") ;

else

*  Phase in the shock

   for(iter=1 to niter(tsim),
      imptx.fx(r,i,rp,tsim) = 0.5*imptx.l(r,i,rp,"base") * (iter/niter(tsim))
                            + imptx.l(r,i,rp,"Base") * (1 - iter/niter(tsim)) ;
      if(iter < niter(tsim),
         $$batinclude "solve.gms" gtap
      ) ;
   ) ;
) ;
$offtext

* imptx.fx(r,"LightMnfc-c","NAmerica",tsim) = 0.5*imptx.l(r,"LightMnfc-c","NAmerica",tsim) ;

*  Test the NTM module

ntmFlag = 1 ;
ntmY.lo(r,tsim) = -inf ;
ntmY.up(r,tsim) = +inf ;
ntmAVE.fx(r,"TextWapp-c",rp,tsim) = 0.10 ;
chiNTM(r,r,tsim) = 1 ;

