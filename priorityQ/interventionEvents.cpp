//
//  interventionEvents.cpp
//  priorityQ
//
//  Created by Jack Olney on 03/11/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#include <iostream>
#include "macro.h"
#include "interventionEvents.h"
#include "interventionUpdate.h"
#include "update.h"
#include "impact.h"
#include "cost.h"
#include "cascadeEvents.h"
#include "cascadeUpdate.h"

using namespace std;

/////////////////////
/////////////////////

HctHivTest::HctHivTest(person * const thePerson, const double Time, const bool poc) :
event(Time),
pPerson(thePerson),
pointOfCare(poc)
{
	thePerson->SetHctHivTestDate(Time);
	D(cout << "HctHivTest scheduled for day = " << Time << endl);
}

HctHivTest::~HctHivTest()
{}

bool HctHivTest::CheckValid()
{
	if(pPerson->GetHctHivTestDate() == GetTime() && !pPerson->GetEverArt())
		return pPerson->Alive();
	else
		return false;
}

void HctHivTest::Execute()
{
	UpdateAge(pPerson);
	UpdateDaly(pPerson);
	ChargeHctVisit(pPerson);
	D(cout << "HctHivTest executed." << endl);
	if(pPerson->GetSeroStatus()) {
		pPerson->SetDiagnosedState(true,1);
		D(cout << "Diagnosed as HIV-positive." << endl);
		if(pointOfCare)
			new HctPocCd4Test(pPerson,GetTime());
		else if(HctLinkage(pPerson))
			ScheduleInitialCd4TestAfterHct(pPerson);
		SchedulePictHivTest(pPerson);
	}
}

/////////////////////
/////////////////////

HctPocCd4Test::HctPocCd4Test(person * const thePerson, const double Time) :
event(Time),
pPerson(thePerson)
{
	D(cout << "HctPocCd4Test scheduled for day = " << Time << endl);
}

HctPocCd4Test::~HctPocCd4Test()
{}

bool HctPocCd4Test::CheckValid()
{
	return pPerson->Alive();
}

void HctPocCd4Test::Execute()
{
	UpdateAge(pPerson);
	UpdateDaly(pPerson);
	ChargePocCd4Test(pPerson);
	D(cout << "HctPocCd4Test executed." << endl);
	pPerson->SetEverCd4TestState(true);
	pPerson->SetEverCD4TestResultState(true);
	if(pPerson->GetEligible()) {
		D(cout << "Eligible for ART." << endl);
		ScheduleArtInitiation(pPerson);
	} else {
		D(cout << "Not eligible for ART." << endl);
		if(HctLinkage(pPerson))
			ScheduleInitialCd4TestAfterHct(pPerson);
	}
	SchedulePictHivTest(pPerson);
}