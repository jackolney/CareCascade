//
//  person.h
//  priorityQ
//
//  Created by Jack Olney on 09/10/2014.
//  Copyright (c) 2014 Jack Olney. All rights reserved.
//

#ifndef __priorityQ__person__
#define __priorityQ__person__

#include <stdio.h>

class person {
public:
	person(const double Time); //constuctor
	virtual ~person(); //destructor
	
	/* Initialiser functions */
	bool AssignGender();
	void AssignInitialAge(const double Time);
	double GenerateNatDeathDate();
	double AssignNatDeathDate(const double Time);
	
	/////////////
	/* Methods */
	/////////////
	void Kill(const double Time);
	double SetAge(const double Time);

	/* Hiv Acquisition Functions */
	bool CheckHiv(const double Time);
	void SetSeroStatus(const bool theState) { seroStatus = theState; }
	void SetSeroconversionDay(const double Time) { seroconversionDay = Time; }
	void SetHivIndicators();
	void SetInitialCd4Count();
	void SetInitialWhoStage();
	
	/* Hiv Progression Functions */
	void ScheduleHivIndicatorUpdate();
	void SetCurrentCd4Count(unsigned int theCount) { currentCd4 = theCount; }
	void SetCurrentWhoStage(unsigned int theStage) { currentWho = theStage; }
	double GenerateHivDeathDate(); //function returns the HivDeathDate Value;
	void AssignHivDeathDate(); //function creates the Death event.
	
	/* Hiv Care Functions */
	void SetDiagnosedState(const bool theState) { diagnosed = theState; }
	void SetEverCd4TestState(const bool theState) { everCd4Test = theState; }
	void SetArtInitiationState(const bool theState) { art = theState; }

	/* Natural History Date Setting Functions */
	void SetHivDeathDate(double theDate) { HivDeathDate = theDate; }
	void SetCd4DeclineDate(double theDate) { Cd4DeclineDate = theDate; }
	void SetCd4RecoverDate(double theDate) { Cd4RecoverDate = theDate; }
	void SetWhoDeclineDate(double theDate) { WhoDeclineDate = theDate; }
	void SetWhoRecoverDate(double theDate) { WhoRecoverDate = theDate; }

	/* Hiv Care Date Setting Functions */
	void SetHctHivTestDate(double theDate) { HctHivTestDate = theDate; }
	void SetVctHivTestDate(double theDate) { VctHivTestDate = theDate; }
	void SetPictHivTestDate(double theDate) { PictHivTestDate = theDate; }
	
	//////////////////////
	/* Accessor methods */
	//////////////////////
	bool GetGender() const;
	double GetNatDeathDate() const;
	bool Alive() const;
	double GetAge() const;
	const double GetBirthDay() const { return BirthDay; }
	unsigned int GetCurrentCd4() const { return currentCd4; }
	unsigned int GetCurrentWho() const { return currentWho; }
	
	/* Hiv Care Flag Getting Functions */
	bool GetDiagnosedState() const { return diagnosed; }
	bool GetEverCd4TestState() const { return everCd4Test; }
	bool GetEverCd4ResultState() const { return everCd4Result; }
	bool GetArtInitiationState() const { return art; }
	bool GetSeroStatus() const { return seroStatus; }
	
	/* Hiv Care Date Getting Functions */
	double GetHivDeathDate() const { return HivDeathDate; }
	double GetCd4DeclineDate() const { return Cd4DeclineDate; }
	double GetCd4RecoverDate() const { return Cd4RecoverDate; }
	double GetWhoDeclineDate() const { return WhoDeclineDate; }
	double GetWhoRecoverDate() const { return WhoRecoverDate; }
	
	/* Hiv Care Date Getting Functions */
	double GetHctHivTestDate() const { return HctHivTestDate; }
	double GetVctHivTestDate() const { return VctHivTestDate; }
	double GetPictHivTestDate() const { return PictHivTestDate; }
	
	/* Tx Guideline Getting Functions */
	unsigned int GetCd4TxGuideline() const { return cd4Tx; }
	unsigned int GetWhoTxGuideline() const { return whoTx; }
	
private:
	/* basic characteristics */
	bool gender;
	double currentAge;
	double initialAge;
	double natDeathDate;
	
	/* Hiv status */
	bool seroStatus;
	double seroconversionDay;
	double hivDeathDate;
	
	unsigned int currentCd4;
	unsigned int initialCd4;
	unsigned int currentWho;
	unsigned int initialWho;
	
	/* Day = time an event occured */
	double DeathDay;
	const double BirthDay;
	
	/* Date = time an event will occur */
	double HivDeathDate;
	double Cd4DeclineDate;
	double Cd4RecoverDate;
	double WhoDeclineDate;
	double WhoRecoverDate;
	
	/* Hiv test dates */
	double HctHivTestDate;
	double VctHivTestDate;
	double PictHivTestDate;
	
	/* Hiv care flags */
	bool diagnosed;
	bool inCare;
	bool everCd4Test;
	bool everCd4Result;
	bool art;
	
	/* Tx Guidelines */
	unsigned int cd4Tx;
	unsigned int whoTx;
	
};

#endif /* defined(__priorityQ__person__) */