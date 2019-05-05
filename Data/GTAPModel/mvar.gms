$setargs theMacro theYear

$macro initVar0(x, pFlag)                    \
   x.l(r, %theYear%) = \
   x.l(r, %theYear%-1)*(1$pFlag + rwork(r)$(not pFlag))
$macro initVar1(x,i__1, pFlag)               \
   x.l(r, i__1, %theYear%) = \
   x.l(r, i__1, %theYear%-1)*(1$pFlag + rwork(r)$(not pFlag))
$macro initVar2(x,i__1, i__2, pFlag)         \
   x.l(r, i__1, i__2, %theYear%) = \
   x.l(r, i__1, i__2, %theYear%-1)*(1$pFlag + rwork(r)$(not pFlag))
$macro initVar3(x,i__1, i__2, i__3, pFlag)   \
   x.l(r, i__1, i__2, i__3, %theYear%) = \
   x.l(r, i__1, i__2, i__3, %theYear%-1)*(1$pFlag + rwork(r)$(not pFlag))

$macro initVar0g(x, pFlag)                          \
   x.l(%theYear%) = \
   x.l(%theYear%-1)*(1$pFlag + 1$(not pFlag))
$macro initVar1g(x,i__1, pFlag)                     \
   x.l(i__1, %theYear%) = \
   x.l(i__1, %theYear%-1)*(1$pFlag + 1$(not pFlag))
$macro initVar4g(x,i__1, i__2, i__3, i__4, pFlag)   \
   x.l(i__1, i__2, i__3, i__4, %theYear%) = \
   x.l(i__1, i__2, i__3, i__4, %theYear%-1)*(1$pFlag + 1$(not pFlag))

%theMacro%1(nd,a,0) ;
%theMacro%1(va,a,0) ;
%theMacro%1(px,a,1) ;

%theMacro%2(xa,i,aa,0) ;
%theMacro%1(pnd,a,1) ;
%theMacro%2(xf,fp,a,0) ;
%theMacro%1(pva,a,1) ;

%theMacro%2(x,a,i,0) ;
%theMacro%1(xp,a,0) ;
%theMacro%2(pp,a,i,1) ;
%theMacro%2(p,a,i,1) ;
%theMacro%1(ps,i,1) ;

%theMacro%1(ytax,gy,0) ;
%theMacro%0(ytaxTot,0) ;
%theMacro%0(yTaxInd,0) ;
%theMacro%0(factY,0) ;
%theMacro%0(regY,0) ;

%theMacro%0(rsav,0) ;
%theMacro%0(yg,0) ;
%theMacro%0(yc,0) ;
%theMacro%0(phi,1) ;
%theMacro%0(u,0) ;
%theMacro%0(us,0) ;

%theMacro%2(zcons,i,h,0) ;
%theMacro%2(xcshr,i,h,1) ;
*  %theMacro%2(xa,i,h,0) ;
%theMacro%0(phiP,1) ;
%theMacro%0(pcons,1) ;
%theMacro%1(uh,h,1) ;

*  %theMacro%2(xa,i,gov,0) ;
%theMacro%0(pg,1) ;
%theMacro%0(xg,0) ;
%theMacro%0(ug,0) ;

*  %theMacro%2(xa,i,inv,0) ;
%theMacro%0(pi,1) ;
%theMacro%0(xi,0) ;

%theMacro%2(pdp,i,aa,1) ;
%theMacro%2(pmp,i,aa,1) ;
%theMacro%2(pa,i,aa,1) ;
%theMacro%2(xd,i,aa,0) ;
%theMacro%2(xm,i,aa,0) ;

* 01-May-2019: MRIO

%theMacro%2(pma,i,aa,0) ;
%theMacro%3(xwa,i,d,aa,0) ;
%theMacro%3(pdma,i,d,aa,0) ;

* 01-May-2019: Top level Armington
%theMacro%1(xat,i,0) ;
%theMacro%1(pat,i,0) ;

%theMacro%1(xdt,i,0) ;
%theMacro%1(xmt,i,0) ;
%theMacro%2(xw,i,rp,0) ;
%theMacro%1(pmt,i,1) ;
%theMacro%1(xds,i,1) ;
%theMacro%1(xet,i,0) ;
%theMacro%1(xs,i,0) ;
%theMacro%2(pe,i,rp,1) ;
%theMacro%1(pet,i,1) ;

%theMacro%2(xwmg,i,rp,0) ;

%theMacro%4g(xmgm,m,r,i,rp,1) ;
%theMacro%2(pwmg,i,rp,1) ;
%theMacro%1g(xtmg,m,1) ;
*  %theMacro%2(xa,i,tmg,0) ;
%theMacro%1g(ptmg,m,1) ;

%theMacro%2(pefob,i,rp,1) ;
%theMacro%2(pmcif,i,rp,1) ;
%theMacro%2(pm,i,rp,1) ;

%theMacro%1(pd,i,1) ;

%theMacro%1(xft,fm,0) ;
%theMacro%2(pf,fp,a,1) ;
%theMacro%1(pft,fm,1) ;
%theMacro%2(pfa,fp,a,1) ;

%theMacro%0(kstock,0) ;
%theMacro%0(kapEnd,0) ;
%theMacro%0(arent,1) ;
%theMacro%0(rorc,1) ;
%theMacro%0(rore,1) ;
%theMacro%0(savf,1) ;
%theMacro%0g(rorg,1) ;
%theMacro%0(yi,0) ;
%theMacro%0g(xigbl,0) ;
%theMacro%0g(pigbl,1) ;
%theMacro%0g(chiSave,1) ;
%theMacro%0(psave,1) ;

%theMacro%0(pabs,1) ;
%theMacro%0g(pmuv,1) ;
%theMacro%0(pfact,1) ;
%theMacro%0g(pwfact,1) ;
%theMacro%0g(pnum,1) ;

%theMacro%2(dintx,i,aa,1) ;
%theMacro%2(mintx,i,aa,1) ;
%theMacro%1(ytaxshr,gy,1) ;

%theMacro%0(gdpmp,0) ;
%theMacro%0(rgdpmp,0) ;
%theMacro%0(pgdpmp,1) ;

%theMacro%1(axp,a,1) ;
%theMacro%1(lambdand,a,1) ;
%theMacro%1(lambdava,a,1) ;
%theMacro%2(lambdaf,fp,a,1) ;
%theMacro%2(lambdaio,i,a,1) ;

%theMacro%0(ggdppc,1) ;
%theMacro%0(gl,1) ;
%theMacro%2(afeall,fp,a,1) ;

%theMacro%2(ued,i,j,1) ;
%theMacro%1(incElas,i,1) ;
%theMacro%2(ced,i,j,1) ;
%theMacro%2(ape,i,j,1) ;

%theMacro%1(ev,h,1) ;
%theMacro%1(cv,h,1) ;
