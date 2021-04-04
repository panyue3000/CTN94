

/*COMBINE RBS27 30 AND 51*/

DATA RBS;
SET 

RBS27 (DROP=VISIT)
RBS30 (DROP=VISIT)
RBS51 (DROP=VISNO)

;

RUN;

PROC FREQ DATA=RBS;
TABLES PROJECT*(
TXX_PRT
TXX_MPRT
TXX_FPRT
MSW_NPT
MSW_FRQ
MSW_PXX
MSW_UXX
MSM_NPT
MSM_FRQ
MSM_PXX
MSM_UXX
WSM_NPT
WSM_FRQ
WSM_PXX
WSM_UXX
TXX_FRQ
TXX_PXX
TXX_UXX
MVW_FRQ
MAW_FRQ
MIM_FRQ
MRM_FRQ
WVM_FRQ
WAM_FRQ
MVW_PXX
MAW_PXX
MIM_PXX
MRM_PXX
WVM_PXX
WAM_PXX
MVW_UXX
MAW_UXX
MIM_UXX
MRM_UXX
WVM_UXX
WAM_UXX
T_P
T_FP
T_MP)
;
RUN;

/*	data dictionary 

	in the past month			*/
/*TXX_PRT	Total sex partner	0=0	1=1	2=more than one*/
/*TXX_MPRT	Total male sex partner			*/
/*TXX_FPRT	Total female sex partner			*/
/*MSW_NPT	MSW sex partner			*/
/*MSW_FRQ	MSW count of sex			*/
/*MSW_PXX	MSW count of protected (with condomuse) sex			*/
/*MSW_UXX	MSW count of unprotected sex			*/
/*MSM_NPT	MSM ….			*/
/*MSM_FRQ				*/
/*MSM_PXX				*/
/*MSM_UXX				*/
/*WSM_NPT	WSM…			*/
/*WSM_FRQ				*/
/*WSM_PXX				*/
/*WSM_UXX				*/
/*TXX_FRQ	TOTAL…			*/
/*TXX_PXX				*/
/*TXX_UXX				*/
/*MVW_FRQ	Men vaginal sex with women count of sex			*/
/*MAW_FRQ	Men anal sex with women count of sex			*/
/*MIM_FRQ	Men insertive with men count of sex			*/
/*MRM_FRQ	Men receptive with men count of sex 			*/
/*WVM_FRQ	Women vaginal sex with men count of sex			*/
/*WAM_FRQ	women anal sex with men count of sex			*/
/*MVW_PXX	MVW_count of protected sex 			*/
/*MAW_PXX	…			*/
/*MIM_PXX				*/
/*MRM_PXX				*/
/*WVM_PXX				*/
/*WAM_PXX				*/
/*MVW_UXX				*/
/*MAW_UXX				*/
/*MIM_UXX				*/
/*MRM_UXX				*/
/*WVM_UXX				*/
/*WAM_UXX				*/
/*T_P	total count of sex partenr			*/
/*T_FP	total count of female sex partner			*/
/*T_MP	total count of male sex partner			*/
