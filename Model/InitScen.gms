Parameters
   popg(r)
   popScen(scen, r, tranche, tt)
   gdpScen(mod, ssp, var, r, tt)
   educScen(scen, r, tranche, ed, tt)
;

Execute_load "%BASENAME%Scn.gdx", popScen, gdpScen, educScen ;

*	All incoming data is assumed to be in millions -- SSP database is in levels

popScen(scen, r, tranche, tt)      = 1e-6*popScen(scen, r, tranche, tt) ;
educScen(scen, r, tranche, ed, tt) = 1e-6*educScen(scen, r, tranche, ed, tt) ;

if(%OVERLAYPOP%,
   popg(r) = sum(t0, popScen("%POPSCEN%", r, "PTOTL", t0)) ;
else
   Execute_load "%BASENAME%Dat.gdx", popg=pop ;
) ;

popT(r,"PTOTL", t0) = popScale*popg(r) ;

*  Calculate the growth in total population

loop(t$(not t0(t)),
   popT(r,"PTOTL", t) = popT(r,"PTOTL",t-1)*(popScen("%POPSCEN%", r, "PTOTL", t)/popScen("%POPSCEN%", r, "PTOTL", t-1)) ;
) ;

*  Update the tranches according to the structure in popScen

popT(r,tranche,t) = popT(r,"PTOTL", t)*popScen("%POPSCEN%",r,tranche,t)/popScen("%POPSCEN%",r,"PTOTL",t) ;

pop.l(r,t) = popT(r, "PTOTL", t) ;

*  Calculate GDP trend, assuming per capita growth rates are as given by scenario

rgdppcT(r,t) = gdpScen("%SSPMOD%", "%SSPSCEN%", "gdppc", r, t) ;

*  Assumptions about labor force participation rates

lfpr(r, l, "PLT15", t) = 0 ;
lfpr(r, l, "P1564", t) = 2/3 ;
lfpr(r, l, "P65UP", t) = 0 ;

*  Calculate education-based growth rates of labor
*  Size of labor by skill based on education and lfpr
*  Needs modification if using UN population profile (for aggregate labor growth)

*  Check to see if we are using an SSP scenario for labor

work = sum(ssp$sameas("%LABSCEN%", ssp), 1) ;

if(work = 1,
   educ(r, l, t) = sum(trs, lfpr(r,l,trs,t)*sum(educMap(r,l,ed), educScen("%LABSCEN%", r, trs, ed, t))) ;
   loop(t0,
      gLabT(r,l,t)$(years(t) gt years(t0)) = 100*((educ(r, l, t)/educ(r, l, t-1))**(1/gap(t)) - 1) ;
      glab.l(r,l,t)$(years(t) gt years(t0))    = gLabT(r,l,t) ;
      gLabz.l(r,l,z,t)$(years(t) gt years(t0)) = gLabT(r,l,t) ;
      gtlab.l(r,t)$(years(t) gt years(t0)) = 100*((sum(l, educ(r, l, t))
                     /       sum(l, educ(r, l, t-1)))**(1/gap(t))-1) ;
   ) ;
else
*  Just use the growth of the working age population
   loop(t0,
      gtlab.l(r,t)$(years(t) gt years(t0)) = 100*((popT(r,"P1564",t)/popT(r,"P1564",t-1))**(1/gap(t))-1) ;
      glab.l(r,l,t) = gtlab.l(r,t) ;
      glabT(r,l,t)  = glab.l(r,l,t) ;
      glabz.l(r,l,z,t) = glab.l(r,l,t) ;
   ) ;
) ;

*  Assumptions about labor productivity

glAddShft(r,l,a,t) = 0 ;
glMltShft(r,l,a,t) = 1 ;
glAddShft(r,l,agr,t) = 0.02 ;
glAddShft(r,l,man,t) = 0.02 ;

*  AEEI assumptions (in percent)

aeei(r,e,a,v,t)  = 1 ;
aeeic(r,e,k,h,t) = 1 ;

*  Exogenous yield assumptions (in percent)

yexo(r,acr,t) = 1 ;

*  Exogenous assumption on improvement in trading margins (in percent)

tteff(r,i,rp,t) = 1 ;
