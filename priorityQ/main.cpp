//
//  main.cpp
//  priorityQ
//
//  Created by Jack Olney on 23/08/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#include <iostream>
#include <mach/mach_time.h>
#include "rng.h"
#include "person.h"
#include "cohort.h"
#include "event.h"
#include "events.h"
#include "eventQ.h"

using namespace std;

/* Pointers to things (allows me to access them elsewhere with extern) */
Rng * theRng;
eventQ * theQ;
person * thePerson;


int main(int argc, const char * argv[])
{
	
	/* Keeps the output window open */
	cout << "Starting code." << endl;

	/* Declare RandomNumberGenerator */
	theRng = new Rng(mach_absolute_time());

	/* Define the event queue */
	theQ = new eventQ(0,100); //constructor takes the parameters of startTime and stopTime.

//	person * test[2] = {new person(0),new person(0)};
//	cohort * test[2] = {new person(0),new person(0)};
//	cout << test[0]->GetNatDeathDate() << endl;
//	cout << test[1]->GetNatDeathDate() << endl;
	
	cohort * theCohort = new cohort(2);

	theCohort->GenerateCohort(0);
	
	// PRIORITY //
	// Need to find a way of accessing the new persons created in each cohort individually.
	
	
//	/* Create a person */
//	thePerson = new person(0);
//	
//	
//	
//	cout << "NatDeatDate = " << thePerson->GetNatDeathDate() << endl;
//	cout << "Alive = " << thePerson->Alive() << endl;
//		
////	/* Schedule some events */
//	event * testEvent1 = new HivTest(10);
////	event * testEvent2 = new Cd4Test(20);
////
//	/* Add events into priorityQ */
//	theQ->AddEvent(testEvent1);
////	theQ->AddEvent(testEvent2);
//	
//	/* Model Run */
//	cout << "Start time = " << theQ->GetTime() << endl;
//	theQ->RunEvents();
//	cout << "End time = " << theQ->GetTime() << endl;
	
	/* Upcoming planned order of events */
	// cohort * theCohort = new cohort(100);
	// theCohort->GenerateCohort();
	// theQ->RunEvents();
	// RunEvents() will have a function that will include NEW cohorts each year, thereby keeping main() code minimal.
	
	/*CHALLENGE*/
	
	// 1) Pull out the top() etc. = Done.
	// 2) Pull out multiple tops(), ensuring that they are being ordered correctly. = Done.
	// 3) Test out including function pointers in here too. = Done.
	// 4) Transition to multiple cpp files. = Done.
	// 5) Supply time and function reference in event class constructor. = Done.
	// 5) Including a "currentTime" we walk through time and execute the top of the queue, pop it off and continue. = Done.
	// 6) Include a PERSON. = Done.
	// 7) Assign characteristics to an instance of person at initialisation. = Done.
	// 8) Allow events (derived from class event) to act upon person. = Done.
	// 9) Run two people on one eventQ with a GlobalTime.
	// 10) Set up ages to run properly.
	// 11) DeathDates should be MINUS initialAge (convert to days too).
	// 12) Allow UpdateQ() to run -> perhaps to remote functions.
	// 13) Allow events to be cancelled.
	// 14) How to handle multiple events occuring on the same day?
	// 15) Allow person to be part of a COHORT.
	// 16) EXPAND to include all functions of the model.
	
	theQ->Empty(); //Empty eventQ at end of run.

    return 0;
}


/*NOTES*/

// Will create this model for one individual
// Transistion into defining an array of pointers (of class event) to an array of pointers (of class event Q) to corresponding eventQ's. Therefore allowing me to simulate mulitple individuals simultaneously.

// All events.h classes inherit attributes from event.h
// Ell events have an Execute() which takes NO arguments.

/* Rules to implement */
// 1) Require a GlobalTime variable
// 2) One eventQ -> theQ.
// 3) One cohort of people run per year
// 4) ALL persons feed events into the queue which then executes over time. All individuals run on same time, BUT do not interact (yet).