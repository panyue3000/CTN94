
%macro URI(URI, URI_O);
IF &URI IN (99) THEN &URI_O=.;
%mend;

/*CTN27:*/

PROC SQL;
   CREATE TABLE URINE27_0 AS 
   SELECT "27" AS PROJECT,
		  t1.PATIENTNUMBER AS WHO, 
          t1.VISIT, 
          t1.UDS003 AS URI_TEMP
      FROM CTN27.T_FRUDSAB t1;
QUIT;

PROC FREQ DATA= URINE27_0;
RUN;

DATA URI27;

SET URINE27_0;

%URI(URI_TEMP, URI_TEMP);
DROP UDS003;

RUN;

PROC FREQ DATA= URI27;
RUN;


/*CTN30:*/

PROC SQL;
   CREATE TABLE URINE30_0 AS 
   SELECT "30" AS PROJECT,
		  t1.PATIENTNUMBER AS WHO, 
          t1.VISIT, 
          t1.UDS003 AS URI_TEMP
      FROM CTN30.T_FRUDS t1;
QUIT;

PROC FREQ DATA= URINE30_0;
RUN;

DATA URI30;

SET URINE30_0;

%URI(URI_TEMP, URI_TEMP);
DROP UDS003;

RUN;

PROC FREQ DATA= URI30;
RUN;



/*CTN51:*/

PROC SQL;
   CREATE TABLE URINE51_0 AS 
   SELECT "51" AS PROJECT,
		  t1.PATID AS WHO, 
          t1.VISNO AS VISIT, 
          INPUT(t1.UDTEMP1, BEST.) AS URI_TEMP,
/*		  Unclear, Invalid or Not Assessed (Test Failure)*/
		  case when UDADULT1 in ('1') then 1 
	           when UDADULT1 in ('0') then 0 end as uri_fail,
/*		  Unclear, Invalid or Not Assessed (Test Failure) include missing*/
		  case when UDADULT1 in ('1' '') then 1 
	           else 0 end as uri_fail2

/*		  UDTEMP2,	*/
/*		  UDADULT1,*/
/*		  UDADULT2*/
      FROM CTN51.UDS T1
;
QUIT;

PROC FREQ DATA= URINE51_0;
RUN;

DATA URI51;

SET URINE51_0;

%URI(URI_TEMP, URI_TEMP);
DROP UDTEMP1;

RUN;

PROC FREQ DATA= URI51;
RUN;


/*COMBINE ALL*/
DATA URI;
SET 

URI27 
URI30 
URI51 
;

IF VISIT IN ('BASELINE' 'BL' '00')
;

RUN;

PROC FREQ DATA= URI;
tables project*(uri_temp uri_fail uri_fail2);
RUN;