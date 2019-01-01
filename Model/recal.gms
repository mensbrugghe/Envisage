if(ord(tsim) ge 3,
*                             Agg   COMP PAGG  PCOMP     COEF    ELAST   SET  COMPTECH  AGGTECH
$batinclude "recalvat.gms"    xpv   xpx   uc    pxp       axp   sigmaxp   a   lambdaxp  axghg
$batinclude "recalvat.gms"    xpv   xghg  uc    pxghg     aghg  sigmaxp   a   lambdaghg axghg
$batinclude "recalnnn.gms"    xpx   nd1   pxp   pnd1      and1  sigmap    a
$batinclude "recalvnn.gms"    xpx   va    pxp   pva       ava   sigmap    a
$batinclude "recalnnn.gms"    va    lab1  pva   plab1     alab1 sigmav    acr
$batinclude "recalnnn.gms"    va1   lab1  pva1  plab1     alab1 sigmav1   alv
$batinclude "recalnnn.gms"    va    lab1  pva   plab1     alab1 sigmav    ax
$batinclude "recalvnn.gms"    va2   kef   pva2  pkef      akef  sigmav2   acr
$batinclude "recalvnn.gms"    va1   kef   pva1  pkef      akef  sigmav1   alv
$batinclude "recalvnn.gms"    va1   kef   pva1  pkef      akef  sigmav1   ax
$batinclude "recalnnn.gms"    va1   nd2   pva1  pnd2      and2  sigmav1   acr
$batinclude "recalnnn.gms"    va2   nd2   pva2  pnd2      and2  sigmav2   alv
$batinclude "recalvnn.gms"    va    va1   pva   pva1      ava1  sigmav    acr
$batinclude "recalvnn.gms"    va    va1   pva   pva1      ava1  sigmav    alv
$batinclude "recalvnn.gms"    va    va1   pva   pva1      ava1  sigmav    ax
$batinclude "recalvnn.gms"    va1   va2   pva1  pva2      ava2  sigmav1   acr
$batinclude "recalvnn.gms"    va    va2   pva   pva2      ava2  sigmav    alv
$batinclude "recalnnt.gms"    va2   xf    pva2  pfp       aland sigmav2   acr lambdaf  lnd
$batinclude "recalnnt.gms"    va2   xf    pva2  pfp       aland sigmav2   alv lambdaf  lnd
$batinclude "recalnnt.gms"    va1   xf    pva1  pfp       aland sigmav1   ax  lambdaf  lnd
$batinclude "recalvnn.gms"    kef   kf    pkef  pkf       akf   sigmakef  a
$batinclude "recalvnn.gms"    kef   xnrg  pkef  pnrg      ae    sigmakef  a
$batinclude "recalvnn.gms"    kf    ksw   pkf   pksw      aksW  sigmakf   a
$batinclude "recalnnt.gms"    kf    xf    pkf   pfp       anrs  sigmakf   a   lambdaf  nrs
$batinclude "recalvnn.gms"    ksw   ks    pksw  pks       aks   sigmakw   a
$batinclude "recalnnn.gms"    ksw   xwat  pksw  pwat      awat  sigmakw   a
$batinclude "recalvnt.gms"    ks    kv    pks   pkp       ak    sigmak    a   lambdak
$batinclude "recalnnn.gms"    ks    lab2  pks   plab2     alab2 sigmak    a
if(ifNRGNest,
$batinclude "recalvnn.gms"    xnrg  xnely pnrg  pnely     anely sigmae    a
$batinclude "recalvnn.gms"    xnely xolg  pnely polg      aolg  sigmanely a
$batinclude "recalnrg.gms"    xnrg  xaNRG pnrg  paNRG     aNRG  sigmae    a  "ELY"
$batinclude "recalnrg.gms"    xnely xaNRG pnely paNRG     aNRG  sigmanely a  "COA"
$batinclude "recalnrg.gms"    xolg  xaNRG polg  paNRG     aNRG  sigmaolg  a  "GAS"
$batinclude "recalnrg.gms"    xolg  xaNRG polg  paNRG     aNRG  sigmaolg  a  "OIL"
$batinclude "recalxanrgn.gms" xaNRG xa    paNRG pa        aeio  sigmaNRG  a  lambdae
else
$batinclude "recalxanrg.gms"  xnrg  xa    pnrg  pa        aeio  sigmae    a  lambdae
) ;
) ;

* --------------------------------------------------------------------------------------------------
*
*  'Twisting the Armington preference parameters
*
* --------------------------------------------------------------------------------------------------

$ondotL
if(ifCal,

*     Apply the twist parameters to top level Armington with national sourcing

   if(ArmFlag eq 0,
*     Calculate the top level import share
      ArmMShrt1(r,i)$xat0(r,i) =  pmt0(r,i)*pmt.l(r,i,tsim-1)*xmt0(r,i)*xmt.l(r,i,tsim-1)
                               / (pat0(r,i)*pat.l(r,i,tsim-1)*xat0(r,i)*xat.l(r,i,tsim-1)) ;
      alphadt(r,i,tsim) = alphadt(r,i,tsim-1)
                        * power(1/(1+ArmMShrt1(r,i)*twt1(r,i,tsim)), gap(tsim)) ;
      alphamt(r,i,tsim) = alphamt(r,i,tsim-1)
                        * power((1+twt1(r,i,tsim))/(1+ArmMShrt1(r,i)*twt1(r,i,tsim)), gap(tsim)) ;
   ) ;

*  Apply the twist parameters to top level Armington with agent-specific sourcing

   if(ArmFlag,
*     Calculate the top level import shares
      ArmMShr1(r,i,aa)$xa0(r,i,aa) =  pm0(r,i,aa)*PM_SUB(r,i,aa,tsim-1)
                                   *   xm0(r,i,aa)*xm.l(r,i,aa,tsim-1)
                                   /  (pa0(r,i,aa)*pa.l(r,i,aa,tsim-1)
                                   *   xa0(r,i,aa)*xa.l(r,i,aa,tsim-1)) ;
      alphad(r,i,aa,tsim) = alphad(r,i,aa,tsim-1)
                          * power(1/(1+ArmMShr1(r,i,aa)*tw1(r,i,aa,tsim)), gap(tsim)) ;
      alpham(r,i,aa,tsim) = alpham(r,i,aa,tsim-1)
                          * power((1+tw1(r,i,aa,tsim))/(1+ArmMShr1(r,i,aa)*tw1(r,i,aa,tsim)),
                                    gap(tsim)) ;
   ) ;

*  Apply the twist parameters to second Armington nest -- rtwtgt(rp,r)
*                 is the target set of country(ies)

   ArmMShr2(i,r) = sum(rp, pdm0(rp,i,r)*PDM_SUB(rp,i,r,tsim-1)*xw0(rp,i,r)*xw.l(rp,i,r,tsim-1)) ;
   ArmMShr2(i,r)$ArmMShr2(i,r) = sum(rp$rtwtgt(rp,r), pdm0(rp,i,r)*PDM_SUB(rp,i,r,tsim-1)
                               * xw0(rp,i,r)*xw.l(rp,i,r,tsim-1))
                               / ArmMShr2(i,r) ;

   alphaw(rp,i,r,tsim) = alphaw(rp,i,r,tsim-1)
                       * ((power(1/(1+ArmMshr2(i,r)*tw2(r,i,tsim)), gap(tsim)))$(not rtwtgt(rp,r))
                       +  (power((1+tw2(r,i,tsim))/(1+ArmMShr2(i,r)*tw2(r,i,tsim)),
                              gap(tsim))$rtwtgt(rp,r))) ;
) ;
$offDotL
