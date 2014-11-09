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

extern double * thePOP;
extern double * theHIV;
extern double * theART;
extern double * thePOP_15to49;
extern double * theHIV_15to49;
extern double * theART_15to49;

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
		thePOP[i] += thePerson->Alive();
		thePerson->SetAge(theQ->GetTime());
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
		theHIV[i] += thePerson->GetSeroStatus();
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
		theART[i] += thePerson->GetArtInitiationState();
		thePerson->SetAge(theQ->GetTime());
		if(thePerson->GetAge() > 15 * 365.25 && thePerson->GetAge() <= 49 * 365.25)
			theART_15to49[i] += thePerson->GetArtInitiationState();
	}
}

/////////////////////
/////////////////////
