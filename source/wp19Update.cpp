//
//  wp19Update.cpp
//  priorityQ
//
//  Created by Jack Olney on 12/03/2015.
//  Copyright (c) 2015 Jack Olney. All rights reserved.
//

#include <iostream>
#include "wp19Update.h"
#include "eventQ.h"

using namespace std;

extern eventQ * theQ;

extern int * theGuidelines_PopDist_HivNegative;
extern int * theGuidelines_PopDist_500_NeverDiag;
extern int * theGuidelines_PopDist_500_DiagNotInCareNeverCare;
extern int * theGuidelines_PopDist_500_DiagNotInCareNeverCareEligible;
extern int * theGuidelines_PopDist_500_DiagNotInCareEverCare;
extern int * theGuidelines_PopDist_500_DiagNotInCareEverCareEligible;
extern int * theGuidelines_PopDist_500_InCareNeverArtNeverCd4Result;
extern int * theGuidelines_PopDist_500_InCareNeverArtLessTwoCd4Test;
extern int * theGuidelines_PopDist_500_InCareNeverArtMoreTwoCd4Test;
extern int * theGuidelines_PopDist_500_ArtAtEnrollmentLessSixMonths;
extern int * theGuidelines_PopDist_500_ArtAtEnrollmentMoreSixMonths;
extern int * theGuidelines_PopDist_500_ArtLessSixMonths;
extern int * theGuidelines_PopDist_500_ArtMoreSixMonths;
extern int * theGuidelines_PopDist_500_OffArt;
extern int * theGuidelines_PopDist_350500_NeverDiag;
extern int * theGuidelines_PopDist_350500_DiagNotInCareNeverCare;
extern int * theGuidelines_PopDist_350500_DiagNotInCareNeverCareEligible;
extern int * theGuidelines_PopDist_350500_DiagNotInCareEverCare;
extern int * theGuidelines_PopDist_350500_DiagNotInCareEverCareEligible;
extern int * theGuidelines_PopDist_350500_InCareNeverArtNeverCd4Result;
extern int * theGuidelines_PopDist_350500_InCareNeverArtLessTwoCd4Test;
extern int * theGuidelines_PopDist_350500_InCareNeverArtMoreTwoCd4Test;
extern int * theGuidelines_PopDist_350500_ArtAtEnrollmentLessSixMonths;
extern int * theGuidelines_PopDist_350500_ArtAtEnrollmentMoreSixMonths;
extern int * theGuidelines_PopDist_350500_ArtLessSixMonths;
extern int * theGuidelines_PopDist_350500_ArtMoreSixMonths;
extern int * theGuidelines_PopDist_350500_OffArt;
extern int * theGuidelines_PopDist_200350_NeverDiag;
extern int * theGuidelines_PopDist_200350_DiagNotInCareNeverCare;
extern int * theGuidelines_PopDist_200350_DiagNotInCareNeverCareEligible;
extern int * theGuidelines_PopDist_200350_DiagNotInCareEverCare;
extern int * theGuidelines_PopDist_200350_DiagNotInCareEverCareEligible;
extern int * theGuidelines_PopDist_200350_InCareNeverArtNeverCd4Result;
extern int * theGuidelines_PopDist_200350_InCareNeverArtLessTwoCd4Test;
extern int * theGuidelines_PopDist_200350_InCareNeverArtMoreTwoCd4Test;
extern int * theGuidelines_PopDist_200350_ArtAtEnrollmentLessSixMonths;
extern int * theGuidelines_PopDist_200350_ArtAtEnrollmentMoreSixMonths;
extern int * theGuidelines_PopDist_200350_ArtLessSixMonths;
extern int * theGuidelines_PopDist_200350_ArtMoreSixMonths;
extern int * theGuidelines_PopDist_200350_OffArt;
extern int * theGuidelines_PopDist_200_NeverDiag;
extern int * theGuidelines_PopDist_200_DiagNotInCareNeverCare;
extern int * theGuidelines_PopDist_200_DiagNotInCareNeverCareEligible;
extern int * theGuidelines_PopDist_200_DiagNotInCareEverCare;
extern int * theGuidelines_PopDist_200_DiagNotInCareEverCareEligible;
extern int * theGuidelines_PopDist_200_InCareNeverArtNeverCd4Result;
extern int * theGuidelines_PopDist_200_InCareNeverArtLessTwoCd4Test;
extern int * theGuidelines_PopDist_200_InCareNeverArtMoreTwoCd4Test;
extern int * theGuidelines_PopDist_200_ArtAtEnrollmentLessSixMonths;
extern int * theGuidelines_PopDist_200_ArtAtEnrollmentMoreSixMonths;
extern int * theGuidelines_PopDist_200_ArtLessSixMonths;
extern int * theGuidelines_PopDist_200_ArtMoreSixMonths;
extern int * theGuidelines_PopDist_200_OffArt;

extern int * theGuidelines_Death_HivNegative;
extern int * theGuidelines_Death_500_NeverDiag;
extern int * theGuidelines_Death_500_DiagNotInCare;
extern int * theGuidelines_Death_500_InCareNeverArt;
extern int * theGuidelines_Death_500_ArtLessSixMonths;
extern int * theGuidelines_Death_500_ArtMoreSixMonths;
extern int * theGuidelines_Death_500_OffArt;
extern int * theGuidelines_Death_350500_NeverDiag;
extern int * theGuidelines_Death_350500_DiagNotInCare;
extern int * theGuidelines_Death_350500_InCareNeverArt;
extern int * theGuidelines_Death_350500_ArtLessSixMonths;
extern int * theGuidelines_Death_350500_ArtMoreSixMonths;
extern int * theGuidelines_Death_350500_OffArt;
extern int * theGuidelines_Death_200350_NeverDiag;
extern int * theGuidelines_Death_200350_DiagNotInCare;
extern int * theGuidelines_Death_200350_InCareNeverArt;
extern int * theGuidelines_Death_200350_ArtLessSixMonths;
extern int * theGuidelines_Death_200350_ArtMoreSixMonths;
extern int * theGuidelines_Death_200350_OffArt;
extern int * theGuidelines_Death_200_NeverDiag;
extern int * theGuidelines_Death_200_DiagNotInCare;
extern int * theGuidelines_Death_200_InCareNeverArt;
extern int * theGuidelines_Death_200_ArtLessSixMonths;
extern int * theGuidelines_Death_200_ArtMoreSixMonths;
extern int * theGuidelines_Death_200_OffArt;

extern int * theGuidelines_Art_500;
extern int * theGuidelines_Art_350500;
extern int * theGuidelines_Art_200350;
extern int * theGuidelines_Art_200;

extern int * theGuidelines_NewInfectionsAdult;
extern int * theGuidelines_NewDiagnoses;
extern int * theGuidelines_PreArtDropout;
extern int * theGuidelines_ArtDropout;

/////////////////////
/////////////////////

void WriteGuidelinesPopDist(person * const thePerson, const size_t theIndex)
{
	if(!thePerson->GetSeroStatus()) {
		theGuidelines_PopDist_HivNegative[theIndex]++;
	} else if(thePerson->GetCurrentCd4() == 4) {
		if(!thePerson->GetDiagnosedState())
			theGuidelines_PopDist_500_NeverDiag[theIndex]++;
		else if(!thePerson->GetInCareState() && !thePerson->GetEverCareState() && !thePerson->GetEligible())
			theGuidelines_PopDist_500_DiagNotInCareNeverCare[theIndex]++;
		else if(!thePerson->GetInCareState() && !thePerson->GetEverCareState() && thePerson->GetEligible())
			theGuidelines_PopDist_500_DiagNotInCareNeverCareEligible[theIndex]++;
		else if(!thePerson->GetInCareState() && thePerson->GetEverCareState() && !thePerson->GetEligible())
			theGuidelines_PopDist_500_DiagNotInCareEverCare[theIndex]++;
		else if(!thePerson->GetInCareState() && thePerson->GetEverCareState() && thePerson->GetEligible())
			theGuidelines_PopDist_500_DiagNotInCareEverCareEligible[theIndex]++;
		else if (!thePerson->GetEverArt() && !thePerson->GetEverCd4TestResultState())
			theGuidelines_PopDist_500_InCareNeverArtNeverCd4Result[theIndex]++;
		else if (!thePerson->GetEverArt() && thePerson->GetCd4TestCount() <= 2)
			theGuidelines_PopDist_500_InCareNeverArtLessTwoCd4Test[theIndex]++;
		else if (!thePerson->GetEverArt() && thePerson->GetCd4TestCount() > 2)	
			theGuidelines_PopDist_500_InCareNeverArtMoreTwoCd4Test[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtAtEnrollment() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))		
			theGuidelines_PopDist_500_ArtAtEnrollmentLessSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtAtEnrollment() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_500_ArtAtEnrollmentMoreSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_500_ArtLessSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_500_ArtMoreSixMonths[theIndex]++;
		else if (!thePerson->GetArtInitiationState())
			theGuidelines_PopDist_500_OffArt[theIndex]++;
	} else if(thePerson->GetCurrentCd4() == 3) {
		if(!thePerson->GetDiagnosedState())
			theGuidelines_PopDist_350500_NeverDiag[theIndex]++;
		else if(!thePerson->GetInCareState() && !thePerson->GetEverCareState() && !thePerson->GetEligible())
			theGuidelines_PopDist_350500_DiagNotInCareNeverCare[theIndex]++;
		else if(!thePerson->GetInCareState() && !thePerson->GetEverCareState() && thePerson->GetEligible())
			theGuidelines_PopDist_350500_DiagNotInCareNeverCareEligible[theIndex]++;
		else if(!thePerson->GetInCareState() && thePerson->GetEverCareState() && !thePerson->GetEligible())
			theGuidelines_PopDist_350500_DiagNotInCareEverCare[theIndex]++;
		else if(!thePerson->GetInCareState() && thePerson->GetEverCareState() && thePerson->GetEligible())
			theGuidelines_PopDist_350500_DiagNotInCareEverCareEligible[theIndex]++;
		else if (!thePerson->GetEverArt() && !thePerson->GetEverCd4TestResultState())
			theGuidelines_PopDist_350500_InCareNeverArtNeverCd4Result[theIndex]++;
		else if (!thePerson->GetEverArt() && thePerson->GetCd4TestCount() <= 2)
			theGuidelines_PopDist_350500_InCareNeverArtLessTwoCd4Test[theIndex]++;
		else if (!thePerson->GetEverArt() && thePerson->GetCd4TestCount() > 2)	
			theGuidelines_PopDist_350500_InCareNeverArtMoreTwoCd4Test[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtAtEnrollment() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))		
			theGuidelines_PopDist_350500_ArtAtEnrollmentLessSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtAtEnrollment() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_350500_ArtAtEnrollmentMoreSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_350500_ArtLessSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_350500_ArtMoreSixMonths[theIndex]++;
		else if (!thePerson->GetArtInitiationState())
			theGuidelines_PopDist_350500_OffArt[theIndex]++;	
	} else if(thePerson->GetCurrentCd4() == 2) {
		if(!thePerson->GetDiagnosedState())
			theGuidelines_PopDist_200350_NeverDiag[theIndex]++;
		else if(!thePerson->GetInCareState() && !thePerson->GetEverCareState() && !thePerson->GetEligible())
			theGuidelines_PopDist_200350_DiagNotInCareNeverCare[theIndex]++;
		else if(!thePerson->GetInCareState() && !thePerson->GetEverCareState() && thePerson->GetEligible())
			theGuidelines_PopDist_200350_DiagNotInCareNeverCareEligible[theIndex]++;
		else if(!thePerson->GetInCareState() && thePerson->GetEverCareState() && !thePerson->GetEligible())
			theGuidelines_PopDist_200350_DiagNotInCareEverCare[theIndex]++;
		else if(!thePerson->GetInCareState() && thePerson->GetEverCareState() && thePerson->GetEligible())
			theGuidelines_PopDist_200350_DiagNotInCareEverCareEligible[theIndex]++;
		else if (!thePerson->GetEverArt() && !thePerson->GetEverCd4TestResultState())
			theGuidelines_PopDist_200350_InCareNeverArtNeverCd4Result[theIndex]++;
		else if (!thePerson->GetEverArt() && thePerson->GetCd4TestCount() <= 2)
			theGuidelines_PopDist_200350_InCareNeverArtLessTwoCd4Test[theIndex]++;
		else if (!thePerson->GetEverArt() && thePerson->GetCd4TestCount() > 2)	
			theGuidelines_PopDist_200350_InCareNeverArtMoreTwoCd4Test[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtAtEnrollment() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))		
			theGuidelines_PopDist_200350_ArtAtEnrollmentLessSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtAtEnrollment() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_200350_ArtAtEnrollmentMoreSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_200350_ArtLessSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_200350_ArtMoreSixMonths[theIndex]++;
		else if (!thePerson->GetArtInitiationState())
			theGuidelines_PopDist_200350_OffArt[theIndex]++;
	} else if(thePerson->GetCurrentCd4() == 1) {
		if(!thePerson->GetDiagnosedState())
			theGuidelines_PopDist_200_NeverDiag[theIndex]++;
		else if(!thePerson->GetInCareState() && !thePerson->GetEverCareState() && !thePerson->GetEligible())
			theGuidelines_PopDist_200_DiagNotInCareNeverCare[theIndex]++;
		else if(!thePerson->GetInCareState() && !thePerson->GetEverCareState() && thePerson->GetEligible())
			theGuidelines_PopDist_200_DiagNotInCareNeverCareEligible[theIndex]++;
		else if(!thePerson->GetInCareState() && thePerson->GetEverCareState() && !thePerson->GetEligible())
			theGuidelines_PopDist_200_DiagNotInCareEverCare[theIndex]++;
		else if(!thePerson->GetInCareState() && thePerson->GetEverCareState() && thePerson->GetEligible())
			theGuidelines_PopDist_200_DiagNotInCareEverCareEligible[theIndex]++;
		else if (!thePerson->GetEverArt() && !thePerson->GetEverCd4TestResultState())
			theGuidelines_PopDist_200_InCareNeverArtNeverCd4Result[theIndex]++;
		else if (!thePerson->GetEverArt() && thePerson->GetCd4TestCount() <= 2)
			theGuidelines_PopDist_200_InCareNeverArtLessTwoCd4Test[theIndex]++;
		else if (!thePerson->GetEverArt() && thePerson->GetCd4TestCount() > 2)	
			theGuidelines_PopDist_200_InCareNeverArtMoreTwoCd4Test[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtAtEnrollment() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))		
			theGuidelines_PopDist_200_ArtAtEnrollmentLessSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtAtEnrollment() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_200_ArtAtEnrollmentMoreSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_200_ArtLessSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_200_ArtMoreSixMonths[theIndex]++;
		else if (!thePerson->GetArtInitiationState())
			theGuidelines_PopDist_200_OffArt[theIndex]++;
	}
}

/////////////////////
/////////////////////

void WriteGuidelinesDeath(person * const thePerson)
{
	if(theQ->GetTime() >= 10957.5) {
		double yr [36];
		for(size_t i=0; i<36; i++)
			yr[i] = 11322.75 + (i * 365.25);

		unsigned int i=0;
		while(theQ->GetTime() >= yr[i] && i<36)
			i++;

		if(!thePerson->GetSeroStatus()) {
			theGuidelines_Death_HivNegative[i]++;
		} else if(thePerson->GetCurrentCd4() == 4) {
			if(!thePerson->GetDiagnosedState())
				theGuidelines_Death_500_NeverDiag[i]++;
			else if(!thePerson->GetInCareState())
				theGuidelines_Death_500_DiagNotInCare[i]++;
			else if (!thePerson->GetEverArt())
				theGuidelines_Death_500_InCareNeverArt[i]++;
			else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))
				theGuidelines_Death_500_ArtLessSixMonths[i]++;
			else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
				theGuidelines_Death_500_ArtMoreSixMonths[i]++;
			else if (!thePerson->GetArtInitiationState())
				theGuidelines_Death_500_OffArt[i]++;		
		} else if(thePerson->GetCurrentCd4() == 3) {
			if(!thePerson->GetDiagnosedState())
				theGuidelines_Death_350500_NeverDiag[i]++;
			else if(!thePerson->GetInCareState())
				theGuidelines_Death_350500_DiagNotInCare[i]++;
			else if (!thePerson->GetEverArt())
				theGuidelines_Death_350500_InCareNeverArt[i]++;
			else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))
				theGuidelines_Death_350500_ArtLessSixMonths[i]++;
			else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
				theGuidelines_Death_350500_ArtMoreSixMonths[i]++;
			else if (!thePerson->GetArtInitiationState())
				theGuidelines_Death_350500_OffArt[i]++;
		} else if(thePerson->GetCurrentCd4() == 2) {
			if(!thePerson->GetDiagnosedState())
				theGuidelines_Death_200350_NeverDiag[i]++;
			else if(!thePerson->GetInCareState())
				theGuidelines_Death_200350_DiagNotInCare[i]++;
			else if (!thePerson->GetEverArt())
				theGuidelines_Death_200350_InCareNeverArt[i]++;
			else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))
				theGuidelines_Death_200350_ArtLessSixMonths[i]++;
			else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
				theGuidelines_Death_200350_ArtMoreSixMonths[i]++;
			else if (!thePerson->GetArtInitiationState())
				theGuidelines_Death_200350_OffArt[i]++;
		} else if(thePerson->GetCurrentCd4() == 1) {
			if(!thePerson->GetDiagnosedState())
				theGuidelines_Death_200_NeverDiag[i]++;
			else if(!thePerson->GetInCareState())
				theGuidelines_Death_200_DiagNotInCare[i]++;
			else if (!thePerson->GetEverArt())
				theGuidelines_Death_200_InCareNeverArt[i]++;
			else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))
				theGuidelines_Death_200_ArtLessSixMonths[i]++;
			else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
				theGuidelines_Death_200_ArtMoreSixMonths[i]++;
			else if (!thePerson->GetArtInitiationState())
				theGuidelines_Death_200_OffArt[i]++;
		}
	}
}

/////////////////////
/////////////////////

void WriteGuidelinesArtInitiation(person * const thePerson)
{
	if(theQ->GetTime() >= 10957.5) {
		double yr [36];
		for(size_t i=0; i<36; i++)
			yr[i] = 11322.75 + (i * 365.25);

		unsigned int i=0;
		while(theQ->GetTime() >= yr[i] && i<36)
			i++;

		if(thePerson->GetCurrentCd4() == 4)
			theGuidelines_Art_500[i]++;
		else if(thePerson->GetCurrentCd4() == 3)
			theGuidelines_Art_350500[i]++;
		else if(thePerson->GetCurrentCd4() == 2)
			theGuidelines_Art_200350[i]++;
		else if(thePerson->GetCurrentCd4() == 1)
			theGuidelines_Art_200[i]++;
	}
}

/////////////////////
/////////////////////

void WriteGuidelinesNewInfection(person * const thePerson)
{
	if(theQ->GetTime() >= 10957.5) {
		double yr [36];
		for(size_t i=0; i<36; i++)
			yr[i] = 11322.75 + (i * 365.25);

		unsigned int i=0;
		while(theQ->GetTime() >= yr[i] && i<36)
			i++;

		if(thePerson->GetAge(theQ->GetTime()) > 15 * 365.25)
			theGuidelines_NewInfectionsAdult[i]++;
	}
}

/////////////////////
/////////////////////

void WriteGuidelinesNewDiagnosis()
{
	if(theQ->GetTime() >= 10957.5) {
		double yr [36];
		for(size_t i=0; i<36; i++)
			yr[i] = 11322.75 + (i * 365.25);

		unsigned int i=0;
		while(theQ->GetTime() >= yr[i] && i<36)
			i++;

		theGuidelines_NewDiagnoses[i]++;
	}
}

/////////////////////
/////////////////////

void WriteGuidelinesPreArtDropout()
{
	if(theQ->GetTime() >= 10957.5) {
		double yr [36];
		for(size_t i=0; i<36; i++)
			yr[i] = 11322.75 + (i * 365.25);

		unsigned int i=0;
		while(theQ->GetTime() >= yr[i] && i<36)
			i++;

		theGuidelines_PreArtDropout[i]++;
	}
}

/////////////////////
/////////////////////

void WriteGuidelinesArtDropout()
{
	if(theQ->GetTime() >= 10957.5) {
		double yr [36];
		for(size_t i=0; i<36; i++)
			yr[i] = 11322.75 + (i * 365.25);

		unsigned int i=0;
		while(theQ->GetTime() >= yr[i] && i<36)
			i++;

		theGuidelines_ArtDropout[i]++;
	}
}

/////////////////////
/////////////////////
