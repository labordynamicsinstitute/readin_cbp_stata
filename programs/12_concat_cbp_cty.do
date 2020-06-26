/* $Id$ */
/* $URL$ */
/* read in CBP */
#delimit;
include "config.do";
set more 1;
display "Starting at $S_DATE $S_TIME";

global common "emp est fipstate fipscty empflag";
use $outputs/cbp1986_co, clear;
keep year sic $common;
forvalues yr = 1987/1997 {;
append  using $outputs/cbp`yr'_co, keep(year sic $common);
};
forvalues yr = 1998/2007 {;
append  using $outputs/cbp`yr'_co, keep(year naics $common);
};
forvalues yr = 2008/$maxyear {;
append  using $outputs/cbp`yr'_co, keep(year naics $common );
};

/* standardization */
replace naics="31----" if sic=="20--";
gen str5 naicssec=substr(naics,1,2) if substr(naics,3,4)=="----";
replace naicssec="31-33" if naicssec=="31";
replace naicssec="00" if naics=="------";
label var naicssec "NAICS Industry Sectors";
gen state = fipstate;
label var state "FIPS State Code (compat)";
gen county = fipscty;
label var county "FIPS County Code (compat)";

saveold $outputs/cbp_us_co, replace;
tab naicssec;
tab fipstate;

display "Ending at $S_DATE $S_TIME";
