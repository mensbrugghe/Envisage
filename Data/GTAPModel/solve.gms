if(ifMCP,
   solve %1 using mcp ;
else
   solve %1 using nlp maximizing obj ;
) ;

*  Update the substituted variables

if(ifSUB,
   pp.l(r,a,i,t)      = p.l(r,a,i,t)*(1 + prdtx.l(r,a,i,t))*p0(r,a,i)/pp0(r,a,i) ;
   pdp.l(r,i,aa,t)    = pd.l(r,i,t)*(1 + dintx.l(r,i,aa,t))*pd0(r,i)/pdp0(r,i,aa) ;
   pmp.l(r,i,aa,t)    = (1 + mintx.l(r,i,aa,t))
                      * ((pmt.l(r,i,t)*pmt0(r,i))$(not MRIO) + (pma.l(r,i,aa,t)*pma0(r,i,aa))$MRIO)
                      /  pmp0(r,i,aa) ;
   pmcif.l(s,i,d,t)   = (pefob0(s,i,d)*pefob.l(s,i,d,t)
                      +  pwmg0(s,i,d)*pwmg.l(s,i,d,t)*tmarg.l(s,i,d,t))/pmcif0(s,i,d) ;
   if(MRIO,
      pdma.l(s,i,d,aa,t) = (1 + imptxa.l(s,i,d,aa,t) + mtax.l(d,i,t))*pmcif.l(s,i,d,t)
                     *     pmcif0(s,i,d)/pdma0(s,i,d,aa) ;
   ) ;
   xwmg.l(s,i,d,t)$xwmg0(s,i,d)     = tmarg.l(s,i,d,t)*xw.l(s,i,d,t)*xw0(s,i,d)/xwmg0(s,i,d) ;
   xmgm.l(m,s,i,d,t)$xmgm0(m,s,i,d) = amgm(m,s,i,d)*xwmg.l(s,i,d,t)*(xwmg0(s,i,d)/xmgm0(m,s,i,d))
                                    / lambdamg.l(m,s,i,d,t) ;
   pwmg.l(s,i,d,t)$pwmg0(s,i,d)     = sum(m, amgm(m,s,i,d)*ptmg.l(m,t)*(ptmg0(m)/pwmg0(s,i,d))
                                    / lambdamg.l(m,s,i,d,t)) ;
   pefob.l(s,i,d,t)  = (1 + exptx.l(s,i,d,t) + etax.l(s,i,t))*pe.l(s,i,d,t)
                     *     pe0(s,i,d)/pefob0(s,i,d) ;
   pmcif.l(s,i,d,t)  = (pefob.l(s,i,d,t)*pefob0(s,i,d)
                     +     pwmg0(s,i,d)*pwmg.l(s,i,d,t)*tmarg.l(s,i,d,t)) / pmcif0(s,i,d) ;
   pm.l(s,i,d,t)     = (1 + imptx.l(s,i,d,t) + mtax.l(d,i,t) + ntmAVE.l(s,i,d,t))*pmcif.l(s,i,d,t)
                     *     pmcif0(s,i,d)/pm0(s,i,d) ;
   pfa.l(r,fp,a,t)   = pf.l(r,fp,a,t)*(1 + fctts.l(r,fp,a,t) + fcttx.l(r,fp,a,t))
                     *    pf0(r,fp,a)/pfa0(r,fp,a) ;
   pfy.l(r,fp,a,t)   = pf.l(r,fp,a,t)*(1 - kappaf.l(r,fp,a,t))*pf0(r,fp,a)/pfy0(r,fp,a) ;
) ;
