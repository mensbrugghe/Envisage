*  Initialize scenario variables before starting

popT(r,tranche,t)    = 0 ;
rgdppcT(r,t)         = 0 ;
gl.l(r,t)            = 0 ;
lfpr(r,l,tranche,t)  = 0 ;
glMltShft(r,l,a,t)   = 1 ;
glAddShft(r,l,a,t)   = 0 ;
aeei(r,e,a,v,t)      = 0 ;
aeeic(r,e,k,h,t)     = 0 ;
yexo(r,a,t)          = 0 ;
tteff(r,i,rp,t)      = 0 ;
gtLab.l(r,t)         = 0 ;
glabT(r,l,t)         = 0 ;

Parameters
   popScen(scen, r, tranche, tt)
   gdpScen(mod, ssp, var, r, tt)
;

popScen(scen, r, tranche ,tt) = 0 ;
gdpScen(mod, ssp, var, r, tt) = 0 ;


glBaU(r,t)       = 0 ;
xfdBaU(r,fd,t)   = 0 ;
