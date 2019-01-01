* ----------------------------------------------------------------------------------------
*
*  Set definitions for standard GTAP database
*
*     Includes water endowment
*
* ----------------------------------------------------------------------------------------

scalar ver / 9 / ;

$onempty

set REG Set of regions in GTAP /
   AUS     "Australia"
   NZL     "New Zealand"
   XOC     "Rest of Oceania"
   CHN     "China"
   HKG     "Hong Kong"
   JPN     "Japan"
   KOR     "Korea"
   MNG     "Mongolia"
   TWN     "Taiwan"
   XEA     "Rest of East Asia"
   BRN     "Brunei Darussalam"
   KHM     "Cambodia"
   IDN     "Indonesia"
   LAO     "Laos"
   MYS     "Malaysia"
   PHL     "Philippines"
   SGP     "Singapore"
   THA     "Thailand"
   VNM     "Viet Nam"
   XSE     "Rest of Southeast Asia"
   BGD     "Bangladesh"
   IND     "India"
   NPL     "Nepal"
   PAK     "Pakistan"
   LKA     "Sri Lanka"
   XSA     "Rest of South Asia"
   CAN     "Canada"
   USA     "United States of America"
   MEX     "Mexico"
   XNA     "Rest of North America"
   ARG     "Argentina"
   BOL     "Bolivia"
   BRA     "Brazil"
   CHL     "Chile"
   COL     "Colombia"
   ECU     "Ecuador"
   PRY     "Paraguay"
   PER     "Peru"
   URY     "Uruguay"
   VEN     "Venezuela"
   XSM     "Rest of South America"
   CRI     "Costa Rica"
   GTM     "Guatemala"
   HND     "Honduras"
   NIC     "Nicaragua"
   PAN     "Panama"
   SLV     "El Salvador"
   XCA     "Rest of Central America"
   DOM     "Dominican Republic"
   JAM     "Jamaica"
   PRI     "Puerto Rico"
   TTO     "Trinidad and Tobago"
   XCB     "Rest of Caribbean"
   AUT     "Austria"
   BEL     "Belgium"
   CYP     "Cyprus"
   CZE     "Czech Republic"
   DNK     "Denmark"
   EST     "Estonia"
   FIN     "Finland"
   FRA     "France"
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
   GBR     "United Kingdom"
   CHE     "Switzerland"
   NOR     "Norway"
   XEF     "Rest of EFTA"
   ALB     "Albania"
   BGR     "Bulgaria"
   BLR     "Belarus"
   HRV     "Croatia"
   ROU     "Romania"
   RUS     "Russian Federation"
   UKR     "Ukraine"
   XEE     "Rest of Eastern Europe"
   XER     "Rest of Europe"
   KAZ     "Kazakhstan"
   KGZ     "Kyrgyzstan"
   TJK     "Tajikistan"
   XSU     "Rest of Former Soviet Union"
   ARM     "Armenia"
   AZE     "Azerbaijan"
   GEO     "Georgia"
   BHR     "Bahrain"
   IRN     "Iran"
   ISR     "Israel"
   JOR     "Jordan"
   KWT     "Kuwait"
   OMN     "Oman"
   QAT     "Qatar"
   SAU     "Saudi Arabia"
   TUR     "Turkey"
   ARE     "United Arab Emirates"
   XWS     "Rest of Western Asia"
   EGY     "Egypt"
   MAR     "Morocco"
   TUN     "Tunisia"
   XNF     "Rest of North Africa"
   BEN     "Benin"
   BFA     "Burkina Faso"
   CMR     "Cameroon"
   CIV     "Côte d'Ivoire"
   GHA     "Ghana"
   GIN     "Guinea"
   NGA     "Nigeria"
   SEN     "Senegal"
   TGO     "Togo"
   XWF     "Rest of Western Africa"
   XCF     "Central Africa"
   XAC     "South-Central Africa"
   ETH     "Ethiopia"
   KEN     "Kenya"
   MDG     "Madagascar"
   MWI     "Malawi"
   MUS     "Mauritius"
   MOZ     "Mozambique"
   RWA     "Rwanda"
   TZA     "Tanzania"
   UGA     "Uganda"
   ZMB     "Zambia"
   ZWE     "Zimbabwe"
   XEC     "Rest of Eastern Africa"
   BWA     "Botswana"
   NAM     "Namibia"
   ZAF     "South Africa"
   XSC     "Rest of South African Customs Union"
   XTW     "Rest of the World"
/ ;

alias(reg,r0) ; alias(reg,rp0) ;

set comm "Set of activities in GTAP" /
   PDR   "Paddy rice"
   WHT   "Wheat"
   GRO   "Cereal grains, n.e.s."
   V_F   "Vegetables and fruits"
   OSD   "Oil seeds"
   C_B   "Sugar cane and sugar beet"
   PFB   "Plant-based fibers"
   OCR   "Crops, n.e.s."
   CTL   "Bovine cattle, sheep and goats, horses"
   OAP   "Animal products n.e.s."
   RMK   "Raw milk"
   WOL   "Wool, silk-worm cocoons"
   FRS   "Forestry"
   FSH   "Fishing"
   COA   "Coal"
   OIL   "Oil"
   GAS   "Gas"
   OMN   "Minerals n.e.s."
   CMT   "Bovine cattle, sheep and goat, horse meat products"
   OMT   "Meat products n.e.s."
   VOL   "Vegetable oils and fats"
   MIL   "Dairy products"
   PCR   "Processed rice"
   SGR   "Sugar"
   OFD   "Food products n.e.s."
   B_T   "Beverages and tobacco products"
   TEX   "Textiles"
   WAP   "Wearing apparel"
   LEA   "Leather products"
   LUM   "Wood products"
   PPP   "Paper products, publishing"
   P_C   "Petroleum, coal products"
   CRP   "Chemical, rubber, plastic products"
   NMM   "Mineral products n.e.s."
   I_S   "Ferrous metals"
   NFM   "Metals n.e.s."
   FMP   "Metal products"
   MVH   "Motor vehicles and parts"
   OTN   "Transport equipment n.e.s."
   ELE   "Electronic equipment"
   OME   "Machinery and equipment n.e.s."
   OMF   "Manufactures n.e.s."
   ELY   "Electricity"
   GDT   "Gas manufacture, distribution"
   WTR   "Water"
   CNS   "Construction"
   TRD   "Trade"
   OTP   "Transport n.e.s."
   WTP   "Sea transport"
   ATP   "Air transport"
   CMN   "Communication"
   OFI   "Financial services n.e.s."
   ISR   "Insurance"
   OBS   "Business services n.e.s."
   ROS   "Recreation and other services"
   OSG   "Public administration and defense, education, health services"
   DWE   "Dwellings"
/ ;

alias(acts,comm) ;

alias(comm, i0) ;
alias(acts, a0) ;

SET MARG(comm) /

otp
wtp
atp

/;
alias(img0, marg) ;

set erg(comm) /

   "coa"    "Coal"
   "oil"    "Crude oil"
   "gas"    "Natural gas"
   "p_c"    "Refined oil"
   "ely"    "Electricity"
   "gdt"    "Gas distribution"
/ ;


*  !!!! NEEDS REVIEW -- SHOULD PROBABLY MOVE THIS TO A MAP FILE

parameter scaleXP(a0) ;
scaleXP(a0) = 1 ;

set fuel(erg) /

   coa   "Coal"
   oil   "Oil"
   gas   "Gas"
   p_c   "Petroleum, coal products"
   gdt   "Gas manufacture, distribution"

/ ;

sets
    acr0(a0) "Crop activities" /
      pdr   "Paddy rice"
      wht   "Wheat"
      gro   "Cereal grains, n.e.s."
      v_f   "Vegetables and fruits"
      osd   "Oil seeds"
      c_b   "Sugar cane and sugar beet"
      pfb   "Plant-based fibers"
      ocr   "Crops, n.e.s."
      /
   alv0(a0) "Livestock activities" /
      ctl   "Bovine cattle, sheep and goats, horses"
      oap   "Animal products n.e.s."
      rmk   "Raw milk"
      wol   "Wool, silk-worm cocoons"
      /
;

set elya0(a0)  "Power activities" /

/ ;

set endw Set of endowment factors /
   Land           "Land"
   tech_aspros    "Technical and professional workers"
   clerks         "Clerical workers"
   service_shop   "Service shop"
   off_mgr_pros   "Management"
   ag_othlowsk    "Agriculture and other low-skill workers"
   Capital        "Capital"
   NatlRes        "Natural resources"
$iftheni %ifWater% == "on"
   Water          "Water resource"
$endif
/ ;

set lab(endw) Set of labor factors /
   tech_aspros    "Technical and professional workers"
   clerks         "Clerical workers"
   service_shop   "Service shop"
   off_mgr_pros   "Management"
   ag_othlowsk    "Agriculture and other low-skill workers"
/ ;

alias(endw, fp0) ;

set ENDWS(endw) "Sluggish endowments" /
   Land     "Land"
   NatlRes  "Natural resources"
/ ;

set CAPT(endw) "Capital endowment" /
   Capital  "Capital"
/ ;

set LAND(endw) "Land endowment" /
   Land     "Land"
/ ;

set NTRS(endw) "Natural resource endowment" /
   NatlRes  "Natural resources"
/ ;

set WATER(endw) "Water commodity" /
$iftheni %ifWater% == "on"
   Water          "Water resource"
$endif
/ ;

set DIR /
   Domestic
   Imported
/ ;

set TARTYPE /
   ADV      "Ad valorem"
   SPE      "Specific"
/ ;

set wbnd0 "Aggregate water markets" /
   crp      "Crops"
   lvs      "Livestock"
   ind      "Industrial use"
   mun      "Municipal use"
/ ;

*  Emissions sets

set em "Emissions" /
   co2      "Carbon emissions"
   n2o      "N2O emissions"
   ch4      "Methane emissions"
   fgas     "Emissions of fluoridated gases"

   bc       "Black carbon (Gg)"
   co       "Carbon monoxide (Gg)"
   nh3      "Ammonia (Gg)"
   nmvb     "Non-methane volatile organic compounds (Gg)"
   nmvf     "Non-methane volatile organic compounds (Gg)"
   nox      "Nitrogen oxides (Gg)"
   oc       "Organic carbon (Gg)"
   pm10     "Particulate matter 10 (Gg)"
   pm2_5    "Particulate matter 2.5 (Gg)"
   so2      "Sulfur dioxide (Gg)"
/ ;

set ghg(em) "Greenhouse gas emissions" /

   co2      "Carbon emissions"
   n2o      "N2O emissions"
   ch4      "Methane emissions"
   fgas     "Emissions of fluoridated gases"

/ ;

set nghg(em) "Non-greenhouse gas emissions" /

   bc       "Black carbon (Gg)"
   co       "Carbon monoxide (Gg)"
   nh3      "Ammonia (Gg)"
   nmvb     "Non-methane volatile organic compounds (Gg)"
   nmvf     "Non-methane volatile organic compounds (Gg)"
   nox      "Nitrogen oxides (Gg)"
   oc       "Organic carbon (Gg)"
   pm10     "Particulate matter 10 (Gg)"
   pm2_5    "Particulate matter 2.5 (Gg)"
   so2      "Sulfur dioxide (Gg)"

/ ;

*  Non-CO2 Emissions sets

set emn(em) "Non-CO2 emissions" /
   n2o      "N2O emissions"
   ch4      "Methane emissions"
   fgas     "Emissions of fluoridated gases"

   bc       "Black carbon (Gg)"
   co       "Carbon monoxide (Gg)"
   nh3      "Ammonia (Gg)"
   nmvb     "Non-methane volatile organic compounds (Gg)"
   nmvf     "Non-methane volatile organic compounds (Gg)"
   nox      "Nitrogen oxides (Gg)"
   oc       "Organic carbon (Gg)"
   pm10     "Particulate matter 10 (Gg)"
   pm2_5    "Particulate matter 2.5 (Gg)"
   so2      "Sulfur dioxide (Gg)"
/ ;

alias(emn, nco2) ;

set mapnco2(nco2,nco2) ; mapnco2(nco2,nco2) = yes ;

set nco2eq "Labels for NCO2 gases in GWP units" /
   n2o_co2eq
   ch4_co2eq
   fgas_co2eq
/ ;

set mapco2eq(emn,nco2eq) /
   n2o . n2o_co2eq
   ch4 . ch4_co2eq
   fgas. fgas_co2eq
/ ;

set lg "Labor sets in the GIDD database" /
      nsk      "Unskilled labor"
      skl      "Skilled labor"
/ ;

set z Zones /
   rur   "Agricultural sectors"
   urb   "Non-agricultural sectors"
   nsg   "Non-segmented labor markets"
/ ;

set rur(z) "Rural zone" /
   rur         "Rural zone"
/ ;

set urb(z) "Urban zone" /
   urb         "Urban zone"
/ ;

set nsg(z) "Both zones" /
   nsg         "Non-segmented labor markets"
/ ;

set stdlab  "Standard SAM labels" /
   hhd            "Household"
   gov            "Government"
   inv            "Investment"
   deprY          "Depreciation"
   tmg            "Trade margins"
   itax           "Indirect tax"
   ptax           "Production tax"
   mtax           "Import tax"
   etax           "Export tax"
   vtax           "Taxes on factors of production"
   vsub           "Subsidies on factors of production"
   wtax           "Waste tax"
   ntmY           "NTM revenue"
   dtax           "Direct taxation"
   ctax           "Carbon tax"
   trd            "Trade account"
   bop            "Balance of payments account"
   tot            "Total for row/column sums"
/ ;

set fd(stdlab) "Domestic final demand agents" /

   hhd            "Household"
   gov            "Government"
   inv            "Investment"
   tmg            "Trade margins"

/ ;

set h(fd) "Households" /
   hhd            "Household"
/ ;

set gov(fd) "Government" /
   gov            "Government"
/ ;

set inv(fd) "Investment"/
   inv            "Investment"
/ ;

set tmg(fd) "Domestic supply of trade margins services" /
   tmg            "Trade margins"
/ ;

* --------------------------------------------------------------------------------------------------
*
*     Additions for AEZ database
*
* --------------------------------------------------------------------------------------------------

sets
   aezdef   /
      AEZ1           "Tropical and arid LGP000_060"
      AEZ2           "Tropical and dry semi-arid LGP060_119"
      AEZ3           "Tropical and moist semi-arid LGP120_179"
      AEZ4           "Tropical and sub-humid LGP180_239"
      AEZ5           "Tropical and humid LGP240_299"
      AEZ6           "Tropical and humid; year round growing season LGP300PLUS"
      AEZ7           "Temperate and arid LGP000_060"
      AEZ8           "Temperate and dry semi-arid LGP060_119"
      AEZ9           "Temperate and moist semi-arid LGP120_179"
      AEZ10          "Temperate and sub-humid LGP180_239"
      AEZ11          "Temperate and humid LGP240_299"
      AEZ12          "Temperate and humid; year round growing season LGP300PLUS"
      AEZ13          "Boreal and arid LGP000_060"
      AEZ14          "Boreal and dry semi-arid LGP060_119"
      AEZ15          "Boreal and moist semi-arid LGP120_179"
      AEZ16          "Boreal and sub-humid LGP180_239"
      AEZ17          "Boreal and humid LGP240_299"
      AEZ18          "Boreal and humid; year round growing season LGP300PLUS"
   /
   LCOVER_TYPE Land cover type /
      Forest         "Forest (accesible only)"
      SavnGrasslnd   "Savanna and grass land"
      Shrubland      "Shrub land"
      Cropland       "Crop land"
      Pastureland    "Pasture land"
      Builtupland    "Built-up land"
      Otherland      "All other land"
   /
   rum0(alv0) "Ruminants" /
      ctl   "Bovine cattle, sheep and goats, horses"
*     oap   "Animal products n.e.s."
      rmk   "Raw milk"
      wol   "Wool, silk-worm cocoons"
   /
   fpa0 "Set of endowment factors associated with the AEZ" /
      set.aezdef
      unSkLab     "Unskilled labor"
      SkLab       "Skilled labor"
      Capital     "Capital"
      NatRes      "Natural resources"
   /
   aez0(fpa0) /
      set.aezdef
   /
   mapaez(endw,fpa0) /
      land.(aez1*aez18)
      ag_othlowsk  . UnSkLab
      service_shop . UnSkLab
      clerks       . UnSkLab
      tech_aspros  . SkLab
      off_mgr_pros . SkLab
      Capital      . Capital
      NatlRes      . NatRes
   /
;

$offempty
