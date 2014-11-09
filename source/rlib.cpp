//
//  rlib.cpp
//  priorityQ
//
//  Created by Jack Olney on 27/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#include <iostream>
#include <mach/mach_time.h>
#include "rng.h"
#include <Rdefines.h>
#include <stdio.h>
#include <R.h>

#include "macro.h"
#include "eventQ.h"
#include "population.h"

using namespace std;

Rng * theRng;
eventQ * theQ;

/* Output Pointers */
extern double * theCARE;
extern double * theDALY;
extern double * theCOST;
extern double * thePOP_15to49;
extern double * theHIV_15to49;
extern double * theART_15to49;
extern double * theAidsDeath_15plus;
extern double * thePOP_AgeSex_2007;
extern double * theHIV_AgeSex_2007;
extern double * thePOP_AgeSex_2012;
extern double * theHIV_AgeSex_2012;
extern double * theCd4_200; //Setup a Cd4 class which fills in vectors dynamically (as transmission works), as we need to get CD4 at a point in time and it is highly dynamic.
extern double * theCd4_200350;
extern double * theCd4_350500;
extern double * theCd4_500;

/* Intervention Pointers */
int const * p_Hbct;
int const * p_Vct;
int const * p_HbctPocCd4;
int const * p_Linkage;
int const * p_PreOutreach;
int const * p_ImprovedCare;
int const * p_PocCd4;
int const * p_VctPocCd4;
int const * p_ArtOutreach;
int const * p_ImmediateArt;
int const * p_UniversalTestAndTreat;
int const * p_Adherence;


extern "C" {

/////////////////////

SEXP CallCascade(SEXP s_pop, 
				 SEXP s_Hbct, 
				 SEXP s_Vct, 
				 SEXP s_HbctPocCd4, 
				 SEXP s_Linkage,
		 		 SEXP s_PreOutreach, 
		 		 SEXP s_ImprovedCare, 
		 		 SEXP s_PocCd4, 
		 		 SEXP s_VctPocCd4, 
		 		 SEXP s_ArtOutreach,
		 		 SEXP s_ImmediateArt, 
		 		 SEXP s_UniversalTestAndTreat, 
		 		 SEXP s_Adherence) {

	PROTECT(s_pop = coerceVector(s_pop, REALSXP));
	PROTECT(s_Hbct = coerceVector(s_Hbct, INTSXP)); 
	PROTECT(s_Vct = coerceVector(s_Vct, INTSXP)); 
	PROTECT(s_HbctPocCd4 = coerceVector(s_HbctPocCd4, INTSXP)); 
	PROTECT(s_Linkage = coerceVector(s_Linkage, INTSXP));
	PROTECT(s_PreOutreach = coerceVector(s_PreOutreach, INTSXP)); 
	PROTECT(s_ImprovedCare = coerceVector(s_ImprovedCare, INTSXP)); 
	PROTECT(s_PocCd4 = coerceVector(s_PocCd4, INTSXP)); 
	PROTECT(s_VctPocCd4 = coerceVector(s_VctPocCd4, INTSXP)); 
	PROTECT(s_ArtOutreach = coerceVector(s_ArtOutreach, INTSXP));
	PROTECT(s_ImmediateArt = coerceVector(s_ImmediateArt, INTSXP)); 
	PROTECT(s_UniversalTestAndTreat = coerceVector(s_UniversalTestAndTreat, INTSXP)); 
	PROTECT(s_Adherence = coerceVector(s_Adherence, INTSXP));


	/* Assigning Pointers */
	p_Hbct = INTEGER(s_Hbct);
	p_Vct = INTEGER(s_Vct);
	p_HbctPocCd4 = INTEGER(s_HbctPocCd4);
	p_Linkage = INTEGER(s_Linkage);
	p_PreOutreach = INTEGER(s_PreOutreach);
	p_ImprovedCare = INTEGER(s_ImprovedCare);
	p_PocCd4 = INTEGER(s_PocCd4);
	p_VctPocCd4 = INTEGER(s_VctPocCd4);
	p_ArtOutreach = INTEGER(s_ArtOutreach);
	p_ImmediateArt = INTEGER(s_ImmediateArt);
	p_UniversalTestAndTreat = INTEGER(s_UniversalTestAndTreat);
	p_Adherence = INTEGER(s_Adherence);

	cout << "Hello, Jack - the model is running..." << endl;

	/* THE MODEL */
	theRng = new Rng(mach_absolute_time());
	theQ = new eventQ(0);
	new population(*REAL(s_pop));
	theQ->RunEvents();
	delete theQ;
	delete theRng;


	/* OUTPUTS */
	SEXP sOUT, sCARE, sDALY, sCOST, sPOP_15to49, sHIV_15to49, sART_15to49, sOUTNAMES;

	PROTECT(sCARE = allocVector(REALSXP,5));
	PROTECT(sDALY = allocVector(REALSXP,20));
	PROTECT(sCOST = allocVector(REALSXP,20));
	PROTECT(sPOP_15to49 = allocVector(REALSXP,60));
	PROTECT(sHIV_15to49 = allocVector(REALSXP,60));
	PROTECT(sART_15to49 = allocVector(REALSXP,60));
	PROTECT(theAidsDeath_15plus = allocVector(REALSXP,60);
	PROTECT(thePOP_AgeSex_2007 = allocVector(REALSXP,16);
	PROTECT(theHIV_AgeSex_2007 = allocVector(REALSXP,16);
	PROTECT(thePOP_AgeSex_2012 = allocVector(REALSXP,16);
	PROTECT(theHIV_AgeSex_2012 = allocVector(REALSXP,16);
	PROTECT(theCd4_200 = allocVector(REALSXP,60);
	PROTECT(theCd4_200350 = allocVector(REALSXP,60);
	PROTECT(theCd4_350500 = allocVector(REALSXP,60);
	PROTECT(theCd4_500 = allocVector(REALSXP,60);

	double * pCARE = REAL(sCARE);
	double * pDALY = REAL(sDALY);
	double * pCOST = REAL(sCOST);
	double * pPOP_15to49 = REAL(sPOP_15to49);
	double * pHIV_15to49 = REAL(sHIV_15to49);
	double * pART_15to49 = REAL(sART_15to49);
	double * pAidsDeath_15plus = REAL(sAidsDeath_15plus);
	double * pPOP_AgeSex_2007 = REAL(sPOP_AgeSex_2007);
	double * pHIV_AgeSex_2007 = REAL(sHIV_AgeSex_2007);
	double * pPOP_AgeSex_2012 = REAL(sPOP_AgeSex_2012);
	double * pHIV_AgeSex_2012 = REAL(sHIV_AgeSex_2012);
	double * pCd4_200 = REAL(sCd4_200);
	double * pCd4_200350 = REAL(sCd4_200350);
	double * pCd4_350500 = REAL(sCd4_350500);
	double * pCd4_500 = REAL(sCd4_500);

	for(size_t i=0;i<60;i++) {
		if(i<5)
			pCARE[i] = theCARE[i];
		if(i<20)
			pDALY[i] = theDALY[i];
		if(i<20)
			pCOST[i] = theCOST[i];
		if(i<16) {
			pPOP_AgeSex_2007[i] = thePOP_AgeSex_2007[i]
			pHIV_AgeSex_2007[i] = theHIV_AgeSex_2007[i]
			pPOP_AgeSex_2012[i] = thePOP_AgeSex_2012[i]
			pHIV_AgeSex_2012[i] = theHIV_AgeSex_2012[i]
		}
		pPOP_15to49[i] = thePOP_15to49[i];
		pHIV_15to49[i] = theHIV_15to49[i];
		pART_15to49[i] = theART_15to49[i];
		pAidsDeath_15plus[i] = theAidsDeath_15plus[i];
		pCd4_200[i] = theCd4_200[i];
		pCd4_200350[i] = theCd4_200350[i];
		pCd4_350500[i] = theCd4_350500[i];
		pCd4_500[i] = theCd4_500[i];
	}

	PROTECT(sOUT = allocVector(VECSXP,15));
	SET_VECTOR_ELT(sOUT,0,sCARE);
	SET_VECTOR_ELT(sOUT,1,sDALY);
	SET_VECTOR_ELT(sOUT,2,sCOST);
	SET_VECTOR_ELT(sOUT,3,sPOP_15to49);
	SET_VECTOR_ELT(sOUT,4,sHIV_15to49);
	SET_VECTOR_ELT(sOUT,5,sART_15to49);
	SET_VECTOR_ELT(sOUT,6,sAidsDeath_15plus);
	SET_VECTOR_ELT(sOUT,7,sPOP_AgeSex_2007);
	SET_VECTOR_ELT(sOUT,8,sHIV_AgeSex_2007);
	SET_VECTOR_ELT(sOUT,9,sPOP_AgeSex_2012);
	SET_VECTOR_ELT(sOUT,10,sHIV_AgeSex_2012);
	SET_VECTOR_ELT(sOUT,11,sCd4_200);
	SET_VECTOR_ELT(sOUT,12,sCd4_200350);
	SET_VECTOR_ELT(sOUT,13,sCd4_350500);
	SET_VECTOR_ELT(sOUT,14,sCd4_500);

	PROTECT(sOUTNAMES = allocVector(VECSXP,15));
	SET_VECTOR_ELT(sOUTNAMES,0,mkChar("sCARE"));
	SET_VECTOR_ELT(sOUTNAMES,1,mkChar("sDALY"));
	SET_VECTOR_ELT(sOUTNAMES,2,mkChar("sCOST"));
	SET_VECTOR_ELT(sOUTNAMES,3,mkChar("sPOP_15to49"));
	SET_VECTOR_ELT(sOUTNAMES,4,mkChar("sHIV_15to49"));
	SET_VECTOR_ELT(sOUTNAMES,5,mkChar("sART_15to49"));
	SET_VECTOR_ELT(sOUT,6,mkChar("sAidsDeath_15plus"));
	SET_VECTOR_ELT(sOUT,7,mkChar("sPOP_AgeSex_2007"));
	SET_VECTOR_ELT(sOUT,8,mkChar("sHIV_AgeSex_2007"));
	SET_VECTOR_ELT(sOUT,9,mkChar("sPOP_AgeSex_2012"));
	SET_VECTOR_ELT(sOUT,10,mkChar("sHIV_AgeSex_2012"));
	SET_VECTOR_ELT(sOUT,11,mkChar("sCd4_200"));
	SET_VECTOR_ELT(sOUT,12,mkChar("sCd4_200350"));
	SET_VECTOR_ELT(sOUT,13,mkChar("sCd4_350500"));
	SET_VECTOR_ELT(sOUT,14,mkChar("sCd4_500"));
	namesgets(sOUT,sOUTNAMES);

	UNPROTECT(30);
	return(sOUT);
	}

/////////////////////

}
