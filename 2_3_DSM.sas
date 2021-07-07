
DATA DSM;
SET 

DSM_27 
DSM_30 
DSM_51 

;

RUN;

/*CHECK DUPLICATE*/
PROC SQL;
   CREATE TABLE WORK.DSM_DUP AS 
   SELECT DISTINCT 
	      t1.WHO, 
          t1.PROJECT,
		  COUNT(T1.WHO) AS COUNT
      FROM WORK.DSM t1
	  GROUP BY T1.WHO, PROJECT
	  ORDER BY COUNT DESC
/*      WHERE t1.WHO = '0102-15-1071'*/
;
QUIT;

/*data dictionary */
/*binary yes no*/
/*DSMOPI	Opiates:*/
/*DSMAL	Alcohol:*/
/*DSMAM	Amphetamines:*/
/*DSMCA	Cannabis:*/
/*DSMCO	Cocaine:*/
/*DSMSE	Sedatives:*/
/*DSMBZ	benzodiazapines or alcohol*/
/*DSMOT	other depressants, or stimulants*/
