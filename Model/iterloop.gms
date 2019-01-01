*  This is called using batinclude
*  The parameter %1 is a year
*  Variables are initialized for all years greater than %1
*  When starting from a baseline, one would use the baseline
*  values until the first year of a shock. Thus if a shock
*  begins in 2020, make %1 2025, then the beginning value
*  for 2020 will be the baseline value. If there is no shock
*  then make %1 greater than the terminal year, for example 2055
*  if the terminal year is 2050. The model should solve in
*  the first iteration if there is no shock

*  Initialize variables for new iteration

* rwork(r) = %1 ;

rwork(r) = 1 ;
loop(t0$(ifDyn and years(tsim) gt years(t0) and years(tsim) gt %1),
   if(ifDyn,
      rwork(r) = (popT(r,"PTOTL",tsim)/popT(r,"PTOTL",tsim-1))
               * (rgdppcT(r,tsim)/rgdppcT(r,tsim-1)) ;
   else
      rwork(r) = 1 ;
   ) ;
*  display rwork ;
   $$include "InitVar.gms"

*  Initialize vintage volumes for first simulation year

   if(ifVint and ord(tsim) eq 2,
   $$include "InitVint.gms"
   ) ;

) ;

*  Re-calibrate the production parameters starting with the
*  second simulation year
*  N.B. We must do this step even in a no-shock scenario
*       since the share parameters are initialized in 'init.gms'
*       !!!! We may want to re-think this in the future, though it
*       doesn't appear to cost much in terms of calculations

if(ifDyn and ord(tsim) ge 2,
   $$include "recal.gms"
) ;

*  Scale the model

$ontext
loop(t0$(years(tsim) gt years(t0)),
   $$include "scale.gms"
) ;
$offtext

*  Fix lagged variables

mlag1(px, a)
mlag1(xp, a)
mlag1(pfd, fd)
mlag1(xfd, fd)
mlag1(yfd, fd)
mlag1(pat, i)
mlag1(pdt, i)
mlag1(xtt, i)
mlag2(pe, i, d)
mlag2(pwe, i, d)
mlag2(pwm, i, d)
mlag2(xw, i, d)
mlag2(pwmg, i, d)
mlag0(rgdppc)
mlag0(rgdpmp)
mlag0(pgdpmp)
mlag0(gdpmp)
mlag0(pfact)
mlag0(kstock)
mlag0(tkaps)
mlag2(kv, a, v)
mlag2(pk, a, v)
mlag1(urbPrem, l)
mlag1(ls, l)
mlag2(lsz, l, z)
mlag2(uez, l, z)
mlag2(lambdaf, f, a)
mlag2(pf, f, a)
mlag2(xf, f, a)
mlag2(pc, k, h)
mlag2(pah, i, h)

mlag2(pa, i, aa)
mlag2(xa, i, aa)

mlag1(emiTax, em)

*  Fix global lag variables (no macros)

ptmg.fx(img,tsim-1)      = ptmg.l(img,tsim-1) ;
pw.fx(a,tsim-1)          = pw.l(a,tsim-1) ;
pmuv.fx(tsim-1)          = pmuv.l(tsim-1) ;
pwfact.fx(tsim-1)        = pwfact.l(tsim-1) ;

*  Update the dynamics

if(ifDyn, loop(t0$(years(tsim) gt years(t0)),

   rwork(r) = (popT(r,"PTOTL",tsim)/popT(r,"PTOTL",tsim-1))
            * (rgdppcT(r,tsim)/rgdppcT(r,tsim-1)) ;

*  Population

   pop.fx(r,tsim) = pop.l(r,tsim-1)*(popT(r,"PTOTL",tsim)/popT(r,"PTOTL",tsim-1)) ;

*  Capital accumulation is endogeous

   tkaps.lo(r,tsim)  = -inf ; tkaps.up(r,tsim)  = +inf ;
   kstock.lo(r,tsim) = -inf ; kstock.up(r,tsim) = +inf ;

*  Installed capital

   k0.l(r,a,tsim)$kflag(r,a)
      = sum(v, (kv0(r,a)/k00(r,a))*kv.l(r,a,v,tsim-1))*power(1-depr(r,tsim-1), gap(tsim)) ;

*  Energy

   lambdae.fx(r,e,a,v,tsim)  = lambdae.l(r,e,a,v,tsim-1)
                             *   power(1 + 0.01*aeei(r,e,a,v,tsim), gap(tsim)) ;
   lambdace.fx(r,e,k,h,tsim) = lambdace.l(r,e,k,h,tsim-1)
                             *   power(1 + 0.01*aeeic(r,e,k,h,tsim), gap(tsim)) ;

*  International trade and transport margins

   tmarg.fx(r,i,rp,tsim) = tmarg.l(r,i,rp,tsim-1)*power(1 - 0.01*tteff(r,i,rp,tsim), gap(tsim)) ;

*  Land (yield?)
*  27-Feb-2018 DvdM: Make yexo apply to livestock capital, not land

   loop(a,
      if(acr(a),
         lambdaf.fx(r,lnd,a,tsim) = lambdaf.l(r,lnd,a,tsim-1)*power(1 + 0.01*yexo(r,a,tsim), gap(tsim)) ;
      elseif(alv(a)),
         lambdaf.fx(r,cap,a,tsim) = lambdaf.l(r,cap,a,tsim-1)*power(1 + 0.01*yexo(r,a,tsim), gap(tsim)) ;
      else
         lambdaf.fx(r,lnd,a,tsim) = lambdaf.l(r,lnd,a,tsim-1)*power(1 + 0.01*yexo(r,a,tsim), gap(tsim)) ;
      ) ;
   ) ;

*  Implement assumptions on growth rate of labor -- driven by growth of skilled labor
*  The growth of total labor is given by the SSP population assumptions
*  skLabgrwgt is a user-determined parameter

   tls.l(r,tsim)      = tls.l(r,tsim-1)*power(1 + 0.01*gtLab.l(r,tsim),gap(tsim)) ;
   glab.l(r,skl,tsim) = (skLabgrwgt*glabT(r,skl,tsim) + (1-skLabgrwgt)*gtlab.l(r,tsim)) ;
   ls.l(r,skl,tsim)   = power(1 + 0.01*glab.l(r,skl,tsim), gap(tsim))*ls.l(r,skl,tsim-1) ;
   glab.l(r,nsk,tsim) = 100*(((tls0(r)*tls.l(r,tsim) - sum(skl, ls.l(r,skl,tsim)*ls0(r,skl)))
                      / (tls0(r)*tls.l(r,tsim-1) - sum(skl, ls.l(r,skl,tsim-1)*ls0(r,skl)))
                        )**(1/gap(tsim)) - 1) ;
   ls.l(r,nsk,tsim)   = ls.l(r,nsk,tsim-1)*power(1 + 0.01*glab.l(r,nsk,tsim), gap(tsim)) ;

   glabz.fx(r,l,z,tsim) = glab.l(r,l,tsim) ;

   lsz.lo(r,l,z,tsim) = -inf ;
   lsz.up(r,l,z,tsim) = +inf ;

   if(ifCal,
      migrMult.l(r,l,z,tsim)$migrFlag(r,l) = (power(1 + 0.01*glabz.l(r,l,z,tsim), gap(tsim))
         * (urbPrem.l(r,l,tsim-1)/urbPrem.l(r,l,tsim))**omegam(r,l) - 1)
         / ((1 + 0.01*glabz.l(r,l,z,tsim))
         * (urbPrem.l(r,l,tsim-1)/urbPrem.l(r,l,tsim))**(omegam(r,l)/gap(tsim))-1) ;

      lsz.l(r,l,z,tsim)$lsz0(r,l,z)
         = power(1 + 0.01*glabz.l(r,l,z,tsim), gap(tsim))*lsz.l(r,l,z,tsim-1)
         + kronm(z)*migrMult.l(r,l,z,tsim)*migr.l(r,l,tsim)*migr0(r,l)/lsz0(r,l,z) ;
      glab.l(r,l,tsim)  = 100*((sum(z,lsz.l(r,l,z,tsim)*lsz0(r,l,z))
                        /  sum(z,lsz.l(r,l,z,tsim-1)*lsz0(r,l,z)))**(1/gap(tsim)) - 1 ) ;
   ) ;

*  World price trends

   if(ifCal,
*     Calibrate to exogenous trends
      loop(a,
         if(pwTrend(a,tsim) ne na,
            pw.fx(a,tsim) = pwTrend(a,tsim) ;
            wchinrs.lo(a,tsim) = -inf ;
            wchinrs.up(a,tsim) = +inf ;
         else
            pw.lo(a,tsim) = -inf ;
            pw.up(a,tsim) = +inf ;
            wchinrs.fx(a,tsim) = wchinrs.l(a,tsim-1) ;
         ) ;
      ) ;
   else
*     Calibrate to exogenous shock
      loop(a,
         if(pwShock(a,tsim) ne na,
            pw.fx(a,tsim) = pwShock(a,tsim) ;
            wchinrs.lo(a,tsim) = -inf ;
            wchinrs.up(a,tsim) = +inf ;
         else
            pw.lo(a,tsim) = -inf ;
            pw.up(a,tsim) = +inf ;
            wchinrs.fx(a,tsim) = wchinrs.l(a,tsim) ;
         ) ;
      ) ;
   ) ;

   if(ifCal,

*     GDP growth is given, labor productivity is endogenous

      grrgdppc.fx(r,tsim) = 100*((rgdppcT(r,tsim)/rgdppcT(r,tsim-1))**(1/gap(tsim)) - 1) ;
      if(ifInitFlag = 0,
         gl.l(r,tsim)$(ord(tsim) eq 2) = 0.01 ;
         gl.l(r,tsim)$(ord(tsim) gt 2) = gl.l(r,tsim-1) ;
      ) ;
      lambdaf.l(r,l,a,tsim) = lambdaf.l(r,l,a,tsim-1)
         * power(1 + glAddShft(r,l,a,tsim) + glMltShft(r,l,a,tsim)*gl.l(r,tsim), gap(tsim)) ;
      lambdaf.lo(r,l,a,tsim)$xfFlag(r,l,a) = -inf ;
      lambdaf.up(r,l,a,tsim)$xfFlag(r,l,a) = +inf ;
      gl.lo(r,tsim) = -inf ; gl.up(r,tsim) = +inf ;

*     Government expenditures grow at the rate of GDP growth

      xfd.fx(r,gov,tsim) = xfd.l(r,gov,tsim-1)*rwork(r) ;

   else

*     Labor productivity is exogenous, GDP growth is endogenous

      gl.fx(r,tsim) = glBaU(r,tsim) ;
      lambdaf.l(r,l,a,tsim) = lambdaf.l(r,l,a,tsim-1)
         * power(1 + glAddShft(r,l,a,tsim) + glMltShft(r,l,a,tsim)*gl.l(r,tsim), gap(tsim)) ;
      lambdaf.lo(r,l,a,tsim)$xfFlag(r,l,a) = -inf ;
      lambdaf.up(r,l,a,tsim)$xfFlag(r,l,a) = +inf ;
      grrgdppc.lo(r,tsim) = -inf ;
      grrgdppc.up(r,tsim) = +inf ;

*     Government expenditures are exogenous and equal to the baseline levels

      xfd.fx(r,gov,tsim) = xfdBaU(r,gov,tsim) ;

      eh.fx(r,k,h,tsim)  = ehBaU(r,k,h,tsim) ;
      bh.fx(r,k,h,tsim)  = bhBaU(r,k,h,tsim) ;
   ) ;
) ;

else
   grrgdppc.fx(r,tsim) = 0 ;
) ;

$iftheni.costCurve "%simType%" == "RcvDyn"

* --------------------------------------------------------------------------------------------------
*
*  Implement cost reductions in selected activities
*
* --------------------------------------------------------------------------------------------------

if(years(tsim) gt FirstYear,

   loop((r,a)$ifCostCurve(r,a),

      $$iftheni.type %costCurve% == HYPERB

         work = log((costTgt(r,a) - costMin(r,a))/(1 - costMin(r,a)))
              / log(1/(costTgtYear(r,a) - (FirstYear-1))) ;
         work = ((costMin(r,a) + (1-costMin(r,a))*(years(tsim-1)-(FirstYear-1))**(-work))
              / (costMin(r,a) + (1-costMin(r,a))*(years(tsim)-(FirstYear-1))**(-work))) ;

      $$elseifi.type %costCurve% == LOGIST

         work = -(1/(costTgtYear(r,a)-FirstYear))*log((costTgt(r,a)-costMin(r,a))
              /  (costTgt(r,a)*(1 - costMin(r,a))))) ;

         work = (1 + (costMin(r,a)-1)*exp(-work*(years(tsim)-FirstYear)))
              / (1 + (costMin(r,a)-1)*exp(-work*(years(tsim)-FirstYear - gap(tsim))))) ;

      $$else.type

         Abort "Wrong cost curve type, valid types are 'HYPERB' and 'LOGIST'" ;

      $$endif.type

      lambdaxp.fx(r,a,v,tsim) = work*lambdaxp.l(r,a,v,tsim-1) ;

   ) ;
) ;

$endif.costCurve
