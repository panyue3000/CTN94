/*FROM MEICHEN */
/**/
/*Here is SAS data we received (CIDI_aj for alcohol, CIDI_L for drug) a week ago for CIDI disorder implemented in the beginning of CTN27 (about N=200).  */
/* */
/*We had data for DSM-disorder implemented the rest of CTN27 before.   */
/* */
/*Here is One SAS job (CIDI_27) and one SAS dataset (CIDI_combined_aj_L).  */
/* */
/*Another one SAS Job (predictor_8_03152021 included disorder, FTND and other variables for All study. */
/**/
/*All saved in the box (harmonization/Meichen/mergedvaraibles/CIDI/)*/


/*CTN27*/
/*DSM-IV Checklist*/
/*2. Opiates: (CTN0027CDD:t_frDSM.DSMOPI)*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/
/*3. Alcohol: (CTN0027CDD:t_frDSM.DSMAL)*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/
/*4. Amphetamines: (CTN0027CDD:t_frDSM.DSMAM)*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/
/*5. Cannabis: (CTN0027CDD:t_frDSM.DSMCA)*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/
/*6. Cocaine: (CTN0027CDD:t_frDSM.DSMCO)*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/
/*7. Sedatives:*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/
PROC SQL;
   CREATE TABLE DSM_2701 AS 
   SELECT 
   		  "27" AS PROJECT,
		  t1.PATIENTNUMBER AS WHO, 
          t1.SITE, 
          t1.DSMOPI, 
          t1.DSMAL, 
          t1.DSMAM, 
          t1.DSMCA, 
          t1.DSMCO, 
          t1.DSMSE
      FROM CTN27.T_FRDSM t1;
QUIT;

PROC FREQ DATA=DSM_2701;
TABLES    DSMOPI 
          DSMAL 
          DSMAM 
          DSMCA 
          DSMCO 
          DSMSE
;
RUN;


/*CHECK EXCLUSION CRITERIA DSM4 FOR BENZODIAZAPINE*/
/*benzodiazapines or alcohol requiring immediate medical attention*/
/*other depressants, or stimulants requiring immediate medical attention*/
PROC SQL;
   CREATE TABLE CTN27_FREXC AS 
   SELECT "27" AS PROJECT,
		  t1.PATIENTNUMBER AS WHO, 
          t1.EXC011 AS DSMBZ, 
          t1.EXC012 AS DSMOT
      FROM CTN27.T_FREXC t1;
QUIT;

PROC FREQ DATA=CTN27_FREXC;
TABLES DSMBZ DSMOT;
RUN;


/*CHECK INCLUSION CRITERIA*/
/*Does the participant meet DSM-IV criteria for opioid dependence?*/
PROC SQL;
   CREATE TABLE CTN27_FRIXC AS 
   SELECT "27" AS PROJECT,
		  t1.PATIENTNUMBER AS WHO, 
          t1.SITE, 
          t1.IXC002 AS DSMOD
      FROM CTN27.T_FRIXC t1;
QUIT;



/*JOIN THREE TOGETHER*/
PROC SQL;
   CREATE TABLE DSM_2702 (DROP=SITE WHO_TEMP WHO_EXC WHO_IXC) AS 
   SELECT "27" AS PROJECT, 
          t1.WHO AS WHO_TEMP, 
          t1.SITE, 
          t1.DSMOPI, 
          t1.DSMAL, 
          t1.DSMAM, 
          t1.DSMCA, 
          t1.DSMCO, 
          t1.DSMSE, 
		  T3.WHO AS WHO_EXC,
          t3.DSMBZ, 
          t3.DSMOT, 
		  T2.WHO AS WHO_IXC,
          t2.DSMOD,
		  SUBSTR(CATS(WHO_TEMP, WHO_EXC, WHO_IXC),1,12) AS WHO
      FROM WORK.DSM_2701 t1
           FULL JOIN WORK.CTN27_FREXC t3 ON (t1.WHO = t3.WHO)
           FULL JOIN WORK.CTN27_FRIXC t2 ON (t1.WHO = t2.WHO)
;
QUIT;

/*RENAME 3 NO DIAGNOSIS TO 0*/

/*CREATE BINARY LIST*/
/*DSM-IV Checklist*/
/*2. Opiates: (CTN0027CDD:t_frDSM.DSMOPI)*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/
/*3. Alcohol: (CTN0027CDD:t_frDSM.DSMAL)*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/
/*4. Amphetamines: (CTN0027CDD:t_frDSM.DSMAM)*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/
/*5. Cannabis: (CTN0027CDD:t_frDSM.DSMCA)*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/
/*6. Cocaine: (CTN0027CDD:t_frDSM.DSMCO)*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/
/*7. Sedatives:*/
/*[1] Dependence [2] Abuse [3] No diagnosis*/

%macro DSM_A(DSM_I, DSM_O);
	 IF &DSM_I = 3 THEN &DSM_O=0;
ELSE IF &DSM_I IN (1 2) THEN &DSM_O=1;
%mend;


DATA DSM_27;
SET DSM_2702;

%DSM_A( DSMOPI, DSMOPI2);
%DSM_A( DSMAL, DSMAL);
%DSM_A( DSMAM, DSMAM);
%DSM_A( DSMCA, DSMCA);
%DSM_A( DSMCO, DSMCO);
%DSM_A( DSMSE, DSMSE);

DSMOPI = MAX(DSMOPI2, DSMOD);

DROP DSMOPI2;

RUN;


PROC FREQ DATA=DSM_27;
RUN;