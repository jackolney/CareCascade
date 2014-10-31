//
//  toolbox.h
//  priorityQ
//
//  Created by Jack Olney on 23/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#ifndef priorityQ_toolbox_h
#define priorityQ_toolbox_h

////////////////////
//PARAMETER VALUES//
////////////////////

////////////////////
/////POINTERS//////

////////////////////
/* Hiv testing times */
const double hctHivTestTime = 1 * 365.25;
const double vctHivTestTime = 5.8 * 365.25;
const double pictHivTestTime_AsymptomaticNoCd4Result = 2 * 365.25;
const double pictHivTestTime_AsymptomaticCd4ResultNotEligible = 1 * 365.25;
const double pictHivTestTime_AsymptomaticCd4ResultEligible = 0.5 * 365.25;
const double pictHivTestTime_SymptomaticOblivious = 1 * 365.25;
const double pictHivTestTime_SymptomaticNoCd4Result = 0.5 * 365.25;
const double pictHivTestTime_SymptomaticCd4Result = 0.5 * 365.25;


/* Linkage probabilities */
	//I changed nothing.
const double hctProbLink = 0.054;
const double hctProbLinkPreviouslyDiagnosed = 0.2;
const double vctProbLink = 0.59;
const double pictProbLink = 0.54;

/* HCT time between Hiv test and Cd4 test [CD4-1] */
const double hctCd4TestTime [4] = {142,152.5,97,93};

/* Time between Cd4 test and receiving results */
const double cd4ResultTime = 30;

/* Time between receiving result Cd4 test and subsequent Cd4 test */
const double cd4TestTime = 335.25;

/* Probability of attending Cd4 Test result visit */
const double cd4ResultProbAttend = 0.8;

/* Pre-Art retention probability (between test and result) */
const double hctShortTermRetention = 0.6192;
const double hctLongTermRetention = 0.6192;

const double vctShortTermRetention = 0.5326;
const double vctLongTermRetention = 0.5326;

const double pictShortTermRetention = 0.5407;
const double pictLongTermRetention = 0.5407;

/* Proportion returning for secondary Cd4 testing  */
const double hctProbSecondaryCd4Test = 0.4333;
const double vctProbSecondaryCd4Test = 0.3105;
const double pictProbSecondaryCd4Test = 0.3129;

/* Time between eligiblity and Art initiation */
const double artInitiationTime = 217.07;

/* Art dropout times */
const double artDropoutTimeOneYear = 11.99 * 365.25; //0.08/100py
const double artDropoutTimeTwoYear = 19.49 * 365.25; //0.05/100py

/* Time between being lost from Art care and returning */
const double artReturnTime = 3 * 365.25;

////////////////
//DALY WEIGHTS//
////////////////

/* DALY weights */
const double dalyWeight_Cd4_3 = 0.053;
const double dalyWeight_Cd4_2 = 0.221;
const double dalyWeight_Cd4_1 = 0.547;
const double dalyWeightArt = 0.053;

//////////////
//UNIT COSTS//
//////////////

/* Hiv care unit costs */
const double hctVisitCost = 8.00;
const double rapidHivTestCost = 10.00;
const double preArtClinicVisitCost = 28.00;
const double labCd4Test = 12.00;
const double pocCd4Test = 42.00;
const double annualArtCost = 367.00;

	//How to use:
/* HBCT */
	//HCT visit + HIV-test = 8 + 10 = $18
	//HCT visit + HIV-test + POC-CD4 test = 8 + 10 + 42 = $60

/* VCT or PICT */
	//Clinic visit + HIV-test + lab-CD4 test = 28 + 10 + 12 = $50 (Test visit)
	//Clinic visit = $28 (Result visit)
	//Clinic visit + HIV-test + POC-CD4 test = 28 + 10 + 42 = $80

/* Pre-ART Care */
	//Clinic visit + lab-CD4 test = 28 + 12 = $40 (Test visit)
	//Clinic visit = $28 (Result visit)
	//Clinic visit + POC-CD4 test = 28 + 42 = $70

#endif