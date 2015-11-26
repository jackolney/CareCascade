//
//  cost.cpp
//  priorityQ
//
//  Created by Jack Olney on 27/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#include <iostream>
#include "cost.h"
#include "person.h"
#include "toolbox.h"

using namespace std;

extern double * theCOST;
extern double * thePreArtCOST;
extern double * theArtCOST;
extern double * thePreArtCOST_Hiv;
extern double * theArtCOST_Hiv;

/* COST UNITS */
extern double * theUNIT_HctVisitCost;
extern double * theUNIT_RapidHivTestCost;
extern double * theUNIT_LinkageCost;
extern double * theUNIT_ImpCareCost;
extern double * theUNIT_PreArtClinicVisitCost;
extern double * theUNIT_LabCd4TestCost;
extern double * theUNIT_PocCd4TestCost;
extern double * theUNIT_AnnualArtCost;
extern double * theUNIT_AnnualAdherenceCost;
extern double * theUNIT_OutreachCost;

/////////////////////
/////////////////////

void ChargeHctVisit(person * const thePerson)
{
	thePerson->SetHctVisitCost(hctVisitCost);
	thePerson->SetRapidHivTestCost(rapidHivTestCost);

	/* Cost Units  */
	/* Pass these values 1 if an event occurs, else pass them the person-time */
	thePerson->SetHctVisitUnit(1);
	thePerson->SetRapidHivTestUnit(1);
}

/////////////////////
/////////////////////

void ChargeVctPictHivTest(person * const thePerson)
{
	thePerson->SetRapidHivTestCost(rapidHivTestCost);
	thePerson->SetRapidHivTestUnit(1);
}

/////////////////////
/////////////////////

void ChargePreArtClinicVisit(person * const thePerson)
{
	thePerson->SetPreArtClinicVisitCost(preArtClinicVisitCost);
	thePerson->SetPreArtClinicVisitUnit(1);
}

/////////////////////
/////////////////////

void ChargePreArtClinicCd4Test(person * const thePerson)
{
	thePerson->SetLabCd4TestCost(labCd4TestCost);
	thePerson->SetLabCd4TestUnit(1);
}

/////////////////////
/////////////////////

void ChargePreArtClinicCd4ResultVisit(person * const thePerson)
{
	thePerson->SetPreArtClinicVisitCost(preArtClinicVisitCost);
	thePerson->SetPreArtClinicVisitUnit(1);
}

/////////////////////
/////////////////////

void ChargePocCd4Test(person * const thePerson)
{
	thePerson->SetPocCd4TestCost(pocCd4TestCost);
	thePerson->SetPocCd4TestUnit(1);
}

/////////////////////
/////////////////////

void ChargeArtCare(person * const thePerson, const double theTime, const double theArrayTime)
{
	if(thePerson->GetArtInitiationState()) {
		if(thePerson->GetArtDay() <= theArrayTime) {
			thePerson->SetAnnualArtCost((((theTime - theArrayTime) + thePerson->GetArtTime()) / 365.25) * annualArtCost);
			thePerson->SetAnnualArtUnit(((theTime - theArrayTime) + thePerson->GetArtTime()) / 365.25);
		} else {
			thePerson->SetAnnualArtCost((((theTime - thePerson->GetArtDay()) + thePerson->GetArtTime()) / 365.25) * annualArtCost);
			thePerson->SetAnnualArtUnit(((theTime - thePerson->GetArtDay()) + thePerson->GetArtTime()) / 365.25);
		}
	} else {
		thePerson->SetAnnualArtCost((thePerson->GetArtTime() / 365.25) * annualArtCost);
		thePerson->SetAnnualArtUnit(thePerson->GetArtTime() / 365.25);
	}
}


/////////////////////
/////////////////////

void ChargeLinkageInt(person * const thePerson)
{
	if(linkageFlag && thePerson->GetDiagnosedState()) {
		thePerson->SetLinkageCost((thePerson->GetDiagNotLinkedTime() / 365.25) * annualLinkageCost);
		thePerson->SetLinkageUnit(thePerson->GetDiagNotLinkedTime() / 365.25);
	}
}

/////////////////////
/////////////////////

void ChargeImprovedCareInt(person * const thePerson)
{
	if(impCareFlag) {
		thePerson->SetImpCareCost(impCareCost);
		thePerson->SetImpCareUnit(1);
	}
}

/////////////////////
/////////////////////

void ChargeAdherence(person * const thePerson, const double theTime, const double theArrayTime)
{
	if(adherenceFlag && thePerson->GetArtInitiationState()) {
		if(thePerson->GetArtDay() <= theArrayTime) {
			thePerson->SetAnnualAdherenceCost((((theTime - theArrayTime) + thePerson->GetArtTime()) / 365.25) * annualAdherenceCost);
			thePerson->SetAnnualAdherenceUnit(((theTime - theArrayTime) + thePerson->GetArtTime()) / 365.25);
		} else {
			thePerson->SetAnnualAdherenceCost((((theTime - thePerson->GetArtDay()) + thePerson->GetArtTime()) / 365.25) * annualAdherenceCost);
			thePerson->SetAnnualAdherenceUnit(((theTime - thePerson->GetArtDay()) + thePerson->GetArtTime()) / 365.25);
		}
	} else {
		thePerson->SetAnnualAdherenceCost((thePerson->GetArtTime() / 365.25) * annualAdherenceCost);
		thePerson->SetAnnualAdherenceUnit(thePerson->GetArtTime() / 365.25);
	}
}

/////////////////////
/////////////////////

void ChargePreArtOutreach(person * const thePerson)
{
	thePerson->SetPreArtOutreachCost(outreachCost);
	thePerson->SetPreArtOutreachUnit(1);
}

/////////////////////
/////////////////////

void ChargeArtOutreach(person * const thePerson)
{
	thePerson->SetArtOutreachCost(outreachCost);
	thePerson->SetArtOutreachUnit(1);
}

/////////////////////
/////////////////////

void WriteCost(person * const thePerson, const double theTime)
{
	if(thePerson->Alive()) {
		if(theTime > 14610) {
			/* Create array with dates from 2011 to 2030 (to allow us to capture DALYs at year end between 2010 and 2030). */
			double yr [26];
			for(size_t i = 0; i<26; i++)
				yr[i] = 14975.25 + (i * 365.25);

			unsigned int i = 0;
			while(theTime > yr[i] && i < 26)
				i++;

			// Annual Cost Functions to call
			ChargeArtCare(thePerson,theTime,yr[i] - 365.25);
			ChargeAdherence(thePerson,theTime,yr[i] - 365.25);
			ChargeLinkageInt(thePerson);

			theCOST[i] += thePerson->GetHctVisitCost() + thePerson->GetRapidHivTestCost() + thePerson->GetLinkageCost() + thePerson->GetImpCareCost() + thePerson->GetPreArtClinicVisitCost() + thePerson->GetLabCd4TestCost() + thePerson->GetPocCd4TestCost() + thePerson->GetAnnualArtCost() + thePerson->GetAnnualAdherenceCost() + thePerson->GetArtOutreachCost() + thePerson->GetPreArtOutreachCost();
			thePreArtCOST[i] += thePerson->GetHctVisitCost() + thePerson->GetRapidHivTestCost() + thePerson->GetLinkageCost() + thePerson->GetImpCareCost() + thePerson->GetPreArtClinicVisitCost() + thePerson->GetLabCd4TestCost() + thePerson->GetPocCd4TestCost() + thePerson->GetPreArtOutreachCost();
			theArtCOST[i] += thePerson->GetAnnualArtCost() + thePerson->GetAnnualAdherenceCost() + thePerson->GetArtOutreachCost() + thePerson->GetPreArtOutreachCost();

			// HERE INCLUDE THE UNIT COST CALCULATIONS.
			
			if(thePerson->GetSeroStatus()) {
				thePreArtCOST_Hiv[i] += thePerson->GetHctVisitCost() + thePerson->GetRapidHivTestCost() + thePerson->GetLinkageCost() + thePerson->GetImpCareCost() + thePerson->GetPreArtClinicVisitCost() + thePerson->GetLabCd4TestCost() + thePerson->GetPocCd4TestCost() + thePerson->GetPreArtOutreachCost();
				theArtCOST_Hiv[i] += thePerson->GetAnnualArtCost() + thePerson->GetAnnualAdherenceCost() + thePerson->GetArtOutreachCost() + thePerson->GetPreArtOutreachCost();
			}
		}
		thePerson->ResetCost();
	}
}

/////////////////////
/////////////////////
