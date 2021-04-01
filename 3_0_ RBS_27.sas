
/*RBS SEXUAL RISK BEHAVIOR VARIABLE CLEAN */
/*TIME FRAME PAST 30 DAYS*/
/*INCLUDING BL AND FOLLOW UP*/


/*# PARTNER VAR CLEAN*/
%macro VAR(A);
IF &A IN (-2 -1 ) THEN &A=.;
%mend;

%macro VAR2(B);
IF &B IN (9 ) THEN &B=.;
%mend;

%macro VAR3(C);
IF &C IN (-2 -1) THEN &C=.;
%mend;

%macro SEX(SEX);
IF &SEX IN (77 99) THEN &SEX=.;
%mend;

 


/*********************************************SUM TABLE FOR # OF PARTNER THEN FOR STRITIFICATION*/
PROC SQL;
   CREATE TABLE RBS27_01 AS 
   SELECT t1.PATIENTNUMBER AS WHO, 
          t1.VISIT, 
          t1.RBS0C1 AS T_P, 
          t1.RBS0C2 AS T_FP, 
          t1.RBS0C3 AS T_MP, 
          t1.RBS0C4 AS T_ISMALE
       FROM CTN27.T_FRRBS0A t1;
QUIT;

PROC FREQ DATA=RBS27_01;
RUN;

/*RECODE MISSING VALUE*/
DATA RBS27_02;
SET RBS27_01;
%VAR(T_P);
%VAR(T_FP);
%VAR(T_MP);

/*%VAR2(T_ISMALE);*/  /*IF 96 THEN NA FOR SEX*/
RUN;

PROC FREQ DATA=RBS27_02;
RUN;



/************************************************************FOR MALE PARTICIPANTS*/

/*Pulldown List 5: FOR xxxB*/
/*RefName Display Text Value Design Note*/
/*ieSexFr1 1 Once or irregularly 1*/
/*ieSexFr2 2 Less than once a week 2*/
/*ieSexFr3 3 About once a week 3*/
/*ieSexFr4 4 2-6 times a week 4*/
/*ieSexFr5 5 About once a day 5*/
/*ieSexFr6 6 2-3 times a day 6*/
/*ieSexFr7 7 4 or more times a day 7*/
/*ieSexFr8 99 Don't know/unsure 99*/
/*ieSexFr9 77 Refused 77*/
/*ieRBS_NA 96 NA 96*/
/**/
/*Pulldown List 6: FOR XXXC*/
/*RefName Display Text Value Design Note*/
/*ieSexCo1 0 Never 0*/
/*ieSexCo2 1 Less than half the time 1*/
/*ieSexCo3 2 About half the time 2*/
/*ieSexCo4 3 More than half the time 3*/
/*ieSexCo5 4 Always 4*/
/*ieSexCo6 99 Don't know/unsure 99*/
/*ieSexCo7 77 Refused 77*/
/*ieRBS_NA 96 NA 96*/

PROC SQL;
   CREATE TABLE RBS27M_01 AS 
   SELECT t1.PATIENTNUMBER AS WHO, 
          t1.VISIT, 
          t1.RBS0E1A AS MVW_NPT, /*MEN HAVE VAGINAL SEX WITH WOMEN NUMBER OF PARTNER*/ 
          t1.RBS0E1B AS MVW_FRQ, /*MEN HAVE VAGINAL SEX WITH WOMEN FREQUENCY*/
          t1.RBS0E1C AS MVW_CDM, /*MEN HAVE VAGINAL SEX WITH WOMEN CONDOM USE How often did you use a condom?*/

          t1.RBS0E2A AS MAW_NPT, 
          t1.RBS0E2B AS MAW_FRQ, 
          t1.RBS0E2C AS MAW_CDM, 

          t1.RBS0F1A AS MIM_NPT, 
          t1.RBS0F1B AS MIM_FRQ, 
          t1.RBS0F1C AS MIM_CDM, 

          t1.RBS0I1A AS MRM_NPT, 
          t1.RBS0I1B AS MRM_FRQ, 
          t1.RBS0I1C AS MRM_CDM
      FROM CTN27.T_FRRBSM t1;
QUIT;

PROC FREQ DATA=RBS27M_01;
TABLES 

MVW_CDM*(MVW_NPT MVW_FRQ )
MVW_NPT
MVW_FRQ
MVW_CDM

MAW_NPT
MAW_FRQ
MAW_CDM

MIM_NPT
MIM_FRQ
MIM_CDM

MRM_NPT
MRM_FRQ
MRM_CDM
;
RUN;

/*RECODE MISSING VALUE*/
DATA RBS27M_02;
SET RBS27M_01;
%VAR3(	MVW_NPT	);
%SEX(	MVW_FRQ	);
%SEX(	MVW_CDM	);
		
%VAR3(	MAW_NPT	);
%SEX(	MAW_FRQ	);
%SEX(	MAW_CDM	);
		
%VAR3(	MIM_NPT	);
%SEX(	MIM_FRQ	);
%SEX(	MIM_CDM	);
		
%VAR3(	MRM_NPT	);
%SEX(	MRM_FRQ	);
%SEX(	MRM_CDM	);
RUN;

PROC FREQ DATA=RBS27M_02;
TABLES 
MVW_CDM*(MVW_NPT MVW_FRQ )
MVW_NPT
MVW_FRQ
MVW_CDM

MAW_NPT
MAW_FRQ
MAW_CDM

MIM_NPT
MIM_FRQ
MIM_CDM

MRM_NPT
MRM_FRQ
MRM_CDM / missing
;
RUN;





/**************************************************FOR FEMALE PARTICIPANTS*/

/*Pulldown List 5: FOR xxxB*/
/*RefName Display Text Value Design Note*/
/*ieSexFr1 1 Once or irregularly 1*/
/*ieSexFr2 2 Less than once a week 2*/
/*ieSexFr3 3 About once a week 3*/
/*ieSexFr4 4 2-6 times a week 4*/
/*ieSexFr5 5 About once a day 5*/
/*ieSexFr6 6 2-3 times a day 6*/
/*ieSexFr7 7 4 or more times a day 7*/
/*ieSexFr8 99 Don't know/unsure 99*/
/*ieSexFr9 77 Refused 77*/
/*ieRBS_NA 96 NA 96*/
/**/
/*Pulldown List 6: FOR XXXC*/
/*RefName Display Text Value Design Note*/
/*ieSexCo1 0 Never 0*/
/*ieSexCo2 1 Less than half the time 1*/
/*ieSexCo3 2 About half the time 2*/
/*ieSexCo4 3 More than half the time 3*/
/*ieSexCo5 4 Always 4*/
/*ieSexCo6 99 Don't know/unsure 99*/
/*ieSexCo7 77 Refused 77*/
/*ieRBS_NA 96 NA 96*/

PROC SQL;
   CREATE TABLE RBS27W_01 AS 
   SELECT t1.PATIENTNUMBER AS WHO, 
          t1.VISIT, 
          t1.RBS0H1A AS WVM_NPT, /*MEN HAVE VAGINAL SEX WITH WOMEN NUMBER OF PARTNER*/ 
          t1.RBS0H1B AS WVM_FRQ, /*MEN HAVE VAGINAL SEX WITH WOMEN FREQUENCY*/
          t1.RBS0H1C AS WVM_CDM, /*MEN HAVE VAGINAL SEX WITH WOMEN CONDOM USE*/

          t1.RBS0I1A AS WAM_NPT, 
          t1.RBS0I1B AS WAM_FRQ, 
          t1.RBS0I1C AS WAM_CDM

      FROM CTN27.T_FRRBSF t1;
QUIT;

PROC FREQ DATA=RBS27W_01;
RUN;

/*RECODE MISSING VALUE*/
DATA RBS27W_02;
SET RBS27W_01;
%VAR3(	WVM_NPT	);
%SEX(	WVM_FRQ	);
%SEX(	WVM_CDM	);
		
%VAR3(	WAM_NPT	);
%SEX(	WAM_FRQ	);
%SEX(	WAM_CDM	);
		
RUN;

PROC FREQ DATA=RBS27W_02;
RUN;



/************************************************************FOR RBSALL (DONT' KNOW GENDER) PARTICIPANTS*/

/*Pulldown List 5: FOR xxxB*/
/*RefName Display Text Value Design Note*/
/*ieSexFr1 1 Once or irregularly 1*/
/*ieSexFr2 2 Less than once a week 2*/
/*ieSexFr3 3 About once a week 3*/
/*ieSexFr4 4 2-6 times a week 4*/
/*ieSexFr5 5 About once a day 5*/
/*ieSexFr6 6 2-3 times a day 6*/
/*ieSexFr7 7 4 or more times a day 7*/
/*ieSexFr8 99 Don't know/unsure 99*/
/*ieSexFr9 77 Refused 77*/
/*ieRBS_NA 96 NA 96*/
/**/
/*Pulldown List 6: FOR XXXC*/
/*RefName Display Text Value Design Note*/
/*ieSexCo1 0 Never 0*/
/*ieSexCo2 1 Less than half the time 1*/
/*ieSexCo3 2 About half the time 2*/
/*ieSexCo4 3 More than half the time 3*/
/*ieSexCo5 4 Always 4*/
/*ieSexCo6 99 Don't know/unsure 99*/
/*ieSexCo7 77 Refused 77*/
/*ieRBS_NA 96 NA 96*/

PROC SQL;
   CREATE TABLE RBS27A_01 AS 
   SELECT t1.PATIENTNUMBER AS WHO, 
          t1.VISIT, 
          t1.RBS0E1A AS AVW_NPT, /*MEN HAVE VAGINAL SEX WITH WOMEN NUMBER OF PARTNER*/ 
          t1.RBS0E1B AS AVW_FRQ, /*MEN HAVE VAGINAL SEX WITH WOMEN FREQUENCY*/
          t1.RBS0E1C AS AVW_CDM, /*MEN HAVE VAGINAL SEX WITH WOMEN CONDOM USE*/

          t1.RBS0E2A AS AAW_NPT, 
          t1.RBS0E2B AS AAW_FRQ, 
          t1.RBS0E2C AS AAW_CDM, 

          t1.RBS0F1A AS AIM_NPT, 
          t1.RBS0F1B AS AIM_FRQ, 
          t1.RBS0F1C AS AIM_CDM, 

		  t1.RBS0H1A AS AVM_NPT, /*MEN HAVE VAGINAL SEX WITH WOMEN NUMBER OF PARTNER*/ 
          t1.RBS0H1B AS AVM_FRQ, /*MEN HAVE VAGINAL SEX WITH WOMEN FREQUENCY*/
          t1.RBS0H1C AS AVM_CDM, /*MEN HAVE VAGINAL SEX WITH WOMEN CONDOM USE*/

          t1.RBS0I1A AS ARM_NPT, 
          t1.RBS0I1B AS ARM_FRQ, 
          t1.RBS0I1C AS ARM_CDM
      FROM CTN27.T_FRRBS2ALL t1;
QUIT;

PROC FREQ DATA=RBS27A_01;
RUN;

/*RECODE MISSING VALUE*/
DATA RBS27A_02;
SET RBS27A_01;
%VAR3(	AVW_NPT	);
%SEX(	AVW_FRQ	);
%SEX(	AVW_CDM	);
		
%VAR3(	AAW_NPT	);
%SEX(	AAW_FRQ	);
%SEX(	AAW_CDM	);
		
%VAR3(	AIM_NPT	);
%SEX(	AIM_FRQ	);
%SEX(	AIM_CDM	);

%VAR3(	AVM_NPT	);
%SEX(	AVM_FRQ	);
%SEX(	AVM_CDM	);
		
%VAR3(	ARM_NPT	);
%SEX(	ARM_FRQ	);
%SEX(	ARM_CDM	);
RUN;

PROC FREQ DATA=RBS27A_02;
RUN;



/*create final version*/
PROC SQL;
   CREATE TABLE RBS27_1 AS 
   SELECT DISTINCT
			SUBSTR(CATS(t1.who, t2.who, t3.who),1,12) as who,
			SUBSTR(CATS(t1.visit, t2.visit, t3.visit),1,2) as visit,
/*	      T2.WHO as who1, */
/*          T2.VISIT as who2, */
          MVW_NPT, 	
          INPUT(T2.MVW_FRQ, BEST.) AS MVW_FRQ, 	
          INPUT(T2.MVW_CDM, BEST.) AS MVW_CDM, 	
          MAW_NPT, 	
          INPUT(T2.MAW_FRQ, BEST.) AS MAW_FRQ, 	
          INPUT(T2.MAW_CDM, BEST.) AS MAW_CDM, 	
          MIM_NPT, 	
          INPUT(T2.MIM_FRQ, BEST.) AS MIM_FRQ, 	
          INPUT(T2.MIM_CDM, BEST.) AS MIM_CDM, 	
          MRM_NPT, 	
          INPUT(T2.MRM_FRQ, BEST.) AS MRM_FRQ, 	
          INPUT(T2.MRM_CDM, BEST.) AS MRM_CDM, 	
/*		  T3.who as who2,*/
/*		  T3.visit as visiT3,*/
		  WVM_NPT, 	
          INPUT(T3.WVM_FRQ, BEST.) AS WVM_FRQ, 	
          INPUT(T3.WVM_CDM, BEST.) AS WVM_CDM, 	
          WAM_NPT, 	
          INPUT(T3.WAM_FRQ, BEST.) AS WAM_FRQ, 	
          INPUT(T3.WAM_CDM,	BEST.) AS WAM_CDM,
		  t1.who as who3,
		  t1.visit as visit3,
		  t1.T_P, /*TOTAL # OR PARTNER*/
          t1.T_FP, 
          t1.T_MP, 
          t1.T_ISMALE
FROM WORK.RBS27_02 t1
           FULL JOIN WORK.RBS27M_02 t2 ON (t1.WHO = t2.WHO) AND (t1.VISIT = t2.VISIT)
           FULL JOIN WORK.RBS27W_02 t3 ON (t1.WHO = t3.WHO) AND (t1.VISIT = t3.VISIT);
QUIT;

PROC FREQ DATA=RBS27_1;
RUN;

/*CREATE SEX HARMANIZED VARIABLE*/

/*TXX_PRT TOTAL NUMBER OF PARTNER: 0=0, 1=1, 2=MORE THAN ONE*/
/*TXX_MPRT TOTAL MALE PARTNER*/
/*TXX_FPRT TOTAL FEMALE PARTNER*/
/**/
/*TXX_FRQ TOTAL # OF SEX*/
/*TXX_PXX TOTAL PROTECTIVE SEX(CONDOM USE)*/
/*TXX_UPX TOTAL UNPROTECTED SEX (TXX_FRQ - TXX_PXX)*/
/**/
/*MSW_NPT MSW # WOMEN PARTNER*/
/*MSW_FRQ MSW TOTAL # OF SEX*/
/*MSW_PXX MSW TOTAL # PROTECTED SEX*/
/*MSW_UPX MSW_FRQ-MSW_PXX*/
/**/
/*MSM_NPT */
/*MSM_FRQ */
/*MSM_PXX */
/*MSM_UPX */
/**/
/*WSX_NPT */
/*WSX_FRQ */
/*WSX_PXX */
/*WSX_UPX */

/*from ray*/
/*	do x = 1 to dim(usedDays);*/
/*		select;*/
/*			when(missing(usedDays[x])) days = .;*/
/*			when(usedDays[x] = "0") days = 0; * Not at all;*/
/*			when(usedDays[x] = "1") days = 5; * A few times;*/
/*			when(usedDays[x] = "2") days = 15; * A few times each week;*/
/*			when(usedDays[x] = "3") days = 30; * Everyday;*/
/*		end;*/
/*		daysIV = max(daysIV, coalesce(days,0));*/


/*Pulldown List 5: FOR xxxB*/
/*RefName Display Text Value Design Note*/
/*ieSexFr1 1 Once or irregularly 1 -- 1*/
/*ieSexFr2 2 Less than once a week -- 2*/
/*ieSexFr3 3 About once a week 3 -- 4*/
/*ieSexFr4 4 2-6 times a week 4 -- 16*/
/*ieSexFr5 5 About once a day 5 -- 28*/
/*ieSexFr6 6 2-3 times a day 6* -- 70/
/*ieSexFr7 7 4 or more times a day 7 -- 112*/
/*ieSexFr8 99 Don't know/unsure 99*/
/*ieSexFr9 77 Refused 77*/
/*ieRBS_NA 96 NA 96 -- 0*/
/**/
/*Pulldown List 6: FOR XXXC*/
/*How often did you use a condom*/
/*RefName Display Text Value Design Note*/
/*ieSexCo1 0 Never 0   -- FRQ*0*/
/*ieSexCo2 1 Less than half the time 1 -- X0.25*/
/*ieSexCo3 2 About half the time 2 -- X0.5*/
/*ieSexCo4 3 More than half the time -- X0.75*/
/*ieSexCo5 4 Always 4 -- X 0.1*/
/*ieSexCo6 99 Don't know/unsure 99*/
/*ieSexCo7 77 Refused 77*/
/*ieRBS_NA 96 NA 96 -- .*/

/*RECODE TO COUNT VAR*/
%macro SEX_B(SEX_B, SEX_FRQ, SEX_C, SEX_PXX);
	 IF &SEX_B = 1 THEN &SEX_FRQ=1;
ELSE IF &SEX_B = 2 THEN &SEX_FRQ=2;
ELSE IF &SEX_B = 3 THEN &SEX_FRQ=4;
ELSE IF &SEX_B = 4 THEN &SEX_FRQ=16;
ELSE IF &SEX_B = 5 THEN &SEX_FRQ=28;
ELSE IF &SEX_B = 6 THEN &SEX_FRQ=70;
ELSE IF &SEX_B = 7 THEN &SEX_FRQ=112;
ELSE IF &SEX_B = 96 THEN &SEX_FRQ=0;

	 IF &SEX_C = 0 THEN &SEX_PXX=round(&sex_frq*0);
ELSE IF &SEX_C = 1 THEN &SEX_PXX=round(&sex_frq*0.25);
ELSE IF &SEX_C = 2 THEN &SEX_PXX=round(&sex_frq*0.5);
ELSE IF &SEX_C = 3 THEN &SEX_PXX=round(&sex_frq*0.75);
ELSE IF &SEX_C = 4 THEN &SEX_PXX=round(&sex_frq*1);
ELSE IF &SEX_C = 96 THEN &SEX_PXX=0;

%mend;




DATA RBS27_2;
SET RBS27_1;

%SEX_B(	MVW_FRQ	, C_MVW_FRQ	,	MVW_CDM	, C_MVW_CDM		);
%SEX_B(	MAW_FRQ	, C_MAW_FRQ	,	MAW_CDM	, C_MAW_CDM		);
%SEX_B(	MIM_FRQ	, C_MIM_FRQ	,	MIM_CDM	, C_MIM_CDM		);
%SEX_B(	MRM_FRQ	, C_MRM_FRQ	,	MRM_CDM	, C_MRM_CDM		);
%SEX_B(	WVM_FRQ	, C_WVM_FRQ	,	WVM_CDM	, C_WVM_CDM		);
%SEX_B(	WAM_FRQ	, C_WAM_FRQ	,	WAM_CDM	, C_WAM_CDM		);
RUN;


PROC SQL;
   CREATE TABLE RBS27_3 AS 
   SELECT 
		  WHO, 
          VISIT,

/*		  # PARTNER*/
		  SUM(MVW_NPT, MAW_NPT, MIM_NPT, MRM_NPT, WVM_NPT, WAM_NPT) AS TXX_PRT_0
		  ,CASE WHEN CALCULATED TXX_PRT_0>1 THEN 2
		  	   ELSE CALCULATED TXX_PRT_0 END AS TXX_PRT

		  ,SUM(MIM_NPT, MRM_NPT, WVM_NPT, WAM_NPT) AS TXX_MPRT_0
		  ,CASE WHEN CALCULATED TXX_MPRT_0>1 THEN 2
		  	   ELSE CALCULATED TXX_MPRT_0 END AS TXX_MPRT
		  ,SUM(MVW_NPT, MAW_NPT) AS TXX_FPRT_0
		  ,CASE WHEN CALCULATED TXX_FPRT_0>1 THEN 2
		  	   ELSE CALCULATED TXX_FPRT_0 END AS TXX_FPRT

/*		  # MSW SEX*/
		  ,SUM(MVW_NPT, MAW_NPT) AS MSW_NPT_0
		  ,CASE WHEN CALCULATED MSW_NPT_0>1 THEN 2
		  	   ELSE CALCULATED MSW_NPT_0 END AS MSW_NPT
		  ,SUM(C_MVW_FRQ, C_MAW_FRQ) AS MSW_FRQ
		  ,SUM(C_MVW_CDM, C_MAW_CDM) AS MSW_PXX
		  ,SUM(CALCULATED MSW_FRQ, -CALCULATED MSW_PXX) AS MSW_UXX

/*		  # MSM SEX*/
		  ,SUM(MIM_NPT, MRM_NPT) AS MSM_NPT_0
		  ,CASE WHEN CALCULATED MSM_NPT_0>1 THEN 2
		  	   ELSE CALCULATED MSM_NPT_0 END AS MSM_NPT
		  ,SUM(C_MIM_FRQ, C_MRM_FRQ) AS MSM_FRQ
		  ,SUM(C_MIM_CDM, C_MRM_CDM) AS MSM_PXX
		  ,SUM(CALCULATED MSM_FRQ, -CALCULATED MSM_PXX) AS MSM_UXX

/*		  # WSX SEX*/
		  ,SUM(WVM_NPT, WAM_NPT) AS WSM_NPT_0
		  ,CASE WHEN CALCULATED WSM_NPT_0>1 THEN 2
		  	   ELSE CALCULATED WSM_NPT_0 END AS WSM_NPT
		  ,SUM(C_WVM_FRQ, C_WAM_FRQ) AS WSM_FRQ
		  ,SUM(C_WVM_CDM, C_WAM_CDM) AS WSM_PXX
		  ,SUM(CALCULATED WSM_FRQ, -CALCULATED WSM_PXX) AS WSM_UXX

/*		  # OVERALL SEX*/
		  ,SUM(CALCULATED MSW_FRQ, CALCULATED MSM_FRQ, CALCULATED WSM_FRQ) AS TXX_FRQ
		  ,SUM(CALCULATED MSW_PXX, CALCULATED MSM_PXX, CALCULATED WSM_PXX) AS TXX_PXX
		  ,SUM(CALCULATED TXX_FRQ, -CALCULATED WSM_PXX) AS TXX_UXX

/*		  # STRATIFIED SEX*/

		,C_MVW_FRQ	AS	MVW_FRQ		
		,C_MAW_FRQ	AS	MAW_FRQ		
		,C_MIM_FRQ	AS	MIM_FRQ		
		,C_MRM_FRQ	AS	MRM_FRQ		
		,C_WVM_FRQ	AS	WVM_FRQ		
		,C_WAM_FRQ	AS	WAM_FRQ		
						
		,C_MVW_CDM	AS	MVW_PXX		
		,C_MAW_CDM	AS	MAW_PXX		
		,C_MIM_CDM	AS	MIM_PXX		
		,C_MRM_CDM	AS	MRM_PXX		
		,C_WVM_CDM	AS	WVM_PXX		
		,C_WAM_CDM	AS	WAM_PXX		
						
		,C_MVW_FRQ	-	C_MVW_CDM	AS	MVW_UXX
		,C_MAW_FRQ	-	C_MAW_CDM	AS	MAW_UXX
		,C_MIM_FRQ	-	C_MIM_CDM	AS	MIM_UXX
		,C_MRM_FRQ	-	C_MRM_CDM	AS	MRM_UXX
		,C_WVM_FRQ	-	C_WVM_CDM	AS	WVM_UXX
		,C_WAM_FRQ	-	C_WAM_CDM	AS	WAM_UXX
		,T_P /*TOTAL # OR PARTNER*/
        ,T_FP 
        ,T_MP 
        ,T_ISMALE



      FROM RBS27_2
;
QUIT;

PROC FREQ DATA=RBS27_3;
RUN;


		
DATA RBS27;
SET RBS27_3;

IF VISIT = 'BASELINE'

;
RUN;

PROC FREQ DATA=RBS27;
RUN;
