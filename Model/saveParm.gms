$macro putinf(x) ((x)$(x ne inf)+(1e37)$(x eq inf))
$macro put1(varName, i__1)                     loop((i__1), put "&varName", i__1.tl (putinf(&varName(i__1))) / ; ) ;
$macro put2(varName, i__1, i__2)               loop((i__1, i__2), put "&varName", i__1.tl, i__2.tl, (putinf(&varName(i__1, i__2))) / ; ) ;
$macro put3(varName, i__1, i__2, i__3)         loop((i__1, i__2, i__3), put "&varName", i__1.tl, i__2.tl, i__3.tl, (putinf(&varName(i__1, i__2, i__3))) / ; ) ;
$macro put4(varName, i__1, i__2, i__3, i__4)   loop((i__1, i__2, i__3, i__4), put "&varName", i__1.tl, i__2.tl, i__3.tl, i__4.tl, (putinf(&varName(i__1, i__2, i__3, i__4))) / ; ) ;
$macro put2t(varName, i__1, i__2)              loop((i__1, i__2, t), put "&varName", i__1.tl, i__2.tl, t.val:4:0, (putinf(&varName(i__1, i__2, t))) / ; ) ;
$macro put3t(varName, i__1, i__2, i__3)        loop((i__1, i__2, i__3, t), put "&varName", i__1.tl, i__2.tl, i__3.tl, t.val:4:0, (putinf(&varName(i__1, i__2, i__3, t))) / ; ) ;
$macro put4t(varName, i__1, i__2, i__3, i__4)  loop((i__1, i__2, i__3, i__4, t), put "&varName", i__1.tl, i__2.tl, i__3.tl, i__4.tl, t.val:4:0, (putinf(&varName(i__1, i__2, i__3, i__4, t))) / ; ) ;

sets
   tab                  / ravt, rav, rat, rlat, riat, reavt, ranvt, ranv, ra, rai, ri, rit, rkht, rkh, rirt, r /
   tabFlag(tab)         / ravt, rav, rat, rlat, riat, reavt, ranvt, ranv, ra, rai, ri, rit, rkht, rkh, rirt, r /
   ifRegFlag(tab)       / ravt, rav, rat, rlat, riat, reavt, ranvt, ranv, ra, rai, ri, rit, rkht, rkh, rirt, r /
   ifActFlag(tab)       / ravt, rav, rat, rlat, riat, reavt, ranvt, ranv, ra, rai /
   ifCommFlag(tab)      / riat, rai, ri, rit, rirt /
   ifeCommFlag(tab)     / reavt /
   ifkCommFlag(tab)     / rkht, rkh /
   ifhhdFlag(tab)       / rkht, rkh /
   ifVintFlag(tab)      / ravt, rav, reavt, ranvt, ranv /
   tabYear(tab)         / ravt, rat, rlat, riat, reavt, ranvt, rkht, rit, rirt /
   tabReg(tab)          / ravt, rav, rlat, riat, reavt, ranvt, ranv, rai, rirt /
   parmSel              / and1, sigmav, ah2o, alab, aio, aeio, aNRG, sigmaNRG, sigmaul, alphadt, sigmapb, sigmas, etah, nu, alphaw /
   labels               / Parm, Region, Destination, Activity, Commodity, pb, Energy, Labor, Hhd, Vintage, Year, Value /
   pos                  / 1*4 /
;

tabFlag("reavt")$(card(e) eq 0) = no ;

set regSel(r) ;   regSel(r)$(ord(r) eq 1) = yes ;
set yearSel(t) ;  yearSel(t)$(t0(t)) = yes ;

set mapPT(tab, labels, pos) /
   "ravt".Activity.1
   "ravt".Vintage.2
   "ravt".Parm.3
   "ravt".Region.3
   "ravt".Year.3
   "ravt".Value.4

   "rav".Activity.1
   "rav".Vintage.2
   "rav".Parm.3
   "rav".Region.3
   "rav".Value.4

   "rat".Activity.1
   "rat".Region.2
   "rat".Parm.3
   "rat".Value.4
   "rat".Year.3

   "rlat".Activity.1
   "rlat".Labor.2
   "rlat".Parm.3
   "rlat".Region.3
   "rlat".Year.3
   "rlat".Value.4

   "riat".Commodity.1
   "riat".Activity.2
   "riat".Parm.3
   "riat".Region.3
   "riat".Year.3
   "riat".Value.4

   "reavt".Commodity.1
   "reavt".Activity.2
   "reavt".Vintage.2
   "reavt".Parm.3
   "reavt".Region.3
   "reavt".Year.3
   "reavt".Value.4

   "ranvt".Activity.1
   "ranvt".Energy.2
   "ranvt".Vintage.2
   "ranvt".Parm.3
   "ranvt".Region.3
   "ranvt".Year.3
   "ranvt".Value.4

   "ranv".Activity.1
   "ranv".Energy.2
   "ranv".Vintage.2
   "ranv".Parm.3
   "ranv".Region.3
   "ranv".Value.4

   "ra".Activity.1
   "ra".Region.2
   "ra".Parm.3
   "ra".Value.4

   "rai".Activity.1
   "rai".Commodity.2
   "rai".Region.3
   "rai".Parm.3
   "rai".Value.4

   "ri".Commodity.1
   "ri".Region.2
   "ri".Parm.3
   "ri".Value.4

   "rit".Commodity.1
   "rit".Region.2
   "rit".Parm.3
   "rit".Year.3
   "rit".Value.4

   "rkht".Commodity.1
   "rkht".Region.2
   "rkht".Parm.3
   "rkht".Hhd.3
   "rkht".Year.3
   "rkht".Value.4

   "rkh".Commodity.1
   "rkh".Region.2
   "rkh".Parm.3
   "rkh".Hhd.3
   "rkh".Value.4

   "rirt".Commodity.1
   "rirt".Destination.2
   "rirt".Parm.3
   "rirt".Region.3
   "rirt".Year.3
   "rirt".Value.4

   "r".Region.2
   "r".Parm.1
   "r".Value.4

/ ;

set mapSEL(tab,parmSel) /
   "ravt"."and1"
   "rav"."sigmav"
   "rat"."ah2o"
   "rlat"."alab"
   "riat"."aio"
   "reavt"."aeio"
   "ranvt"."aNRG"
   "ranv"."sigmaNRG"
   "ra"."sigmaul"
   "rai"."sigmapb"
   "ri"."sigmas"
   "rit"."alphadt"
   "rkht"."etah"
   "rkh"."nu"
   "rirt"."alphaw"
/ ;

file csvravt   / "%odir%/%BaseName%ravt.csv" / ;
file csvrav    / "%odir%/%BaseName%rav.csv" / ;
file csvrat    / "%odir%/%BaseName%rat.csv" / ;
file csvrlat   / "%odir%/%BaseName%rlat.csv" / ;
file csvriat   / "%odir%/%BaseName%riat.csv" / ;
file csvreavt  / "%odir%/%BaseName%reavt.csv" / ;
file csvranvt  / "%odir%/%BaseName%ranvt.csv" / ;
file csvranv   / "%odir%/%BaseName%ranv.csv" / ;
file csvra     / "%odir%/%BaseName%ra.csv" / ;
file csvrai    / "%odir%/%BaseName%rai.csv" / ;
file csvri     / "%odir%/%BaseName%ri.csv" / ;
file csvrit    / "%odir%/%BaseName%rit.csv" / ;
file csvrkht   / "%odir%/%BaseName%rkht.csv" / ;
file csvrkh    / "%odir%/%BaseName%rkh.csv" / ;
file csvrirt   / "%odir%/%BaseName%rirt.csv" / ;
file csvr      / "%odir%/%BaseName%r.csv" / ;

$ondotL
if(ifCSVVerbose,

   put csvravt ;
   put "Parm,Region,Activity,Vintage,Year,Value" / ;
   csvravt.pc=5 ;
   csvravt.nd=9 ;

   put3t(axghg, r, a, v)
   put3t(aghg, r, a, v)
   put3t(axp, r, a, v)
   put3t(and1, r, a, v)
   put3t(ava, r, a, v)
   put3t(alab1, r, a, v)
   put3t(akef, r, a, v)
   put3t(and2, r, a, v)
   put3t(ava1, r, a, v)
   put3t(ava2, r, a, v)
   put3t(aland, r, a, v)
   put3t(akf, r, a, v)
   put3t(ae, r, a, v)
   put3t(aksw, r, a, v)
   put3t(anrf, r, a, v)
   put3t(aks, r, a, v)
   put3t(awat, r, a, v)
   put3t(ak, r, a, v)
   put3t(alab2, r, a, v)
   put3t(anely, r, a, v)
   put3t(aolg, r, a, v)

   putclose csvravt ;

else

   tabFlag("ravt") = no ;

) ;

put csvrav ;
put "Parm,Region,Activity,Vintage,Value" / ;
csvrav.pc=5 ;
csvrav.nd=9 ;

put3(sigmaxp, r, a, v)
put3(sigmap, r, a, v)
put3(sigmav, r, a, v)
put3(sigmav1, r, a, v)
put3(sigmav2, r, a, v)
put3(sigmakef, r, a, v)
put3(sigmakf, r, a, v)
put3(sigmakw, r, a, v)
put3(sigmak, r, a, v)
put3(sigmae, r, a, v)
put3(sigmanely, r, a, v)
put3(sigmaolg, r, a, v)

putclose csvrav ;

if(ifCSVVerbose,
   put csvrat ;
   put "Parm,Region,Activity,Year,Value" / ;
   csvrat.pc=5 ;
   csvrat.nd=9 ;

   put2t(ah2o, r, a)

   putclose csvrat ;

else

   tabFlag("rat") = no ;

) ;

if(ifCSVVerbose,
   put csvrlat ;
   put "Parm,Region,Labor,Activity,Year,Value" / ;
   csvrlat.pc=5 ;
   csvrlat.nd=9 ;

   put3t(alab, r, l, a)

   putclose csvrlat ;

else

   tabFlag("rlat") = no ;

) ;

if(ifCSVVerbose,
   put csvriat ;
   put "Parm,Region,Commodity,Activity,Year,Value" / ;
   csvriat.pc=5 ;
   csvriat.nd=9 ;

   put3t(aio, r, i, a)
   put3t(alphafd, r, i, fdc)

   putclose csvriat ;

else

   tabFlag("riat") = no ;

) ;

if(ifCSVVerbose,
   put csvreavt ;
   put "Parm,Region,Commodity,Activity,Vintage,Year,Value" / ;
   csvreavt.pc=5 ;
   csvreavt.nd=9 ;

   put4t(aeio, r, e, a, v)

   putclose csvreavt ;

else

   tabFlag("reavt") = no ;

) ;

if(ifCSVVerbose,
   put csvranvt ;
   put "Parm,Region,Activity,Energy,Vintage,Year,Value" / ;
   csvranvt.pc=5 ;
   csvranvt.nd=9 ;

   put4t(aNRG, r, a, NRG, v)

   putclose csvranvt ;

else

   tabFlag("ranvt") = no ;

) ;

put csvranv ;
put "Parm,Region,Activity,Energy,Vintage,Value" / ;
csvranv.pc=5 ;
csvranv.nd=9 ;

put4(sigmaNRG, r, a, NRG, v)

putclose csvranv ;

put csvra ;
put "Parm,Region,Activity,Value" / ;
csvra.pc=5 ;
csvra.nd=9 ;

put2(sigmawat, r, a)
put2(sigmaul, r, a)
put2(sigmasl, r, a)
put2(sigman1, r, a)
put2(sigman2, r, a)
put2(omegas, r, a)
put2(sigmafd, r, fdc)
put2(invElas, r, a)
put2(etanrf, r, a)
put2(omegalb, r, lb)
put2(omegaw2, r, wbnd)
put2(etah2obnd, r, wbnd)
put2(omegam, r, l)

putclose csvra ;

put csvrai ;
put "Parm,Region,Activity,Commodity,Value" / ;
csvrai.pc=5 ;
csvrai.nd=9 ;

put3(sigmapb, r, pb, elyc)
put3(gp, r, a, i)

if(ifCSVVerbose,
   put3(as, r, a, i)
   put3(apb, r, pb, elyc)
) ;
putclose csvrai ;

put csvri ;
put "Parm,Region,Commodity,Value" / ;
csvri.pc=5 ;
csvri.nd=9 ;


put2(sigmas, r, i)
put2(sigmael, r, elyc)
put2(sigmapow, r, elyc)
put2(sigmamt, r, i)
put2(sigmaw, r, i)
put2(gammaesd, r, i)
put2(gammaese, r, i)
put2(omegax, r, i)
put2(omegaw, r, i)
if(ifCSVVerbose,
   put2(apow, r, elyc)
) ;
putclose csvri ;

if(ifCSVVerbose,
   put csvrit ;
   put "Parm,Region,Commodity,Year,Value" / ;
   csvrit.pc=5 ;
   csvrit.nd=9 ;

   put2t(alphadt, r, i)
   put2t(alphamt, r, i)
   put2t(gammad, r, i)
   put2t(gammae, r, i)
   putclose csvrit ;

else

   tabFlag("rit") = no ;

) ;

if(ifCSVVerbose,
   put csvrirt ;
   put "Parm,Region,Commodity,Destination,Year,Value" / ;
   csvrirt.pc = 5 ;
   csvrirt.nd = 9 ;

   put3t(alphaw,r,i,rp)
   put3t(gammaw,r,i,rp)

   putClose csvrirt ;

else

   tabFlag("rirt") = no ;

) ;

put csvrkht ;
put "Parm,Region,Commodity,Hhd,Year,Value" / ;
csvrkht.pc=5 ;
csvrkht.nd=9 ;

put3t(etah, r, k, h)

if(ifCSVVerbose,
   put3t(acnely, r, k, h)
   put3t(acolg, r, k, h)
) ;

if(%utility%=ELES,
   put3t(muc, r, k, h)
   put3t(gammac, r, k, h)
else
   put3t(bh, r, k, h)
   put3t(eh, r, k, h)
   if(ifCSVVerbose, put3t(alphah, r, k, h) ) ;
) ;

putclose csvrkht ;

put csvrkh ;
put "Parm,Region,Commodity,Hhd,Value" / ;
csvrkh.pc=5 ;
csvrkh.nd=9 ;

put3(nu, r, k, h)
put3(nue, r, k, h)
put3(nunely, r, k, h)
put3(nuolg, r, k, h)
put3(nunnrg, r, k, h)
if(ifCSVVerbose,
   put3(acxnnrg, r, k, h)
   put3(acxnrg, r, k, h)
) ;

putclose csvrkh ;

put csvr ;
put "Parm,Region,Value" / ;
csvr.pc=5 ;
csvr.nd=9 ;

put1(etat, r)
put1(omegat, r)
put1(omeganlb, r)
put1(etaw, r)
put1(omegaw1, r)

putclose csvr ;

$offDotL

*  Write the script

file script / savPrm.vbs / ;
put script ;

*  Start the script

Put 'Wscript.Echo "Creating Excel worksheet pivot tables...."' / ;
Put 'Wscript.Echo "This will take a minute..."' / ;
Put 'Wscript.Echo ""' / ;
Put 'Set xl = CreateObject("Excel.Application")' / ;
Put 'xl.DisplayAlerts=False' / ;
Put 'Set wb = xl.Workbooks.Add' / ;

scalar itab, iindex ; itab=0 ;

loop(tab$tabFlag(tab),
   itab = itab+1 ;

*  Initiate the table

   Put 'Wscript.Echo "Creating pivot table number",', itab:2:0 / ;
   Put 'Set pc = wb.PivotCaches.Create(2)' / ;
   Put 'pc.Connection = "ODBC;DSN=Text files;Driver={Microsoft Access Text Driver (*.txt; *.csv)};Dbq=%odir%"' / ;
   Put 'pc.CommandText = "select * from [%baseName%',tab.tl:card(tab.tl),'.csv]"' / ;

*  Add a wks
   if(ord(tab) eq 1,
      Put 'If wb.Sheets.count = 0 Then' / ;
      Put '   Set sh = wb.Sheets.Add()' / ;
      Put 'Else' / ;
      Put '   Set sh = wb.Sheets(1)' / ;
      Put 'End If' / ;
   else
      Put 'Set sh = wb.Sheets.Add()' / ;
   ) ;
   Put 'sh.Name="',tab.tl:card(tab.tl),'"' / ;

*  Create the pivot table

   Put 'Set pt = pc.CreatePivotTable(sh.Range("A1"))' / ;
   Put 'pt.SmallGrid = False' / ;
   Put 'pt.HasAutoFormat = False' / ;
   Put 'pt.PivotCache.RefreshPeriod = 0' / ;

*  Configure the pivot table

   loop((labels,pos)$mapPT(tab, labels, pos),
      put 'pt.PivotFields("',labels.tl:card(labels.tl),'").Orientation=',pos.val:1:0 / ;
   ) ;
   loop((labels,pos)$mapPT(tab, labels, pos),
      if(ord(pos) ne 4,
         put 'pt.PivotFields("',labels.tl:card(labels.tl),
            '").Subtotals = Array(False, False, False, False, False, False, False, False, False, False, False, False)' / ;
      ) ;
   ) ;
   Put 'pt.PivotFields("Sum of value").NumberFormat = "#,##0.000"' / ;

*  Select the specific fields

   if(tabReg(tab),
      loop(r$regSel(r),
         Put 'pt.PivotFields("Region").CurrentPage = "',r.tl:card(r.tl),'"' / ;
      ) ;
   ) ;
   if(ifhhdFlag(tab),
      Put 'pt.PivotFields("Hhd").CurrentPage = "hhd"' / ;
   ) ;
   if(tabYear(tab),
      loop(t$YearSel(t),
         Put 'pt.PivotFields("Year").CurrentPage = ', years(t):4:0 / ;
      ) ;
   ) ;
   loop(parmSel$mapSEL(tab,parmSel),
      Put 'pt.PivotFields("Parm").CurrentPage = "', parmSel.tl:card(parmSel.tl), '"' / ;
   ) ;

*  Sort the various labels

*  Sort the regional labels
   if(ifregFlag(tab),
      loop(mapRegSort(sortOrder,r),
         Put 'pt.PivotFields("Region").PivotItems("', r.tl:card(r.tl), '").Position = ', ord(sortOrder):4:0 / ;
      ) ;
   ) ;
*  Sort the activity labels
   if(ifactFlag(tab),
      loop(mapActSort(sortOrder,a),
         Put 'pt.PivotFields("Activity").PivotItems("', a.tl:card(a.tl), '").Position = ', ord(sortOrder):4:0 / ;
      ) ;
   ) ;
*  Sort the commodity labels
   if(ifCommFlag(tab),
      loop(mapCommSort(sortOrder,i),
         Put 'pt.PivotFields("Commodity").PivotItems("', i.tl:card(i.tl), '").Position = ', ord(sortOrder):4:0 / ;
      ) ;
   ) ;
*  Sort the energy commodity labels
   if(ifeCommFlag(tab),
      iindex = 0 ;
      loop(mapCommSort(sortOrder,i)$e(i),
         iindex = iindex + 1 ;
         Put 'pt.PivotFields("Commodity").PivotItems("', i.tl:card(i.tl), '").Position = ', iindex:4:0 / ;
      ) ;
   ) ;
*  Sort the consumer commodity labels
   if(ifkCommFlag(tab),
      loop(mapkCommSort(sortOrder,k),
         Put 'pt.PivotFields("Commodity").PivotItems("', k.tl:card(k.tl), '").Position = ', ord(sortOrder):4:0 / ;
      ) ;
   ) ;
*  Sort the Vintage labels
   if(ifVintFlag(tab),
      loop(v,
         Put 'pt.PivotFields("Vintage").PivotItems("', v.tl:card(v.tl), '").Position = ', ord(v):1:0 / ;
      ) ;
   ) ;

*  Finish formatting the pivot table and the wks

   Put 'pt.ColumnGrand = False' / ;
   Put 'pt.RowGrand = False' / ;
   Put 'pt.TableStyle2 = "PivotStyleMedium7"' / ;
   Put 'sh.Columns("A:A").EntireColumn.AutoFit' / ;

   put / ;
) ;

*  Finish the script

Put 'Wscript.Echo "Saving %BaseName%Parm.xlsx"' / ;
Put 'wb.SaveAs("%wdir%%BaseName%Parm.xlsx")' / ;
Put 'wb.Close' / ;
Put 'xl.Quit' / ;

putclose script ;

*  Execute the script creating the Excel file

execute "cscript savPrm.vbs //Nologo" ;
