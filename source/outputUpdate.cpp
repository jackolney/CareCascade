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

using namespace std;

extern eventQ * theQ;

extern double * theCARE;
extern double * thePOP_15to49;
extern double * theHIV_15to49;
extern double * theART_15to49;
extern double * thePOP_15plus;
extern double * theAidsDeath_15plus;
extern double * thePOP_AgeSex_2007;
extern double * theHIV_AgeSex_2007;
extern double * thePOP_AgeSex_2012;
extern double * theHIV_AgeSex_2012;

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
		if(thePerson->GetAge() > 15 * 365.25 && thePerson->GetAge() <= 53 * 365.25) {
			unsigned int ageCatMax [10] = {19,24,29,34,39,44,49,54,59,53};
			unsigned int i = 0;
			while(thePerson->GetAge() > ageCatMax[i] && i < 9)
				i++;

			if(thePerson->GetGender())
				i += 10;
			
			thePOP_AgeSex_2007[i] += thePerson->Alive();
			if(thePerson->Alive())
				theHIV_AgeSex_2007[i] += thePerson->GetArtInitiationState();
		}
	}
}

/////////////////////
/////////////////////

void Write2012(person * const thePerson)
{

}

/////////////////////
/////////////////////
