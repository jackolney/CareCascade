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
	void SetDiagnosedState(const bool theState,unsigned int theRoute) { diagnosed = theState; diagnosisCount += 1; diagnosisRoute = theRoute; }
	void SetEverCd4TestState(const bool theState) { everCd4Test = theState; cd4TestCount += 1; }
	void SetEverCD4TestResultState(const bool theState) { everCd4TestResult = theState; }
	void SetInCareState(const bool theState) { inCare = theState; }
	void SetArtInitiationState(const bool theState) { art = theState; }

	/* Natural History Date Setting Functions */
	void SetHivDeathDate(double theDate) { hivDeathDate = theDate; }
	void SetCd4DeclineDate(double theDate) { cd4DeclineDate = theDate; }
	void SetCd4RecoverDate(double theDate) { cd4RecoverDate = theDate; }
	void SetWhoDeclineDate(double theDate) { whoDeclineDate = theDate; }
	void SetWhoRecoverDate(double theDate) { whoRecoverDate = theDate; }

	/* Hiv Care Date Setting Functions */
	void SetHctHivTestDate(double theDate) { hctHivTestDate = theDate; }
	void SetVctHivTestDate(double theDate) { vctHivTestDate = theDate; }
	void SetPictHivTestDate(double theDate) { pictHivTestDate = theDate; }
	
	/* Update Tx Guidelines */
	void UpdateTxGuidelines(unsigned int theCd4, unsigned int theWho) { cd4Tx = theCd4; whoTx = theWho; }
	
	//////////////////////
	/* Accessor methods */
	//////////////////////
	bool GetGender() const;
	double GetNatDeathDate() const;
	bool Alive() const;
	double GetAge() const;
	const double GetBirthDay() const { return birthDay; }
	unsigned int GetCurrentCd4() const { return currentCd4; }
	unsigned int GetCurrentWho() const { return currentWho; }
	
	/* Hiv Care Flag Getting Functions */
	bool GetDiagnosedState() const { return diagnosed; }
	unsigned int GetDiagnosisCount() const { return diagnosisCount; }
	unsigned int GetDiagnosisRoute() const { return diagnosisRoute; }
	bool GetEverCd4TestState() const { return everCd4Test; }
	unsigned int GetCd4TestCount() const { return cd4TestCount; }
	bool GetEverCd4ResultState() const { return everCd4TestResult; }
	bool GetEligible() const { if(currentCd4 <= cd4Tx || currentWho >= whoTx) return true; else return false; }
	bool GetArtInitiationState() const { return art; }
	bool GetSeroStatus() const { return seroStatus; }
	
	/* Hiv Care Date Getting Functions */
	double GetHivDeathDate() const { return hivDeathDate; }
	double GetCd4DeclineDate() const { return cd4DeclineDate; }
	double GetCd4RecoverDate() const { return cd4RecoverDate; }
	double GetWhoDeclineDate() const { return whoDeclineDate; }
	double GetWhoRecoverDate() const { return whoRecoverDate; }
	
	/* Hiv Care Date Getting Functions */
	double GetHctHivTestDate() const { return hctHivTestDate; }
	double GetVctHivTestDate() const { return vctHivTestDate; }
	double GetPictHivTestDate() const { return pictHivTestDate; }
	
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
	
	unsigned int currentCd4;
	unsigned int initialCd4;
	unsigned int currentWho;
	unsigned int initialWho;
	
	/* Day = time an event occured */
	double deathDay;
	const double birthDay;
	
	/* Date = time an event will occur */
	double hivDeathDate;
	double cd4DeclineDate;
	double cd4RecoverDate;
	double whoDeclineDate;
	double whoRecoverDate;
	
	/* Hiv test dates */
	double hctHivTestDate;
	double vctHivTestDate;
	double pictHivTestDate;
	
	/* Hiv care flags */
	bool diagnosed;
	unsigned int diagnosisCount;
	unsigned int diagnosisRoute; //1 = Hct, 2 = Vct, 3 = Pict.
	bool inCare;
	bool everCd4Test;
	unsigned int cd4TestCount;
	bool everCd4TestResult;
	bool art;
	
	/* Tx Guidelines */
	unsigned int cd4Tx;
	unsigned int whoTx;
	
};

#endif /* defined(__priorityQ__person__) */