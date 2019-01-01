*  Sets for SSPs

sets
   th          "Full time path including history" / 1950*2100 /
   tt(th)      "Full time path for SSPs"          / 2007*2100 /
   t0(tt)      "Base year for SSPs"               / 2007 /
   var "GDP variables" /
         GDP         "GDP in million $2007 MER"
         GDPpc       "GDP per capita in $2007 MER"
         gdpppp05    "GDP in $2005 PPP"
         gdppcppp05  "GDP per capita in $2005"
      /
   scen "Scenarios" /
      SSP1        "Sustainable development"
      SSP2        "Middle of the road"
      SSP3        "Regional rivalry"
      SSP4        "Inequality"
      SSP5        "Fossil-fueled development"
      UNMED2010   "UN Population Division Medium Variant 2010 revision"
      UNMED2012   "UN Population Division Medium Variant 2012 revision"
      UNMED2015   "UN Population Division Medium Variant 2015 revision"
      UNMED2017   "UN Population Division Medium Variant 2017 revision"
      GIDD        "GIDD population projection"
      /
   ssp(scen) "SSP Scenarios" /
      SSP1        "Sustainable development"
      SSP2        "Middle of the road"
      SSP3        "Regional rivalry"
      SSP4        "Inequality"
      SSP5        "Fossil-fueled development"
      /
   mod "Models" /
      OECD        "OECD-based SSPs"
      IIASA       "IIASA-based SSPs"
      /
   tranche "Population cohorts" /
      PLT15       "Population less than 15"
      P1564       "Population aged 15 to 64"
      P65UP       "Population 65 and over"
      PTOTL       "Total population"
      /
   trs(tranche) "Population cohorts" /
      PLT15       "Population less than 15"
      P1564       "Population aged 15 to 64"
      P65UP       "Population 65 and over"
      /
   ed "Education levels" /
      ENONE       "No Education"
      EPRIM       "Primary Education"
      ESECN       "Secondary Education"
      ETERT       "Tertiary Education"
      ETOTL       "Total"
      /
   edx(ed) "Education levels excl total" /
      ENONE       "No Education"
      EPRIM       "Primary Education"
      ESECN       "Secondary Education"
      ETERT       "Tertiary Education"
      /
   sex   "Gender categories" /
      MAL         "Male"
      FEM         "Female"
      BOTH        "M+F"
      /
   sexx(sex) "Gender categories excl total"  /
      MAL         "Male"
      FEM         "Female"
      /

   edw "GIDD education labels" /
      educ0_6     "educ0_6"
      educ6_9     "educ6_9"
      educ9up     "educ9up"
      eductot     "eductot"
      /

   edwx(edw) "GIDD education labels /x total" /
      educ0_6     "educ0_6"
      educ6_9     "educ6_9"
      educ9up     "educ9up"
      /

   edj "Combined SSP/GIDD education levels" /
      elev0       "ENONE/EDUC0_6"
      elev1       "EPRIM/EDUC6_9"
      elev2       "ESECN/EDUC9UP"
      elev3       "ETERT"
      elevt       "Total"
   /

   mape1(edj, ed) "Mapping of SSP education to edj" /
      elev0.ENONE
      elev1.EPRIM
      elev2.ESECN
      elev3.ETERT
      elevt.ETOTL
   /

   mape2(edj, edw) "Mapping of GIDD education to edj" /
      elev0.EDUC0_6
      elev1.EDUC6_9
      elev2.EDUC9UP
      elevt.eductot
   /
;

set c countries "UN list of 230 countries /
   AUS     "Australia"
*  CXR     "Christmas Island"
*  CCK     "Cocos (Keeling) Islands"
*  HMD     "Heard Island and McDonald Islands"
*  NFK     "Norfolk Island"
   NZL     "New Zealand"
   ASM     "American Samoa"
   COK     "Cook Islands"
   FJI     "Fiji"
   PYF     "French Polynesia"
   GUM     "Guam"
   KIR     "Kiribati"
   MHL     "Marshall Islands"
   FSM     "Micronesia (Federated States of)"
   NRU     "Nauru"
   NCL     "New Caledonia"
   MNP     "Northern Mariana Islands"
   NIU     "Niue"
   PLW     "Palau"
   PNG     "Papua New Guinea"
*  PCN     "Pitcairn"
   WSM     "Samoa"
   SLB     "Solomon Islands"
   TKL     "Tokelau"
   TON     "Tonga"
   TUV     "Tuvalu"
*  UMI     "United States Minor Outlying Islands"
   VUT     "Vanuatu"
   WLF     "Wallis and Futuna Islands"
   CHN     "China"
   HKG     "Hong Kong, China Special Administrative Region"
   JPN     "Japan"
   KOR     "Korea, Republic of"
   MNG     "Mongolia"
   TWN     "Taiwan"
   MAC     "Macao, China Special Administrative Region"
   PRK     "Korea, Democratic People's Republic of "
   KHM     "Cambodia"
   IDN     "Indonesia"
   LAO     "Lao People's Democratic Republic"
   MYS     "Malaysia"
   PHL     "Philippines"
   SGP     "Singapore"
   THA     "Thailand"
   VNM     "Viet Nam"
   BRN     "Brunei Darussalam"
   MMR     "Myanmar"
   TLS     "Timor-Leste"
   BGD     "Bangladesh"
   IND     "India"
   NPL     "Nepal"
   PAK     "Pakistan"
   LKA     "Sri Lanka"
   AFG     "Afghanistan"
   BTN     "Bhutan"
   MDV     "Maldives"
   CAN     "Canada"
   USA     "United States of America"
   MEX     "Mexico"
   BMU     "Bermuda"
   GRL     "Greenland"
   SPM     "Saint Pierre and Miquelon"
   ARG     "Argentina"
   BOL     "Bolivia (Plurinational State of)"
   BRA     "Brazil"
   CHL     "Chile"
   COL     "Colombia"
   ECU     "Ecuador"
   PRY     "Paraguay"
   PER     "Peru"
   URY     "Uruguay"
   VEN     "Venezuela (Bolivarian Republic of)"
   FLK     "Falkland Islands (Malvinas)"
   GUF     "French Guiana"
*  SGS     "South George and the South Sandwich Islands"
   GUY     "Guyana"
   SUR     "Suriname"
   CRI     "Costa Rica"
   GTM     "Guatemala"
   HND     "Honduras"
   NIC     "Nicaragua"
   PAN     "Panama"
   SLV     "El Salvador"
   BLZ     "Belize"
   AIA     "Anguilla"
   ATG     "Antigua and Barbuda"
   ABW     "Aruba"
   BHS     "Bahamas"
   BRB     "Barbados"
   CYM     "Cayman Islands"
   CUB     "Cuba"
   DMA     "Dominica"
   DOM     "Dominican Republic"
   GRD     "Grenada"
   HTI     "Haiti"
   JAM     "Jamaica"
   MSR     "Montserrat"
   ANT     "Netherlands Antilles"
   PRI     "Puerto Rico"
   KNA     "Saint Kitts and Nevis"
   LCA     "Saint Lucia"
   VCT     "Saint Vincent and the Grenadines"
   TTO     "Trinidad and Tobago"
   TCA     "Turks and Caicos Islands"
   VGB     "British Virgin Islands"
   VIR     "United States Virgin Islands"
   AUT     "Austria"
   BEL     "Belgium"
   CYP     "Cyprus"
   CZE     "Czech Republic"
   DNK     "Denmark"
   EST     "Estonia"
   FIN     "Finland"
   FRA     "France"
   MTQ     "Martinique"
   GLP     "Guadeloupe"
   DEU     "Germany"
   GRC     "Greece"
   HUN     "Hungary"
   IRL     "Ireland"
   ITA     "Italy"
   LVA     "Latvia"
   LTU     "Lithuania"
   LUX     "Luxembourg"
   MLT     "Malta"
   NLD     "Netherlands"
   POL     "Poland"
   PRT     "Portugal"
   SVK     "Slovakia"
   SVN     "Slovenia"
   ESP     "Spain"
   SWE     "Sweden"
   GBR     "United Kingdom of Great Britain and Northern Ireland"
   CHI     "Channel Islands"
   IMN     "Isle of Man"
   CHE     "Switzerland"
   NOR     "Norway"
   ISL     "Iceland"
   LIE     "Liechtenstein"
   ALB     "Albania"
   BGR     "Bulgaria"
   BLR     "Belarus"
   HRV     "Croatia"
   ROU     "Romania"
   RUS     "Russian Federation"
   UKR     "Ukraine"
   MDA     "Republic of Moldova"
   AND     "Andorra"
   BIH     "Bosnia and Herzegovina"
   FRO     "Faeroe Islands"
   GIB     "Gibraltar"
*  GGY     "Guernsey"
   VAT     "Holy See"
*  JEY     "Jersey"
*  KSV     "Kosovo"
   MKD     "The former Yugoslav Republic of Macedonia"
   MCO     "Monaco"
   MNE     "Montenegro"
   SMR     "San Marino"
   SRB     "Serbia"
   KAZ     "Kazakhstan"
   KGZ     "Kyrgyzstan"
   TJK     "Tajikistan"
   TKM     "Turkmenistan"
   UZB     "Uzbekistan"
   ARM     "Armenia"
   AZE     "Azerbaijan"
   GEO     "Georgia"
   BHR     "Bahrain"
   IRN     "Iran (Islamic Republic of)"
   ISR     "Israel"
   KWT     "Kuwait"
   OMN     "Oman"
   QAT     "Qatar"
   SAU     "Saudi Arabia"
   TUR     "Turkey"
   ARE     "United Arab Emirates"
   IRQ     "Iraq"
   JOR     "Jordan"
   LBN     "Lebanon"
   PSE     "Occupied Palestinian Territory"
   SYR     "Syrian Arab Republic"
   YEM     "Yemen"
   EGY     "Egypt"
   MAR     "Morocco"
   TUN     "Tunisia"
   DZA     "Algeria"
   LBY     "Libyan Arab Jamahiriya"
   ESH     "Western Sahara"
   CMR     "Cameroon"
   CIV     "Côte d'Ivoire"
   GHA     "Ghana"
   NGA     "Nigeria"
   SEN     "Senegal"
   BEN     "Benin"
   BFA     "Burkina Faso"
   CPV     "Cape Verde"
   GMB     "Gambia"
   GIN     "Guinea"
   GNB     "Guinea-Bissau"
   LBR     "Liberia"
   MLI     "Mali"
   MRT     "Mauritania"
   NER     "Niger"
   SHN     "Saint Helena"
   SLE     "Sierra Leone"
   TGO     "Togo"
   CAF     "Central African Republic"
   TCD     "Chad"
   COG     "Congo"
   GNQ     "Equatorial Guinea"
   GAB     "Gabon"
   STP     "Sao Tome and Principe"
   AGO     "Angola"
   COD     "Democratic Republic of the Congo"
   ETH     "Ethiopia"
   KEN     "Kenya"
   MDG     "Madagascar"
   MWI     "Malawi"
   MUS     "Mauritius"
   MOZ     "Mozambique"
   TZA     "United Republic of Tanzania"
   UGA     "Uganda"
   ZMB     "Zambia"
   ZWE     "Zimbabwe"
   BDI     "Burundi"
   COM     "Comoros"
   DJI     "Djibouti"
   ERI     "Eritrea"
   MYT     "Mayotte"
   REU     "Réunion"
   RWA     "Rwanda"
   SYC     "Seychelles"
   SOM     "Somalia"
   SDN     "Sudan"
   BWA     "Botswana"
   NAM     "Namibia"
   ZAF     "South Africa"
   LSO     "Lesotho"
   SWZ     "Swaziland"
*  ATA     "Antarctica"
*  BVT     "Bouvet Island"
*  IOT     "British Indian Ocean Territory"
*  ATF     "French Southern Territories"
/ ;

set mapc(c,r0) "Mapping of countries to GTAP regions" /
   AUS.AUS
*  CXR.AUS
*  CCK.AUS
*  HMD.AUS
*  NFK.AUS
   NZL.NZL
   ASM.XOC
   COK.XOC
   FJI.XOC
   PYF.XOC
   GUM.XOC
   KIR.XOC
   MHL.XOC
   FSM.XOC
   NRU.XOC
   NCL.XOC
   MNP.XOC
   NIU.XOC
   PLW.XOC
   PNG.XOC
   WSM.XOC
   SLB.XOC
   TKL.XOC
   TON.XOC
   TUV.XOC
   VUT.XOC
   WLF.XOC
   CHN.CHN
   HKG.HKG
   JPN.JPN
   KOR.KOR
   MNG.MNG
   TWN.TWN
   MAC.XEA
   PRK.XEA
   KHM.KHM
   IDN.IDN
   LAO.LAO
   MYS.MYS
   PHL.PHL
   SGP.SGP
   THA.THA
   VNM.VNM
   BRN.BRN
   MMR.XSE
   TLS.XSE
   BGD.BGD
   IND.IND
   NPL.NPL
   PAK.PAK
   LKA.LKA
   AFG.XSA
   BTN.XSA
   MDV.XSA
   CAN.CAN
   USA.USA
   MEX.MEX
   BMU.XNA
   GRL.XNA
   SPM.XNA
   ARG.ARG
   BOL.BOL
   BRA.BRA
   CHL.CHL
   COL.COL
   ECU.ECU
   PRY.PRY
   PER.PER
   URY.URY
   VEN.VEN
   FLK.XSM
   GUF.XSM
   GUY.XSM
   SUR.XSM
   CRI.CRI
   GTM.GTM
   HND.HND
   NIC.NIC
   PAN.PAN
   SLV.SLV
   BLZ.XCA
   AIA.XCB
   ATG.XCB
   ABW.XCB
   BHS.XCB
   BRB.XCB
   CYM.XCB
   CUB.XCB
   DMA.XCB
   DOM.DOM
   GRD.XCB
   HTI.XCB
   JAM.JAM
   MSR.XCB
   ANT.XCB
   PRI.PRI
   KNA.XCB
   LCA.XCB
   VCT.XCB
   TTO.TTO
   TCA.XCB
   VGB.XCB
   VIR.XCB
   AUT.AUT
   BEL.BEL
   CYP.CYP
   CZE.CZE
   DNK.DNK
   EST.EST
   FIN.FIN
   FRA.FRA
   MTQ.FRA
   GLP.FRA
   DEU.DEU
   GRC.GRC
   HUN.HUN
   IRL.IRL
   ITA.ITA
   LVA.LVA
   LTU.LTU
   LUX.LUX
   MLT.MLT
   NLD.NLD
   POL.POL
   PRT.PRT
   SVK.SVK
   SVN.SVN
   ESP.ESP
   SWE.SWE
   GBR.GBR
   CHI.GBR
   CHE.CHE
   NOR.NOR
   ISL.XEF
   LIE.XEF
   ALB.ALB
   BGR.BGR
   BLR.BLR
   HRV.HRV
   ROU.ROU
   RUS.RUS
   UKR.UKR
   MDA.XEE
   AND.XER
   BIH.XER
   FRO.XER
   GIB.XER
*  GGY.XER
   VAT.XER
   IMN.XER
*  JEY.XER
*  KSV.XER
   MKD.XER
   MCO.XER
   MNE.XER
   SMR.XER
   SRB.XER
   KAZ.KAZ
   KGZ.KGZ
   TJK.XSU
   TKM.XSU
   UZB.XSU
   ARM.ARM
   AZE.AZE
   GEO.GEO
   BHR.BHR
   IRN.IRN
   ISR.ISR
   KWT.KWT
   OMN.OMN
   QAT.QAT
   SAU.SAU
   TUR.TUR
   ARE.ARE
   IRQ.XWS
   JOR.JOR
   LBN.XWS
   PSE.XWS
   SYR.XWS
   YEM.XWS
   EGY.EGY
   MAR.MAR
   TUN.TUN
   DZA.XNF
   LBY.XNF
   ESH.XNF
   BEN.BEN
   BFA.BFA
   CMR.CMR
   CIV.CIV
   GHA.GHA
   GIN.GIN
   NGA.NGA
   SEN.SEN
   TGO.TGO
   CPV.XWF
   GMB.XWF
   GNB.XWF
   LBR.XWF
   MLI.XWF
   MRT.XWF
   NER.XWF
   SHN.XWF
   SLE.XWF
   CAF.XCF
   TCD.XCF
   COG.XCF
   GNQ.XCF
   GAB.XCF
   STP.XCF
   AGO.XAC
   COD.XAC
   ETH.ETH
   KEN.KEN
   MDG.MDG
   MWI.MWI
   MUS.MUS
   MOZ.MOZ
   RWA.RWA
   TZA.TZA
   UGA.UGA
   ZMB.ZMB
   ZWE.ZWE
   BDI.XEC
   COM.XEC
   DJI.XEC
   ERI.XEC
   MYT.XEC
   REU.XEC
   SYC.XEC
   SOM.XEC
   SDN.XEC
   BWA.BWA
   NAM.NAM
   ZAF.ZAF
   LSO.XSC
   SWZ.XSC
*  ATA.XTW
*  BVT.XTW
*  IOT.XTW
*  ATF.XTW
/ ;
