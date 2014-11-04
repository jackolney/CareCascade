//
//  interventions.cpp
//  priorityQ
//
//  Created by Jack Olney on 31/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#include <iostream>
#include "macro.h"
#include "interventions.h"
#include "interventionUpdate.h"
#include "interventionEvents.h"
#include "cascadeEvents.h"
#include "cascadeUpdate.h"
#include "toolbox.h"

using namespace std;

/* Intervention Pointers */
extern int const * p_Hbct;
extern int const * p_Vct;
extern int const * p_HbctPocCd4;
extern int const * p_Linkage;
extern int const * p_PreOutreach;
extern int const * p_ImprovedCare;
extern int const * p_PocCd4;
extern int const * p_VctPocCd4;
extern int const * p_ArtOutreach;
extern int const * p_ImmediateArt;
extern int const * p_UniversalTestAndTreat;
extern int const * p_Adherence;
extern int const * p_ArtDropout;

/////////////////////
/////////////////////

void SeedInterventions(person * const thePerson)
{
	if(*p_Hbct || *p_Vct || *p_HbctPocCd4 || *p_Linkage || *p_PreOutreach || *p_ImprovedCare || *p_PocCd4 || *p_VctPocCd4 || *p_ArtOutreach || *p_ImmediateArt || *p_UniversalTestAndTreat || *p_Adherence || *p_ArtDropout) {
		if(thePerson->GetBirthDay() < 14610)
			new Interventions(thePerson,14610);
		else
			new Interventions(thePerson,thePerson->GetBirthDay());
	}
}

/////////////////////
/////////////////////

Interventions::Interventions(person * const thePerson, const double Time) :
event(Time),
pPerson(thePerson)
{
	D(cout << "Interventions scheduled for " << Time << " (year = " << Time / 365.25 << ")" << endl);
}

Interventions::~Interventions()
{}

bool Interventions::CheckValid()
{
	return pPerson->Alive();
}

void Interventions::Execute()
{

/////////////////////
/////////////////////
	/* Hbct */
	
	if(*p_Hbct) {
		new SeedHct(pPerson,14610,false); //2010
		new SeedHct(pPerson,16071,false); //2014
		new SeedHct(pPerson,17532,false); //2018
		new SeedHct(pPerson,18993,false); //2022
		new SeedHct(pPerson,20454,false); //2026
		
		if(*p_Hbct == 1) {
			hctProbLink = 1;
			hctProbLinkPreviouslyDiagnosed = 1;
		}
	}
	
/////////////////////
	/* Vct */
	
	if(*p_Vct) {
		if(*p_Vct == 1)
			vctHivTestTime *= 0.5; //2.9
		else
			vctHivTestTime *= 0.8; //4.64
		D(cout << "VctHivTest Intervention. vctHivTestTime = " << vctHivTestTime << endl);
		ScheduleVctHivTest(pPerson);
	}
	
/////////////////////
	/* HbctPocCd4 */
	
	if(*p_HbctPocCd4) {
		new SeedHct(pPerson,14610,true); //2010
		new SeedHct(pPerson,16071,true); //2014
		new SeedHct(pPerson,17532,true); //2018
		new SeedHct(pPerson,18993,true); //2022
		new SeedHct(pPerson,20454,true); //2026
		
		if(*p_HbctPocCd4 == 1) {
			hctProbLink = 1;
			hctProbLinkPreviouslyDiagnosed = 1;
		} else {
			hctProbLink += (1-hctProbLink)*0.5;
			hctProbLinkPreviouslyDiagnosed += (1-hctProbLinkPreviouslyDiagnosed)*0.5;
		}
	}

/////////////////////
	/* Linkage */
	
	if(*p_Linkage) {
		D(cout << "Linkage intervention." << endl);
		if(*p_Linkage == 1) {
			hctProbLink = 1;
			hctProbLinkPreviouslyDiagnosed = 1;
			vctProbLink = 1;
			pictProbLink = 1;
		} else {
			hctProbLink += (1-hctProbLink)*0.5;
			hctProbLinkPreviouslyDiagnosed += (1-hctProbLinkPreviouslyDiagnosed)*0.5;
			vctProbLink += (1-vctProbLink)*0.5;
			pictProbLink += (1-pictProbLink)*0.5;
		}
	}
	
/////////////////////
	/* PreOutreach */
	
	if(*p_PreOutreach) {
		double k = 0;
		if(*p_PreOutreach == 1) { k = 1; } else { k = 0.2; }
		
		for(size_t i=0;i<20;i++)
			new PreArtOutreach(pPerson,14792.625 + (i * 182.625),k);
	}

/////////////////////
	/* ImprovedCare */
	
	if(*p_ImprovedCare) {
		D(cout << "ImprovedCare intervention." << endl);
		if(*p_ImprovedCare == 1) {
			cd4ResultProbAttend = 1;
			hctShortTermRetention = 1;
			hctLongTermRetention = 1;
			vctShortTermRetention = 1;
			vctLongTermRetention = 1;
			pictShortTermRetention = 1;
			pictLongTermRetention = 1;
			hctProbSecondaryCd4Test = 1;
			vctProbSecondaryCd4Test = 1;
			pictProbSecondaryCd4Test = 1;
		} else {
			cd4ResultProbAttend += (1-cd4ResultProbAttend)*0.5;
			hctShortTermRetention += (1-hctShortTermRetention)*0.5;
			hctLongTermRetention += (1-hctLongTermRetention)*0.5;
			vctShortTermRetention += (1-vctShortTermRetention)*0.5;
			vctLongTermRetention += (1-vctLongTermRetention)*0.5;
			pictShortTermRetention += (1-pictShortTermRetention)*0.5;
			pictLongTermRetention += (1-pictLongTermRetention)*0.5;
			hctProbSecondaryCd4Test += (1-hctProbSecondaryCd4Test)*0.5;
			vctProbSecondaryCd4Test += (1-vctProbSecondaryCd4Test)*0.5;
			pictProbSecondaryCd4Test += (1-pictProbSecondaryCd4Test)*0.5;
		}
	}

/////////////////////
	/* PocCd4 */
	
	if(*p_PocCd4)
		pocFlag = true;
	
/////////////////////
	/* VctPocCd4 */
	
	if(*p_VctPocCd4)
		vctPocFlag = true;
	
/////////////////////
	/* ArtOutreach */
	
	if(*p_ArtOutreach) {
		double k = 0;
		if(*p_ArtOutreach == 1) { k = 1; } else { k = 0.4; }
		
		for(size_t i=0;i<20;i++)
			new ArtOutreach(pPerson,14792.625 + (i * 182.625),k);
	}
	
/////////////////////
	/* ImmediateArt */
	
	if(*p_ImmediateArt) {
		D(cout << "ImmediateArt intervention." << endl);
		immediateArtFlag = true;
		UpdateTreatmentGuidelines(pPerson,4,1);
	}
	
/////////////////////
	/* UniversalTestAndTreat */
	
	if(*p_UniversalTestAndTreat) {
		
	}
	
/////////////////////
	/* Adherence */
	
	if(*p_Adherence) {
		
	}

/////////////////////
	/* ArtDropout */
	
	if(*p_ArtDropout) {
		
	}
	
/////////////////////
	
}
	
/////////////////////
/////////////////////