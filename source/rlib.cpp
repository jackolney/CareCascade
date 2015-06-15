
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
extern double * thePreArtCOST;
extern double * theArtCOST;
extern double * thePreArtCOST_Hiv;
extern double * theArtCOST_Hiv;
extern double * theDALY_OffArt;
extern double * theDALY_OnArt;
extern double * theDALY_LYL;
extern double * thePOP_15to49;
extern double * theHIV_15to49;
extern double * theART_15to49;
extern double * thePOP_15plus;
extern double * theAidsDeath_15plus;
extern double * theCD4_200;
extern double * theCD4_200350;
extern double * theCD4_350500;
extern double * theCD4_500;
extern double * theCD4_200_Art;
extern double * theCD4_200350_Art;
extern double * theCD4_350500_Art;
extern double * theCD4_500_Art;
extern double * theWHO_1;
extern double * theWHO_2;
extern double * theWHO_3;
extern double * theWHO_4;
extern double * theWHO_1_Art;
extern double * theWHO_2_Art;
extern double * theWHO_3_Art;
extern double * theWHO_4_Art;
extern double * theINCIDENCE;
extern double * theDeath;
extern double * theAidsDeath;

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
int const * p_Adherence;
int const * p_ImmediateArt;
int const * p_UniversalTestAndTreat;
int const * p_Calibration;

extern "C" {

/////////////////////

SEXP CallCascade(SEXP s_pop,
				 SEXP s_Hbct,
				 SEXP s_Vct,
				 SEXP s_HbctPocCd4,
				 SEXP s_Linkage,
				 SEXP s_VctPocCd4,
				 SEXP s_PreOutreach,
				 SEXP s_ImprovedCare,
				 SEXP s_PocCd4,
				 SEXP s_ArtOutreach,
				 SEXP s_Adherence,
				 SEXP s_ImmediateArt,
				 SEXP s_UniversalTestAndTreat,
				 SEXP s_Calibration) {

	PROTECT(s_pop = coerceVector(s_pop, REALSXP));
	PROTECT(s_Hbct = coerceVector(s_Hbct, INTSXP));
	PROTECT(s_Vct = coerceVector(s_Vct, INTSXP));
	PROTECT(s_HbctPocCd4 = coerceVector(s_HbctPocCd4, INTSXP));
	PROTECT(s_Linkage = coerceVector(s_Linkage, INTSXP));
	PROTECT(s_VctPocCd4 = coerceVector(s_VctPocCd4, INTSXP));
	PROTECT(s_PreOutreach = coerceVector(s_PreOutreach, INTSXP));
	PROTECT(s_ImprovedCare = coerceVector(s_ImprovedCare, INTSXP));
	PROTECT(s_PocCd4 = coerceVector(s_PocCd4, INTSXP));
	PROTECT(s_ArtOutreach = coerceVector(s_ArtOutreach, INTSXP));
	PROTECT(s_Adherence = coerceVector(s_Adherence, INTSXP));
	PROTECT(s_ImmediateArt = coerceVector(s_ImmediateArt, INTSXP));
	PROTECT(s_UniversalTestAndTreat = coerceVector(s_UniversalTestAndTreat, INTSXP));
	PROTECT(s_Calibration = coerceVector(s_Calibration, INTSXP));

	/* Assigning Pointers */
	p_Hbct = INTEGER(s_Hbct);
	p_Vct = INTEGER(s_Vct);
	p_HbctPocCd4 = INTEGER(s_HbctPocCd4);
	p_Linkage = INTEGER(s_Linkage);
	p_VctPocCd4 = INTEGER(s_VctPocCd4);
	p_PreOutreach = INTEGER(s_PreOutreach);
	p_ImprovedCare = INTEGER(s_ImprovedCare);
	p_PocCd4 = INTEGER(s_PocCd4);
	p_ArtOutreach = INTEGER(s_ArtOutreach);
	p_Adherence = INTEGER(s_Adherence);
	p_ImmediateArt = INTEGER(s_ImmediateArt);
	p_UniversalTestAndTreat = INTEGER(s_UniversalTestAndTreat);
	p_Calibration = INTEGER(s_Calibration);

	/* THE MODEL */
	cout << "Hello, Jack - the model is running..." << endl;
	cout << "Caution: WP19 version. Runs until 2035." << endl;
	theRng = new Rng(mach_absolute_time());
	theQ = new eventQ(0,(140 * 365.25) + 1);
	population * thePop = new population(*REAL(s_pop));
	theQ->RunEvents();
	delete theQ;
	delete thePop;
	delete theRng;

	/* OUTPUTS */
	SEXP sOUT, sCARE, sDALY, sCOST, sPreArtCOST, sArtCOST, sPreArtCOST_Hiv, sArtCOST_Hiv,
	sDALY_OffArt, sDALY_OnArt, sDALY_LYL, sPOP_15to49, sHIV_15to49, sART_15to49, sPOP_15plus, 
	sAidsDeath_15plus, sCD4_200, sCD4_200350, sCD4_350500, sCD4_500, sCD4_200_Art, sCD4_200350_Art, 
	sCD4_350500_Art, sCD4_500_Art, sWHO_1, sWHO_2, sWHO_3, sWHO_4, sWHO_1_Art, sWHO_2_Art, sWHO_3_Art, sWHO_4_Art, sINCIDENCE, sDeath, sAidsDeath, sOUTNAMES;

    PROTECT(sCARE = allocVector(REALSXP,6));
    PROTECT(sDALY = allocVector(REALSXP,100));
    PROTECT(sCOST = allocVector(REALSXP,100));
    PROTECT(sPreArtCOST = allocVector(REALSXP,100));
    PROTECT(sArtCOST = allocVector(REALSXP,100));
    PROTECT(sPreArtCOST_Hiv = allocVector(REALSXP,100));
    PROTECT(sArtCOST_Hiv = allocVector(REALSXP,100));
    PROTECT(sDALY_OffArt = allocVector(REALSXP,100));
    PROTECT(sDALY_OnArt = allocVector(REALSXP,100));
    PROTECT(sDALY_LYL = allocVector(REALSXP,100));
    PROTECT(sPOP_15to49 = allocVector(REALSXP,140));
    PROTECT(sHIV_15to49 = allocVector(REALSXP,140));
    PROTECT(sART_15to49 = allocVector(REALSXP,140));
    PROTECT(sPOP_15plus = allocVector(REALSXP,140));
    PROTECT(sAidsDeath_15plus = allocVector(REALSXP,140));
    PROTECT(sCD4_200 = allocVector(REALSXP,140));
    PROTECT(sCD4_200350 = allocVector(REALSXP,140));
    PROTECT(sCD4_350500 = allocVector(REALSXP,140));
    PROTECT(sCD4_500 = allocVector(REALSXP,140));
    PROTECT(sCD4_200_Art = allocVector(REALSXP,140));
    PROTECT(sCD4_200350_Art = allocVector(REALSXP,140));
    PROTECT(sCD4_350500_Art = allocVector(REALSXP,140));
    PROTECT(sCD4_500_Art = allocVector(REALSXP,140));
    PROTECT(sWHO_1 = allocVector(REALSXP,140));
    PROTECT(sWHO_2 = allocVector(REALSXP,140));
    PROTECT(sWHO_3 = allocVector(REALSXP,140));
    PROTECT(sWHO_4 = allocVector(REALSXP,140));
    PROTECT(sWHO_1_Art = allocVector(REALSXP,140));
    PROTECT(sWHO_2_Art = allocVector(REALSXP,140));
    PROTECT(sWHO_3_Art = allocVector(REALSXP,140));
    PROTECT(sWHO_4_Art = allocVector(REALSXP,140));
    PROTECT(sINCIDENCE = allocVector(REALSXP,140));
    PROTECT(sDeath = allocVector(REALSXP,140));
    PROTECT(sAidsDeath = allocVector(REALSXP,140));

    double * pCARE = REAL(sCARE);
    double * pDALY = REAL(sDALY);
    double * pCOST = REAL(sCOST);
    double * pPreArtCOST = REAL(sPreArtCOST);
    double * pArtCOST = REAL(sArtCOST);
    double * pPreArtCOST_Hiv = REAL(sPreArtCOST_Hiv);
    double * pArtCOST_Hiv = REAL(sArtCOST_Hiv);
    double * pDALY_OffArt = REAL(sDALY_OffArt);
    double * pDALY_OnArt = REAL(sDALY_OnArt);
    double * pDALY_LYL = REAL(sDALY_LYL);
    double * pPOP_15to49 = REAL(sPOP_15to49);
    double * pHIV_15to49 = REAL(sHIV_15to49);
    double * pART_15to49 = REAL(sART_15to49);
    double * pPOP_15plus = REAL(sPOP_15plus);
    double * pAidsDeath_15plus = REAL(sAidsDeath_15plus);
    double * pCD4_200 = REAL(sCD4_200);
    double * pCD4_200350 = REAL(sCD4_200350);
    double * pCD4_350500 = REAL(sCD4_350500);
    double * pCD4_500 = REAL(sCD4_500);
    double * pCD4_200_Art = REAL(sCD4_200_Art);
    double * pCD4_200350_Art = REAL(sCD4_200350_Art);
    double * pCD4_350500_Art = REAL(sCD4_350500_Art);
    double * pCD4_500_Art = REAL(sCD4_500_Art);
    double * pWHO_1 = REAL(sWHO_1);
    double * pWHO_2 = REAL(sWHO_2);
    double * pWHO_3 = REAL(sWHO_3);
    double * pWHO_4 = REAL(sWHO_4);
    double * pWHO_1_Art = REAL(sWHO_1_Art);
    double * pWHO_2_Art = REAL(sWHO_2_Art);
    double * pWHO_3_Art = REAL(sWHO_3_Art);
    double * pWHO_4_Art = REAL(sWHO_4_Art);
    double * pINCIDENCE = REAL(sINCIDENCE);
    double * pDeath = REAL(sDeath);
    double * pAidsDeath = REAL(sAidsDeath);

	for(size_t i=0;i<140;i++) {
		if(i<6)
			pCARE[i] = theCARE[i];
		if(i<100) {
			pDALY[i] = theDALY[i];
    		pCOST[i] = theCOST[i];
    		pPreArtCOST[i] = thePreArtCOST[i];
    		pArtCOST[i] = theArtCOST[i];
    		pPreArtCOST_Hiv[i] = thePreArtCOST_Hiv[i];
    		pArtCOST_Hiv[i] = theArtCOST_Hiv[i];
    		pDALY_OffArt[i] = theDALY_OffArt[i];
    		pDALY_OnArt[i] = theDALY_OnArt[i];
    		pDALY_LYL[i] = theDALY_LYL[i];
		}

		pPOP_15to49[i] = thePOP_15to49[i];
    	pHIV_15to49[i] = theHIV_15to49[i];
    	pART_15to49[i] = theART_15to49[i];
    	pPOP_15plus[i] = thePOP_15plus[i];
    	pAidsDeath_15plus[i] = theAidsDeath_15plus[i];
    	pCD4_200[i] = theCD4_200[i];
    	pCD4_200350[i] = theCD4_200350[i];
    	pCD4_350500[i] = theCD4_350500[i];
    	pCD4_500[i] = theCD4_500[i];
    	pCD4_200_Art[i] = theCD4_200_Art[i];
    	pCD4_200350_Art[i] = theCD4_200350_Art[i];
    	pCD4_350500_Art[i] = theCD4_350500_Art[i];
    	pCD4_500_Art[i] = theCD4_500_Art[i];
    	pWHO_1[i] = theWHO_1[i];
    	pWHO_2[i] = theWHO_2[i];
    	pWHO_3[i] = theWHO_3[i];
    	pWHO_4[i] = theWHO_4[i];
    	pWHO_1_Art[i] = theWHO_1_Art[i];
    	pWHO_2_Art[i] = theWHO_2_Art[i];
    	pWHO_3_Art[i] = theWHO_3_Art[i];
    	pWHO_4_Art[i] = theWHO_4_Art[i];
    	pINCIDENCE[i] = theINCIDENCE[i];
    	pDeath[i] = theDeath[i];
    	pAidsDeath[i] = theAidsDeath[i];
	}

	PROTECT(sOUT = allocVector(VECSXP,34));
    SET_VECTOR_ELT(sOUT,0,sCARE);
    SET_VECTOR_ELT(sOUT,1,sDALY);
    SET_VECTOR_ELT(sOUT,2,sCOST);
    SET_VECTOR_ELT(sOUT,3,sPreArtCOST);
    SET_VECTOR_ELT(sOUT,4,sArtCOST);
    SET_VECTOR_ELT(sOUT,5,sPreArtCOST_Hiv);
    SET_VECTOR_ELT(sOUT,6,sArtCOST_Hiv);
    SET_VECTOR_ELT(sOUT,7,sDALY_OffArt);
    SET_VECTOR_ELT(sOUT,8,sDALY_OnArt);
    SET_VECTOR_ELT(sOUT,9,sDALY_LYL);
    SET_VECTOR_ELT(sOUT,10,sPOP_15to49);
    SET_VECTOR_ELT(sOUT,11,sHIV_15to49);
    SET_VECTOR_ELT(sOUT,12,sART_15to49);
    SET_VECTOR_ELT(sOUT,13,sPOP_15plus);
    SET_VECTOR_ELT(sOUT,14,sAidsDeath_15plus);
    SET_VECTOR_ELT(sOUT,15,sCD4_200);
    SET_VECTOR_ELT(sOUT,16,sCD4_200350);
    SET_VECTOR_ELT(sOUT,17,sCD4_350500);
    SET_VECTOR_ELT(sOUT,18,sCD4_500);
    SET_VECTOR_ELT(sOUT,19,sCD4_200_Art);
    SET_VECTOR_ELT(sOUT,20,sCD4_200350_Art);
    SET_VECTOR_ELT(sOUT,21,sCD4_350500_Art);
    SET_VECTOR_ELT(sOUT,22,sCD4_500_Art);
    SET_VECTOR_ELT(sOUT,23,sWHO_1);
    SET_VECTOR_ELT(sOUT,24,sWHO_2);
    SET_VECTOR_ELT(sOUT,25,sWHO_3);
    SET_VECTOR_ELT(sOUT,26,sWHO_4);
    SET_VECTOR_ELT(sOUT,27,sWHO_1_Art);
    SET_VECTOR_ELT(sOUT,28,sWHO_2_Art);
    SET_VECTOR_ELT(sOUT,29,sWHO_3_Art);
    SET_VECTOR_ELT(sOUT,30,sWHO_4_Art);
    SET_VECTOR_ELT(sOUT,31,sINCIDENCE);
    SET_VECTOR_ELT(sOUT,32,sDeath);
    SET_VECTOR_ELT(sOUT,33,sAidsDeath);

	PROTECT(sOUTNAMES = allocVector(VECSXP,34));
	SET_VECTOR_ELT(sOUTNAMES,0,mkChar("sCARE"));
    SET_VECTOR_ELT(sOUTNAMES,1,mkChar("sDALY"));
    SET_VECTOR_ELT(sOUTNAMES,2,mkChar("sCOST"));
    SET_VECTOR_ELT(sOUTNAMES,3,mkChar("sPreArtCOST"));
    SET_VECTOR_ELT(sOUTNAMES,4,mkChar("sArtCOST"));
    SET_VECTOR_ELT(sOUTNAMES,5,mkChar("sPreArtCOST_Hiv"));
    SET_VECTOR_ELT(sOUTNAMES,6,mkChar("sArtCOST_Hiv"));
    SET_VECTOR_ELT(sOUTNAMES,7,mkChar("sDALY_OffArt"));
    SET_VECTOR_ELT(sOUTNAMES,8,mkChar("sDALY_OnArt"));
    SET_VECTOR_ELT(sOUTNAMES,9,mkChar("sDALY_LYL"));
    SET_VECTOR_ELT(sOUTNAMES,10,mkChar("sPOP_15to49"));
    SET_VECTOR_ELT(sOUTNAMES,11,mkChar("sHIV_15to49"));
    SET_VECTOR_ELT(sOUTNAMES,12,mkChar("sART_15to49"));
    SET_VECTOR_ELT(sOUTNAMES,13,mkChar("sPOP_15plus"));
    SET_VECTOR_ELT(sOUTNAMES,14,mkChar("sAidsDeath_15plus"));
    SET_VECTOR_ELT(sOUTNAMES,15,mkChar("sCD4_200"));
    SET_VECTOR_ELT(sOUTNAMES,16,mkChar("sCD4_200350"));
    SET_VECTOR_ELT(sOUTNAMES,17,mkChar("sCD4_350500"));
    SET_VECTOR_ELT(sOUTNAMES,18,mkChar("sCD4_500"));
    SET_VECTOR_ELT(sOUTNAMES,19,mkChar("sCD4_200_Art"));
    SET_VECTOR_ELT(sOUTNAMES,20,mkChar("sCD4_200350_Art"));
    SET_VECTOR_ELT(sOUTNAMES,21,mkChar("sCD4_350500_Art"));
    SET_VECTOR_ELT(sOUTNAMES,22,mkChar("sCD4_500_Art"));
    SET_VECTOR_ELT(sOUTNAMES,23,mkChar("sWHO_1"));
    SET_VECTOR_ELT(sOUTNAMES,24,mkChar("sWHO_2"));
    SET_VECTOR_ELT(sOUTNAMES,25,mkChar("sWHO_3"));
    SET_VECTOR_ELT(sOUTNAMES,26,mkChar("sWHO_4"));
    SET_VECTOR_ELT(sOUTNAMES,27,mkChar("sWHO_1_Art"));
    SET_VECTOR_ELT(sOUTNAMES,28,mkChar("sWHO_2_Art"));
    SET_VECTOR_ELT(sOUTNAMES,29,mkChar("sWHO_3_Art"));
    SET_VECTOR_ELT(sOUTNAMES,30,mkChar("sWHO_4_Art"));
    SET_VECTOR_ELT(sOUTNAMES,31,mkChar("sINCIDENCE"));
    SET_VECTOR_ELT(sOUTNAMES,32,mkChar("sDeath"));
    SET_VECTOR_ELT(sOUTNAMES,33,mkChar("sAidsDeath"));
	namesgets(sOUT,sOUTNAMES);

	UNPROTECT(51);
	return(sOUT);
	}

/////////////////////

}
