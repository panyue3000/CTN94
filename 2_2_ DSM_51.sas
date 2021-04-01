
/**********************************DIFF BETWEEN DSM4 VS  5***************************************/
/*https://www.niaaa.nih.gov/publications/brochures-and-fact-sheets/alcohol-use-disorder-comparison-between-dsm*/

/*Changes Disorder Terminology*/
/*DSM–IV described two distinct disorders, alcohol abuse and alcohol dependence, with specific criteria for each.*/
/*DSM–5 integrates the two DSM–IV disorders, alcohol abuse and alcohol dependence, into a single disorder called alcohol use disorder (AUD) with mild, moderate, and severe sub-classifications.*/
/*Changes Diagnostic Thresholds*/
/*Under DSM–IV, the diagnostic criteria for abuse and dependence were distinct: anyone meeting one or more of the “abuse” criteria (see items 1 through 4) within a 12-month period would receive the “abuse” diagnosis. Anyone with three or more of the “dependence” criteria (see items 5 through 11) during the same 12-month period would receive a “dependence” diagnosis.*/
/*Under DSM–5, anyone meeting any two of the 11 criteria during the same 12-month period would receive a diagnosis of AUD. The severity of AUD—mild, moderate, or severe—is based on the number of criteria met.*/
/*Removes Criterion*/
/*DSM–5 eliminates legal problems as a criterion.*/
/*Adds Criterion*/
/*DSM–5 adds craving as a criterion for an AUD diagnosis. It was not included in DSM–IV.*/


/*CTN51*/
/*DSOPISCO Opi score*/
/*DSALCSCO Alc score*/
/*DSAMPSCO Amp score*/
/*DSMETSCO Met score*/
/*DSTHCSCO Can score*/
/*DSCOCSCO Coc score*/
/*DSSEDSCO Sed score*/
/**/
/*SCALE*/
/*  1=Severe*/
/*, 2=Moderate*/
/*, 3=Mild*/
/*, 4=None*/


PROC SQL;
   CREATE TABLE DSM_51 AS 
   SELECT "51" AS PROJECT,
		  t1.PATID AS WHO, 
          t1.DSOPISCO, 
          t1.DSALCSCO, 
          t1.DSAMPSCO, 
          t1.DSTHCSCO, 
          t1.DSCOCSCO, 
          t1.DSSEDSCO
      FROM CTN51.DSM t1;
QUIT;

PROC FREQ DATA=DSM_51;
RUN;