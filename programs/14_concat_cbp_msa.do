/* $Id$ */
/* $URL$ */
/* read in CBP */
#delimit;
include "config.do";
set more 1;

global common "emp est fipstate fipscty ";
use $outputs/cbp1993msa, clear;
keep year sic $common;
forvalues yr = 1994/1997 {;
append  using $outputs/cbp`yr'msa, keep(year sic $common);
};
forvalues yr = 1998/2007 {;
append  using $outputs/cbp`yr'msa, keep(year naics $common);
};
forvalues yr = 2008/$maxyear {;
append  using $outputs/cbp`yr'msa, keep(year naics $common );
};

/* standardization */
replace naics="31----" if sic=="20--";
gen str5 naicssec=substr(naics,1,2) if substr(naics,3,4)=="----";
replace naicssec="31-33" if naicssec=="31";
replace naicssec="00" if naics=="------";
label var naicssec "NAICS Industry Sectors";

saveold $outputs/cbp_us_msa, replace;
tab naicssec;
tab msa;
