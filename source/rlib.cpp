
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
extern double * thePOP_15plus;
extern double * theAidsDeath_15plus;
extern double * thePOP_AgeSex_2007;
extern double * theHIV_AgeSex_2007;
extern double * thePOP_NoArtCd4_2007;
extern double * thePOP_AgeSex_2012;
extern double * theHIV_AgeSex_2012;
extern double * thePOP_AgeSex_2014;
extern double * theHIV_AgeSex_2014;
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
extern double * thePreArtCOST;
extern double * theArtCOST;
extern double * thePreArtCOST_Hiv;
extern double * theArtCOST_Hiv;
extern double * theCLINIC;
extern double * theDeath;
extern double * theAidsDeath;
extern double * theDeath_2010_Age;
extern double * theAidsDeath_2010_Age;

/* Calibration pointers */
extern double * C1;
extern double * L21;
extern double * R3;
extern double * R8;
extern double * ART1;
extern double * ART4;
extern double * ART5;
extern double * ART6;
extern double * ART9;
extern double * ART10;
extern double * ART11;
extern double * ART12;
extern double * ART13;
extern double * ART14;
extern double * Pre2010;
extern unsigned int * HivArray;
extern unsigned int * ArtArray;
extern unsigned int * R3_Counter;
extern unsigned int * R8_Counter;
extern unsigned int * ART6_Counter;
extern unsigned int * ART10_Counter;
extern unsigned int * ART12_Counter;

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
	theQ = new eventQ(0,(65 * 365.25) + 1);
	new population(*REAL(s_pop));
	theQ->RunEvents();
	delete theQ;
	delete theRng;

	/* OUTPUTS */
	SEXP sOUT, sCARE, sDALY, sCOST, sPOP_15to49, sHIV_15to49, sART_15to49, sPOP_15plus, sAidsDeath_15plus,
	sPOP_AgeSex_2007, sHIV_AgeSex_2007, sPOP_NoArtCd4_2007, sPOP_AgeSex_2012, sHIV_AgeSex_2012, sPOP_AgeSex_2014,
	sHIV_AgeSex_2014, sCD4_200, sCD4_200350, sCD4_350500, sCD4_500, sCD4_200_Art, sCD4_200350_Art, sCD4_350500_Art,
	sCD4_500_Art, sWHO_1, sWHO_2, sWHO_3, sWHO_4, sWHO_1_Art, sWHO_2_Art, sWHO_3_Art, sWHO_4_Art, sINCIDENCE, sPreArtCOST,
	sArtCOST, sPreArtCOST_Hiv, sArtCOST_Hiv, sC1, sL21, sR3, sR8, sART1, sART4, sART5, sART6, sART9, sART10, sART11, sART12,
	sART13, sART14, sPre2010, sHivArray, sArtArray, sR3_Counter, sR8_Counter, sART6_Counter, sART10_Counter, sART12_Counter, 
	sCLINIC, sDeath, sAidsDeath, sDeath_2010_Age, sAidsDeath_2010_Age, sOUTNAMES;

	PROTECT(sCARE = allocVector(REALSXP,6));
	PROTECT(sDALY = allocVector(REALSXP,25));
	PROTECT(sCOST = allocVector(REALSXP,25));
	PROTECT(sPOP_15to49 = allocVector(REALSXP,65));
	PROTECT(sHIV_15to49 = allocVector(REALSXP,65));
	PROTECT(sART_15to49 = allocVector(REALSXP,65));
	PROTECT(sPOP_15plus = allocVector(REALSXP,65));
	PROTECT(sAidsDeath_15plus = allocVector(REALSXP,65));
	PROTECT(sPOP_AgeSex_2007 = allocVector(REALSXP,20));
	PROTECT(sHIV_AgeSex_2007 = allocVector(REALSXP,20));
	PROTECT(sPOP_NoArtCd4_2007 = allocVector(REALSXP,4));
	PROTECT(sPOP_AgeSex_2012 = allocVector(REALSXP,16));
	PROTECT(sHIV_AgeSex_2012 = allocVector(REALSXP,16));
	PROTECT(sPOP_AgeSex_2014 = allocVector(REALSXP,10));
	PROTECT(sHIV_AgeSex_2014 = allocVector(REALSXP,10));
	PROTECT(sCD4_200 = allocVector(REALSXP,65));
	PROTECT(sCD4_200350 = allocVector(REALSXP,65));
	PROTECT(sCD4_350500 = allocVector(REALSXP,65));
	PROTECT(sCD4_500 = allocVector(REALSXP,65));
	PROTECT(sCD4_200_Art = allocVector(REALSXP,65));
	PROTECT(sCD4_200350_Art = allocVector(REALSXP,65));
	PROTECT(sCD4_350500_Art = allocVector(REALSXP,65));
	PROTECT(sCD4_500_Art = allocVector(REALSXP,65));
	PROTECT(sWHO_1 = allocVector(REALSXP,65));
	PROTECT(sWHO_2 = allocVector(REALSXP,65));
	PROTECT(sWHO_3 = allocVector(REALSXP,65));
	PROTECT(sWHO_4 = allocVector(REALSXP,65));
	PROTECT(sWHO_1_Art = allocVector(REALSXP,65));
	PROTECT(sWHO_2_Art = allocVector(REALSXP,65));
	PROTECT(sWHO_3_Art = allocVector(REALSXP,65));
	PROTECT(sWHO_4_Art = allocVector(REALSXP,65));
	PROTECT(sINCIDENCE = allocVector(REALSXP,65));
	PROTECT(sPreArtCOST = allocVector(REALSXP,25));
	PROTECT(sArtCOST = allocVector(REALSXP,25));
	PROTECT(sPreArtCOST_Hiv = allocVector(REALSXP,25));
	PROTECT(sArtCOST_Hiv = allocVector(REALSXP,25));
	PROTECT(sC1 = allocVector(REALSXP,9));
	PROTECT(sL21 = allocVector(REALSXP,36));
	PROTECT(sR3 = allocVector(REALSXP,9));
	PROTECT(sR8 = allocVector(REALSXP,9));
	PROTECT(sART1 = allocVector(REALSXP,48));
	PROTECT(sART4 = allocVector(REALSXP,3));
	PROTECT(sART5 = allocVector(REALSXP,9));
	PROTECT(sART6 = allocVector(REALSXP,3));
	PROTECT(sART9 = allocVector(REALSXP,9));
	PROTECT(sART10 = allocVector(REALSXP,3));
	PROTECT(sART11 = allocVector(REALSXP,9));
	PROTECT(sART12 = allocVector(REALSXP,3));
	PROTECT(sART13 = allocVector(REALSXP,9));
	PROTECT(sART14 = allocVector(REALSXP,9));
	PROTECT(sPre2010 = allocVector(REALSXP,3));
	PROTECT(sHivArray = allocVector(INTSXP,3));
	PROTECT(sArtArray = allocVector(INTSXP,3));
	PROTECT(sR3_Counter = allocVector(INTSXP,9));
	PROTECT(sR8_Counter = allocVector(INTSXP,9));
	PROTECT(sART6_Counter = allocVector(INTSXP,3));
	PROTECT(sART10_Counter = allocVector(INTSXP,3));
	PROTECT(sART12_Counter = allocVector(INTSXP,3));
	PROTECT(sCLINIC = allocVector(REALSXP,5));
	PROTECT(sDeath = allocVector(REALSXP,65));
	PROTECT(sAidsDeath = allocVector(REALSXP,65));
	PROTECT(sDeath_2010_Age = allocVector(REALSXP,20));
	PROTECT(sAidsDeath_2010_Age = allocVector(REALSXP,20));

	double * pCARE = REAL(sCARE);
	double * pDALY = REAL(sDALY);
	double * pCOST = REAL(sCOST);
	double * pPOP_15to49 = REAL(sPOP_15to49);
	double * pHIV_15to49 = REAL(sHIV_15to49);
	double * pART_15to49 = REAL(sART_15to49);
	double * pPOP_15plus = REAL(sPOP_15plus);
	double * pAidsDeath_15plus = REAL(sAidsDeath_15plus);
	double * pPOP_AgeSex_2007 = REAL(sPOP_AgeSex_2007);
	double * pHIV_AgeSex_2007 = REAL(sHIV_AgeSex_2007);
	double * pPOP_NoArtCd4_2007 = REAL(sPOP_NoArtCd4_2007);
	double * pPOP_AgeSex_2012 = REAL(sPOP_AgeSex_2012);
	double * pHIV_AgeSex_2012 = REAL(sHIV_AgeSex_2012);
	double * pPOP_AgeSex_2014 = REAL(sPOP_AgeSex_2014);
	double * pHIV_AgeSex_2014 = REAL(sHIV_AgeSex_2014);
	double * pCd4_200 = REAL(sCD4_200);
	double * pCd4_200350 = REAL(sCD4_200350);
	double * pCd4_350500 = REAL(sCD4_350500);
	double * pCd4_500 = REAL(sCD4_500);
	double * pCd4_200_Art = REAL(sCD4_200_Art);
	double * pCd4_200350_Art = REAL(sCD4_200350_Art);
	double * pCd4_350500_Art = REAL(sCD4_350500_Art);
	double * pCd4_500_Art = REAL(sCD4_500_Art);
	double * pWHO_1 = REAL(sWHO_1);
	double * pWHO_2 = REAL(sWHO_2);
	double * pWHO_3 = REAL(sWHO_3);
	double * pWHO_4 = REAL(sWHO_4);
	double * pWHO_1_Art = REAL(sWHO_1_Art);
	double * pWHO_2_Art = REAL(sWHO_2_Art);
	double * pWHO_3_Art = REAL(sWHO_3_Art);
	double * pWHO_4_Art = REAL(sWHO_4_Art);
	double * pINCIDENCE = REAL(sINCIDENCE);
	double * pPreArtCOST = REAL(sPreArtCOST);
	double * pArtCOST = REAL(sArtCOST);
	double * pPreArtCOST_Hiv = REAL(sPreArtCOST_Hiv);
	double * pArtCOST_Hiv = REAL(sArtCOST_Hiv);
	double * pC1 = REAL(sC1);
	double * pL21 = REAL(sL21);
	double * pR3 = REAL(sR3);
	double * pR8 = REAL(sR8);
	double * pART1 = REAL(sART1);
	double * pART4 = REAL(sART4);
	double * pART5 = REAL(sART5);
	double * pART6 = REAL(sART6);
	double * pART9 = REAL(sART9);
	double * pART10 = REAL(sART10);
	double * pART11 = REAL(sART11);
	double * pART12 = REAL(sART12);
	double * pART13 = REAL(sART13);
	double * pART14 = REAL(sART14);
	double * pPre2010 = REAL(sPre2010);
	int * pHivArray = INTEGER(sHivArray);
	int * pArtArray = INTEGER(sArtArray);
	int * pR3_Counter = INTEGER(sR3_Counter);
	int * pR8_Counter = INTEGER(sR8_Counter);
	int * pART6_Counter = INTEGER(sART6_Counter);
	int * pART10_Counter = INTEGER(sART10_Counter);
	int * pART12_Counter = INTEGER(sART12_Counter);
	double * pCLINIC = REAL(sCLINIC);
	double * pDeath = REAL(sDeath);
	double * pAidsDeath = REAL(sAidsDeath);
	double * pDeath_2010_Age = REAL(sDeath_2010_Age);
	double * pAidsDeath_2010_Age = REAL(sAidsDeath_2010_Age);

	for(size_t i=0;i<65;i++) {
		if(i<3) {
			pART4[i] = ART4[i];
			pART6[i] = ART6[i];
			pART10[i] = ART10[i];
			pART12[i] = ART12[i];
			pPre2010[i] = Pre2010[i];
			pHivArray[i] = HivArray[i];
			pArtArray[i] = ArtArray[i];
			pART6_Counter[i] = ART6_Counter[i];
			pART10_Counter[i] = ART10_Counter[i];
			pART12_Counter[i] = ART12_Counter[i];
		}
		if(i<4)
			pPOP_NoArtCd4_2007[i] = thePOP_NoArtCd4_2007[i];
		if(i<5)
			pCLINIC[i] = theCLINIC[i];
		if(i<6)
			pCARE[i] = theCARE[i];
		if(i<9) {
			pC1[i] = C1[i];
			pR3[i] = R3[i];
			pR8[i] = R8[i];
			pART5[i] = ART5[i];
			pART9[i] = ART9[i];
			pART11[i] = ART11[i];
			pART13[i] = ART13[i];
			pART14[i] = ART14[i];
			pR3_Counter[i] = R3_Counter[i];
			pR8_Counter[i] = R8_Counter[i];
		}
		if(i<10) {
			pPOP_AgeSex_2014[i] = thePOP_AgeSex_2014[i];
			pHIV_AgeSex_2014[i] = theHIV_AgeSex_2014[i];
		}
		if(i<16) {
			pPOP_AgeSex_2012[i] = thePOP_AgeSex_2012[i];
			pHIV_AgeSex_2012[i] = theHIV_AgeSex_2012[i];
		}
		if(i<20) {
			pPOP_AgeSex_2007[i] = thePOP_AgeSex_2007[i];
			pHIV_AgeSex_2007[i] = theHIV_AgeSex_2007[i];
			pDeath_2010_Age[i] = theDeath_2010_Age[i];
			pAidsDeath_2010_Age[i] = theAidsDeath_2010_Age[i];
		}
		if(i<25) {
			pDALY[i] = theDALY[i];
			pCOST[i] = theCOST[i];
			pPreArtCOST[i] = thePreArtCOST[i];
			pArtCOST[i] = theArtCOST[i];
			pPreArtCOST_Hiv[i] = thePreArtCOST_Hiv[i];
			pArtCOST_Hiv[i] = theArtCOST_Hiv[i];
		}
		if(i<36)
			pL21[i] = L21[i];
		if(i<48)
			pART1[i] = ART1[i];
		pPOP_15to49[i] = thePOP_15to49[i];
		pHIV_15to49[i] = theHIV_15to49[i];
		pART_15to49[i] = theART_15to49[i];
		pPOP_15plus[i] = thePOP_15plus[i];
		pAidsDeath_15plus[i] = theAidsDeath_15plus[i];
		pCd4_200[i] = theCD4_200[i];
		pCd4_200350[i] = theCD4_200350[i];
		pCd4_350500[i] = theCD4_350500[i];
		pCd4_500[i] = theCD4_500[i];
		pCd4_200_Art[i] = theCD4_200_Art[i];
		pCd4_200350_Art[i] = theCD4_200350_Art[i];
		pCd4_350500_Art[i] = theCD4_350500_Art[i];
		pCd4_500_Art[i] = theCD4_500_Art[i];
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

	PROTECT(sOUT = allocVector(VECSXP,63));
	SET_VECTOR_ELT(sOUT,0,sCARE);
	SET_VECTOR_ELT(sOUT,1,sDALY);
	SET_VECTOR_ELT(sOUT,2,sCOST);
	SET_VECTOR_ELT(sOUT,3,sPOP_15to49);
	SET_VECTOR_ELT(sOUT,4,sHIV_15to49);
	SET_VECTOR_ELT(sOUT,5,sART_15to49);
	SET_VECTOR_ELT(sOUT,6,sPOP_15plus);
	SET_VECTOR_ELT(sOUT,7,sAidsDeath_15plus);
	SET_VECTOR_ELT(sOUT,8,sPOP_AgeSex_2007);
	SET_VECTOR_ELT(sOUT,9,sHIV_AgeSex_2007);
	SET_VECTOR_ELT(sOUT,10,sPOP_NoArtCd4_2007);
	SET_VECTOR_ELT(sOUT,11,sPOP_AgeSex_2012);
	SET_VECTOR_ELT(sOUT,12,sHIV_AgeSex_2012);
	SET_VECTOR_ELT(sOUT,13,sPOP_AgeSex_2014);
	SET_VECTOR_ELT(sOUT,14,sHIV_AgeSex_2014);
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
	SET_VECTOR_ELT(sOUT,32,sPreArtCOST);
	SET_VECTOR_ELT(sOUT,33,sArtCOST);
	SET_VECTOR_ELT(sOUT,34,sPreArtCOST_Hiv);
	SET_VECTOR_ELT(sOUT,35,sArtCOST_Hiv);
	SET_VECTOR_ELT(sOUT,36,sC1);
	SET_VECTOR_ELT(sOUT,37,sL21);
	SET_VECTOR_ELT(sOUT,38,sR3);
	SET_VECTOR_ELT(sOUT,39,sR8);
	SET_VECTOR_ELT(sOUT,40,sART1);
	SET_VECTOR_ELT(sOUT,41,sART4);
	SET_VECTOR_ELT(sOUT,42,sART5);
	SET_VECTOR_ELT(sOUT,43,sART6);
	SET_VECTOR_ELT(sOUT,44,sART9);
	SET_VECTOR_ELT(sOUT,45,sART10);
	SET_VECTOR_ELT(sOUT,46,sART11);
	SET_VECTOR_ELT(sOUT,47,sART12);
	SET_VECTOR_ELT(sOUT,48,sART13);
	SET_VECTOR_ELT(sOUT,49,sART14);
	SET_VECTOR_ELT(sOUT,50,sPre2010);
	SET_VECTOR_ELT(sOUT,51,sHivArray);
	SET_VECTOR_ELT(sOUT,52,sArtArray);
	SET_VECTOR_ELT(sOUT,53,sR3_Counter);
	SET_VECTOR_ELT(sOUT,54,sR8_Counter);
	SET_VECTOR_ELT(sOUT,55,sART6_Counter);
	SET_VECTOR_ELT(sOUT,56,sART10_Counter);
	SET_VECTOR_ELT(sOUT,57,sART12_Counter);
	SET_VECTOR_ELT(sOUT,58,sCLINIC);
	SET_VECTOR_ELT(sOUT,59,sDeath);
	SET_VECTOR_ELT(sOUT,60,sAidsDeath);
	SET_VECTOR_ELT(sOUT,61,sDeath_2010_Age);
	SET_VECTOR_ELT(sOUT,62,sAidsDeath_2010_Age);

	PROTECT(sOUTNAMES = allocVector(VECSXP,63));
	SET_VECTOR_ELT(sOUTNAMES,0,mkChar("sCARE"));
	SET_VECTOR_ELT(sOUTNAMES,1,mkChar("sDALY"));
	SET_VECTOR_ELT(sOUTNAMES,2,mkChar("sCOST"));
	SET_VECTOR_ELT(sOUTNAMES,3,mkChar("sPOP_15to49"));
	SET_VECTOR_ELT(sOUTNAMES,4,mkChar("sHIV_15to49"));
	SET_VECTOR_ELT(sOUTNAMES,5,mkChar("sART_15to49"));
	SET_VECTOR_ELT(sOUTNAMES,6,mkChar("sPOP_15plus"));
	SET_VECTOR_ELT(sOUTNAMES,7,mkChar("sAidsDeath_15plus"));
	SET_VECTOR_ELT(sOUTNAMES,8,mkChar("sPOP_AgeSex_2007"));
	SET_VECTOR_ELT(sOUTNAMES,9,mkChar("sHIV_AgeSex_2007"));
	SET_VECTOR_ELT(sOUTNAMES,10,mkChar("sPOP_NoArtCd4_2007"));
	SET_VECTOR_ELT(sOUTNAMES,11,mkChar("sPOP_AgeSex_2012"));
	SET_VECTOR_ELT(sOUTNAMES,12,mkChar("sHIV_AgeSex_2012"));
	SET_VECTOR_ELT(sOUTNAMES,13,mkChar("sPOP_AgeSex_2014"));
	SET_VECTOR_ELT(sOUTNAMES,14,mkChar("sHIV_AgeSex_2014"));
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
	SET_VECTOR_ELT(sOUTNAMES,32,mkChar("sPreArtCOST"));
	SET_VECTOR_ELT(sOUTNAMES,33,mkChar("sArtCOST"));
	SET_VECTOR_ELT(sOUTNAMES,34,mkChar("sPreArtCOST_Hiv"));
	SET_VECTOR_ELT(sOUTNAMES,35,mkChar("sArtCOST_Hiv"));
	SET_VECTOR_ELT(sOUTNAMES,36,mkChar("sC1"));
	SET_VECTOR_ELT(sOUTNAMES,37,mkChar("sL21"));
	SET_VECTOR_ELT(sOUTNAMES,38,mkChar("sR3"));
	SET_VECTOR_ELT(sOUTNAMES,39,mkChar("sR8"));
	SET_VECTOR_ELT(sOUTNAMES,40,mkChar("sART1"));
	SET_VECTOR_ELT(sOUTNAMES,41,mkChar("sART4"));
	SET_VECTOR_ELT(sOUTNAMES,42,mkChar("sART5"));
	SET_VECTOR_ELT(sOUTNAMES,43,mkChar("sART6"));
	SET_VECTOR_ELT(sOUTNAMES,44,mkChar("sART9"));
	SET_VECTOR_ELT(sOUTNAMES,45,mkChar("sART10"));
	SET_VECTOR_ELT(sOUTNAMES,46,mkChar("sART11"));
	SET_VECTOR_ELT(sOUTNAMES,47,mkChar("sART12"));
	SET_VECTOR_ELT(sOUTNAMES,48,mkChar("sART13"));
	SET_VECTOR_ELT(sOUTNAMES,49,mkChar("sART14"));
	SET_VECTOR_ELT(sOUTNAMES,50,mkChar("sPre2010"));
	SET_VECTOR_ELT(sOUTNAMES,51,mkChar("sHivArray"));
	SET_VECTOR_ELT(sOUTNAMES,52,mkChar("sArtArray"));
	SET_VECTOR_ELT(sOUTNAMES,53,mkChar("sR3_Counter"));
	SET_VECTOR_ELT(sOUTNAMES,54,mkChar("sR8_Counter"));
	SET_VECTOR_ELT(sOUTNAMES,55,mkChar("sART6_Counter"));
	SET_VECTOR_ELT(sOUTNAMES,56,mkChar("sART10_Counter"));
	SET_VECTOR_ELT(sOUTNAMES,57,mkChar("sART12_Counter"));
	SET_VECTOR_ELT(sOUTNAMES,58,mkChar("sCLINIC"));
	SET_VECTOR_ELT(sOUTNAMES,59,mkChar("sDeath"));
	SET_VECTOR_ELT(sOUTNAMES,60,mkChar("sAidsDeath"));
	SET_VECTOR_ELT(sOUTNAMES,61,mkChar("sDeath_2010_Age"));
	SET_VECTOR_ELT(sOUTNAMES,62,mkChar("sAidsDeath_2010_Age"));
	namesgets(sOUT,sOUTNAMES);

	UNPROTECT(79);
	return(sOUT);
	}

/////////////////////

}
