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
extern double * thePOP;
extern double * theHIV;
extern double * theART;

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
	SEXP sOUT, sCARE, sDALY, sCOST, sPOP, sHIV, sART, sOUTNAMES;

	PROTECT(sCARE = allocVector(REALSXP,5));
	PROTECT(sDALY = allocVector(REALSXP,20));
	PROTECT(sCOST = allocVector(REALSXP,20));
	PROTECT(sPOP = allocVector(REALSXP,60));
	PROTECT(sHIV = allocVector(REALSXP,60));
	PROTECT(sART = allocVector(REALSXP,60));

	double * pCARE = REAL(sCARE);
	double * pDALY = REAL(sDALY);
	double * pCOST = REAL(sCOST);
	double * pPOP = REAL(sPOP);
	double * pHIV = REAL(sHIV);
	double * pART = REAL(sART);

	for(size_t i=0;i<60;i++) {
		if(i<5)
			pCARE[i] = theCARE[i];
		if(i<20)
			pDALY[i] = theDALY[i];
		if(i<20)
			pCOST[i] = theCOST[i];
		pPOP[i] = thePOP[i];
		pHIV[i] = theHIV[i];
		pART[i] = theART[i];
	}

	PROTECT(sOUT = allocVector(VECSXP,6));
	SET_VECTOR_ELT(sOUT,0,sCARE);
	SET_VECTOR_ELT(sOUT,1,sDALY);
	SET_VECTOR_ELT(sOUT,2,sCOST);
	SET_VECTOR_ELT(sOUT,3,sPOP);
	SET_VECTOR_ELT(sOUT,4,sHIV);
	SET_VECTOR_ELT(sOUT,5,sART);

	PROTECT(sOUTNAMES = allocVector(VECSXP, 6));
	SET_VECTOR_ELT(sOUTNAMES,0,mkChar("sCARE"));
	SET_VECTOR_ELT(sOUTNAMES,1,mkChar("sDALY"));
	SET_VECTOR_ELT(sOUTNAMES,2,mkChar("sCOST"));
	SET_VECTOR_ELT(sOUTNAMES,3,mkChar("sPOP"));
	SET_VECTOR_ELT(sOUTNAMES,4,mkChar("sHIV"));
	SET_VECTOR_ELT(sOUTNAMES,5,mkChar("sART"));
	namesgets(sOUT,sOUTNAMES);

	UNPROTECT(21);
	return(sOUT);
	}

/////////////////////

}
