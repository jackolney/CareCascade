//
//  eventQ.h
//  priorityQ
//
//  Created by Jack Olney on 08/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#ifndef __priorityQ__eventQ__
#define __priorityQ__eventQ__

#include <stdio.h>
#include <queue>

using namespace std;

/* Define operator() for comparison class */
struct timeComparison {bool operator()(const event *lhs, const event *rhs) const;};

/* Define eventQ class */
class eventQ {
public:
	eventQ(const double startTime, const double stopTime); //constructor
	~eventQ(); //destructor
	
	/* Methods */
	void AddEvent(event * const theEvent);
	void RunEvents();
	void UpdateQ();
	
	/* Accessor methods */
	size_t Size() const; //size_t is a type able to represent the size of any object in bytes.
	bool Empty() const; //to empty the Q at the end of the run?
	double GetTime() const {return currentTime;}
	
	/* Methods */
	event * GetTop(); //Perhaps make private eventually - Jeff calls this NextEvent.
	void PopTop();
	
private:
	priority_queue<event*, vector<event*>, timeComparison> iQ;
	double currentTime;
	double endTime;
	
};

#endif /* defined(__priorityQ__eventQ__) */
