*-------------------------------------------------------------------------------
$ontext

   CAPRI project

   GAMS file : ITRLOG.GMS

   @purpose  : Track changes during filtering
   @author   : Tom Rutherford
   @date     : 16.06.15
   @since    :
   @refDoc   :
   @seeAlso  :
   @calledBy : build\filter.gms

$offtext
*-------------------------------------------------------------------------------

$iftheni %1==before

   trace("vom",r,"before")  = sum(i, vom(i,r));
   trace("vdm",r,"before")  = sum(i, vdm(i,r));
   trace("evfb",r,"before") = sum((fp,j), evfb(fp,j,r));
   trace("vdfb",r,"before") = sum((i,j), vdfb(i,j,r));
   trace("vmfb",r,"before") = sum((i,j), vmfb(i,j,r));
   trace("vdpb",r,"before") = sum(i, vdpb(i,r));
   trace("vmpb",r,"before") = sum(i, vmpb(i,r));
   trace("vdgb",r,"before") = sum(i, vdgb(i,r));
   trace("vmgb",r,"before") = sum(i, vmgb(i,r));
   trace("vdib",r,"before") = sum(i, vdib(i,r));
   trace("vmib",r,"before") = sum(i, vmib(i,r));
   trace("vxsb",r,"before") = sum((i,s), vxsb(i,r,s));
   trace("vtwr",r,"before") = sum((j,i,s), vtwr(j,i,r,s));
   trace("gdp",r,"before")  = trace("vdpb",r,"before") + trace("vmpb",r,"before")
                            + trace("vdgb",r,"before") + trace("vmgb",r,"before")
                            + trace("vdib",r,"before") + trace("vmib",r,"before")
                            ;

$elseif %1==count

   nz("vom","count")  = card(vom);
   nz("evfb","count") = card(evfb);
   nz("vxsb","count") = card(vxsb);
   nz("vtwr","count") = card(vtwr);
   nz("vdfb","count") = card(vdfb);
   nz("vmfb","count") = card(vmfb);
   nz("vdpb","count") = card(vdpb);
   nz("vmpb","count") = card(vmpb);
   nz("vdgb","count") = card(vdgb);
   nz("vmgb","count") = card(vmgb);
   nz("vdib","count") = card(vdib);
   nz("vmib","count") = card(vmib);

   nz(r,"count") = sum(i $ vom(i,r),1)
                 + sum(i $ vdm(i,r),1)
                 + sum(i $ vdpb(i,r),1)
                 + sum(i $ vdgb(i,r),1)
                 + sum(i $ vdib(i,r),1)
                 + sum(i $ vmpb(i,r),1)
                 + sum(i $ vmgb(i,r),1)
                 + sum(i $ vmib(i,r),1)
                 + sum((fp,j) $ evfb(fp,j,r),1)
                 + sum((i,s)  $ vxsb(i,r,s),1)
                 + sum((i,s)  $ vxsb(i,s,r),1)
                 + sum((i,j)  $ vdfb(i,j,r),1)
                 + sum((i,j)  $ vmfb(i,j,r),1)
                 + sum((j,i,s) $ vtwr(j,i,r,s),1)
                 + sum((j,i,s) $ vtwr(j,i,s,r),1) ;

   nz(i,"count") = sum(r $ vom(i,r),1)
                 + sum(r $ vdm(i,r),1)
                 + sum(r $ vdpb(i,r),1)
                 + sum(r $ vdgb(i,r),1)
                 + sum(r $ vdib(i,r),1)
                 + sum(r $ vmpb(i,r),1)
                 + sum(r $ vmgb(i,r),1)
                 + sum(r $ vmib(i,r),1)
                 + sum((fp,r) $ evfb(fp,i,r),1)
                 + sum((r,s)  $ vxsb(i,r,s),1)
                 + sum((j,r)  $ vdfb(i,j,r),1)
                 + sum((j,r)  $ vmfb(i,j,r),1)
                 + sum((j,r,s) $ vtwr(j,i,r,s),1) ;

$else

   trace("vom",r,"after")  = sum(j, vom(j,r));
   trace("vdm",r,"after")  = sum(j, vdm(j,r));
   trace("evfb",r,"after") = sum((fp,j), evfb(fp,j,r));
   trace("vdfb",r,"after") = sum((i,j), vdfb(i,j,r));
   trace("vmfb",r,"after") = sum((i,j), vmfb(i,j,r));
   trace("vdpb",r,"after") = sum(i, vdpb(i,r));
   trace("vdgb",r,"after") = sum(i, vdgb(i,r));
   trace("vdib",r,"after") = sum(i, vdib(i,r));
   trace("vmpb",r,"after") = sum(i, vmpb(i,r));
   trace("vmgb",r,"after") = sum(i, vmgb(i,r));
   trace("vmib",r,"after") = sum(i, vmib(i,r));
   trace("vxsb",r,"after") = sum((i,s), vxsb(i,r,s));
   trace("vtwr",r,"after") = sum((j,i,s), vtwr(j,i,r,s));
   trace("gdp",r,"after")  = trace("vdpb",r,"after") + trace("vmpb",r,"after")
                           + trace("vdgb",r,"after") + trace("vmgb",r,"after")
                           + trace("vdib",r,"after") + trace("vmib",r,"after")
                           ;

   nz("vom","change")  = card(vom)  - nz("vom","count");
   nz("evfb","change") = card(evfb) - nz("evfb","count");
   nz("vxsb","change") = card(vxsb) - nz("vxsb","count");
   nz("vtwr","change") = card(vtwr) - nz("vtwr","count");
   nz("vdfb","change") = card(vdfb) - nz("vdfb","count");
   nz("vmfb","change") = card(vmfb) - nz("vmfb","count");
   nz("vdpb","change") = card(vdpb) - nz("vdpb","count");
   nz("vdgb","change") = card(vdgb) - nz("vdgb","count");
   nz("vdib","change") = card(vdib) - nz("vdib","count");
   nz("vmpb","change") = card(vmpb) - nz("vmpb","count");
   nz("vmgb","change") = card(vmgb) - nz("vmgb","count");
   nz("vmib","change") = card(vmib) - nz("vmib","count");

$endif
