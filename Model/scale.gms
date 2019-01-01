
* --------------------------------------------------------------------------------------------------
*
*  EV calc
*
* --------------------------------------------------------------------------------------------------

eveq.scale(r,h,tsim) = smin(k, 10**round(log10(abs(alphah.l(r,k,h,tsim)
                     *    (u0(r,h)**(eh.l(r,k,h,tsim)*bh.l(r,k,h,tsim)))
                     *    (pc0(r,k,h)*pop0(r)/ev0(r,h))**bh.l(r,k,h,tsim))))) ;

* --------------------------------------------------------------------------------------------------
*
*  Price of energy bundles
*
* --------------------------------------------------------------------------------------------------

$ontext
paNRGeq(r,a,NRG,v,t)$(ts(t) and rs(r) and xaNRGFlag(r,a,NRG) and ifNRGNest)..
   paNRG(r,a,NRG,v,t)**(1-sigmaNRG(r,a,NRG,v)) =e= sum(e$mape(NRG,e),
      aeio(r,e,a,v,t)*(PAA_SUB(r,e,a,t)/lambdae(r,e,a,v,t))**(1-sigmaNRG(r,a,NRG,v))) ;

if(1,
   paNRGeq.scale(r,a,NRG,v,tsim)$(xaNRGFlag(r,a,NRG) and ifNRGNest) = 10**round(log10(
      max(abs((1-sigmaNRG(r,a,NRG,v))*paNRG.l(r,a,NRG,v,tsim)**(-sigmaNRG(r,a,NRG,v))),
            smax(e, abs((1-sigmaNRG(r,a,NRG,v))*aeio(r,e,a,v,tsim)
         *  ((paScale(r,e)/lambdae.l(r,e,a,v,tsim))**(1-sigmaNRG(r,a,NRG,v)))
         *  paa.l(r,e,a,tsim)**(-sigmaNRG(r,a,NRG,v)))) ;
      ) ;
   )) ;
) ;
$offtext

* --------------------------------------------------------------------------------------------------
*
*  Demand for energy carriers at Armington level
*
* --------------------------------------------------------------------------------------------------

$ontext
xaeeq(r,e,a,t)$(ts(t) and rs(r) and xaFlag(r,e,a))..
   xa(r,e,a,t) =e= (sum(v,aeio(r,e,a,v,t)*(xnrg(r,a,v,t)/lambdae(r,e,a,v,t))
                *     (lambdae(r,e,a,v,t)*pnrg(r,a,v,t)/PAA_SUB(r,e,a,t))**sigmae(r,a,v)))
                $(not ifNRGNest)
                +  (sum(v,sum(NRG$mape(NRG,e), aeio(r,e,a,v,t)
                *    (lambdae(r,e,a,v,t)**(sigmaNRG(r,a,NRG,v)-1))*xaNRG(r,a,NRG,v,t)
                *    (paNRG(r,a,NRG,v,t)/PAA_SUB(r,e,a,t))**sigmaNRG(r,a,NRG,v))))
                $(ifNRGNest)
                ;

if(ifNRGNEST,
   xaeeq.scale(r,e,a,tsim)$xaFlag(r,e,a) = 10**round(log10(
      max(1, smax(v,
         max(abs(sum(NRG$mape(NRG,e), aeio(r,e,a,v,tsim)
            *  (lambdae.l(r,e,a,v,tsim)**(sigmaNRG(r,a,NRG,v)-1))
            *  ((paNRG.l(r,a,NRG,v,tsim)/(paScale(r,e)*paa.l(r,e,a,tsim)))**sigmaNRG(r,a,NRG,v)))),
               abs(sum(NRG$mape(NRG,e), sigmaNRG(r,a,NRG,v)*xaNRG.l(r,a,NRG,v,tsim)
            *  (paNRG.l(r,a,NRG,v,tsim)**(sigmaNRG(r,a,NRG,v)-1))*aeio(r,e,a,v,tsim)
            *  (lambdae.l(r,e,a,v,tsim)**(sigmaNRG(r,a,NRG,v)-1))
            *  (paScale(r,e)*paa.l(r,e,a,tsim))**(-sigmaNRG(r,a,NRG,v)))),
               abs(sum(NRG$mape(NRG,e), xaNRG.l(r,a,NRG,v,tsim)
            *  (paNRG.l(r,a,NRG,v,tsim)**sigmaNRG(r,a,NRG,v))*sigmaNRG(r,a,NRG,v)
            *  aeio(r,e,a,v,tsim)*(lambdae.l(r,e,a,v,tsim)**(sigmaNRG(r,a,NRG,v)-1))
            * (paScale(r,e)**sigmaNRG(r,a,NRG,v))*(paa.l(r,e,a,tsim)**(-sigmaNRG(r,a,NRG,v)-1))))
         )
      ))
   )) ;
) ;
$offtext

* --------------------------------------------------------------------------------------------------
*
*  Aggregate import price equation
*
* --------------------------------------------------------------------------------------------------

$ontext
pmteq(r,i,t)$(ts(t) and xmtFlag(r,i))..
   PMT_SUB(r,i,t)**(1-sigmaw(r,i)) =e= sum(rp, alphaw(rp,i,r,t)*PM_SUB(rp,i,r,t)**(1-sigmaw(r,i))) ;

pmteq.scale(r,i,tsim)$xmt.l(r,i,tsim) = 10**round(log10(
   smax(rp, abs(alphaw(rp,i,r,tsim)*(psScale(rp,i)**(1-sigmaw(r,i)))
                                   *(pm.l(rp,i,r,tsim))**(-sigmaw(r,i)))),
       abs((sigmaw(r,i)-1)*(paScale(r,i)**(1-sigmaw(r,i)))*(pmt.l(r,i,tsim))**(-sigmaw(r,i)))
   )
)) ;
$offtext

$ontext
pmteq(r,i,t)$(ts(t) and xmtFlag(r,i))..
   PMT_SUB(r,i,t) =e= sum(rp, alphaw(rp,i,r,t)*PM_SUB(rp,i,r,t)**(1-sigmaw(r,i)))**(1-sigmaw(r,i)) ;

pmteq.scale(r,i,tsim)$xmt.l(r,i,tsim) = 10**round(log10(
         smax(rp, abs(psScale(rp,i)*pm.l(rp,i,r,tsim)*xw.l(rp,i,r,tsim)/xeScale(rp,i)))
      /     sum(rp,psScale(rp,i)*pm.l(rp,i,r,tsim)*xw.l(rp,i,r,tsim)/xeScale(rp,i))
)) ;
$offtext

* --------------------------------------------------------------------------------------------------
*
*  Second level Armington demand (bilateral import demand)
*
* --------------------------------------------------------------------------------------------------

$ontext
xwdeq(rp,i,r,t)$(ts(t) and (rs(r) or rs(rp)) and xwFlag(rp,i,r))..
   (lambdaw(rp,i,r,t)*xw(rp,i,r,t)/xeScale(rp,i)) =e=
      alphaw(rp,i,r,t)*xmt(r,i,t)*(PMT_SUB(r,i,t)/PM_SUB(rp,i,r,t))**sigmaw(r,i) ;

xw.scale(r,i,rp,tsim)$xwFlag(r,i,rp) = 10**round(log10(xw.l(r,i,rp,tsim))) ;

xwdeq.scale(rp,i,r,tsim)$xwFlag(rp,i,r) = 10**round(log10(
   xw.l(rp,i,r,tsim)*(lambdaw(rp,i,r,tsim)/xeScale(rp,i))
      * max(1,
         abs(sigmaw(r,i)/pm.l(rp,i,r,tsim)),
         abs(sigmaw(r,i)/pmt.l(r,i,tsim)),
         abs(1/xmt.l(r,i,tsim))
      )
)) ;
$offtext

* --------------------------------------------------------------------------------------------------
*
*  Top level Armington price equation
*
* --------------------------------------------------------------------------------------------------

$ontext
paeq(r,i,t)$(ts(t) and xatFlag(r,i))..
   PA_SUB(r,i,t)**(1-sigmam(r,i)) =e= alphad(r,i,t)*PD_SUB(r,i,t)**(1-sigmam(r,i))
                                   +  alpham(r,i,t)*PMT_SUB(r,i,t)**(1-sigmam(r,i)) ;

paeq.scale(r,i,tsim)$xat.l(r,i,tsim) = 10**round(log10(
   max(abs((sigmam(r,i)-1)*(paScale(r,i)**(1-sigmam(r,i)))*(pa.l(r,i,tsim)**(-sigmam(r,i)))),
         abs((sigmam(r,i)-1)*alphad(r,i,tsim)
      *  (psScale(r,i)**(1-sigmam(r,i)))*(pd.l(r,i,tsim)**(-sigmam(r,i)))),
         abs((sigmam(r,i)-1)*alpham(r,i,tsim)
      *  (paScale(r,i)**(1-sigmam(r,i)))*(pmt.l(r,i,tsim)**(-sigmam(r,i))))
   ) ;
)) ;
$offtext

* --------------------------------------------------------------------------------------------------
*
*  Investment growth factor equation
*
* --------------------------------------------------------------------------------------------------

$ontext
invGFacteq(r,t)$(ts(t) and rs(r))..
   invGFact(r,t)*((sum(inv, xfd(r,inv,t)/xfd(r,inv,t-1)))**(1/gap(t)) - 1 + depr(r,t)) =e= 1 ;
$offtext

$ontext
invGFacteq.scale(r,tsim) = 10**round(log10(
   max(abs(1/invGFact.l(r,tsim)),
       abs((1 + invGFact.l(r,tsim)*(1 - depr(r,tsim)))/(gap(tsim)*xfd.l(r,inv,t)))
   )
)) ;
$offtext

* --------------------------------------------------------------------------------------------------
*
*  Scale aggregate domestic absorption variables
*
* --------------------------------------------------------------------------------------------------

$ontext
xfd.scale(r,fd,tsim) = 10**(round(log10(xfd.l(r,fd,tsim)))) ;
yfd.scale(r,fd,tsim) = 10**(round(log10(yfd.l(r,fd,tsim)))) ;
x.scale(r,a,i,tsim)$gp(r,a,i) = 10**(round(log10(x.l(r,a,i,tsim)))) ;
$offtext

$ontext
gdpmpeq.scale(r,tsim)    = 1000 ;
rgdpmpeq.scale(r,tsim)   = 1000 ;
rgdppceq.scale(r,tsim)   = 1000 ;
yheq.scale(r,tsim)       = 1000 ;
ygoveq.scale(r,gy,tsim)  = 1000 ;
$offtext
