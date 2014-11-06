//
//  interventionUpdate.h
//  priorityQ
//
//  Created by Jack Olney on 03/11/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#ifndef __priorityQ__interventionUpdate__
#define __priorityQ__interventionUpdate__

#include <stdio.h>
#include "event.h"
#include "person.h"

/////////////////////
/////////////////////

void ScheduleHctHivTest(person * const thePerson,const bool poc);

bool HctLinkage(person * const thePerson);

/////////////////////
/////////////////////

void ScheduleImmediateArt(person * const thePerson);

/////////////////////
/////////////////////

#endif /* defined(__priorityQ__interventionUpdate__) */