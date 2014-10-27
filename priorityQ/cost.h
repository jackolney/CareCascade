//
//  cost.h
//  priorityQ
//
//  Created by Jack Olney on 27/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#ifndef __priorityQ__cost__
#define __priorityQ__cost__

#include <stdio.h>
#include "person.h"

//void ChargeHctVisit(person * const thePerson);

//void ChargeHctVisitPoc(person * const thePerson);

void ChargeVctPictClinicVisit(person * const thePerson);

//void ChargeVctPictClinicVisitPoc(person * const thePerson);

void ChargePreArtClinicVisit(person * const thePerson);

//void ChargePreArtClinicVisitPoc(person * const thePerson);

void ChargePreArtClinicResultVisit(person * const thePerson);

void ChargeArtCare(person * const thePerson);

#endif /* defined(__priorityQ__cost__) */
