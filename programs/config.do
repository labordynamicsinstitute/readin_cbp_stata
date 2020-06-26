/* $Id$ */
/* $URL$ */
global dataset cbp
global outputs ../../clean/$dataset
global interwrk ../../raw/$dataset
global INPUTS ../../raw/$dataset


*global maxyear 2012
local list : dir "$INPUTS" files "cbp*co.zip"
local clean : subinstr local list "cbp" "", all
local years : subinstr local clean "co.zip" "", all
global maxyear 0
foreach y of local years { 
 if  `y' < 50  {
   local y = `y' + 2000
  }
  else {
   local y = `y' + 1900
  }
 if  `y' > $maxyear  {
   global maxyear `y'
  }
}
/* override: layout changed in 2017 */
global maxyear 2016
#delimit;
capture program drop recode_flag;
program define recode_flag ;

	/* labels for flags */
	gen empflag_num = . ;
	replace empflag_num =1 if empflag=="A" ; /* "A: 0-19         " */
	replace empflag_num =2 if empflag=="B" ; /* "B: 20-99         "*/
	replace empflag_num =3 if empflag=="C" ; /* "C: 100-249         "*/
	replace empflag_num =5 if empflag=="E" ; /* "E: 250-499         "*/
	replace empflag_num =6 if empflag=="F" ; /* "F: 500-999         "*/
	replace empflag_num =7 if empflag=="G" ; /* "G: 1,000-2,499         "*/
	replace empflag_num =8 if empflag=="H" ; /* "H: 2,500-4,999         "*/
	replace empflag_num =9 if empflag=="I" ; /* "I: 5,000-9,999         "*/
	replace empflag_num =10 if empflag=="J" ; /* "J: 10,000-24,999         "*/
	replace empflag_num =11 if empflag=="K" ; /* "K: 25,000-49,999         "*/
	replace empflag_num =12 if empflag=="L" ; /* "L: 50,000-99,999         "*/
	replace empflag_num =13 if empflag=="M" ; /* "M: 100,000 or More       "*/
	;
	label var empflag_num "Data Suppression Flag (numeric)";

end;

capture program drop recode_nflag;
program define recode_nflag ;
    di "Converting `1' to `2'";

    gen `2' = .;
	replace `2'= 1 if `1'==    "G"; /*: 0 to < 2% noise (low noise)"*/
	replace `2'= 2 if `1'==    "H"; /*: 2 to < 5% noise (medium noise)"*/
	replace `2'= 3 if `1'==    "D"; /*: Withheld to avoid disclosing data for individual companies; data are included in higher level totals. Employment or payroll field set to zero."*/
	replace `2'= 4 if `1'==    "S";/*: Withheld because estimate did not meet publication standards. Employment or payroll field set to zero."*/

end;
