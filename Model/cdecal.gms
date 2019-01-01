Variables
   zcal(r,k)
   alphacal(r,k)
   bcal(r,k)
   ecal(r,k)
   ucal(r)
   etacal(r,k)
   sigmacal(r,k)
   cepscal(r,k,kp)
   epscal(r,k,kp)
   objcal
;

Parameters
   pccal(r,k)
   xccal(r,k)
   popcal(r)
   ycal(r)
   scal(r,k)
   xccalFlag(r,k)
   cepscaltgt(r,k,kp)
   epscaltgt(r,k,kp)
   etacaltgt(r,k)
;

equations
   zcaleq(r,k)
   xccaleq(r,k)
   scaleq(r,k)
   ucaleq(r)
   etacaleq(r,k)
   cepscaleq(r,k,kp)
   bcaleq(r,k)
   epscaleq(r,k,kp)
   alphacons(r,k)
   etacalcons1(r)
   etacalcons2(r,k)
   etacalcons3(r)
   objcalcepseq
   objcaletaeq
   objeq
;

kron(k,k) = 1 ;

*  CDE auxiliary variable (alphacal)

zcaleq(r,k)$(rs(r) and xccalFlag(r,k))..
   zcal(r,k) =e= alphacal(r,k)*bcal(r,k)
              *  ((pccal(r,k)*ucal(r)**ecal(r,k))**bcal(r,k))
              *  ((ycal(r)/popcal(r))**(-bcal(r,k)))
              ;

*  Household consumption in household commodity space (zcal)

xccaleq(r,k)$(rs(r) and xccalFlag(r,k))..
   scal(r,k) =e= zcal(r,k)
              /  sum(kp$xccalFlag(r,kp), zcal(r,kp)) ;

*  Household budget share (out of expenditures on goods and services)

scaleq(r,k)$(rs(r) and xccalFlag(r,k))..
   scal(r,k) =e= pccal(r,k)*xccal(r,k)/ycal(r) ;

*  Ucal

ucaleq(r)$(rs(r))..
   sum(k$xccalFlag(r,k), zcal(r,k)/bcal(r,k)) =e= 1 ;

*  etacal (ecal or etacal)

etacaleq(r,k)$(rs(r) and xccalFlag(r,k))..
   etacal(r,k) =e= (ecal(r,k)*bcal(r,k)
                - sum(kp$xccalFlag(r,kp), scal(r,kp)*ecal(r,kp)*bcal(r,kp)))
                / sum(kp$xccalFlag(r,kp), scal(r,kp)*ecal(r,kp))
                - (bcal(r,k)-1)
                + sum(kp$xccalFlag(r,kp), scal(r,kp)*bcal(r,kp)) ;
                ;

cepscaleq(r,k,kp)$(rs(r) and xccalFlag(r,k) and xccalFlag(r,kp))..
   cepscal(r,k,kp) =e= scal(r,kp)*(sigmacal(r,kp) + sigmacal(r,k)
                    -    sum(k1$xcCalFlag(r,k1), scal(r,k1)*sigmacal(r,k1)))
                    -    kron(k,kp)*sigmacal(r,k)
                    ;

bcaleq(r,k)$(rs(r) and xcCalFlag(r,k))..
   1 - sigmacal(r,k) =e= bcal(r,k) ;

epscaleq(r,k,kp)$(rs(r) and xccalFlag(r,k) and xccalFlag(r,kp))..
   epscal(r,k,kp) =e= (scal(r,kp)*(-bcal(r,kp) - (ecal(r,k)*bcal(r,k)
                   -  sum(k1$xccalFlag(r,k1), scal(r,k1)*ecal(r,k1)*bcal(r,k1)))
                   /  sum(k1$xccalFlag(r,k1), scal(r,k1)*ecal(r,k1)))
                   + kron(k,kp)*(bcal(r,k)-1))
;

etacalcons1(r)$rs(r)..
   sum(k$xccalFlag(r,k), scal(r,k)*etacal(r,k)) =e= 1 ;

etacalcons2(r,k)$(rs(r) and xcCalFlag(r,k))..
   (etacal(r,k) - 1)*(etacaltgt(r,k) - 1) =g= 0 ;

etacalcons3(r)$rs(r)..
   sum(k$xccalFlag(r,k), scal(r,k)*ecal(r,k)) =e= 1 ;

objcalcepseq..
   objcal =e= sum((k,r)$(rs(r) and xcCalFlag(r,k)), cepscal(r,k,k)*(log(cepscal(r,k,k)/cepscaltgt(r,k,k))-1)) ;

objcaletaeq..
   objcal =e= sum((k,r)$(rs(r) and xcCalFlag(r,k)), scal(r,k)*power(etacal(r,k) - etacaltgt(r,k), 2)) ;

objeq..
   objcal =e= sum((k,r)$(rs(r) and xcCalFlag(r,k)), scal(r,k)*power(etacal(r,k) - etacaltgt(r,k), 2))
           +  sum((k,r)$(rs(r) and xcCalFlag(r,k)), scal(r,k)*power(epscal(r,k,k) - epscaltgt(r,k,k), 2))

model bcalmod / cepscaleq, bcaleq, objcalcepseq / ;
bcalmod.holdfixed = 1 ;
model ecalmod / zcaleq, xccaleq, ucaleq, etacaleq, etacalcons1, etacalcons2, etacalcons3, objcaletaeq / ;
ecalmod.holdfixed = 1 ;
model jntmod / zcaleq, xccaleq, ucaleq, etacaleq, cepscaleq, epscaleq, bcaleq, etacalcons1, etacalcons2, etacalcons3, objeq / ;
jntmod.holdfixed=1 ;

*  Initialize

pccal(r,k)      = 1 ;
xccal(r,k)      = sum(i, inscale*cmat(i,k,r)) / pccal(r,k) ;
ycal(r)         = sum(k, pccal(r,k)*xccal(r,k)) ;
scal(r,k)       = (pccal(r,k)*xccal(r,k))/ycal(r) ;
popcal(r)       = popScale*popg(r) ;

display xccal, ycal, scal, popcal ;

xccalFlag(r,k)$xccal(r,k) = 1 ;

ucal.l(r)   = 1 ;
ecal.l(r,k) = eh0(k,r) ;
bcal.l(r,k) = bh0(k,r) ;
alphacal.l(r,k)$xccalFlag(r,k) = (scal(r,k)/bcal.l(r,k))
   * (((ycal(r)/popcal(r))/pccal(r,k))**bcal.l(r,k))
   * (ucal.l(r)**(-bcal.l(r,k)*ecal.l(r,k)))
   / sum(kp$xccalFlag(r,kp), scal(r,kp)/bcal.l(r,kp)) ;

zcal.l(r,k) = alphacal.l(r,k)*bcal.l(r,k)*(ucal.l(r)**(ecal.l(r,k)*bcal.l(r,k)))
            *  (pccal(r,k)/(ycal(r)/popcal(r)))**bcal.l(r,k) ;

etacal.l(r,k)$xccalFlag(r,k) =
   (ecal.l(r,k)*bcal.l(r,k) - sum(kp$xccalFlag(r,kp),
      scal(r,kp)*ecal.l(r,kp)*bcal.l(r,kp)))
   / sum(kp$xccalFlag(r,kp), scal(r,kp)*ecal.l(r,kp)) - (bcal.l(r,k)-1)
   + sum(kp$xccalFlag(r,kp), scal(r,kp)*bcal.l(r,kp)) ;

sigmacal.l(r,k) = 1 - bcal.l(r,k) ;

cepscal.l(r,k,kp) = scal(r,kp)*(sigmacal.l(r,kp) + sigmacal.l(r,k)
                  -    sum(k1$xcCalFlag(r,k1), scal(r,k1)*sigmacal.l(r,k1)))
                  -    kron(k,kp)*sigmacal.l(r,k)
                  ;

epscal.l(r,k,kp)$(xccalFlag(r,k) and xccalFlag(r,kp)) =
   (scal(r,kp)*(-bcal.l(r,kp)
    - (ecal.l(r,k)*bcal.l(r,k) - sum(k1$xccalFlag(r,k1),
       scal(r,k1)*ecal.l(r,k1)*bcal.l(r,k1)))
    /  sum(k1$xccalFlag(r,k1), scal(r,k1)*ecal.l(r,k1))) + kron(k,kp)*(bcal.l(r,k)-1)) ;

rs(r) = no ;
alias(rsim,r) ;

file cdecsv / cde.csv / ;
if(1,
   put cdecsv ;
   put "Var,Region,Comm,Qual,Value" / ;
   cdecsv.pc=5 ;
   cdecsv.nd=9 ;

   loop(r,
      loop(k,
         put "PC", r.tl, k.tl, "", pccal(r,k) / ;
         put "XC", r.tl, k.tl, "", (xccal(r,k)/inscale) / ;
         put "S", r.tl, k.tl, "", (100*scal(r,k)) / ;
         put "eCal0", r.tl, k.tl, "", ecal.l(r,k) / ;
         put "bCal0", r.tl, k.tl, "", bcal.l(r,k) / ;
         put "eta0", r.tl, k.tl, "", etacal.l(r,k) / ;
         loop(kp,
            put "eps0", r.tl, k.tl, kp.tl, epscal.l(r,k,kp) / ;
            put "ceps0", r.tl, k.tl, kp.tl, cepscal.l(r,k,kp) / ;
         ) ;
      ) ;
   ) ;
) ;

loop(rsim,
   rs(rsim) = yes ;
   zcal.fx(rsim,k)$(xcCalFlag(rsim,k) eq 0) = 0 ;
   ecal.fx(rsim,k)$(xcCalFlag(rsim,k) eq 0) = 0 ;
   bcal.fx(rsim,k)$(xcCalFlag(rsim,k) eq 0) = 0 ;
   sigmacal.fx(rsim,k)$(xcCalFlag(rsim,k) eq 0) = 0 ;

   sigmacal.lo(rsim,k) = 0.01 ;
   sigmacal.up(rsim,k) = 0.99 ;
   ecal.lo(rsim,k) = 0.0001 ;
   ucal.fx(rsim) = 1 ;

   if(0,
      cepscaltgt(rsim,k,k)     = cepscal.l(rsim,k,k) ;
      cepscaltgt(rsim,fud,fud) = 1*cepscal.l(rsim,fud,fud) ;

      options limrow=3, limcol=3 ;
      solve bcalmod using nlp minimizing objcal ;

      bcal.fx(rsim,k) = bcal.l(rsim,k) ;
      etacaltgt(rsim,k)$fud(k) = 1*etacal.l(rsim,k) ;
      etacaltgt(rsim,k)$(not fud(k)) = etacal.l(rsim,k) * ((1-sum(fud,scal(rsim,fud)*etacaltgt(rsim,fud)))
                                  / (sum(kp$(not fud(kp)), scal(rsim,kp)*etacal.l(rsim,kp)))) ;

*  etacal.fx(rsim,fud) = etacaltgt(rsim,fud) ;

      objcal.l = 0 ;

      solve ecalmod using nlp minimizing objcal ;

      epscal.l(rsim,k,kp) = cepscaltgt(rsim,k,kp) - scal(rsim,kp)*etacal.l(rsim,k) ;

   else
      epscaltgt(rsim,k,k)     = epscal.l(rsim,k,k) ;
      epscaltgt(rsim,fud,fud) = 0.75*epscal.l(rsim,fud,fud) ;

      etacaltgt(rsim,k)$fud(k) = 0.75*etacal.l(rsim,k) ;
      etacaltgt(rsim,k)$(not fud(k)) = etacal.l(rsim,k) * ((1-sum(fud,scal(rsim,fud)*etacaltgt(rsim,fud)))
                                     / (sum(kp$(not fud(kp)), scal(rsim,kp)*etacal.l(rsim,kp)))) ;

      options limrow=3, limcol=3 ;
      solve jntmod using nlp minimizing objcal ;
   ) ;

   rs(rsim) = no ;
) ;

if(1,
   loop(r,
      loop(k,
         put "eCal", r.tl, k.tl, "", ecal.l(r,k) / ;
         put "bCal", r.tl, k.tl, "", bcal.l(r,k) / ;
         put "eta", r.tl, k.tl, "", etacal.l(r,k) / ;
         put "etacaltgt", r.tl, k.tl, "", etacaltgt(r,k) / ;
         loop(kp,
            put "eps", r.tl, k.tl, kp.tl, epscal.l(r,k,kp) / ;
            put "ceps", r.tl, k.tl, kp.tl, cepscal.l(r,k,kp) / ;
            put "cepscaltgt", r.tl, k.tl, kp.tl, cepscaltgt(r,k,kp) / ;
            put "epscaltgt", r.tl, k.tl, kp.tl, epscaltgt(r,k,kp) / ;
         ) ;
      ) ;
   ) ;
) ;
