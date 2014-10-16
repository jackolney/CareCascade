//
//  events.cpp
//  priorityQ
//
//  Created by Jack Olney on 09/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#include <iostream>
#include "events.h"
#include "event.h"
#include "person.h"
#include "update.h"

using namespace std;

/////////////////////
/////////////////////

Death::Death(person * const thePerson, const double Time) :
event(Time),
pPerson(thePerson)
{}

Death::~Death()
{}

void Death::Execute()
{
	cout << "Death executed." << endl;
	pPerson->Kill(eventTime);
}

/////////////////////
/////////////////////

HivTest::HivTest(person * const thePerson, const double Time) :
event(Time),
pPerson(thePerson)
{}

HivTest::~HivTest()
{}

void HivTest::Execute()
{
	cout << "HivTest executed." << endl;
	pPerson->SetDiagnosedState(true);
	UpdateEvents(pPerson);
};

/////////////////////
/////////////////////

Cd4Test::Cd4Test(person * const thePerson, const double Time) :
event(Time),
pPerson(thePerson)
{}

Cd4Test::~Cd4Test()
{}

void Cd4Test::Execute()
{
	cout << "Cd4Test executed." << endl;
	pPerson->SetCd4TestState(true);
	UpdateEvents(pPerson);
};
