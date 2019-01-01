if(ifMCP,
   solve %1 using mcp ;
else
   solve %1 using nlp maximizing walras ;
) ;

*  Update the substituted variables

if(ifSUB,
   pp.l(r,a,i,t)      = p.l(r,a,i,t)*(1 + prdtx.l(r,a,i,t)) ;
   pdp.l(r,i,aa,t)    = pd.l(r,i,t)*(1 + dintx.l(r,i,aa,t)) ;
   pmp.l(r,i,aa,t)    = pmt.l(r,i,t)*(1 + mintx.l(r,i,aa,t)) ;
   xwmg.l(r,i,rp,t)   = tmarg.l(r,i,rp,t)*xw.l(r,i,rp,t) ;
   xmgm.l(m,r,i,rp,t) = amgm(m,r,i,rp)*xwmg.l(r,i,rp,t)/lambdamg.l(m,r,i,rp,t) ;
   pwmg.l(r,i,rp,t)   = sum(m, amgm(m,r,i,rp)*ptmg.l(m,t)/lambdamg.l(m,r,i,rp,t)) ;
   pefob.l(r,i,rp,t)  = (1 + exptx.l(r,i,rp,t) + etax.l(r,i,t))*pe.l(r,i,rp,t) ;
   pmcif.l(r,i,rp,t)  = pefob.l(r,i,rp,t) + pwmg.l(r,i,rp,t)*tmarg.l(r,i,rp,t) ;
   pm.l(r,i,rp,t)     = (1 + imptx.l(r,i,rp,t) + mtax.l(rp,i,t) + ntmAVE.l(r,i,rp,t))*pmcif.l(r,i,rp,t)/chipm(r,i,rp) ;
   pfa.l(r,fp,a,t)    = pf.l(r,fp,a,t)*(1 + fctts.l(r,fp,a,t) + fcttx.l(r,fp,a,t)) ;
   pfy.l(r,fp,a,t)    = pf.l(r,fp,a,t)*(1 - kappaf.l(r,fp,a,t)) ;
) ;
