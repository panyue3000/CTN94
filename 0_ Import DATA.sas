/***********************************************************
This file creates two macro variables that hold paths.
I am assuming you are using Windows SAS.

SAS remembers the last value that a macro variable is assigned. 

So for the libpath macro variable add a line, below all the 
others, that sets libpath to be the directory that contains the
CTN0094 directory.  The path should NOT end in a \.  

Next, set the macroLibrary macro variable to the path to your 
copy of Ray's macros library.  It SHOULD end with a \.
************************************************************/
%global libpath macroLibrary;

%let libpath = C:\Users\dfeaster\Box Sync\CTN; *original;
%let libpath = Z:\box sync; * ray laptop; 
%let libpath = C:\Users\axc2019\Box Sync\CTN0094\InvestigatorsData; * Aneesh laptop; 
%let libpath = Y:\box sync; * ray desktop;
%let libpath = C:\Users\panyue\Box; * Pan;

%let macroLibrary =z:\box sync\macros\; * ray laptop;
%let macroLibrary =Y:\box sync\macros\; * ray desktop;
%let macroLibrary = C:\Users\panyue\Box\macros\; * Pan;







*******************************************************************************
*******************************************************************************
*                                 CTN 27                                      *
*******************************************************************************
******************************************************************************;

* dictionary is /Users/rrb28/Box Sync/CTN0094/InvestigatorsData/CTN-0027/0027-CRFs/CTN0027_AnnotatedCRF.pdf;

libname ctn27 "&libpath.\CTN0094\InvestigatorsData\CTN-0027\0027-Cris_SAS_Analysis_Datasets\sasdata" access = "readonly";
libname ctn27_94 "&libpath.\CTN0094\InvestigatorsData\CTN-0027\0027-Cris_SAS_Analysis_Datasets\sasdata94";


proc cimport LIB=work  FILE="&libpath.\CTN0094\InvestigatorsData\CTN-0027\0027-Cris_SAS_Analysis_Datasets\analysis_data\formats27.xpt";  
run;

/*proc format library = work.formats27 fmtlib;*/
/*run;*/

*proc migrate in = ctn27 out = ctn27_94;* noclone;
*run;

proc format library=work;
	value inf004_ 
	1 = "Buprenorphine/Naloxone"
	2 = "Methadone";
run;


data ran27 (drop = deleted section INF005_UNIT INF006_UNIT ITEMSET ITEMSET_REPEAT_NUMBER ITEMSETINDEX 
				 VISIT VISIT_REPEAT_NUMBER VISITID VISITINDEX FORM_REPEAT_NUMBER FORMINDEX inf002_str disposition
		  ) 
	 notCA notRandomized 
	 everybody (keep = Disposition);
	length who $255;
	set CTN27_94.T_frran (rename = (patientNumber = who));
	label inf004 = "Treatment Group";
	format inf004 inf004_.;
	when = input(INF002_DT, mmddyy10.);
	select;
		when(INF006 ne 1) do; output notCA; Disposition = "Not Complete Accurate "; end; *notCompleteAccurate;
		when(INF004 not in (1,2)) do; output notRandomized; Disposition = "Not Randomized"; end;  
		otherwise do; output ran27; Disposition = "Randomized"; end;
	end;
	output everybody;
run;


*******************************************************************************
*******************************************************************************
*                                 CTN 30                                      *
*******************************************************************************
******************************************************************************;



* dictionary is /Users/rrb28/Box Sync/CTN0094/CTN0030/ctn0030_DataDictionary_INFORM.pdf;

libname ctn30a "&libpath.\CTN0094\InvestigatorsData\CTN-0030\0030-Analysis_Datasets" access = "readonly";
libname ctn30 "&libpath.\CTN0094\InvestigatorsData\CTN-0030\0030-Data_analysis_Cris_SAS_formats\sasdata" access = "readonly";
libname ctn30_94 "&libpath.\CTN0094\InvestigatorsData\CTN-0030\0030-Data_analysis_Cris_SAS_formats\sasdata94" ;

*proc migrate in = ctn30 out = ctn30_94 ;
*run;

*proc cimport LIB=work  FILE="&libpath.\CTN0094\InvestigatorsData\CTN-0030\0030-Data_analysis_Cris_SAS_formats\formats\formats30.xpt";  
*run;

/*proc format library = work.formats30 fmtlib;*/
/*run;*/

data ran30; 
	length who $255;
	set CTN30_94.T_frrnd (rename = (patientNumber = who ));
	label when = "Date of Randomization";
	format when mmddyy10.;
	when = input(RND003_DT, mmddyy10.);
	where RND002 = 1; * was randomized;
run;


*******************************************************************************
*******************************************************************************
*                                 CTN 51                                      *
*******************************************************************************
******************************************************************************;


libname ctn51 "&libpath.\CTN0094\InvestigatorsData\CTN-0051\0051-Datasets" access = "readonly";

*proc cimport LIB=work  FILE="Y:\Box Sync\CTN0094\InvestigatorsData\CTN-0051\0051-Datasets\formats51.xpt";  
*run;

/*proc format library = ctn51.formats51 fmtlib;*/
/*run;*/
/**/
/*options fmtsearch = (work ctn51);*/
/*proc contents data = CTN51.T51;*/
/*run;*/


/*  Work on CTN0051--First work on T51, the weekly detail of the TLFB.  Have noticed that there are people with All 7 days of "TLSUBALx"=0
    which implies no use.  All other fields are missing--this means within this form need to change missing to zeros.  Then need to 
    check the TAP file--I had interpreted this as the master file and had expected that in cases where whole week is no use, the master 
  	file would have said no use.
Following checked that we do not need to use TAP to fill in

proc sort data=ctn51.t51;
by patid tfwkstdt;
proc print data=ctn51.t51;
var patid randdt visno tfwkstdt tldate1-tldate7 tlsubal1-tlsubal7;
run;
proc sort data=ctn51.tap;
by patid tapasmdt;
proc print data=ctn51.tap;
var patid randdt visno tapasmdt tatfstdt tatfendt tasubalc;
run;

*/

proc sql;
	create table ran51 as
		select distinct patid as who, randdt label = "Date of Randomization" as when
			from CTN51.dem
		;
quit;

proc format;
	value $protocol "     " = "     ";
	value $site     "     " = "     ";
	value $X27281X  " "     = " ";
	value $X27998X  "  "    = "  ";
	value $X27800X "  " = "  ";   
	value $X27797X "  " = "  ";   
	value $X42521X "  " = "  ";   		
	value $X28037X "  " = "  ";   
	value $X27287X "  " = "  ";   
	value $X28185X "  " = "  ";   
run;

Data T51 ctn.offs;
Set CTN51.T51;
array y(7) 		TLDATE1 -TLDATE7;
array y1(7) 	TLSUBAL1-TLSUBAL7;
array y2(7) 	TLALCHL1-TLALCHL7;
array y3(7) 	TLTHCR1 -TLTHCR7;
array y4(7) 	TLCOCR1 -TLCOCR7;
array y5(7) 	TLCRAKR1-TLCRAKR7;
array y6(7) 	TLAMPR1 -TLAMPR7;
array y7(7) 	TLBUPR1 -TLBUPR7;
array y8(7) 	TLOPIR1 -TLOPIR7;
array y9(7) 	TLMTDR1 -TLMTDR7;
array y10(7) 	TLHERR1 -TLHERR7;
array y11(7)	TLMDAR1 -TLMDAR7;
array y12(7)	TLBARR1 -TLBARR7;
array y13(7)	TLBZOR1 -TLBZOR7;
array y14(7)	TLINHR1 -TLINHR7;
array y15(7)	TLOT1R1 -TLOT1R7;
array y16(7)	TLOTSP11-TLOTSP17;
array y17(7)	TLOT2R1 -TLOT2R7;
array y18(7)	TLOTSP21 TLOTSP22 TLOTSP23 TLOTSP24 TLOTSP25 TLOTSP26 TLOTSP217;
format date mmddyy8.;
*  Adding zero should make these into numeric variables;
Do time = 1 to 7;
   DayofWk =time;
   Date    =y(time);
   TLSUBAL =input(y1(time), best.);
   TLALCHL =y2(time);
   TLTHCR  =input(y3(time), best.);
   TLCOCR  =input(y4(time), best.);
   TLCRAK  =input(y5(time), best.);
   TLAMPR  =input(y6(time), best.);
   TLBUPR  =input(y7(time), best.);
   TLOPIR  =input(y8(time), best.);
   TLMTDR  =input(y9(time), best.);
   TLHERR  =input(y10(time), best.);
   TLMDAR  =input(y11(time), best.);
   TLBARR  =input(y12(time), best.);
   TLBZOR  =input(y13(time), best.);
   TLINHR  =input(y14(time), best.);
   TLOT1R  =input(y15(time), best.); 
   TLOTSP1 =y16(time);
   TLOT2R  =input(y17(time), best.); 
   TLOTSP2 =y18(time);
   if not missing(date) and missing(TLSUBAL) then output ctn.offs;
   else if Date ne . then output T51;
end;
keep PROT PATID SITE RANDDT TFWKSTDT DayofWk Date TLSUBAL TLALCHL TLTHCR TLCOCR TLCRAK 
     TLAMPR TLBUPR TLOPIR TLMTDR TLHERR TLMDAR TLBARR TLBZOR TLINHR TLOT1R TLOTSP1 
     TLOT2R TLOTSP2 T51COMM
;
run;



