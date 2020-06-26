/* $Id$ */
/* $URL$ */

%include "config.sas";
%macro convert_files(cwd=);
/* read files in directory */

filename dirlist pipe "cd &cwd; ls -1 *.dta"  ;


data filenames;
	infile dirlist length=reclen;
	length name $ 200;
	input name $varying200. reclen;
	basename=scan(name,1);
run;

proc print data=filenames;
run;

libname here "&cwd.";

data _null_;
	set filenames;
	call execute("proc import out=here."||trim(left(basename)));
	call execute("(compress=yes) dbms=dta ");
	call execute("datafile='&cwd./"||trim(left(basename))||".dta' replace;run;");
run;
%mend;

%convert_files(cwd=&outputs.);
	
