//
//  eventQ.cpp
//  priorityQ
//
//  Created by Jack Olney on 08/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#include <iostream>
#include "macro.h"
#include "event.h"
#include "events.h"
#include "eventQ.h"
#include "rng.h"
#include "person.h"
#include "cohort.h"
#include "update.h"

extern Rng * theRng;
extern eventQ * theQ;

using namespace std;

/* Define operator for timeComparison */
bool timeComparison::operator()(const event *lhs, const event *rhs) const
{
	return lhs->GetTime() > rhs->GetTime();
}

/* Define constructor */
eventQ::eventQ(const double startTime,const double stopTime) :
currentTime(startTime),
endTime(stopTime)
{}

/* Define destructor */
eventQ::~eventQ()
{}

/* Define AddEvent() */
void eventQ::AddEvent(event * const theEvent)
{
	iQ.push(theEvent);
}

/* Define RunEvents() */
void eventQ::RunEvents()
{
	while(!Empty() && currentTime < endTime) {
		event * nextEvent = GetTop();
		currentTime = nextEvent->GetTime();
		PopTop();
		if(nextEvent->CheckValid()) // Checks to see if event is cancelled, if so doesn't even bother doing anything else should just PopTop() it.
			nextEvent->Execute();
		D(cout << "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tcurrentTime is = " << currentTime << endl);
		D(cout << "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\ttheQ size is = " << theQ->Size() << endl);
		delete nextEvent;
	}
	return;
}

/* Define Empty() */
bool eventQ::Empty() const
{
	return iQ.empty(); //Returns 1 if iQ is empty.
}

/* Define GetTop() */
event * eventQ::GetTop()
{
	event * theEvent = iQ.top();
	return theEvent;
}

/* Define PopTop() */
void eventQ::PopTop()
{
	iQ.pop();
}

/* Define Size() */
size_t eventQ::Size() const //const after a function declaration means the function is not allowed to change any class members.
{
	return iQ.size();
}