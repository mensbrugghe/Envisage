*  Make trade imbalances disappear between tf0 and tfT

if(0,
*  Make trade imbalances disappear between tf0 and tfT

   loop((t0,tf0,tfT)$(years(tsim) gt years(t0)),
      if (years(tsim) lt years(tf0),
         savfBar(r,tsim) = savfBar(r,tsim-1) ;
      elseif (years(tsim) gt years(tfT)),
         savfBar(r,tsim) = 0 ;
      elseif (years(tfT) eq years(tf0)),
         savfBar(r,tsim) = savfBar(r,tsim-1) ;
      else
         savfBar(r,tsim) = (savfBar(r,tf0)*(years(tfT)-years(tsim))
                         + 0*(years(tsim) - years(tf0)))/(years(tfT) - years(tf0)) ;
      ) ;
   )
else
*  !!!! Careful with scale here!
*  savfBar(r,t)$(years(t) gt FirstYear) = inscale*savfT(t,r) ;
   savfBar(r,t)$(years(t) gt FirstYear) = savfT(t,r) ;
) ;

*fixER("RestofWorld")$(years(tsim) gt FirstYear) = yes ;
*pfact.fx("RestofWorld",tsim)$(years(tsim) gt FirstYear) = 1.03*pfact.l("RestofWorld",tsim-1) ;

*  Make savings endogenous in baseline and investment fixed

if(ifCal,
   loop((r,t0)$(years(tsim) gt years(t0)),
      if(invTargetT(r,tsim) ne na,
         chiaps.lo(r,tsim)  = -inf ;
         chiaps.up(r,tsim)  = +inf ;
         chiaps.l(r,tsim)   = chiaps.l(r,tsim-1) ;
         rinvshr.fx(r,tsim) = 0.01*invTargetT(r,tsim) ;
      else
         chiaps.fx(r,tsim)  = chiaps.l(r,tsim-1) ;
         rinvshr.lo(r,tsim) = -inf ;
         rinvshr.up(r,tsim) = +inf ;
      ) ;
   ) ;
else
   chiaps.fx(r,tsim)  = chiaps.l(r,tsim) ;
   rinvshr.lo(r,tsim) = -inf ;
   rinvshr.up(r,tsim) = +inf ;
) ;

*  Tease a first solution for 2012

if(0 and ifCal,
   if(sameas(tsim,"2012"),
      gl.fx(r,tsim) = ((rgdppcT(r,tsim)/rgdppcT(r,tsim-1))**(1/gap(tsim)) - 1) ;
      grrgdppc.lo(r,tsim) = -inf ;
      grrgdppc.up(r,tsim) = +inf ;
      options iterlim = 10000 ;
      $$batinclude "solve.gms" coreDyn
      grrgdppc.fx(r,tsim) = 100*((rgdppcT(r,tsim)/rgdppcT(r,tsim-1))**(1/gap(tsim)) - 1) ;
      gl.lo(r,tsim) = -inf ;
      gl.up(r,tsim) = +inf ;
   ) ;
) ;
