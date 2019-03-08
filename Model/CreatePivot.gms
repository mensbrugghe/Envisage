*  Load pivot table

$include "%baseName%Sets.gms"

$include "%baseName%Tab.gms"

$setGlobal fileName  %fileName%
$setGlobal  varTgt   %target%
$setGlobal  format   "#,##0.00"

$iftheni.getEnv "%sysenv.COMPUTERNAME%" == "DESKTOP-6G0TUU5"
   $$setGlobal DSN Text files;DefaultDir=C:\;DriverId=27;FIL=text;MaxBufferSize=2048;PageTimeout=5;
$elseifi.getEnv "%sysenv.COMPUTERNAME%" == "DESKTOP-N5CKOPI"
   $$setGlobal DSN Text files;DefaultDir=C:\;DriverId=27;FIL=text;MaxBufferSize=2048;PageTimeout=5;
$elseifi.getEnv "%sysenv.COMPUTERNAME%" == "1145KRAN563-02D"
*  $$setGlobal DSN MS Access Text Driver;DefaultDir=C:\;DriverId=27;FIL=text;MaxBufferSize=2048;PageTimeout=5;
   $$setGlobal DSN Text files;DefaultDir=C:\;DriverId=27;FIL=text;MaxBufferSize=2048;PageTimeout=5;
$else.getEnv
   $$setGlobal DSN Text files;DefaultDir=C:\;DriverId=27;FIL=text;MaxBufferSize=2048;PageTimeout=5;
$endif.getEnv

$show

$setGlobal ifActivity 0
$setGlobal ifSortAct  0
$setGlobal ifComm     0
$setGlobal ifSortComm 0
$setGlobal ifFact     0

$iftheni "%GEOM%" == "VarByRegion"
set fields /
   Sim
   Var
   Region
   Year
   Value
/ ;

Table PivotOptions(fields, *)
         Pos    ifSum
Sim        3      0
Var        3      0
Region     2      0
Year       1      0
Value      4      1
;

$elseifi "%GEOM%" == "VarByHH"

set fields /
   Sim
   Var
   Region
   Household
   Year
   Value
/ ;

Table PivotOptions(fields, *)
         Pos    ifSum
Sim        3      0
Var        3      0
Household  3      0
Region     2      0
Year       1      0
Value      4      1
;

$elseifi "%GEOM%" == "VarByActivity"

set fields /
   Sim
   Var
   Region
   Activity
   Year
   Value
/ ;

Table PivotOptions(fields, *)
         Pos    ifSum
Sim        3      0
Var        3      0
Region     3      0
Activity   2      0
Year       1      0
Value      4      1
;
$setGlobal ifActivity 1
$setGlobal ifSortAct  1

$elseifi "%GEOM%" == "VarByNRG"

set fields /
   Sim
   Var
   Region
   Source
   Unit
   Year
   Value
/ ;

Table PivotOptions(fields, *)
         Pos    ifSum
Sim        3      0
Var        3      0
Region     3      0
Unit       3      0
Source     2      0
Year       1      0
Value      4      1
;
$setGlobal ifActivity 0
$setGlobal ifSortAct  0

$elseifi "%GEOM%" == "VarByReserve"

set fields /
   Sim
   Var
   Region
   Activity
   Year
   Value
/ ;

Table PivotOptions(fields, *)
         Pos    ifSum
Sim        3      0
Var        3      0
Region     3      0
Activity   2      0
Year       1      0
Value      4      1
;
$setGlobal ifActivity 0
$setGlobal ifSortAct  0

$elseifi "%GEOM%" == "VarByPower"

set fields /
   Sim
   Var
   Region
   Activity
   Year
   Value
/ ;

Table PivotOptions(fields, *)
         Pos    ifSum
Sim        3      0
Var        3      0
Region     3      0
Activity   2      0
Year       1      0
Value      4      1
;

$elseifi "%GEOM%" == "VarByCommodity"

set fields /
   Sim
   Var
   Region
   Commodity
   Year
   Value
/ ;

Table PivotOptions(fields, *)
         Pos    ifSum
Sim        3      0
Var        3      0
Region     3      0
Commodity  2      0
Year       1      0
Value      4      1
;
$setGlobal ifComm      1
$setGlobal ifSortComm  1

$elseifi "%GEOM%" == "VarByFactor"

set fields /
   Sim
   Var
   Region
   Activity
   Factor
   Year
   Value
/ ;

Table PivotOptions(fields, *)
         Pos    ifSum
Sim        3      0
Var        3      0
Region     3      0
Factor     3      0
Activity   2      0
Year       1      0
Value      4      1
;
$setGlobal ifActivity 1
$setGlobal ifSortAct  0
$setGlobal ifFact     1

$elseifi "%GEOM%" == "VarByZone"

set fields /
   Sim
   Var
   Region
   Type
   Zone
   Year
   Value
/ ;

Table PivotOptions(fields, *)
         Pos    ifSum
Sim        3      0
Var        3      0
Region     3      0
Type       2      0
Zone       3      0
Year       1      0
Value      4      1
;

$elseifi "%GEOM%" == "VarByEmi"

set fields /
   Sim
   Var
   Region
   Agent
   Emission
   Unit
   Year
   Value
/ ;

Table PivotOptions(fields, *)
         Pos    ifSum
Sim        3      0
Var        3      0
Region     3      0
Agent      2      0
Emission   3      0
Unit       3      0
Year       1      0
Value      4      1
;

$elseifi "%GEOM%" == "VarByCost"

set fields /
   Sim
   Var
   Region
   Activity
   Input
   Qualifier
   Year
   Value
/ ;

Table PivotOptions(fields, *)
         Pos    ifSum
Sim        3      0
Var        3      0
Region     3      0
Activity   3      0
Input      2      0
Qualifier  3      0
Year       1      0
Value      4      1
;
$setGlobal ifActivity 1
$setGlobal ifSortAct  1
$setGlobal ifFact     0

$endif

scalar order ;

file script / %fileName%.vbs / ;
put script ;

*  Script pre-amble

Put 'Wscript.Echo "Creating Excel worksheet pivot table(s)...."' / ;
Put 'Wscript.Echo "This will take a minute..."' / ;
Put 'Wscript.Echo ""' / ;
Put 'Set xl = CreateObject("Excel.Application")' / ;
Put 'xl.DisplayAlerts=False' / ;
Put 'Set wb = xl.Workbooks.Add' / ;

*  Put 'Wscript.Echo "Creating pivot table number",', itab:2:0 / ;
Put 'Set pc = wb.PivotCaches.Create(2)' / ;
Put 'pc.Connection = "ODBC;DSN=%DSN%Dbq=%inDir%\"' / ;
Put 'pc.CommandText = "select * from [%fileName%.csv]"' / ;

*  Add a wks
Put 'If wb.Sheets.count = 0 Then' / ;
Put '   Set sh = wb.Sheets.Add()' / ;
Put 'Else' / ;
Put '   Set sh = wb.Sheets(1)' / ;
Put 'End If' / ;
Put 'sh.Name="%varTgt%"' / ;

*  Create the pivot table

Put 'Set pt = pc.CreatePivotTable(sh.Range("A1"))' / ;
Put 'pt.SmallGrid = False' / ;
Put 'pt.HasAutoFormat = False' / ;
Put 'pt.PivotCache.RefreshPeriod = 0' / ;

loop(fields,
   put 'pt.PivotFields("',fields.tl:0:0,'").Orientation=',PivotOptions(fields,"Pos"):0:0 / ;
) ;

loop(fields$(PivotOptions(fields,"ifSum")=0),
   put 'pt.PivotFields("',fields.tl:0:0,
            '").Subtotals = Array(False, False, False, False, False, False, False, False, False, False, False, False)' / ;
) ;

Put 'pt.PivotFields("Sum of Value").NumberFormat = "%format%"' / ;

*  Sort the labels

*  Regions

order=0 ;
loop(mapOrder(sortOrder,r),
   order = order+1 ;
   Put 'pt.PivotFields("Region").PivotItems("', r.tl:0:0, '").Position = ', order:0:0 / ;
) ;

$ifthen.sortAct1 %ifActivity% == 1
   $$ifthen.sortAct2 %ifSortAct% == 1
      order=0 ;
      loop(mapOrder(sortOrder,a),
         order = order+1 ;
         Put 'pt.PivotFields("Activity").PivotItems("', a.tl:0:0, '").Position = ', order:0:0 / ;
      ) ;
   $$endif.sortAct2
$endif.sortAct1

$ifthen.sortComm1 %ifComm% == 1
   $$ifthen.sortComm2 %ifSortComm% == 1
      order=0 ;
      loop(mapOrder(sortOrder,i),
         order = order+1 ;
         Put 'pt.PivotFields("Commodity").PivotItems("', i.tl:0:0, '").Position = ', order:0:0 / ;
      ) ;
   $$endif.sortComm2
$endif.sortComm1

Put 'pt.PivotFields("Sim").CurrentPage = "%simTgt%"' / ;
Put 'pt.PivotFields("Var").CurrentPage = "%varTgt%"' / ;

$ifthen %ifActivity% == 1
   Put 'pt.PivotFields("Region").CurrentPage = "%regTgt%"' / ;
$endif

$ifthen %ifComm% == 1
   Put 'pt.PivotFields("Region").CurrentPage = "%regTgt%"' / ;
$endif

*Put 'pt.PivotFields("Year").CurrentPage = "%timeTgt%"' / ;

*  Finish formatting the pivot table and the wks

Put 'pt.ColumnGrand = False' / ;
Put 'pt.RowGrand = False' / ;
Put 'pt.TableStyle2 = "PivotStyleMedium7"' / ;
Put 'sh.Columns("A:A").EntireColumn.AutoFit' / ;
put / ;

*  Finish the script

Put 'Wscript.Echo "Saving %fileName%.xlsx"' / ;
Put 'wb.SaveAs("%xclDir%%fileName%.xlsx")' / ;
Put 'wb.Close' / ;
Put 'xl.Quit' / ;

putclose script ;

*  Execute the script creating the Excel file

execute "cscript %fileName%.vbs //Nologo" ;
