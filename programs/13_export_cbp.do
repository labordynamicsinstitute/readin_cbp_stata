/* $Id$ */
/* $URL$ */
/* read in CBP */
#delimit;
include "config.do";
set more 1;

/* national files */
forvalues yr = 1986/$maxyear {;
  use $outputs/cbp`yr', clear;
  qui capture drop empflag_num;
  outsheet using $outputs/cbp`yr'.csv, comma replace;
};
/* county files */
forvalues yr = 1986/$maxyear {;
  use $outputs/cbp`yr'_co, clear;
  qui capture drop empflag_num;
  outsheet using $outputs/cbp`yr'_co.csv, comma replace;
};

