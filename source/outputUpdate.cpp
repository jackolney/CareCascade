	//
	//  outputUpdate.cpp
	//  priorityQ
	//
	//  Created by Jack Olney on 30/10/2014.
	//  Copyright (c) 2014 Jack Olney. All rights reserved.
	//

#include <iostream>
#include "outputUpdate.h"
#include "eventQ.h"
#include "cd4Counter.h"

using namespace std;

extern eventQ * theQ;
extern Cd4Counter * theCd4Counter;

extern double * theCARE;
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
extern double * theCd4_200;
extern double * theCd4_200350;
extern double * theCd4_350500;
extern double * theCd4_500;
extern double * theCd4_200_Art;
extern double * theCd4_200350_Art;
extern double * theCd4_350500_Art;
extern double * theCd4_500_Art;

/////////////////////
/////////////////////

void WritePop(person * const thePerson)
{
	double yr [60];
	for(size_t i = 0; i<60; i++)
		yr[i] = 365.25 + (i * 365.25);
	
	unsigned int i = 0;
	while(theQ->GetTime() > yr[i] && i < 59)
		i++;
	
	if(theQ->GetTime() > thePerson->GetBirthDay()) {
		thePerson->SetAge(theQ->GetTime());
		if(thePerson->GetAge() > 15 * 365.25)
			thePOP_15plus[i] += thePerson->Alive();
		if(thePerson->GetAge() > 15 * 365.25 && thePerson->GetAge() <= 49 * 365.25)
			thePOP_15to49[i] += thePerson->Alive();
	}
}

/////////////////////
/////////////////////

void WriteHiv(person * const thePerson)
{
	double yr [60];
	for(size_t i = 0; i<60; i++)
		yr[i] = 365.25 + (i * 365.25);
	
	unsigned int i = 0;
	while(theQ->GetTime() > yr[i] && i < 59)
		i++;
	
	if(thePerson->Alive()) {
		thePerson->SetAge(theQ->GetTime());
		if(thePerson->GetAge() > 15 * 365.25 && thePerson->GetAge() <= 49 * 365.25)
			theHIV_15to49[i] += thePerson->GetSeroStatus();
	}
}

/////////////////////
/////////////////////

void WriteArt(person * const thePerson)
{
	double yr [60];
	for(size_t i = 0; i<60; i++)
		yr[i] = 365.25 + (i * 365.25);
	
	unsigned int i = 0;
	while(theQ->GetTime() > yr[i] && i < 59)
		i++;
	
	if(thePerson->Alive()) {
		thePerson->SetAge(theQ->GetTime());
		if(thePerson->GetAge() > 15 * 365.25 && thePerson->GetAge() <= 49 * 365.25)
			theART_15to49[i] += thePerson->GetArtInitiationState();
	}
}

/////////////////////
/////////////////////

void WriteCare(person * const thePerson, const double theTime)
{
	if(thePerson->GetHivDeath() && theTime >= 14610 && theTime < 21915) {
			//NeverDiagnosed
		theCARE[0] += !thePerson->GetDiagnosedState();
			//DiagnosedButNeverInitiatedArt
		theCARE[1] += (thePerson->GetDiagnosedState() && !thePerson->GetEverArt());
			//ArtLate
		theCARE[2] += (thePerson->GetEverArt() && thePerson->GetArtDeath() && thePerson->GetCd4AtArt() == 1);
			//ArtButDiedOffArt
		theCARE[3] += (thePerson->GetEverArt() && !thePerson->GetArtDeath());
			//ArtEarly
		theCARE[4] += (thePerson->GetEverArt() && thePerson->GetArtDeath() && thePerson->GetCd4AtArt() > 1);
	}
}

/////////////////////
/////////////////////

void WriteAidsDeath(person * const thePerson)
{
	double yr [60];
	for(size_t i = 0; i<60; i++)
		yr[i] = 365.25 + (i * 365.25);
	
	unsigned int i = 0;
	while(theQ->GetTime() > yr[i] && i < 59)
		i++;

	if(thePerson->GetAge() > 15 * 365.25)
		theAidsDeath_15plus[i] += thePerson->GetSeroStatus();
}

/////////////////////
/////////////////////

void Write2007(person * const thePerson)
{
	if(theQ->GetTime() > thePerson->GetBirthDay()) {
		thePerson->SetAge(theQ->GetTime());
		if(thePerson->GetAge() > 15 * 365.25 && thePerson->GetAge() <= 64 * 365.25) {
			unsigned int ageCatMax [10] = {19,24,29,34,39,44,49,54,59,64};
			unsigned int i = 0;
			while(thePerson->GetAge() / 365.25 > ageCatMax[i] && i < 9)
				i++;

			if(thePerson->GetGender())
				i += 10;
			
			thePOP_AgeSex_2007[i] += thePerson->Alive();
			if(thePerson->Alive()) {
				theHIV_AgeSex_2007[i] += thePerson->GetSeroStatus();
				if(!thePerson->GetArtInitiationState()) {
					if(thePerson->GetCurrentCd4() == 1)
						thePOP_NoArtCd4_2007[0] += 1;
					else if(thePerson->GetCurrentCd4() == 2)
						thePOP_NoArtCd4_2007[1] += 1;
					else if(thePerson->GetCurrentCd4() == 3)
						thePOP_NoArtCd4_2007[2] += 1;
					else if(thePerson->GetCurrentCd4() == 4)
						thePOP_NoArtCd4_2007[3] += 1;
				}
			}
		}
	}
}

/////////////////////
/////////////////////

void Write2012(person * const thePerson)
{
	if(theQ->GetTime() > thePerson->GetBirthDay()) {
		thePerson->SetAge(theQ->GetTime());
		if(thePerson->GetAge() > 15 * 365.25 && thePerson->GetAge() <= 64 * 365.25) {
			unsigned int ageCatMax [8] = {19,24,29,34,39,44,49,64};
			unsigned int i = 0;
			while(thePerson->GetAge() / 365.25 > ageCatMax[i] && i < 7)
				i++;

			if(thePerson->GetGender())
				i += 8;
			
			thePOP_AgeSex_2012[i] += thePerson->Alive();
			if(thePerson->Alive())
				theHIV_AgeSex_2012[i] += thePerson->GetSeroStatus();
		}
	}
}

/////////////////////
/////////////////////

void Write2014(person * const thePerson)
{
	if(theQ->GetTime() > thePerson->GetBirthDay()) {
		thePerson->SetAge(theQ->GetTime());

		unsigned int ageCatMax [5] = {14,21,29,46,200};
		unsigned int i = 0;
		while(thePerson->GetAge() / 365.25 > ageCatMax[i] && i < 4)
			i++;

		if(thePerson->GetGender())
			i += 5;
		
		thePOP_AgeSex_2014[i] += thePerson->Alive();
		if(thePerson->Alive())
			theHIV_AgeSex_2014[i] += thePerson->GetSeroStatus();
	}
}

/////////////////////
/////////////////////

void WriteCd4(person * const thePerson)
{
	double yr [60];
	for(size_t i = 0; i<60; i++)
		yr[i] = 365.25 + (i * 365.25);
	
	unsigned int i = 0;
	while(theQ->GetTime() > yr[i] && i < 59)
		i++;

	theCd4_200[i] = theCd4Counter->GetCd4VectorSize_1();
	theCd4_200350[i] = theCd4Counter->GetCd4VectorSize_2();
	theCd4_350500[i] = theCd4Counter->GetCd4VectorSize_3();
	theCd4_500[i] = theCd4Counter->GetCd4VectorSize_4();

	if(theQ->GetTime() > thePerson->GetBirthDay() && thePerson->Alive()) {
		if(thePerson->GetCurrentCd4() == 1)
			theCd4_200_Art[i] += thePerson->GetArtInitiationState();
		else if(thePerson->GetCurrentCd4() == 2)
			theCd4_200350_Art[i] += thePerson->GetArtInitiationState();
		else if(thePerson->GetCurrentCd4() == 3)
			theCd4_350500_Art[i] += thePerson->GetArtInitiationState();
		else if(thePerson->GetCurrentCd4() == 4)
			theCd4_500_Art[i] += thePerson->GetArtInitiationState();
	}
}

/////////////////////
/////////////////////
