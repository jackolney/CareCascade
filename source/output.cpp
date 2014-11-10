	//
	//  output.cpp
	//  priorityQ
	//
	//  Created by Jack Olney on 28/10/2014.
	//  Copyright (c) 2014 Jack Olney. All rights reserved.
	//

#include <iostream>
#include "output.h"
#include "impact.h"
#include "cost.h"
#include "outputUpdate.h"

using namespace std;

double * theCARE;
double * theDALY;
double * theCOST;
double * thePOP_15to49;
double * theHIV_15to49;
double * theART_15to49;
double * thePOP_15plus;
double * theAidsDeath_15plus;
double * thePOP_AgeSex_2007;
double * theHIV_AgeSex_2007;
double * thePOP_AgeSex_2012;
double * theHIV_AgeSex_2012;
double * theCd4_200;
double * theCd4_200350;
double * theCd4_350500;
double * theCd4_500;

/////////////////////
/////////////////////

void SeedOutput(person * const thePerson)
{
	double yr [60];
	for(size_t i=0;i<60;i++) {
		yr[i] = 365.25 + (i * 365.25);
		if(thePerson->GetBirthDay() < yr[i])
			new Output(thePerson,yr[i]);
	}
}

/////////////////////
/////////////////////

Output::Output(person * const thePerson, const double Time) :
event(Time),
pPerson(thePerson)
{}

Output::~Output()
{}

bool Output::CheckValid()
{
	return true;
}

void Output::Execute()
{
	if(GetTime() >= 14610) {
		WriteDaly(pPerson);
		WriteCost(pPerson);
	}
	WritePop(pPerson);
	WriteHiv(pPerson);
	WriteArt(pPerson);
	//WriteAidsDeaths() in Kill();
	//WriteCd4(pPerson);
}

/////////////////////
/////////////////////

void CreateOutputArray()
{
	theCARE = new double[5]; //NeverDiagnosed, DiagnosedButNeverInitiatedArt, ArtLate, ArtButDiedOffArt, ArtEarly.
	theDALY = new double[20];
	theCOST = new double[20];
	thePOP_15to49 = new double[60];
	theHIV_15to49 = new double[60];
	theART_15to49 = new double[60];
	thePOP_15plus = new double[60];
	theAidsDeath_15plus = new double[60];
	thePOP_AgeSex_2007 = new double[16];
	theHIV_AgeSex_2007 = new double[16];
	thePOP_AgeSex_2012 = new double[16];
	theHIV_AgeSex_2012 = new double[16];
	theCd4_200 = new double[60];
	theCd4_200350 = new double[60];
	theCd4_350500 = new double[60];
	theCd4_500 = new double[60];
	
	for(size_t i=0;i<60;i++) {
		if(i<5)
			theCARE[i] = 0;
		if(i<20)
			theDALY[i] = 0;
		if(i<20)
			theCOST[i] = 0;
		if(i<16) {
			thePOP_AgeSex_2007[i] = 0;
			theHIV_AgeSex_2007[i] = 0;
			thePOP_AgeSex_2012[i] = 0;
			theHIV_AgeSex_2012[i] = 0;
		}
		thePOP_15to49[i] = 0;
		theHIV_15to49[i] = 0;
		theART_15to49[i] = 0;
		thePOP_15plus[i] = 0;
		theAidsDeath_15plus[i] = 0;
		theCd4_200[i] = 0;
		theCd4_200350[i] = 0;
		theCd4_350500[i] = 0;
		theCd4_500[i] = 0;
	}
}

/////////////////////
/////////////////////
