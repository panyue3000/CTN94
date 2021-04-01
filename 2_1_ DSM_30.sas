
/*DSM FROM CTN30*/
/*6. Does the participant meet DSM-IV criteria for*/
/*current opioid dependence?*/


/*QQQQQQQQQQQQQQQQQQQQQQQQ: OPIATES DEPENDENCE = OPIOIDS DEPENDENCE? */

PROC SQL;
   CREATE TABLE DSM_30 AS 
   SELECT "30" AS PROJECT,
		  t1.PATIENTNUMBER AS WHO, 
          t1.INC006 AS DSMOD
      FROM CTN30.T_FRINC t1;
QUIT;

