//
//  cohort.h
//  priorityQ
//
//  Created by Jack Olney on 15/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#ifndef __priorityQ__cohort__
#define __priorityQ__cohort__

#include <vector>
#include <stdio.h>
#include "person.h"

using namespace std;

class cohort {
public:
	cohort(const unsigned int Size); //constructor
	~cohort(); //destructor
	
	/* methods */
	void GenerateCohort(const double Time); // Create cohort of desired size...
	void NewPerson(const double Time); // Generates new person (called by GenerateCohort())
	
	/* accessor methods */
	unsigned int GetCohortSize() const;
	
	/* vector */
	vector<person*> cohortContainer;
	
	/* vector methods */
	void PushToVector(person * const thePerson);
	
private:
	unsigned int cohortSize; //Unsigned denotes type can only contain positive values.
	
};

#endif /* defined(__priorityQ__cohort__) */
