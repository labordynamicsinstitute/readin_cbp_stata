/* $Id$ */
/* $URL$ */
/* read in CBP */
#delimit;
include "config.do";
set more 1;

capture program drop readin;
program define readin;
local year `1';
local yr=`year'-1900;
if ( `year' > 1999 ) {;
	local yr=`year'-2000;
	if ( `yr' < 10 ) { ;
		local yr 0`yr';
	};
};
if ( `year' >= 2007 ) {;
local noise="with noise";
};
else {;
local noise="";
};

/* di "Reading in CBP year=`year' = `yr'";*/
! unzip -LL -o -d $INPUTS $INPUTS/cbp`yr'us.zip;
insheet using $INPUTS/cbp`yr'us.txt;
! chmod u+rw $INPUTS/cbp`yr'us.txt;
rm $INPUTS/cbp`yr'us.txt;
gen int year=`year';
label var year "Year";
/* force fipsstate and fipscty to be character */
tostring uscode, gen(fipstate);
replace fipstate="0"+fipstate if uscode<10;
gen fipscty="000";

/* bugfixes */
if ( `year' >= 1988  & `year' <= 2006 ) {;
tostring empflag, replace;
};

/* label the variables */
/* http://www.census.gov/econ/cbp/download/noise_layout/US_LFO_Layout.txt*/
label var fipstate "FIPS State Code      ";
label var fipscty "FIPS County Code      ";
label var empflag "Data Suppression Flag      ";
label var emp "Total Mid-March Employees `noise'    ";
label var qp1 "Total First Quarter Payroll ($1,000) `noise'  ";
label var ap "Total Annual Payroll ($1,000) `noise'   ";
label var est "Total Number of Establishments     ";
label var f1_4 "Data Suppression Flag: - 1-4 Employee Size Class ";
label var e1_4 "Mid-March Employees `noise': - 1-4 Employee Size Class";
label var q1_4 "First Quarter Payroll ($1,000) `noise': - 1-4 Employee";
label var a1_4 "Annual Payroll ($1,000) `noise': - 1-4 Employee Size";
label var n1_4 "Number of Establishments: 1-4 Employee Size Class  ";
label var f5_9 "Data Suppression Flag: 5-9 Employee Size Class  ";
label var e5_9 "Mid-March Employees `noise': - 5-9 Employee Size Class";
label var q5_9 "First Quarter Payroll ($1,000) `noise': - 5-9 Employee";
label var a5_9 "Annual Payroll ($1,000) `noise': - 5-9 Employee Size";
label var n5_9 "Number of Establishments: 5-9 Employee Size Class  ";
label var f10_19 "Data Suppression Flag: 10-19 Employee Size Class  ";
label var e10_19 "Mid-March Employees `noise': - 10-19 Employee Size Class";
label var q10_19 "First Quarter Payroll ($1,000) `noise': - 10-19 Employee";
label var a10_19 "Annual Payroll ($1,000) `noise': - 10-19 Employee Size";
label var n10_19 "Number of Establishments: 10-19 Employee Size Class  ";
label var f20_49 "Data Suppression Flag: 20-49 Employee Size Class  ";
label var e20_49 "Mid-March Employees `noise': - 20-49 Employee Size Class";
label var q20_49 "First Quarter Payroll ($1,000) `noise': - 20-49 Employee";
label var a20_49 "Annual Payroll ($1,000) `noise': - 20-49 Employee Size";
label var n20_49 "Number of Establishments: 20-49 Employee Size Class  ";
label var f50_99 "Data Suppression Flag: 50-99 Employee Size Class  ";
label var e50_99 "Mid-March Employees `noise': - 50-99 Employee Size Class";
label var q50_99 "First Quarter Payroll ($1,000) `noise': - 50-99 Employee";
label var a50_99 "Annual Payroll ($1,000) `noise': - 50-99 Employee Size";
label var n50_99 "Number of Establishments: 50-99 Employee Size Class  ";
label var f100_249 "Data Suppression Flag: 100-249 Employee Size Class  ";
label var e100_249 "Mid-March Employees `noise': - 100-249 Employee Size Class";
label var q100_249 "First Quarter Payroll ($1,000) `noise': - 100-249 Employee";
label var a100_249 "Annual Payroll ($1,000) `noise': - 100-249 Employee Size";
label var n100_249 "Number of Establishments: 100-249 Employee Size Class  ";
label var f250_499 "Data Suppression Flag: 250-499 Employee Size Class  ";
label var e250_499 "Mid-March Employees `noise': - 250-499 Employee Size Class";
label var q250_499 "First Quarter Payroll ($1,000) `noise': - 250-499 Employee";
label var a250_499 "Annual Payroll ($1,000) `noise': - 250-499 Employee Size";
label var n250_499 "Number of Establishments: 250-499 Employee Size Class  ";
label var f500_999 "Data Suppression Flag: 500-999 Employee Size Class  ";
label var e500_999 "Mid-March Employees `noise': - 500-999 Employee Size Class";
label var q500_999 "First Quarter Payroll ($1,000) `noise': - 500-999 Employee";
label var a500_999 "Annual Payroll ($1,000) `noise': - 500-999 Employee Size";
label var n500_999 "Number of Establishments: 500-999 Employee Size Class  ";
label var f1000 "Data Suppression Flag: - 1,000 or More Employee Size";
label var e1000 "Mid-March Employees `noise': - 1,000 or More Employee";
label var q1000 "First Quarter Payroll ($1,000) `noise': - 1,000 or";
label var a1000 "Annual Payroll ($1,000) `noise': - 1,000 or More";
label var n1000 "Number of Establishments: 1,000 or More Employee Size Class";


recode_flag;

/* industry switches in 1998 */
if ( `year' >= 1998 ) {;
	gen str4 sic="";
};
else {;
	gen str6 naics="";
};
label var naics "Industry Code - 6-digit NAICS code.   ";
label var sic "Industry Code - 4-digit SIC code.";


if ( `year' >= 2008 ) {;
label var lfo "Legal Form of Organization     ";
};
/* 2007 saw the introduction of noise flag */
if ( `year' >= 2007 ) {;

label var emp_nf "Total Mid-March Employees Noise Flag (numeric) (See all Noise Flag (numeric)";
label var qp1_nf "Total First Quarter Payroll Noise Flag (numeric)   ";
label var ap_nf "Total Annual Payroll Noise Flag (numeric)    ";
label var e1_4nf "Mid-March Employees Noise Flag (numeric): - 1-4 Employee Size Class";
label var q1_4nf "First Quarter Payroll Noise Flag (numeric): - 1-4 Employee Size";
label var a1_4nf "Annual Payroll Noise Flag (numeric): - 1-4 Employee Size Class";
label var e5_9nf "Mid-March Employees Noise Flag (numeric): - 5-9 Employee Size Class";
label var q5_9nf "First Quarter Payroll Noise Flag (numeric): - 5-9 Employee Size";
label var a5_9nf "Annual Payroll Noise Flag (numeric): - 5-9 Employee Size Class";
label var e10_19nf "Mid-March Employees Noise Flag (numeric): - 10-19 Employee Size Class";
label var q10_19nf "First Quarter Payroll Noise Flag (numeric): - 10-19 Employee Size";
label var a10_19nf "Annual Payroll Noise Flag (numeric): - 10-19 Employee Size Class";
label var e20_49nf "Mid-March Employees Noise Flag (numeric): - 20-49 Employee Size Class";
label var q20_49nf "First Quarter Payroll Noise Flag (numeric): - 20-49 Employee Size";
label var a20_49nf "Annual Payroll Noise Flag (numeric): - 20-49 Employee Size Class";
label var e50_99nf "Mid-March Employees Noise Flag (numeric): - 50-99 Employee Size Class";
label var q50_99nf "First Quarter Payroll Noise Flag (numeric): - 50-99 Employee Size";
label var a50_99nf "Annual Payroll Noise Flag (numeric): - 50-99 Employee Size Class";
label var e100_249nf "Mid-March Employees Noise Flag (numeric): - 100-249 Employee Size Class";
label var q100_249nf "First Quarter Payroll Noise Flag (numeric): - 100-249 Employee Size";
label var a100_249nf "Annual Payroll Noise Flag (numeric): - 100-249 Employee Size Class";
label var e250_499nf "Mid-March Employees Noise Flag (numeric): - 250-499 Employee Size Class";
label var q250_499nf "First Quarter Payroll Noise Flag (numeric): - 250-499 Employee Size";
label var a250_499nf "Annual Payroll Noise Flag (numeric): - 250-499 Employee Size Class";
label var e500_999nf "Mid-March Employees Noise Flag (numeric): - 500-999 Employee Size Class";
label var q500_999nf "First Quarter Payroll Noise Flag (numeric): - 500-999 Employee Size";
label var a500_999nf "Annual Payroll Noise Flag (numeric): - 500-999 Employee Size Class";
label var e1000nf "Mid-March Employees Noise Flag (numeric): - 1,000 or More Employee";
label var q1000nf "First Quarter Payroll Noise Flag (numeric): - 1,000 or More";
label var a1000nf "Annual Payroll Noise Flag (numeric): - 1,000 or More Employee";

/* transform characters to numbers for Stata */
foreach v of var emp_nf qp1_nf ap_nf {;
	local l`v' : variable label `v';
	if `"`l`v''"' == "" {;
		local l`v' "`v'";
	};
	recode_nflag `v' `v'_num;
	label var `v'_num "`l`v'' (numeric)";
	/* label value `v'_num nflag;*/
	};

foreach part1 in e q a {;
 foreach part2 in 1_4 5_9 10_19 20_49 50_99 100_249 250_499 500_999 1000 {;
	local v="`part1'`part2'nf";
	local l`v' : variable label `v';
	if `"`l`v''"' == "" {;
		local l`v' "`v'";
	};
	recode_nflag `v' `v'_num;
	label var `v'_num "`l`v'' (numeric)";
	/* label value `v'_num nflag;*/
};
};

}; /* end of >2007 condition */

saveold $outputs/cbp`year', replace;
clear;
end;


forvalues yr = 1986/$maxyear {;
readin `yr';
};

use $outputs/cbp1986, clear;
keep year sic emp est;
forvalues yr = 1987/1997 {;
append  using $outputs/cbp`yr', keep(year sic emp est);
};
forvalues yr = 1998/2007 {;
append  using $outputs/cbp`yr', keep(year naics emp est);
};
forvalues yr = 2008/$maxyear {;
append  using $outputs/cbp`yr', keep(year naics emp est lfo);
};
/* cleanup */
replace lfo="-" if lfo=="";
replace naics="31----" if sic=="20--";
gen str5 naicssec=substr(naics,1,2) if substr(naics,3,4)=="----";
replace naicssec="31-33" if naicssec=="31";
replace naicssec="00" if naics=="------";
label var naicssec "NAICS Industry Sectors";


saveold $outputs/cbp_us_all, replace;
tab year if lfo=="-";
tab naicssec;

