*-------------------------------------------------------------------------------
$ontext

   CAPRI project

   GAMS file : REMTINYVALUES.GMS

   @purpose  : Remove values from transaction matrixes below absolute
               Threshold
   @author   : Dominique VDM
   @date     : 15.06.15
   @since    :
   @refDoc   :
   @seeAlso  :
   @calledBy : loadGtapAgg.gms

$offtext
*-------------------------------------------------------------------------------

$macro chkTol2(var,d1,d2)        var(d1,d2)$(abs(var(d1,d2)) lt absTol) = 0
$macro chkTol3(var,d1,d2,d3)     var(d1,d2,d3)$(abs(var(d1,d2,d3)) lt absTol) = 0
$macro chkTol4(var,d1,d2,d3,d4)  var(d1,d2,d3,d4)$(abs(var(d1,d2,d3,d4)) lt absTol) = 0

* The original had fp0, i0, r0 (but these have been aliased)

if (absTol ne 1.E-10,

   chktol3(evfp, fp, j, r) ;
   chktol3(evfb, fp, j, r) ;
   chktol3(evos, fp, a, r) ;
   chktol3(ftrv, fp, j, r) ;
   chktol3(fbep, fp, j, r) ;
   chktol2(osep, i, r) ;
   chktol3(vdfb, i, j, r) ;
   chktol3(vdfp, i, j, r) ;
   chktol3(vmfb, i, j, r) ;
   chktol3(vmfp, i, j, r) ;
   chktol2(vdpb, i, r) ;
   chktol2(vdpp, i, r) ;
   chktol2(vmpb, i, r) ;
   chktol2(vmpp, i, r) ;
   chktol2(vdgb, i, r) ;
   chktol2(vdgp, i, r) ;
   chktol2(vmgb, i, r) ;
   chktol2(vmgp, i, r) ;
   chktol2(vdib, i, r) ;
   chktol2(vdip, i, r) ;
   chktol2(vmib, i, r) ;
   chktol2(vmip, i, r) ;
   chktol3(vxsb, i, r, d) ;
   chktol3(vfob, i, r, d) ;
   chktol3(vcif, i, r, d) ;
   chktol3(vmsb, i, r, d) ;
   chktol4(VTWR, i, j, r, d) ;

*  ???? Does not include vdim

);
