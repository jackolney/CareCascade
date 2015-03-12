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
extern int * theGuidelines_PopDist_500_DiagNotInCare;
extern int * theGuidelines_PopDist_500_InCareNeverArt;
extern int * theGuidelines_PopDist_500_ArtLessSixMonths;
extern int * theGuidelines_PopDist_500_ArtMoreSixMonths;
extern int * theGuidelines_PopDist_500_OffArt;
extern int * theGuidelines_PopDist_350500_NeverDiag;
extern int * theGuidelines_PopDist_350500_DiagNotInCare;
extern int * theGuidelines_PopDist_350500_InCareNeverArt;
extern int * theGuidelines_PopDist_350500_ArtLessSixMonths;
extern int * theGuidelines_PopDist_350500_ArtMoreSixMonths;
extern int * theGuidelines_PopDist_350500_OffArt;
extern int * theGuidelines_PopDist_200350_NeverDiag;
extern int * theGuidelines_PopDist_200350_DiagNotInCare;
extern int * theGuidelines_PopDist_200350_InCareNeverArt;
extern int * theGuidelines_PopDist_200350_ArtLessSixMonths;
extern int * theGuidelines_PopDist_200350_ArtMoreSixMonths;
extern int * theGuidelines_PopDist_200350_OffArt;
extern int * theGuidelines_PopDist_200_NeverDiag;
extern int * theGuidelines_PopDist_200_DiagNotInCare;
extern int * theGuidelines_PopDist_200_InCareNeverArt;
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

/////////////////////
/////////////////////

void WriteGuidelinesPopDist(person * const thePerson, const int theIndex)
{
	if(!thePerson->GetSeroStatus()) {
		theGuidelines_PopDist_HivNegative[theIndex]++;
	} else if(thePerson->GetCurrentCd4() == 4) {
		if(!thePerson->GetDiagnosedState())
			theGuidelines_PopDist_500_NeverDiag[theIndex]++;
		else if(!thePerson->GetInCareState())
			theGuidelines_PopDist_500_DiagNotInCare[theIndex]++;
		else if (!thePerson->GetEverArt())
			theGuidelines_PopDist_500_InCareNeverArt[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_500_ArtLessSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_500_ArtMoreSixMonths[theIndex]++;
		else if (!thePerson->GetArtInitiationState())
			theGuidelines_PopDist_500_OffArt[theIndex]++;		
	} else if(thePerson->GetCurrentCd4() == 3) {
		if(!thePerson->GetDiagnosedState())
			theGuidelines_PopDist_350500_NeverDiag[theIndex]++;
		else if(!thePerson->GetInCareState())
			theGuidelines_PopDist_350500_DiagNotInCare[theIndex]++;
		else if (!thePerson->GetEverArt())
			theGuidelines_PopDist_350500_InCareNeverArt[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_350500_ArtLessSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_350500_ArtMoreSixMonths[theIndex]++;
		else if (!thePerson->GetArtInitiationState())
			theGuidelines_PopDist_350500_OffArt[theIndex]++;
	} else if(thePerson->GetCurrentCd4() == 2) {
		if(!thePerson->GetDiagnosedState())
			theGuidelines_PopDist_200350_NeverDiag[theIndex]++;
		else if(!thePerson->GetInCareState())
			theGuidelines_PopDist_200350_DiagNotInCare[theIndex]++;
		else if (!thePerson->GetEverArt())
			theGuidelines_PopDist_200350_InCareNeverArt[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() >= (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_200350_ArtLessSixMonths[theIndex]++;
		else if (thePerson->GetArtInitiationState() && thePerson->GetArtDay() < (theQ->GetTime() - 182.625))
			theGuidelines_PopDist_200350_ArtMoreSixMonths[theIndex]++;
		else if (!thePerson->GetArtInitiationState())
			theGuidelines_PopDist_200350_OffArt[theIndex]++;
	} else if(thePerson->GetCurrentCd4() == 1) {
		if(!thePerson->GetDiagnosedState())
			theGuidelines_PopDist_200_NeverDiag[theIndex]++;
		else if(!thePerson->GetInCareState())
			theGuidelines_PopDist_200_DiagNotInCare[theIndex]++;
		else if (!thePerson->GetEverArt())
			theGuidelines_PopDist_200_InCareNeverArt[theIndex]++;
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
	// need to know the time
	double yr [36];
	for(size_t i=0; i<36; i++)
		yr[i] = 11322.75 + (i * 365.25);

	unsigned int i=0;
	while(theQ->GetTime() > yr[i] && i<36)
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

/////////////////////
/////////////////////
