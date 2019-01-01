acronym CDE, CD, capFlex, capshrFix, capFix, capSFix ;

set rs(r) "Simulation regions" ;

alias(is,js) ; alias(r,rp) ; alias(i,j) ; alias(j,jp) ; alias(m,i) ; alias(i0,j0) ; alias(m0,i0) ;

$macro pp_sub(r,a,i,t)        ((p(r,a,i,t)*(1 + prdtx(r,a,i,t)))$ifSUB + (pp(r,a,i,t))$(not ifSUB))
$macro pdp_sub(r,i,aa,t)      ((pd(r,i,t)*(1 + dintx(r,i,aa,t)))$ifSUB + (pdp(r,i,aa,t))$(not ifSUB))
$macro pmp_sub(r,i,aa,t)      ((pmt(r,i,t)*(1 + mintx(r,i,aa,t)))$ifSUB + (pmp(r,i,aa,t))$(not ifSUB))
$macro xwmg_sub(r,i,rp,t)     ((tmarg(r,i,rp,t)*xw(r,i,rp,t))$ifSUB + (xwmg(r,i,rp,t))$(not ifSUB))
$macro xmgm_sub(m,r,i,rp,t)   ((amgm(m,r,i,rp)*xwmg_SUB(r,i,rp,t)/lambdamg(m,r,i,rp,t))$ifSUB + (xmgm(m,r,i,rp,t))$(not ifSUB))
$macro pwmg_sub(r,i,rp,t)     ((sum(m, amgm(m,r,i,rp)*ptmg(m,t)/lambdamg(m,r,i,rp,t)))$ifSUB + (pwmg(r,i,rp,t))$(not ifSUB))
$macro pefob_sub(r,i,rp,t)    (((1 + exptx(r,i,rp,t) + etax(r,i,t))*pe(r,i,rp,t))$ifSUB + (pefob(r,i,rp,t))$(not ifSUB))
$macro pmcif_sub(r,i,rp,t)    ((pefob_sub(r,i,rp,t) + pwmg_SUB(r,i,rp,t)*tmarg(r,i,rp,t))$ifSUB + (pmcif(r,i,rp,t))$(not ifSUB))
$macro pm_sub(r,i,rp,t)       (((1 + imptx(r,i,rp,t) + mtax(rp,i,t) + ntmAVE(r,i,rp,t))*pmcif_SUB(r,i,rp,t)/chipm(r,i,rp))$ifSUB + (pm(r,i,rp,t))$(not ifSUB))
$macro pfa_sub(r,fp,a,t)      ((pf(r,fp,a,t)*(1 + fctts(r,fp,a,t) + fcttx(r,fp,a,t)))$ifSUB + (pfa(r,fp,a,t))$(not ifSUB))
$macro pfy_sub(r,fp,a,t)      ((pf(r,fp,a,t)*(1 - kappaf(r,fp,a,t)))$(ifSUB) + (pfy(r,fp,a,t))$(not ifSUB))


$macro delTar(delt, s, comm, d, t)     imptx.fx(s,comm,d,t) = 0.01*delt + imptx.l(s,comm,d,t) ;

sets
   gy Government tax stream revenues /
      pt       "Tax revenues from output taxes"
      fc       "Indirect tax revenues from firm consumption"
      pc       "Indirect tax revenues from private consumption"
      gc       "Indirect tax revenues from government consumption"
      ic       "Indirect tax revenues from investment consumption"
      dt       "Direct tax on factor income"
      mt       "Import tax revenues"
      et       "Export tax revenues"
      ft       "Tax revenues from factor taxes"
      fs       "Revenue costs of subsidies"
   /
;


Variables
   axp(r,a,t)           "Production frontier shifter"
   lambdand(r,a,t)      "Shifter for ND bundle"
   lambdava(r,a,t)      "Shifter for VA bundle"
   nd(r,a,t)            "Demand for aggregate intermediate (ND)"
   va(r,a,t)            "Demand for aggregate value added  (VA)"
   px(r,a,t)            "Unit cost of production"

   lambdaio(r,i,a,t)    "Shifter for intermediate demand"
   pnd(r,a,t)           "Price of ND bundle"

   lambdaf(r,fp,a,t)    "Factor specific technical change"
   xf(r,fp,a,t)         "Factor demand"
   pva(r,a,t)           "Price of value added"

   ytax(r,gy,t)         "Government tax stream revenues"
   ytaxTot(r,t)         "Total government revenues"
   ytaxInd(r,t)         "Total revenues from indirect taxes"
   factY(r,t)           "Factor income net of depreciation"
   ntmY(r,t)            "Revenues from NTMs"
   regY(r,t)            "Regional income"

*  Allocation of national income

   phiP(r,t)            "Elasticity of private exp. wrt to private utility"
   phi(r,t)             "Elasticity of total exp. wrt to total utility"
   yc(r,t)              "Nominal private expenditure on goods and services"
   yg(r,t)              "Nominal government expenditures"
   rsav(r,t)            "Regional savings"
   uh(r,h,t)            "Private utility per capita"
   ug(r,t)              "Utility per capita from public expenditure"
   us(r,t)              "Utility per capita from savings"
   u(r,t)               "Total per capita utility"

*  Private consumption

   zcons(r,i,h,t)       "Auxiliary consumption variable"
   xcshr(r,i,h,t)       "Household budget shares"
   pcons(r,t)           "Consumer expenditure deflator"

   pg(r,t)              "Public expenditure price deflator"
   xg(r,t)              "Aggregate volume of government expenditures"

   pi(r,t)              "Investment expenditure price deflator"
   yi(r,t)              "Nominal Investment expenditures"
   xi(r,t)              "Aggregate volume of Investment expenditures"

   xa(r,i,aa,t)         "Demand for Armington good"
   xd(r,i,aa,t)         "Demand for domestic goods"
   xm(r,i,aa,t)         "Demand for imported goods"
   pdp(r,i,aa,t)        "Purchasers price of domestic goods"
   pmp(r,i,aa,t)        "Purchasers price of imported goods"
   pa(r,i,aa,t)         "Agents price of Armington good"

   xmt(r,i,t)           "Aggregate import demand"
   xw(r,i,rp,t)         "Bilateral demand for imports"
   pmt(r,i,t)           "Price of aggregate imports"

   xds(r,i,t)           "Supply of domestically produced goods"
   xet(r,i,t)           "Aggregate export supply"
   xp(r,a,t)            "Domestic output"
   xs(r,i,t)            "Domestic supply"
   ps(r,i,t)            "Price of domestic supply"
   x(r,a,i,t)           "Supply of commodity 'i' by activity 'a'"
   p(r,a,i,t)           "Pre-tax price of X"
   pp(r,a,i,t)          "Post-tax price of X"
   pe(r,i,rp,t)         "Bilateral export supply"
   pet(r,i,t)           "Price of aggregate exports"

   xwmg(r,i,rp,t)       "Demand for international trade and transport services"
   xmgm(m,r,i,rp,t)     "Demand for TT services by mode"
   pwmg(r,i,rp,t)       "Average price of TT services by node"
   xtmg(m,t)            "Global demand for TT services by mode"
   ptmg(m,t)            "Global price index of TT services by mode"

   pefob(r,i,rp,t)      "Border price of exports"
   pmcif(r,i,rp,t)      "Border price of imports"
   pm(r,i,rp,t)         "Bilateral price of imports, tariff-inclusive"

   pd(r,i,t)            "Supply of domestically produced goods"

   xft(r,fp,t)          "Aggregate supply of mobile factors"
   pf(r,fp,a,t)         "Factor price tax exclusive"
   pft(r,fp,t)          "Aggregate price of mobile factors"
   pfa(r,fp,a,t)        "Factor prices tax inclusive"
   pfy(r,fp,a,t)        "After tax factor prices"

*  Allocation of global savings

   arent(r,t)           "Aggregate rate of return to capital after tax"
   kapEnd(r,t)          "End of period capital stock"
   rorc(r,t)            "Net rate of return to capital"
   rore(r,t)            "Expected rate of return to capital"
   rorg(t)              "Global rate of return"
   chiSave(t)           "Global adjustment factor for price of savings"
   psave(r,t)           "Regional price of savings"
   xigbl(t)             "Global net investment"
   pigbl(t)             "Global price of investment"
   chiInv(r,t)          "Regional share of global net investment"
   chif(r,t)            "Share of nominal foreign savings in regional income"
   savf(r,t)            "Real foreign savings"

*  Prices and exchange rates

   pabs(r,t)            "Price of aggregate domestic absorption"
   pmuv(t)              "Price of HIC manufactured exports"
   pfact(r,t)           "Regional factor price index"
   pwfact(t)            "World factor price index"
   pnum(t)              "Model numeraire"

   walras               "Walras check"

*  Closure variables

   dintx(r,i,aa,t)      "Indirect taxes on consumption of domestic goods"
   mintx(r,i,aa,t)      "Indirect taxes on consumption of import goods"
   ytaxshr(r,gy,t)      "Indirect tax revenues as share of regional income"

   gdpmp(r,t)           "Nominal GDP at market price"
   rgdpmp(r,t)          "Real GDP at market price"
   pgdpmp(r,t)          "GDP price deflator"
   rgdppc(r,t)          "Per capita income"
   rgdppcgr(r,t)        "Change in per capita income"

*  Policy variables

   fctts(r,fp,a,t)      "Subsidies on factors of production"
   fcttx(r,fp,a,t)      "Taxes on factors of production"
   prdtx(r,a,i,t)       "Production tax"
   dtxshft(r,i,aa,t)    "Shifter on domestic indirect taxes"
   mtxshft(r,i,aa,t)    "Shifter on imported indirect taxes"
   rtxshft(r,aa,t)      "Uniform shifter on indirect taxes"
   kappaf(r,fp,a,t)     "Income tax on factor f used in activity a"
   exptx(r,i,rp,t)      "Bilateral export taxes"
   etax(r,i,t)          "Export tax shifter across destinations"
   imptx(r,i,rp,t)      "Bilateral import taxes"
   mtax(r,i,t)          "Import tax shifter uniform across sources"
   ntmAVE(r,i,rp,t)     "NTM ad valorem equivalent"
   adtx(r,t)            "Direct tax schedule intercept"
   mdtx(r,t)            "Marginal rate of direct taxation"

   emid(r,i,aa,t)       "CO2 emissions from consumption of domestic goods"
   emim(r,i,aa,t)       "CO2 emissions from consumption of imported goods"

*  Technical variables

   axpsec(a,t)          "World-wide shift in production by sector"
   axpreg(r,t)          "Region-wide shift in production across sectors"
   axpall(r,a,t)        "Region and sector specific shift in production"

   andsec(a,t)          "World-wide technical shift in ND demand by sector"
   andreg(r,t)          "Region-wide technical shift in ND demand across sectors"
   andall(r,a,t)        "Region and sector specific technical shift in ND demand"

   avasec(a,t)          "World-wide technical shift in VA demand by sector"
   avareg(r,t)          "Region-wide technical shift in VA demand across sectors"
   avaall(r,a,t)        "Region and sector specific technical shift in VA demand"

   aiocom(i,t)          "World-wide technical shift in IO demand by input"
   aiosec(a,t)          "World-wide technical shift in IO demand by activity"
   aioreg(r,t)          "Region-wide tech. shift in IO demand across inputs/activities"
   aioall(r,i,a,t)      "Region/input/activity specific technical shift in IO demand"

   afecom(fp,t)         "World-wide technical shift in VA demand by factor"
   afesec(a,t)          "World-wide technical shift in VA demand by activity"
   afefac(r,fp,t)       "Region-wide tech. shift in VA demand across factors"
   afeLab(r,t)          "Region-wide labor augmenting technical shift"
   afereg(r,t)          "Region-wide tech. shift in VA demand across inputs/activities"
   afeall(r,fp,a,t)     "Region/factor/activity specific technical shift in VA demand"

   atm(m,t)             "Global tech change for mode m"
   atf(i,t)             "Global tech change for transporting good i"
   ats(r,t)             "Global tech change for transporting from region r"
   atd(r,t)             "Global tech change for transporting to region r"
   atall(m,r,i,rp,t)    "Global tech change for transporint i from r to rp using mode m"

   lambdai(r,i,t)       "Technology changes in investment expenditure function"

   lambdam(rp,i,r,t)    "Change in second-level Armington preferences"

   lambdamg(m,r,i,rp,t) "Technical change in TT demand"

   tmarg(r,i,rp,t)      "International trade and transport margin"

*  Top level utility parameters

   betap(r,t)           "Private consumption share coefficient"
   betag(r,t)           "Public consumption share coefficient"
   betas(r,t)           "Savings share coefficients"

   aug(r,t)             "Public expenditure utility shifter"
   aus(r,t)             "Savings expenditure utility shifter"
   au(r,t)              "Aggregate utility shifter"

*  Consumer demand

   bh(r,i,t)            "CDE substitution parameters"
   eh(r,i,t)            "CDE expansion parameters"
   ued(r,i,j,t)         "Uncompensated price elasticities"
   ced(r,i,j,t)         "Compensated price elasticities"
   ape(r,i,j,t)         "Allen-Uzawa price elasticities"
   incelas(r,i,t)       "Income elasticities"

*  Other

   kstock(r,t)          "Beginning of period capital stock"
   pop(r,t)             "Population"

   ev(r,h,t)            "Equivalent variation"
   cv(r,h,t)            "Compensating variation"

   gl(r,t)              "Economy-wide labor productivity parameter"
   ggdppc(r,t)          "Growth of real GDP per capita"

;

Parameters
   xscale(r,aa)         "Scale factor for IO columns"
   and(r,a,t)           "ND bundle share parameter"
   ava(r,a,t)           "VA bundle share parameter"
   sigmap(r,a)          "CES elasticity between ND and VA"

   io(r,i,a,t)          "Input output coefficient wrt ND"
   sigmand(r,a)         "CES elasticity across intermediate demand"

   af(r,fp,a,t)         "Factor shares wrt VA"
   sigmav(r,a)          "CES elasticity across factors"

   gx(r,a,i,t)          "CET share parameter for commodity supply"
   omegas(r,a)          "CET elasticity for commodity supply"

   ax(r,a,i,t)          "CES share parameter for commodity demand"
   sigmas(r,i)          "CES elasticity for commodity demand"

   auh(r,h,t)           "Utility shifter for Cobb-Douglas"

   axg(r,t)             "CES aggregate shifter for government expenditures"
   sigmag(r)            "CES elasticity in government expenditures"
   axi(r,t)             "CES aggregate shifter for investment expenditures"
   sigmai(r)            "CES elasticity in investment"

   alphaa(r,i,aa,t)     "Armington demand shift parameter"
   alphad(r,i,aa,t)     "Armington demand domestic shift parameter"
   alpham(r,i,aa,t)     "Armington demand import shift parameter"
   sigmam(r,i,aa)       "Top level Armington elasticity"

   chiNTM(s,d,t)        "Allocation of NTM revenues across regions"

   amw(r,i,rp,t)        "Import share parameters by region of origin"
   sigmaw(r,i)          "Second level Armington elasticity"
   chipm(r,i,rp)        "Import price normalization factor"

   gd(r,i,t)            "Domestic CET share parameter"
   ge(r,i,t)            "Export CET share parameter"
   omegax(r,i)          "Top level CET elasticity"
   gw(r,i,rp,t)         "Export share parameters by region of destination"
   omegaw(r,i)          "Second level CET elasticity"

   amgm(m,r,i,rp)       "Share parameter for demand for TT services by mode"

   aft(r,fp,t)          "Aggregate factor supply shifter"
   etaf(r,fp)           "Aggregate factor supply elasticity"

   gf(r,fp,a,t)         "Sector supply share/shift parameter"
   omegaf(r,fp)         "CET elasticity of factor supply across sectors"
   etaff(r,fp,a)        "Sector specific factor supply elasticity"

   RoRflex(r,t)         "Flexibility of expected net ROR"
   fdepr(r,t)           "Fiscal depreciation rate"
   depr(r,t)            "Physical depreciation rate"
   risk(r,t)            "Regional risk factor"
   krat(r,t)            "Ratio of normalized capital stock & non-normalized capital stock"

   sigmamg(m)           "TT elasticity across suppliers"
   axmg(m,t)            "TT shift parameter"

   savfBar(r,t)         "Exogenous 'real' foreign savings flow"
   ggdppcT(r,t)         "Exogenous rate of growth of per capita GDP"

   invwgt(r,t)          "Regional share of global investment"
   savwgt(r,t)          "Regional share of global savings"

   piadd(r,l,a,t)       "Labor productivity additive sectoral shifter"
   pimlt(r,l,a,t)       "Labor productivity multiplicative sectoral shifter"

   dintx0(r,i,aa)       "Base year indirect tax on domestic consumption"
   mintx0(r,i,aa)       "Base year indirect tax on imported consumption"

   work                 "A working scalar"
   rwork(r)             "A working vector for regions"
   kron(is,js)          "Kronecker delta"
;

Parameters
   ndFlag(r,a)          "ND flags"
   vaFlag(r,a)          "VA flags"
   xpFlag(r,a)          "XP flags"
   xsFlag(r,i)          "XS flags"
   xFlag(r,a,i)         "X flags"

   xaFlag(r,i,aa)       "XA flags"
   xfFlag(r,fp,a)       "XF flags"
   xftFlag(r,fp)        "XFT flags"

   fdFlag(r,fd)         "FD flags"

   xatFlag(r,i)         "XAT flags"
   xdFlag(r,i)          "XD flags"
   xmtFlag(r,i)         "XMT flags"
   xetFlag(r,i)         "XET flags"
   xwFlag(r,i,rp)       "XW flag"
   tmgFlag(r,i,rp)      "TT flag"
   mFlag(m)             "Margin flags"
   RoRFlag              "Type of foreign savings closure"
   intxFlag(r,i,aa)     "Set to 1 for endogenous indirect sales tax, else to 0"
   afeFlag(r,fp)        "Factor or Hicks neutral tech change"
   NTMFlag              "Flag for NTM"
;

NTMFlag = 0 ;

Equations

*  Top production nest

   ndeq(r,a,t)          "Demand for aggregate intermediate (ND)"
   vaeq(r,a,t)          "Demand for aggregate value added  (VA)"
   pxeq(r,a,t)          "Unit cost of production"

*  Intermediate demand nest

   pndeq(r,a,t)         "Price of ND bundle"
   xapeq(r,i,a,t)       "Intermediate demand food goods and services"

*  Value added demand nest

   xfeq(r,fp,a,t)       "Factor demand"
   pvaeq(r,a,t)         "Price of value added"

*  Commodity supply/demand

   xeq(r,a,i,t)         "Supply of commodity 'i' by activity 'a'"
   xpeq(r,a,t)          "Aggregate production by activity 'a'"
   ppeq(r,a,i,t)        "Post tax price of X"
   peq(r,a,i,t)         "Pre-tax price of X"
   pseq(r,i,t)          "Total domestic supply of commodity 'i'"

*  Income distribution

   ytaxeq(r,gy,t)       "Government tax revenues by stream"
   ntmYeq(r,t)          "NTM revenue equation"
   ytaxToteq(r,t)       "Total government tax revenues"
   ytaxIndeq(r,t)       "Total revenues from indirect taxes"
   factYeq(r,t)         "Factor income net of depreciation"
   regYeq(r,t)          "Regional income"

*  Top level regional expenditure decisions

   phiPeq(r,t)          "Elast. of priv. exp. wrt to priv. utility"
   phieq(r,t)           "Elast. of total exp. wrt to total utility"
   yceq(r,t)            "Determination of nominal private consumption"
   ygeq(r,t)            "Determination of government nominal expenditures"
   rsaveq(r,t)          "Determination of national savings"
   uheq(r,h,t)          "Private utility per capita"
   ugeq(r,t)            "Per capita utility from public spending"
   useq(r,t)            "Per capita utility from savings"
   ueq(r,t)             "Total utility"

*  Private demand

   zconseq(r,i,h,t)     "Auxiliary consumption variable"
   xcshreq(r,i,h,t)     "Household budget share"
   xaceq(r,i,h,t)       "Private demand for goods and services"
   pconseq(r,t)         "Household aggregate expenditure deflator"

*  Public demand

   xageq(r,i,gov,t)     "Public expenditure on Armington goods and services"
   pgeq(r,t)            "Public expenditure price deflator"
   xgeq(r,t)            "Real government expenditure"

*  Investment demand

   xaieq(r,i,inv,t)     "Investment expenditure on Armington goods and services"
   pieq(r,t)            "Investment expenditure price deflator"
   xieq(r,t)            "Nominal Investment expenditure"

*  Top level Armington demand

   pdpeq(r,i,aa,t)      "Agents price of domestic goods"
   pmpeq(r,i,aa,t)      "Agents price of import goods"
   paeq(r,i,aa,t)       "Agents composite (or Armington) price"
   xdeq(r,i,aa,t)       "Agents demand for domestic goods"
   xmeq(r,i,aa,t)       "Agents demand for import goods"

*  Second level Armington nest

   xmteq(r,i,t)         "Aggregate import demand"
   xweq(r,i,rp,t)       "Bilateral demand for imports"
   pmteq(r,i,t)         "Price of aggregate imports"

*  Allocation of domestic production

   xdseq(r,i,t)         "Supply of for domestically produced goods"
   xeteq(r,i,t)         "Aggregate export supply"
   xpeq(r,a,t)          "Domestic output"
   xeq(r,a,i,t)         "Domestic output of 'i' by activity 'a'"
   xseq(r,i,t)          "Domestic supply of good 'i'"
   peq(r,a,i,t)         "Price of X"
   peeq(r,i,rp,t)       "Bilateral export supply"
   peteq(r,i,t)         "Price of aggregate exports"

*  TT services

   xwmgeq(r,i,rp,t)     "Demand for international trade and transport services by node"
   xmgmeq(m,r,i,rp,t)   "Demand for TT services by mode and node"
   pwmgeq(r,i,rp,t)     "Price index of TT services by node"
   xtmgeq(m,t)          "Global demand for TT services by mode"
   xatmgeq(r,m,tmg,t)   "Regional supply of TT services by mode"
   ptmgeq(m,t)          "Global price index of TT services by mode"

*  Bilateral price relations

   pefobeq(r,i,rp,t)    "Border price of exports"
   pmcifeq(r,i,rp,t)    "Border price of imports"
   pmeq(r,i,rp,t)       "Bilateral price of imports, tariff-inclusive"

*  Commodity equilibrium

   pdeq(r,i,t)          "Price of domestically produced goods"
*  peeq(r,i,rp,t)       "Equilibrium for bilateral trade (substituted out)"

*  Factor supply and allocation

   xfteq(r,fp,t)        "Aggregate supply of mobile factors"
   pfeq(r,fp,a,t)       "Factor price tax exclusive"
   pfteq(r,fp,t)        "Aggregate price of mobile factors"
   pfaeq(r,fp,a,t)      "Factor prices pre-tax/subsdidies"
   pfyeq(r,fp,a,t)      "Factor prices post-tax/subsdidies"
   kstockeq(r,t)        "Beginning of period capital stock"

*  Investment determination and its allocation

   arenteq(r,t)         "Aggregate rate of return"
   kapEndeq(r,t)        "End of period capital stock"
   rorceq(r,t)          "Net rate of return to capital"
   roreeq(r,t)          "Expected rate of return to capital"
   yieq(r,t)            "Gross investment by region"
   savfeq(r,t)          "Determination of foreign savings"
   rorgeq(t)            "Global rate of return"
   chifeq(r,t)          "Share of nominal foreign savings in regional income"
   capAccteq(t)         "Capital account consistency"
   chiSaveeq(t)         "Global adjustment factor for regional price of savings"
   psaveeq(r,t)         "Price of savings"
   xigbleq(t)           "Global net investment"
   pigbleq(t)           "Price of global net investment"

*  Price indices and numeraire

   pabseq(r,t)          "Aggregate price of domestic absorption"
   pmuveq(t)            "Price index of HIC manufactured exports"
   pfacteq(r,t)         "Regional factor price index"
   pwfacteq(t)          "World factor price index"
   pnumeq(t)            "Definition of numeraire"
   walraseq             "Walras check"

*  Closure equations

   dintxeq(r,i,aa,t)    "Indirect taxes on domestic consumption"
   mintxeq(r,i,aa,t)    "Direct taxes on import consumption"
   ytaxshreq(r,gy,t)    "Indirect tax revenues as share of regional income"

   gdpmpeq(r,t)         "Nominal GDP at market price"
   rgdpmpeq(r,t)        "Real GDP at market price"
   pgdpmpeq(r,t)        "GDP price deflator"

*  Technology equations

   axpeq(r,a,t)         "Production frontier shifter"
   lambdandeq(r,a,t)    "Tech shifter for ND bundle"
   lambdavaeq(r,a,t)    "Tech shifter for VA bundle"
   lambdaioeq(r,i,a,t)  "Tech shifter for IO demand"
   lambdafeq(r,fp,a,t)  "Factor specific technical change"

   glcaleq(r,t)         "Growth of real GDP per capita"
   afealleq(r,fp,a,t)   "Growth of labor productivity"

*  Other

   uedeq(r,i,j,h,t)     "Uncompensated price elasticities"
   incelaseq(r,i,h,t)   "Income elasticities"
   cedeq(r,i,j,h,t)     "Compensated price elasticities"
   apeeq(r,i,j,h,t)     "Allen-Uzawa price elasticities"

   eveq(r,h,t)          "Equivalent variation"
   cveq(r,h,t)          "Compensating variation"
;

*  -------------------------------------------------------------------------------------------------
*
*     Section 1 -- Production
*
*  -------------------------------------------------------------------------------------------------

*  Top level nest -- (E_qint (983), no equivalent)

ndeq(r,a,t)$(rs(r) and ts(t) and ndFlag(r,a))..
   nd(r,a,t) =e= and(r,a,t)*xp(r,a,t)*(px(r,a,t)/pnd(r,a,t))**sigmap(r,a)
              *  (axp(r,a,t)*lambdand(r,a,t))**(sigmap(r,a)-1) ;

*  Demand for aggregate value added -- (E_qva (997), VADEMAND (1262))

vaeq(r,a,t)$(rs(r) and ts(t) and vaFlag(r,a))..
   va(r,a,t) =e= ava(r,a,t)*xp(r,a,t)*(px(r,a,t)/pva(r,a,t))**sigmap(r,a)
              *  (axp(r,a,t)*lambdava(r,a,t))**(sigmap(r,a)-1) ;

*  Unit cost definition (also zero profit condition) -- (E_qo (1027), ZEROPROFITS (1464))

pxeq(r,a,t)$(rs(r) and ts(t) and xpFlag(r,a))..
   px(r,a,t)**(1-sigmap(r,a)) =e= (axp(r,a,t)**(sigmap(r,a)-1))
      *  (and(r,a,t)*(pnd(r,a,t)/lambdand(r,a,t))**(1-sigmap(r,a))
      +   ava(r,a,t)*(pva(r,a,t)/lambdava(r,a,t))**(1-sigmap(r,a))) ;

*  Intermediate demand nest

*  Demand for intermediates -- (E_qfa (1052), ~INTDEMAND (1286))

xapeq(r,i,a,t)$(rs(r) and ts(t) and xaFlag(r,i,a))..
   xa(r,i,a,t) =e= io(r,i,a,t)*nd(r,a,t)*(pnd(r,a,t)/pa(r,i,a,t))**sigmand(r,a)
                *  lambdaio(r,i,a,t)**(sigmand(r,a)-1) ;

*  Price if ND bundle -- (E_pint (1071), no equivalent)

pndeq(r,a,t)$(rs(r) and ts(t) and ndFlag(r,a))..
   pnd(r,a,t)**(1-sigmand(r,a)) =e= sum(i$io(r,i,a,t), io(r,i,a,t)
      *  (pa(r,i,a,t)/lambdaio(r,i,a,t))**(1-sigmand(r,a))) ;

*  Value added decomposition

*  Demand for value added -- (E_qfe (1103), ENDWDEMAND (1423))

xfeq(r,fp,a,t)$(rs(r) and ts(t) and xfFlag(r,fp,a))..
   xf(r,fp,a,t) =e= af(r,fp,a,t)*va(r,a,t)*(pva(r,a,t)/pfa_SUB(r,fp,a,t))**sigmav(r,a)
                *  (lambdaf(r,fp,a,t))**(sigmav(r,a)-1) ;

*  Price of value added bundle -- (E_pva (1110), VAPRICE (1403))

pvaeq(r,a,t)$(rs(r) and ts(t) and vaFlag(r,a))..
   pva(r,a,t)**(1-sigmav(r,a)) =e=
      sum(fp, af(r,fp,a,t)*(pfa_SUB(r,fp,a,t)/lambdaf(r,fp,a,t))**(1-sigmav(r,a))) ;

*  Sourcing of commodities by firm (see below xdeq, xmeq, paeq -- one set of Armington equations)
*  Consolidates E_qfd, E_qfm and E_pfa

*  -------------------------------------------------------------------------------------------------
*
*     Section 2 -- Commodity supply
*
*  -------------------------------------------------------------------------------------------------

*  Convert output into commodities -- (E_qca (1253), no equivalent)
*  N.B. The GAMS version allows for perfect transformation

xeq(r,a,i,t)$(rs(r) and ts(t) and xFlag(r,a,i))..
   0 =e= (x(r,a,i,t) - gx(r,a,i,t)*(xp(r,a,t)/xscale(r,a))
      *  (p(r,a,i,t)/px(r,a,t))**omegas(r,a))$(omegas(r,a) ne inf)
      +  (p(r,a,i,t) - px(r,a,t))$(omegas(r,a) eq inf)
      ;

*  Zero profit for make 'CET' -- (E_po (1259), no equivalent)

xpeq(r,a,t)$(rs(r) and ts(t) and xpFlag(r,a))..
   0 =e= (xp(r,a,t)/xscale(r,a) - sum(i$xFlag(r,a,i), x(r,a,i,t)))
      $  (omegas(r,a) eq inf)
      +  (px(r,a,t)**(1+omegas(r,a))
      -   sum(i$xFlag(r,a,i), gx(r,a,i,t)*p(r,a,i,t)**(1+omegas(r,a))))
      $  (omegas(r,a) ne inf)
      ;

*  Output tax on commodity i produced by activity a -- (E_ps (1264), ~OUTPUTPRICES (1436))

ppeq(r,a,i,t)$(rs(r) and ts(t) and xFlag(r,a,i) and not ifSUB)..
   pp(r,a,i,t) =e= ((1 + prdtx(r,a,i,t))*p(r,a,i,t)) ;

*  N.B. We are not calculating pb in the GAMS version (E_pb (1286))

*  Aggregate commodities (E_pca (1327) -- no equivalent)

peq(r,a,i,t)$(rs(r) and ts(t) and xFlag(r,a,i))..
   0 =e= (x(r,a,i,t) - ax(r,a,i,t)*xs(r,i,t)
      *  (ps(r,i,t)/PP_SUB(r,a,i,t))**sigmas(r,i))$(sigmas(r,i) ne inf)
      +  (PP_SUB(r,a,i,t) - ps(r,i,t))$(sigmas(r,i) eq inf)
      ;

*  Price of domestic supply (E_qc (1333) -- no equivalent)

pseq(r,i,t)$(rs(r) and ts(t) and xsFlag(r,i))..
   0 =e= (xs(r,i,t) - sum(a$xFlag(r,a,i), x(r,a,i,t)))
      $  (sigmas(r,i) eq inf)
      +  (ps(r,i,t)**(1-sigmas(r,i))
      -     sum(a$xFlag(r,a,i), ax(r,a,i,t)*PP_SUB(r,a,i,t)**(1-sigmas(r,i))))
      $  (sigmas(r,i) ne inf)
      ;

*  -------------------------------------------------------------------------------------------------
*
*     Section 3 -- Income distribution
*
*  -------------------------------------------------------------------------------------------------

*  N.B. In the GEMPACK code, the tax revenue equations are listed towards the
*       end of the code, section 9.
*  Income distribution

ytaxeq(r,gy,t)$(rs(r) and ts(t))..

   ytax(r,gy,t) =e=

*  Tax revenues from production tax -- (E_del_taxrout (2582), TOUTRATIO (1446))
      + (sum((a,i)$xFlag(r,a,i), prdtx(r,a,i,t)*p(r,a,i,t)*x(r,a,i,t)))$sameas(gy,"pt")

*  Tax revenues from factor taxes -- (E_del_taxrfu (2589), TFURATIO (1408))
      +  (sum((fp,a)$xfFlag(r,fp,a), fcttx(r,fp,a,t)*pf(r,fp,a,t)*(xf(r,fp,a,t)/xScale(r,a))))
      $sameas(gy,"ft")

*  Revenue costs from factor subsidies -- N/A
      +  (sum((fp,a)$xfFlag(r,fp,a), fctts(r,fp,a,t)*pf(r,fp,a,t)*(xf(r,fp,a,t)/xScale(r,a))))
      $sameas(gy,"fs")

*  Indirect tax revenues from firm consumption -- (E_del_taxriu (2596), TIURATIO (1327))
      + (sum((i,a), dintx(r,i,a,t)*pd(r,i,t)*(xd(r,i,a,t)/xScale(r,a))
      +             mintx(r,i,a,t)*pmt(r,i,t)*(xm(r,i,a,t)/xScale(r,a))))
      $sameas(gy,"fc")

*  Indirect tax revenues from private consumption -- (E_del_taxrpc (2610), TPCRATIO (1133))
      +  (sum((i,h), dintx(r,i,h,t)*pd(r,i,t)*xd(r,i,h,t)
      +              mintx(r,i,h,t)*pmt(r,i,t)*xm(r,i,h,t)))
      $sameas(gy,"pc")

*  Indirect tax revenues from government consumption -- (E_del_taxrgc (2619), TGCRATIO (965))
      +  (sum((i,gov), dintx(r,i,gov,t)*pd(r,i,t)*xd(r,i,gov,t)
      +                mintx(r,i,gov,t)*pmt(r,i,t)*xm(r,i,gov,t)))
      $sameas(gy,"gc")

*  Indirect tax revenues from investment consumption -- (E_del_taxric (2628), TIURATIO (1327))
      +  (sum((i,inv), dintx(r,i,inv,t)*pd(r,i,t)*xd(r,i,inv,t)
      +                mintx(r,i,inv,t)*pmt(r,i,t)*xm(r,i,inv,t)))
      $sameas(gy,"ic")

*  Export tax revenues -- (E_del_taxrexp (2642), TEXPRATIO (1768))
      +  (sum((i,rp), (exptx(r,i,rp,t) + etax(r,i,t))*pe(r,i,rp,t)*xw(r,i,rp,t)))
      $sameas(gy,"et")

*  Import tax revenues -- (E_del_taxrimp (2649), TIMPRATIO (1842))
      +  (sum((i,rp), (imptx(rp,i,r,t) + mtax(r,i,t))*pmcif_SUB(rp,i,r,t)*xw(rp,i,r,t)))
      $sameas(gy,"mt")

*  Direct tax revenues -- (E_del_taxrinc (2667), TINCRATIO (2141))
      +  (sum((fp,a)$xfFlag(r,fp,a), kappaf(r,fp,a,t)*pf(r,fp,a,t)*xf(r,fp,a,t)/xScale(r,a)))
      $sameas(gy,"dt")
      ;

*  NTM AVE revenue

ntmYeq(r,t)$ntmFlag..
   ntmY(r,t) =e= sum((i,rp), ntmAVE(rp,i,r,t)*pmcif_SUB(rp,i,r,t)*xw(rp,i,r,t)) ;

*  Total tax revenue -- (E_del_ttaxr (2684), DTAXRATIO (2201))

ytaxToteq(r,t)$(rs(r) and ts(t))..
   ytaxTot(r,t) =e= sum(gy, ytax(r,gy,t)) ;

*  Total indirect tax revenues -- (E_del_indtaxr (2674), DINDTAXRATIO (2192))

ytaxIndeq(r,t)$(rs(r) and ts(t))..
   yTaxInd(r,t) =e= ytaxTot(r,t) - ytax(r,"dt",t) ;

*  Factor income, net of depreciation -- (E_fincome (1351), FACTORINCOME (2183))

factYeq(r,t)$(rs(r) and ts(t))..
   factY(r,t) =e= sum((fp,a)$xfFlag(r,fp,a), pf(r,fp,a,t)*xf(r,fp,a,t)/xScale(r,a))
               -     fdepr(r,t)*pi(r,t)*kstock(r,t) ;

*  Regional income -- (E_y (1370), REGIONALINCOME (2224))

regYeq(r,t)$(rs(r) and ts(t))..
   regY(r,t) =e= factY(r,t) + yTaxInd(r,t) + ntmY(r,t)*(1 - sum(s$(not sameas(r,s)), chiNTM(r,s,t)))
              +  sum(s$(not sameas(r,s)), chiNTM(s,r,t)*ntmY(s,t)) ;

*  -------------------------------------------------------------------------------------------------
*
*     Section 4 -- Allocation of regional income across expenditure categories
*
*  -------------------------------------------------------------------------------------------------

*  N.B. This section needs to be reviewed


*  Total nominal saving -- (E_qsave (1394), SAVING (2270))

rsaveq(r,t)$(rs(r) and ts(t))..
   rsav(r,t) =e= betaS(r,t)*phi(r,t)*regY(r,t) ;


*  Total government consumption expenditure -- (E_yg (1399), GOVCONSEXP (2265))

ygeq(r,t)$(rs(r) and ts(t))..
   yg(r,t) =e= betaG(r,t)*phi(r,t)*regY(r,t) ;

*  Total private consumption expenditure -- (E_yp (1404), PRIVCONSEXP (2260))

yceq(r,t)$(rs(r) and ts(t))..
   yc(r,t) =e= betaP(r,t)*(phi(r,t)/phiP(r,t))*regY(r,t) ;

*  Elasticity of total expenditure wrt to utility -- UTILITELASTIC (2255)

phieq(r,t)$(rs(r) and ts(t))..
   phi(r,t)*(betaP(r,t)/phiP(r,t) + betaG(r,t) + betaS(r,t)) =e= 1 ;

*  Top level utility function -- (E_u (1496), UTILITY (2347))

ueq(r,t)$(rs(r) and ts(t))..
   log(u(r,t)) =e= log(au(r,t))
                +  betaP(r,t)*sum(h, log(uh(r,h,t)))
                +  betaG(r,t)*log(ug(r,t))
                +  betaS(r,t)*log(us(r,t)) ;

*  Utility from national savings consumption -- XXX (XXX)

useq(r,t)$(rs(r) and ts(t))..
   us(r,t) =e= aus(r,t)*(rsav(r,t)/psave(r,t))/pop(r,t) ;

*  -------------------------------------------------------------------------------------------------
*
*     Section 5 -- Domestic final demand
*
*  -------------------------------------------------------------------------------------------------

*  Factor needed for household consumption function

zconseq(r,i,h,t)$(rs(r) and ts(t) and xaFlag(r,i,h) ne 0)..
   zcons(r,i,h,t) =e= (alphaa(r,i,h,t)*bh(r,i,t)
                   * (pa(r,i,h,t)**bh(r,i,t))
                   * (uh(r,h,t)**(eh(r,i,t)*bh(r,i,t)))
                   * ((yc(r,t)/pop(r,t))**(-bh(r,i,t))))$(%utility% eq CDE)
                   + (alphaa(r,i,h,t))$(%utility% eq CD) ;

*  Budget shares

xcshreq(r,i,h,t)$(rs(r) and ts(t) and xaFlag(r,i,h) ne 0)..
   xcshr(r,i,h,t) =e= zcons(r,i,h,t)/sum(j$xaFlag(r,j,h), zcons(r,j,h,t)) ;

*  Household demands for goods and services -- (E_qpa (1570), PRIVDMNDS (1080))

xaceq(r,i,h,t)$(rs(r) and ts(t) and xaFlag(r,i,h) ne 0)..
  pa(r,i,h,t)*xa(r,i,h,t) =e= xcshr(r,i,h,t)*yc(r,t) ;

*  Elasticity of expenditure wrt utility from private consumption
*     -- (E_uepriv (1587), UTILELASPRIV (1026))

phiPeq(r,t)$(rs(r) and ts(t))..
   phiP(r,t) =e= sum((i,h)$xaFlag(r,i,h), xcshr(r,i,h,t)*eh(r,i,t))$(%utility% eq CDE)
              +  sum((i,h)$xaFlag(r,i,h), xcshr(r,i,h,t))$(%utility% eq CD)
              ;

*  Consumer expenditure deflator (approx.) -- (E_ppriv (1592), PHHLDINDEX (1005))

pconseq(r,t)$(rs(r) and ts(t))..
   pcons(r,t) =e= sum((i,h), xcshr(r,i,h,t)*pa(r,i,h,t)) ;

* Household utility (per capita) -- (E_up (1597), PRIVATEU (1010))

uheq(r,h,t)$(rs(r) and ts(t))..
   0 =e= (1 - sum(i$xaFlag(r,i,h), zcons(r,i,h,t)/bh(r,i,t)))$(%utility% eq CDE)
      +  (uh(r,h,t) - auh(r,h,t)*prod(i$xaFlag(r,i,h), xa(r,i,h,t)**alphaa(r,i,h,t)))
      $(%utility% eq CD) ;

*  Sourcing of commodities by households
*     (see below xdeq, xmeq, paeq -- one set of Armington equations)
*     Consolidates E_qpd, E_qpm and E_ppa

*  Decomposition of public demand

*  CES expenditure function -- (E_qga (1644), GOVDMNDS (913))

xageq(r,i,gov,t)$(rs(r) and ts(t) and xaFlag(r,i,gov) ne 0)..
   xa(r,i,gov,t) =e= alphaa(r,i,gov,t)*xg(r,t)*(pg(r,t)/pa(r,i,gov,t))**sigmag(r) ;

*  Government expenditure price deflator -- (E_pgov (1649), GPRICEINDEX (908))

pgeq(r,t)$(rs(r) and ts(t))..
   0 =e= (axg(r,t)*pg(r,t) - sum(gov,prod(i$xaFlag(r,i,gov),
                  (pa(r,i,gov,t)/alphaa(r,i,gov,t))**alphaa(r,i,gov,t))))$(sigmag(r) eq 1)
      +  ((axg(r,t)*pg(r,t))**(1-sigmag(r)) - sum(gov,sum(i$xaFlag(r,i,gov),
                     alphaa(r,i,gov,t)*pa(r,i,gov,t)**(1-sigmag(r)))))$(sigmag(r) ne 1)
      +  (pg(r,t)*xg(r,t) - (sum(gov, sum(i$xaFlag(r,i,gov), pa(r,i,gov,t)*xa(r,i,gov,t)))))$(0)
      ;

*  Nominal government expenditures

xgeq(r,t)$(rs(r) and ts(t))..
   pg(r,t)*xg(r,t) =e= yg(r,t) ;

*  Utility from government consumption -- (E_ug (1654), GOVU (918))

ugeq(r,t)$(rs(r) and ts(t))..
   ug(r,t) =e= aug(r,t)*xg(r,t)/pop(r,t) ;

*  Sourcing of commodities by government
*     (see below xdeq, xmeq, paeq -- one set of Armington equations)
*     Consolidates E_qgd, E_qgm and E_pga

*  Decomposition of investment demand
*  N.B. Uses CES expenditure function

*  CES expenditure function -- (E_qia (1692), INTDEMAND (1286))

xaieq(r,i,inv,t)$(rs(r) and ts(t) and xaFlag(r,i,inv) ne 0)..
   xa(r,i,inv,t)*lambdai(r,i,t) =e=
      alphaa(r,i,inv,t)*xi(r,t)*(lambdai(r,i,t)*pi(r,t)/pa(r,i,inv,t))**sigmai(r) ;

*  Investment expenditure price deflator -- (E_pinv (1697), ZEROPROFITS (1464))

pieq(r,t)$(rs(r) and ts(t))..
   0 =e= (axi(r,t)*pi(r,t) - sum(inv,prod(i$alphaa(r,i,inv,t),
                  (pa(r,i,inv,t)/(lambdai(r,i,t)*alphaa(r,i,inv,t)))**alphaa(r,i,inv,t))))
      $(sigmai(r) eq 1)
      +  ((axi(r,t)*pi(r,t))**(1-sigmai(r)) - sum(inv,sum(i$alphaa(r,i,inv,t),
                     alphaa(r,i,inv,t)*(pa(r,i,inv,t)/lambdai(r,i,t))**(1-sigmai(r)))))
      $(sigmai(r) ne 1)
      +  (pi(r,t)*xi(r,t) - (sum(inv, sum(i$xaFlag(r,i,inv), pa(r,i,inv,t)*xa(r,i,inv,t)))))
      $(0)
      ;

*  Sourcing of commodities by investment
*     (see below xdeq, xmeq, paeq -- one set of Armington equations)
*     Consolidates E_qid, E_qim and E_pia

*  Volume of investment expenditures

xieq(r,t)$(rs(r) and ts(t))..
   pi(r,t)*xi(r,t) =e= yi(r,t) ;

*  -------------------------------------------------------------------------------------------------
*
*     Section 6 -- Trade, goods market equilibrium and prices
*
*  -------------------------------------------------------------------------------------------------

*
*  Trade section
*
*  1. Armington decomposition across agents
*
*  Firm purchasers' prices

*  Domestic goods --
*           firms -- E_pfd (2141), DMNDDPRICE (1305)
*         private -- E_ppd (2168), PHHDPRICE  (1114)
*          public -- E_pgd (2183), GHHDPRICE  (935)
*      investment -- E_pid (2198), DMNDDPRICE (1305)
*              TT -- N/A

pdpeq(r,i,aa,t)$(rs(r) and ts(t) and alphad(r,i,aa,t) ne 0 and not ifSUB)..
   pdp(r,i,aa,t) =e= pd(r,i,t)*(1 + dintx(r,i,aa,t)) ;

*  Imported goods --
*           firms -- E_pfm (2150), DMNDIPRICES (1317)
*         private -- E_ppm (2173), PHHIPRICES  (1128)
*          public -- E_pgm (2188), GHHIPRICES  (940)
*      investment -- E_pim (2203), DMNDIPRICES (1317)
*              TT -- N/A

pmpeq(r,i,aa,t)$(rs(r) and ts(t) and alpham(r,i,aa,t) ne 0 and not ifSUB)..
   pmp(r,i,aa,t) =e= pmt(r,i,t)*(1 + mintx(r,i,aa,t)) ;

*  Armington price --
*            firms -- E_pfa (1137), ICOMPRICE (1340)
*          private -- E_ppa (1623), PCOMPRICE (1147)
*           public -- E_pga (1675), GCOMPRICE (950)
*       investment -- E_pia (1717), ICOMPRICE (1340)
*               TT -- N/A

paeq(r,i,aa,t)$(rs(r) and ts(t) and xaFlag(r,i,aa) ne 0)..
   pa(r,i,aa,t)**(1-sigmam(r,i,aa)) =e=
          alphad(r,i,aa,t)*pdp_SUB(r,i,aa,t)**(1-sigmam(r,i,aa))
      +   alpham(r,i,aa,t)*pmp_SUB(r,i,aa,t)**(1-sigmam(r,i,aa)) ;

*  Armington decomposition of purchases -- domestic
*            firms -- E_qfd (1120), INDDOM   (1350)
*          private -- E_qpd (1607), PHHLDDOM (1152)
*           public -- E_qgd (1665), GHHLDDOM (960)
*       investment -- E_qid (1702), INDDOM   (1350)
*               TT -- N/A

xdeq(r,i,aa,t)$(rs(r) and ts(t) and alphad(r,i,aa,t) ne 0)..
   xd(r,i,aa,t) =e= alphad(r,i,aa,t)*xa(r,i,aa,t)
                 *  (pa(r,i,aa,t)/pdp_SUB(r,i,aa,t))**sigmam(r,i,aa) ;

*  Armington decomposition of purchases -- imports
*            firms -- E_qfm (1125), INDIMP     (1345)
*          private -- E_qpm (1618), PHHLAGRIMP (1157)
*           public -- E_qgm (1670), GHHLAGRIMP (955)
*       investment -- E_qim (1707), INDIMP     (1345)
*               TT -- N/A

xmeq(r,i,aa,t)$(rs(r) and ts(t) and alpham(r,i,aa,t) ne 0)..
   xm(r,i,aa,t) =e= alpham(r,i,aa,t)*xa(r,i,aa,t)
                 *  (pa(r,i,aa,t)/pmp_SUB(r,i,aa,t))**sigmam(r,i,aa) ;

*  Allocation of aggregate import by region of origin --

*  Calculate total import demand -- (E_qms (1759), MKTCLIMP (2465))

xmteq(r,i,t)$(rs(r) and ts(t) and xmtFlag(r,i))..
   xmt(r,i,t) =e= sum(aa$alpham(r,i,aa,t), xm(r,i,aa,t)/xScale(r,aa)) ;

*  Calculate bilateral import demand -- (E_qxs (1777), IMPORTDEMAND (1835))

xweq(rp,i,r,t)$(rs(r) and ts(t) and xwFlag(rp,i,r))..
   xw(rp,i,r,t) =e= amw(rp,i,r,t)*xmt(r,i,t)*((pmt(r,i,t)/(pm_SUB(rp,i,r,t)))**sigmaw(r,i))
                 *  lambdam(rp,i,r,t)**(sigmaw(r,i) - 1) ;

*  Calculate aggregate import price -- (E_pms (1793), DPRICEIMP (1806))

pmteq(r,i,t)$(rs(r) and ts(t) and xmtFlag(r,i))..
   pmt(r,i,t)**(1-sigmaw(r,i)) =e=
      sum(rp$xwFlag(rp,i,r), amw(rp,i,r,t)*(pm_SUB(rp,i,r,t)/lambdam(rp,i,r,t))**(1-sigmaw(r,i))) ;

*  Allocation of domestic supply (no equivalent as there is no CET)

*  Top nest

xdseq(r,i,t)$(rs(r) and ts(t) and xdFlag(r,i))..
   0 =e= (xds(r,i,t) - gd(r,i,t)*xs(r,i,t)*(pd(r,i,t)/ps(r,i,t))**omegax(r,i))
      $(omegax(r,i) ne inf)
      +  (pd(r,i,t) - ps(r,i,t))
      $(omegax(r,i) eq inf) ;

xeteq(r,i,t)$(rs(r) and ts(t) and xetFlag(r,i))..
   0 =e= (xet(r,i,t) - ge(r,i,t)*xs(r,i,t)*(pet(r,i,t)/ps(r,i,t))**omegax(r,i))
      $(omegax(r,i) ne inf)
      +  (pet(r,i,t) - ps(r,i,t))
      $(omegax(r,i) eq inf) ;

*  Corresponds to equilibrium condition for domestic output --
*     MKTCLTRD_MARG (2429) and MKTCLTRD_MARG (2437)

xseq(r,i,t)$(rs(r) and ts(t) and xsFlag(r,i))..
   0 =e= (ps(r,i,t)**(1+omegax(r,i)) - (gd(r,i,t)*pd(r,i,t)**(1+omegax(r,i))
      +      ge(r,i,t)*pet(r,i,t)**(1+omegax(r,i))))$(omegax(r,i) ne inf)
      +  (xs(r,i,t) - (xds(r,i,t) + xet(r,i,t)))$(omegax(r,i) eq inf)
      ;

*  This function substitutes out the equilibrium condition for bilateral trade

peeq(r,i,rp,t)$(rs(r) and ts(t) and xwFlag(r,i,rp))..
   0 =e= (xw(r,i,rp,t) - gw(r,i,rp,t)*xet(r,i,t)*(pe(r,i,rp,t)/pet(r,i,t))**omegaw(r,i))
      $(omegaw(r,i) ne inf)
      +  (pe(r,i,rp,t) - pet(r,i,t))
      $(omegaw(r,i) eq inf) ;

peteq(r,i,t)$(rs(r) and ts(t) and xetFlag(r,i))..
   0 =e= (pet(r,i,t)**(1+omegaw(r,i))
      -     sum(rp$xwFlag(r,i,rp), gw(r,i,rp,t)*pe(r,i,rp,t)**(1+omegaw(r,i))))
      $(omegaw(r,i) ne inf)
      +  (xet(r,i,t) - sum(rp$xwFlag(r,i,rp), xw(r,i,rp,t)))$
      (omegaw(r,i) eq inf)
      ;

*  Trade margins

*  Total demand for TT services from r to rp for good i -- Additional

xwmgeq(r,i,rp,t)$(ts(t) and tmgFlag(r,i,rp) and not ifSUB)..
   xwmg(r,i,rp,t) =e= tmarg(r,i,rp,t)*xw(r,i,rp,t) ;

*  Demand for TT services using m from r to rp for good i -- (E_qtmfsd (1829), QTRANS_MFSD (1951))

xmgmeq(m,r,i,rp,t)$(rs(r) and ts(t) and amgm(m,r,i,rp) ne 0 and not ifSUB)..
   xmgm(m,r,i,rp,t) =e= amgm(m,r,i,rp)*xwmg_SUB(r,i,rp,t)/lambdamg(m,r,i,rp,t) ;

*  The aggregate price of transporting i between r and rp --
*        (E_ptrans (1883), TRANSCOSTINDEX (2029))
*  Note--the price per transport mode is uniform globally

pwmgeq(r,i,rp,t)$(ts(t) and tmgFlag(r,i,rp) and not ifSUB)..
   pwmg(r,i,rp,t) =e= sum(m, amgm(m,r,i,rp)*ptmg(m,t)/lambdamg(m,r,i,rp,t)) ;

*  Global demand for TT services of type m -- (E_qtm (1916), TRANSDEMAND (1978))

xtmgeq(m,t)$(ts(t) and mFlag(m))..
   xtmg(m,t) =e= sum((r,i,rp), xmgm_SUB(m,r,i,rp,t)) ;

*  Allocation across regions -- (E_qst (1930), TRANSVCES (2040))

xatmgeq(r,m,tmg,t)$(rs(r) and ts(t) and xaFlag(r,m,tmg) ne 0)..
   xa(r,m,tmg,t) =e= alphaa(r,m,tmg,t)*xtmg(m,t)*(ptmg(m,t)/pa(r,m,tmg,t))**sigmamg(m) ;

*  The average global price of mode m -- (E_pt (1947), PTRANSPORT (1998))

ptmgeq(m,t)$(ts(t) and mFlag(m))..
   0 =e= (ptmg(m,t)**(1-sigmamg(m))
      - sum(tmg, sum(r, alphaa(r,m,tmg,t)*pa(r,m,tmg,t)**(1-sigmamg(m)))))
      $(sigmamg(m) ne 1)
      +  (axmg(m,t)*ptmg(m,t)
      - sum(tmg, prod(r$alphaa(r,m,tmg,t), (pa(r,m,tmg,t)/alphaa(r,m,tmg,t))**(alphaa(r,m,tmg,t)))))
      $(sigmamg(m) eq 1)
      + (ptmg(m,t)*xtmg(m,t) - (sum((r,tmg), pa(r,m,tmg,t)*xa(r,m,tmg,t))))$(0)
      ;

*  Bilateral FOB export prices -- (E_pfob (2005), EXPRICES (1763))

pefobeq(r,i,rp,t)$(rs(r) and ts(t) and xwFlag(r,i,rp) and not ifSUB)..
   pefob(r,i,rp,t) =e= (1 + exptx(r,i,rp,t) + etax(r,i,t))*pe(r,i,rp,t) ;

*  Border price of bilateral imports -- (E_pcif (2027), FOBCIF (2066))

pmcifeq(r,i,rp,t)$(rs(r) and ts(t) and xwFlag(r,i,rp) and not ifSUB)..
   pmcif(r,i,rp,t) =e= pefob(r,i,rp,t) + pwmg(r,i,rp,t)*tmarg(r,i,rp,t) ;

*  Calculate bilateral import prices tariff inclusive -- (E_pmds (2050), MKTPRICES (1797))

pmeq(r,i,rp,t)$(rs(r) and ts(t) and xwFlag(r,i,rp) and not ifSUB)..
   pm(r,i,rp,t) =e= (1 + imptx(r,i,rp,t) + mtax(rp,i,t) + ntmAVE(r,i,rp,t))*pmcif(r,i,rp,t)/chipm(r,i,rp) ;

*  Goods market equilibrium
*  The bilateral trade equilibrium is directly substituted out.
*  N.B. Without the CET, the two market equilibrium conditions collapse to the
*        GTAP market condition, i.e. XDS(r,i)+sum(rp, XWD(r,i,rp)) = XS(r,i)

*  Domestic goods market equilibrium --
*     (E_qds (2096) & E_pds (2124), MKTCLDOM (2398))

pdeq(r,i,t)$(rs(r) and ts(t) and xdFlag(r,i))..
   xds(r,i,t) =e= sum(aa$alphad(r,i,aa,t), xd(r,i,aa,t)/xScale(r,aa)) ;

$ontext

*  Bilateral trade equilibrium condition is substituted out

peeq(r,i,t)$(rs(r) and ts(t) and xwFlag(r,i,rp))..
   xwd(r,i,rp,t) =e= xws(r,i,rp,t) ;
$offtext

*  -------------------------------------------------------------------------------------------------
*
*     Section 7 -- Factor supply and market equilibrium
*
*  -------------------------------------------------------------------------------------------------

*  Aggregate supply of mobile factors -- N/A

xfteq(r,fm,t)$(rs(r) and ts(t) and xftFlag(r,fm))..
   xft(r,fm,t) =e= aft(r,fm,t)*(pft(r,fm,t)/pabs(r,t))**etaf(r,fm) ;

*  Sectoral supply of factors -- ENDW_SUPPLY (2166)  and MKTCLENDWS (2487)
*                                for sluggish commodities, eq. condition not explicit

pfeq(r,fp,a,t)$(rs(r) and ts(t) and xfFlag(r,fp,a))..

*  CET expression for partially mobile factors -- (E_qes2 (2283))
*  N.B. We substitute out the supply = demand equation for each activity,
*       wrt to GTAP this is represented by equation E_peb

   0 =e= (xf(r,fp,a,t) - (xscale(r,a)*gf(r,fp,a,t)*xft(r,fp,t)
      *  (pfy_sub(r,fp,a,t)/pft(r,fp,t))**omegaf(r,fp)))
*     *  (pf(r,fp,a,t)/pft(r,fp,t))**omegaf(r,fp)))
      $(fm(fp) and omegaf(r,fp) ne inf)

*  Law of one price for perfectly mobile factors -- (E_qes1 (2266))
      +  (pfy_sub(r,fp,a,t) - pft(r,fp,t))
*     +  (pf(r,fp,a,t) - pft(r,fp,t))
      $(fm(fp) and omegaf(r,fp) eq inf)

*  Supply function (and equilibrium condition) for sector-specific factors (E_qes3 (2307))
      +  (xf(r,fp,a,t) - xscale(r,a)*gf(r,fp,a,t)*(pfy_sub(r,fp,a,t)/pabs(r,t))**etaff(r,fp,a))
*     +  (xf(r,fp,a,t) - xscale(r,a)*gf(r,fp,a,t)*(pf(r,fp,a,t)/pabs(r,t))**etaff(r,fp,a))
      $(fnm(fp)) ;

*  Aggregate factor price -- (E_pe2 (2294), ENDW_PRICE (2152)) for sluggish commodities
*                         -- (E_pe1 (2261), MKTCLENDWM (2478)) for perfectly mobile commodities

pfteq(r,fm,t)$(rs(r) and ts(t) and xftFlag(r,fm))..

*  Aggregate factor price for partially mobile CET
   0 =e= (pft(r,fm,t)**(1+omegaf(r,fm))
      -   sum(a, gf(r,fm,a,t)*pfy_sub(r,fm,a,t)**(1+omegaf(r,fm))))$(omegaf(r,fm) ne inf)
*     -   sum(a, gf(r,fm,a,t)*pf(r,fm,a,t)**(1+omegaf(r,fm))))$(omegaf(r,fm) ne inf)

*  Aggregation condition for fully mobile CET --
*     (E_pe1 (2261), MKTCLENDWM (2478)) for perfectly mobile commodities
      +  (xft(r,fm,t) - sum(a, xf(r,fm,a,t)/xScale(r,a)))$(omegaf(r,fm) eq inf)
      ;

*  Agents' price of factors -- (E_pfe (2323), MPFACTPRICE (1364) and SPFACTPRICE (1369))

pfaeq(r,fp,a,t)$(rs(r) and ts(t) and xfFlag(r,fp,a) and not ifSUB)..
   pfa(r,fp,a,t) =e= pf(r,fp,a,t)*(1 + fctts(r,fp,a,t) + fcttx(r,fp,a,t)) ;

pfyeq(r,fp,a,t)$(rs(r) and ts(t) and xfFlag(r,fp,a) and not ifSUB)..
   pfy(r,fp,a,t) =e= pf(r,fp,a,t)*(1 - kappaf(r,fp,a,t)) ;

*  -------------------------------------------------------------------------------------------------
*
*     Section 8 -- Allocation of global saving
*
*  -------------------------------------------------------------------------------------------------

*  Aggregate capital stock -- (E_kb (2402), KAPSVCES (1521)) (To be verified)
*  Non-normalized level of the capital stock

kstockeq(r,t)$(rs(r) and ts(t))..
   krat(r,t)*kstock(r,t) =e= sum(cap, xft(r,cap,t)) ;

*  End of period stock of capital -- (E_ke (2367), KEND (1581))

kapEndeq(r,t)$(rs(r) and ts(t))..
   kapEnd(r,t) =e= (1 - depr(r,t))*kstock(r,t) + xi(r,t) ;

*  Aggregate capital rate of return after tax --
*     (E_rental (2392), KAPRENTAL (1533) (to be verified))

arenteq(r,t)$(rs(r) and ts(t))..
   arent(r,t) =e= sum((a,cap),
                     (1-kappaf(r,cap,a,t))*pf(r,cap,a,t)*xf(r,cap,a,t)/xScale(r,a))
               /  kstock(r,t) ;

*  Net rate of return to capital -- (E_rorc (2397), RORCURRENT (1601))

rorceq(r,t)$(rs(r) and ts(t))..
   rorc(r,t) =e= arent(r,t)/pi(r,t) - fdepr(r,t) ;

*  Expected rate of return -- (E_rore (2430), ROREXPECTED (1620))

roreeq(r,t)$(rs(r) and ts(t))..
   rore(r,t) =e= rorc(r,t)*(kstock(r,t)/kapEnd(r,t))**RoRFlex(r,t) ;

*  Determination of capital flow -- (E_qinv (2459), RORGLOBAL (1669)) (to be verified)
*  Determines savf for all regions in the case of capFlex, for r-1 regions in all other cases

savfeq(r,t)$(rs(r) and ts(t))..
   0 =e= (risk(r,t)*rore(r,t) - rorg(t))
      $(RoRFlag eq capFlex)
      +  (xi(r,t) - depr(r,t)*kstock(r,t) - chiInv(r,t)*xigbl(t))
      $(RoRFlag eq capShrFix and not rres(r))
      +  (savf(r,t) - piGbl(t)*savfBar(r,t))
      $(RoRFlag eq capFix and not rres(r))
      +  (savf(r,t) - chif(r,t)*regY(r,t))
      $(RoRFlag eq capSFix and not rres(r))
*     Add constraint for residual region when RoRFlag ne capFlex
      + (sum(rp,savf(rp,t)))$(rres(r) and not (RoRFlag eq capFlex))
      ;

*  Determination of RoRg -- (E_globalcgds (2488), GLOBALINV (1682)) (to be verified)
*  Determines RoRg as an average for all cases save capFlex

rorgeq(t)$ts(t)..
   0 =e= ((rorg(t) - sum(r, rore(r,t)*pi(r,t)*(xi(r,t) - depr(r,t)*kstock(r,t)))
                   / sum(rp, pi(rp,t)*(xi(rp,t) - depr(rp,t)*kstock(rp,t)))))$(RoRFlag ne capFlex)
*     Add constraint for the case when RoRFlag eq capFlex
      +  (sum(r,savf(r,t)))$(RoRFlag eq capFlex)
      ;

*  Determines nominal foreign savings as a share of regional income for
*  all cases except capSFix when chif is exogenous

chifeq(r,t)$(ts(t) and RoRFlag ne capSFix)..
   savf(r,t) =e= chif(r,t)*regY(r,t) ;

*  Determines Sf residually for all cases except capFlex
*  Determines RoRg for capFlex
*  At the moment redundant

capAccteq(t)$(ts(t))..
   0 =e= (sum(r, savf(r,t))) ;

* Nominal gross investment

yieq(r,t)$(rs(r) and ts(t) and not rres(r))..
   yi(r,t) =e= pi(r,t)*depr(r,t)*kstock(r,t) + rsav(r,t) + savf(r,t) ;

*  Global net investment -- GLOBINV (1682) (to be verified)

xigbleq(t)$ts(t)..
   xigbl(t) =e= sum(r, xi(r,t) - depr(r,t)*kstock(r,t)) ;

*  Price of global investment -- PRICGDS (1701) (to be verified)

pigbleq(t)$ts(t)..
   pigbl(t)*xigbl(t) =e= sum(r, pi(r,t)*(xi(r,t) - depr(r,t)*kstock(r,t))) ;

*  Price of savings -- SAVEPRICE (1721) (to be verified)

*  Calculate adjustment factor to make global savings and investment price line up

chiSaveeq(t)$ts(t)..
   chiSave(t) =e= sum((rp,t0), invwgt(rp,t)*pi(rp,t)/pi(rp,t0))
                 /  sum((rp,t0), savwgt(rp,t)*psave(rp,t)/psave(rp,t0)) ;

*  Price of savings equals investment price multiplied by adjustment factor

psaveeq(r,t)$(rs(r) and ts(t))..
   psave(r,t) =e= sum(t0, psave(r,t0)*chiSave(t)*pi(r,t)/pi(r,t0)) ;

*  Model prices

$macro mqabs(r,tp,tq) (sum((i,fd), pa(r,i,fd,tp)*xa(r,i,fd,tq)))

pabseq(r,t)$(rs(r) and ts(t))..
$iftheni "%simType%" == "compStat"
*  Always use baseyear
   pabs(r,t) =e= sum(t0, pabs(r,t0)
              *   sqrt((mqabs(r,t,t0)/mqabs(r,t0,t0))
              *        (mqabs(r,t,t)/mqabs(r,t0,t)))) ;
$else
   pabs(r,t) =e= pabs(r,t-1)
              *   sqrt((mqabs(r,t,t-1)/mqabs(r,t-1,t-1))
              *        (mqabs(r,t,t)/mqabs(r,t-1,t))) ;
$endif

$macro mqmuv(tp,tq) (sum((s,j,d)$(rmuv(s) and imuv(j)), pefob_SUB(s,j,d,tp)*xw(s,j,d,tq)))

pmuveq(t)$ts(t)..
$iftheni "%simType%" == "compStat"
*  Always use baseyear
   pmuv(t) =e= sum(t0, pmuv(t0)
            *     sqrt((mqmuv(t,t0)/mqmuv(t0,t0))
            *          (mqmuv(t,t)/mqmuv(t0,t)))) ;
$else
   pmuv(t) =e= pmuv(t-1)
            *     sqrt((mqmuv(t,t-1)/mqmuv(t-1,t-1))
            *          (mqmuv(t,t)/mqmuv(t-1,t))) ;
$endif

*  Regional index of factor prices

$macro mqfactr(r,tp,tq) (sum((fp,a), pf(r,fp,a,tp)*xf(r,fp,a,tq)/xscale(r,a)))

pfacteq(r,t)$ts(t)..
$iftheni "%simType%" == "compStat"
   pfact(r,t) =e= sum(t0, pfact(r,t0)
               *   sqrt((mqfactr(r,t,t0)/mqfactr(r,t0,t0))
               *        (mqfactr(r,t,t)/mqfactr(r,t0,t)))) ;
$else
   pfact(r,t) =e= pfact(r,t-1)
               *   sqrt((mqfactr(r,t,t-1)/mqfactr(r,t-1,t-1))
               *        (mqfactr(r,t,t)/mqfactr(r,t-1,t))) ;
$endif

$macro mqfactw(tp,tq) (sum((r,fp,a), pf(r,fp,a,tp)*xf(r,fp,a,tq)/xscale(r,a)))

pwfacteq(t)$ts(t)..
$iftheni "%simType%" == "compStat"
   pwfact(t) =e= sum(t0, pwfact(t0)
              *   sqrt((mqfactw(t,t0)/mqfactw(t0,t0))
              *        (mqfactw(t,t)/mqfactw(t0,t)))) ;
$else
   pwfact(t) =e= pwfact(t-1)
              *   sqrt((mqfactw(t,t-1)/mqfactw(t-1,t-1))
              *        (mqfactw(t,t)/mqfactw(t-1,t))) ;
$endif

pnumeq(t)$ts(t)..
   pnum(t) =e= pwfact(t) ;

walraseq..
   walras =e= sum((r,t)$(rres(r) and ts(t)),
      yi(r,t) - (pi(r,t)*depr(r,t)*kstock(r,t) + rsav(r,t) + savf(r,t))) ;

* ------------------------------------------------------------------------------
*
*     Closure equations
*
* ------------------------------------------------------------------------------

dintxeq(r,i,aa,t)$(rs(r) and ts(t) and intxFlag(r,i,aa))..
   dintx(r,i,aa,t) =e= dintx0(r,i,aa) + dtxshft(r,i,aa,t) + rtxshft(r,aa,t) ;

mintxeq(r,i,aa,t)$(rs(r) and ts(t) and intxFlag(r,i,aa))..
   mintx(r,i,aa,t) =e= mintx0(r,i,aa) + mtxshft(r,i,aa,t) + rtxshft(r,aa,t) ;

ytaxshreq(r,gy,t)$(rs(r) and ts(t))..
   ytaxshr(r,gy,t) =e= ytax(r,gy,t)/regY(r,t) ;

gdpmpeq(r,t)$(rs(r) and ts(t))..
   gdpmp(r,t) =e= (sum((i,fd), pa(r,i,fd,t)*xa(r,i,fd,t))
               +   sum((i,rp), pefob_SUB(r,i,rp,t)*xw(r,i,rp,t) - pmcif_SUB(rp,i,r,t)*xw(rp,i,r,t))) ;

*  Real GDP at market price -- using Fisher indexing

$macro mqgdp(tp,tq)  (sum((i,fd), pa(r,i,fd,tp)*xa(r,i,fd,tq)) + sum((i,rp), pefob_SUB(r,i,rp,tp)*xw(r,i,rp,tq) - pmcif_SUB(rp,i,r,tp)*xw(rp,i,r,tq)))

rgdpmpeq(r,t)$(rs(r) and ts(t))..
$iftheni "%simType%" == "compStat"
   rgdpmp(r,t) =e= sum(t0, rgdpmp(r,t0)
                *    sqrt((gdpmp(r,t)/gdpmp(r,t0))*(mqgdp(t0,t)/mqgdp(t,t0)))) ;
$else
   rgdpmp(r,t) =e= rgdpmp(r,t-1)
                *    sqrt((gdpmp(r,t)/gdpmp(r,t-1))*(mqgdp(t-1,t)/mqgdp(t,t-1))) ;
$endif

pgdpmpeq(r,t)$(rs(r) and ts(t))..
   pgdpmp(r,t) =e= gdpmp(r,t)/rgdpmp(r,t) ;

* ------------------------------------------------------------------------------
*
*     Dynamic equations
*
* ------------------------------------------------------------------------------

*  Top level uniform productivity shifter -- AOWORLD (1240)

axpeq(r,a,t)$(rs(r) and ts(t) and xpFlag(r,a))..
   axp(r,a,t) =e= axp(r,a,t-1)*(1 + axpsec(a,t) + axpreg(r,t) + axpall(r,a,t)) ;

*  ND bundle shifter -- no equivalent (TBV)

lambdandeq(r,a,t)$(rs(r) and ts(t) and ndFlag(r,a))..
   lambdand(r,a,t) =e= lambdand(r,a,t-1)*(1 + andsec(a,t) + andreg(r,t) + andall(r,a,t)) ;

*  VA bundle shifter -- AVAWORLD (1251)

lambdavaeq(r,a,t)$(rs(r) and ts(t) and vaFlag(r,a))..
   lambdava(r,a,t) =e= lambdava(r,a,t-1)*(1 + avasec(a,t) + avareg(r,t) + avaall(r,a,t)) ;

*  Factor demand technical change -- AFEWORLD (1382)

lambdafeq(r,fp,a,t)$(rs(r) and ts(t) and xfFlag(r,fp,a))..
   lambdaf(r,fp,a,t) =e= lambdaf(r,fp,a,t-1)
      * (1 + afecom(fp,t) + afesec(a,t) + afefac(r,fp,t)
      + afereg(r,t)$afeFlag(r,fp) + afeall(r,fp,a,t)) ;

*  Intermediate augmenting technical change -- AFWORLD (1281) with adjustments

lambdaioeq(r,i,a,t)$(rs(r) and ts(t) and xaFlag(r,i,a))..
   lambdaio(r,i,a,t) =e= lambdaio(r,i,a,t-1)
      *(1 + aiocom(i,t) + aiosec(a,t) + aioreg(r,t) + aioall(r,i,a,t)) ;

*  Real GDP growth

glcaleq(r,t)$(rs(r) and ts(t) and years(t) gt FirstYear)..
   rgdpmp(r,t) =e= (1 + ggdppc(r,t))*rgdpmp(r,t-1)*(pop(r,t)/pop(r,t-1)) ;

*  Labor productivity

afealleq(r,l,a,t)$(ifCal eq 1 and rs(r) and ts(t) and years(t) gt FirstYear and xfFlag(r,l,a))..
   afeall(r,l,a,t) =e= piadd(r,l,a,t) + pimlt(r,l,a,t)*gl(r,t) ;

*  Other equations

uedeq(r,i,j,h,t)$(rs(r) and ts(t) and xaFlag(r,i,h) ne 0 and xaFlag(r,j,h) and (%utility% eq CDE))..
   ued(r,i,j,t) =e= xcshr(r,i,h,t)*(-bh(r,i,t)
                 - (eh(r,i,t)*bh(r,i,t) - sum(jp, xcshr(r,jp,h,t)*eh(r,jp,t)*bh(r,jp,t)))
                 /  sum(jp, xcshr(r,jp,h,t)*eh(r,jp,t))) + kron(i,j)*(bh(r,i,t) - 1) ;

incelaseq(r,i,h,t)$(rs(r) and ts(t) and xaFlag(r,i,h) and (%utility% eq CDE))..
   incelas(r,i,t) =e= (eh(r,i,t)*bh(r,i,t) - sum(jp, xcshr(r,jp,h,t)*eh(r,jp,t)*bh(r,jp,t)))
                   /   sum(jp, xcshr(r,jp,h,t)*eh(r,jp,t))
                   -  (bh(r,i,t) - 1) + sum(jp, xcshr(r,jp,h,t)*bh(r,jp,t)) ;

cedeq(r,i,j,h,t)$(rs(r) and ts(t) and xaFlag(r,i,h) ne 0 and xaFlag(r,j,h) and (%utility% eq CDE))..
   ced(r,i,j,t) =e= ued(r,i,j,t) + xcshr(r,j,h,t) * incelas(r,i,t) ;

apeeq(r,i,j,h,t)$(rs(r) and ts(t) and xaFlag(r,i,h) ne 0 and xaFlag(r,j,h) and (%utility% eq CDE))..
   ape(r,i,j,t) =e= 1 - bh(r,j,t) - bh(r,i,t) + sum(jp, xcshr(r,jp,h,t)*bh(r,jp,t))
                 -  kron(i,j)*(1-bh(r,i,t))/xcshr(r,j,h,t) ;

*  Equivalent variation (E(p0,u))

eveq(r,h,t)$(rs(r) and ts(t) and (%utility% eq CDE))..
   sum(i$xaFlag(r,i,h), alphaa(r,i,h,t)*(uh(r,h,t)**(bh(r,i,t)*eh(r,i,t)))
          * (sum(t0, pa(r,i,h,t0))*Pop(r,t)/ev(r,h,t))**bh(r,i,t)) =e= 1 ;

*  Compensating variation (E(p,u0))

cveq(r,h,t)$(rs(r) and ts(t) and (%utility% eq CDE))..
   sum(i$xaFlag(r,i,h), alphaa(r,i,h,t)*(sum(t0, uh(r,h,t0))**(bh(r,i,t)*eh(r,i,t)))
          * (pa(r,i,h,t)*Pop(r,t)/cv(r,h,t))**bh(r,i,t)) =e= 1 ;

model gtap /
   axpeq.axp, lambdandeq.lambdand, lambdavaeq.lambdava,
   ndeq.nd, vaeq.va, pxeq.px,
   lambdaioeq.lambdaio, pndeq.pnd, xapeq.xa,
   xeq.x, xpeq.xp, ppeq.pp, peq.p, pseq.ps,
   lambdafeq.lambdaf, xfeq.xf, pvaeq.pva,
   ntmYeq.ntmY, yTaxeq.ytax, yTaxToteq.ytaxtot, yTaxIndeq.ytaxind,
   factYeq.factY, regYeq.regY,
   phiPeq.phiP, phieq.phi, yceq.yc, ygeq.yg, rsaveq.rsav, uheq.uh, ugeq.ug, useq.us, ueq.u,
   zconseq.zcons, xcshreq.xcshr, xaceq.xa, pconseq.pcons,
   xageq.xa, pgeq.pg, xgeq.xg, xaieq.xa, pieq.pi, yieq.yi,
   pdpeq.pdp, pmpeq.pmp,  paeq.pa, xdeq.xd, xmeq.xm,
   xmteq.xmt, xweq.xw, pmteq.pmt, pmeq.pm,
*  xdseq.xds, xeteq.xet, xseq.xs, peeq.pe, peteq.pet, pefobeq.pefob,
   xdseq.xds, xeteq.xet, xseq, peeq.pe, peteq.pet, pefobeq.pefob,
   xwmgeq.xwmg, xmgmeq.xmgm, pwmgeq.pwmg, xtmgeq.xtmg, ptmgeq.ptmg, xatmgeq.xa, pmcifeq.pmcif,
   pdeq.pd,
*  xfteq.xft, pfeq.pf, pfteq.pft, pfaeq.pfa, pfyeq.pfy, kstockeq.kstock,
   xfteq.xft, pfeq.pf, pfteq, pfaeq.pfa, pfyeq.pfy, kstockeq.kstock,
   arenteq.arent, kapEndeq.kapEnd, rorceq.rorc, roreeq.rore, xieq.xi,
   savfeq, rorgeq.rorg, chifeq.chif,
   chiSaveeq.chiSave, psaveeq.psave, xigbleq.xigbl, pigbleq.pigbl,
   dintxeq.dintx, mintxeq.mintx, ytaxshreq.ytaxshr,
   gdpmpeq.gdpmp, rgdpmpeq.rgdpmp, pgdpmpeq.pgdpmp,
   pabseq.pabs, pmuveq.pmuv, pfacteq.pfact, pwfacteq.pwfact, pnumeq,
   eveq, cveq,
   walraseq
/ ;

gtap.holdfixed     = 1 ;
gtap.scaleopt      = 1 ;
gtap.tolinfrep     = 1e-5 ;

*  Define dynamic models

model dynCal /
   gtap + glcaleq + afealleq.afeall
/ ;
dyncal.holdfixed = 1 ;
dyncal.scaleopt  = 1 ;
dyncal.tolinfrep = 1e-5 ;

model dynGTAP /
   gtap + glcaleq.ggdppc
/ ;
dynGTAP.holdfixed = 1 ;
dynGTAP.scaleopt  = 1 ;
dynGTAP.tolinfrep = 1e-5 ;

*  Define sub model used to calibrate the top level utility function

model betaCal / phieq.phi, yceq.betap, ygeq.betag, rsaveq.betas / ;
betaCal.holdfixed = 1 ;

* ------------------------------------------------------------------------------
*
*  Declare post-simulation parameters
*
* ------------------------------------------------------------------------------

set nipa "National income and product accounts" /
   set.fd
   exp
   texp
   imp
/ ;

set fdn(nipa) ;
loop((fd,nipa)$sameas(fd,nipa),
   fdn(nipa) = yes ;
) ;
loop((tmg,nipa)$sameas(tmg,nipa),
   fdn(nipa) = no ;
) ;

display fdn ;

Parameters
   sam(r,is,js,t)
   macroVal(r,nipa,t)
   macroVol(r,nipa,t)
   macroPrc(r,nipa,t)
;

