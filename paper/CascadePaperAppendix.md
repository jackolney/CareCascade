---
title: |
    <span id="h.lozhs2hilzr2" class="anchor"></span>Evaluating Strategies to
    Improve HIV Care Outcomes in Western Kenya - **Appendix**
...

***CONTENTS:***

***1** - Model Description*

***1.1** - Model Design*

***1.2** - Calendar Time*

***1.3** - C++ / R Interface*

***2** - Natural History Model*

***2.1** - Structure*

***2.2** - Calibration*

***3** - Cascade Model*

***3.1** - Structure*

***3.2** - Calibration*

***4** - Cost Derivation*

***5** - DALY Weighting*

***6** - Intervention Detail*

***7** - Intervention Impact on Incidence*

1 - Model Description
=====================

An individual-based microsimulation was created in C++ to model the care
experience of HIV-positive individuals concurrently with HIV-progression
and associated mortality in western Kenya. The model is more easily
described as two interacting submodels: The Natural History Model and
The Cascade Model.

1.1 - Model Design
------------------

During initialisation, the model creates an instance of a class person.
This class possesses three innate characteristics defined during
initialisation: gender, age, HIV serostatus and a natural death date.
Gender is assigned through sampling from a uniform distribution to
obtain a 1:1 ratio of Males:Females{CentralIntelligenceAgency:2013up}.
Age is assigned by randomly sampling from a uniform distribution between
0 and 1 years old. However, if an individual enters the model in 1970,
then their age is matched to the age distribution in Kenya in
1970[[*UNPop*](http://esa.un.org/unpd/wpp/Excel-Data/population.htm)];
the rationale behind this will be explained below. All individuals enter
the model with an HIV-negative serostatus. Natural death dates are then
sampled from sex-stratified survival distributions derived from
mortality rates from Kenya, extracted from the United Nations Population
Division
Database[[*UNPop*](http://www.un.org/en/development/desa/population/)].

The model simulates the life of an individual until death. During this
lifetime many types of events can occur. As mentioned previously, a
natural death date is assigned to each individual; this is the last
event that will occur in an individual’s lifespan. As the individual
moves through time they encounter events that alter their situation
(i.e. they are diagnosed with HIV). As an individual’s situation
changes, new events may occur (i.e. they initiate ART). This system is
highly dynamic; something that an individual-based model lends itself to
particularly well, as individuals can act autonomously.

The model is a time-to-event simulation, meaning that there is no
specific time-step, but rather the model contains a chronologically
ordered queue of events. When an individual is created, the model is
aware of the calendar time point at which they enter and can calculate
the natural death date by taking into consideration the number of years
an individual will live (extracted from the survival distributions
described above). This date is then pushed into the queue which
reshuffles automatically, ensuring that the next event is the event with
the smallest difference in time from the current time of the model.
Events can be scheduled at any time and pushed into the queue. Current
time in the model begins at the time the individual was created and is
updated as the model steps through events.

Thus, the model begins by creating an individual as described above.
Then, it runs through a series of functions to schedule various events
(e.g. an HIV-test). These events are scheduled if certain criteria are
met: the current time must be correct (i.e. an individual will not be
scheduled to initiate ART in 1975 if HIV-testing in Kenya was not rolled
out until 2004), the individual’s health status must also meet certain
criteria (i.e. an individual cannot initiate ART if they are not
HIV-positive) and finally the individual’s care status must be correct
(i.e. an individual is not allowed to initiate ART if they have never
entered care). Events are scheduled by generating a random deviate from
an exponential distribution with a mean value derived from the data
(explained in calibration section). As events are scheduled, dates are
pushed into the queue which organises them chronologically. The model
jumps to the next event in time and checks to see which event is
scheduled to occur. If the event scheduled is still valid (i.e. some
change to the individual doesn’t prevent it from occurring, e.g. an
individual was scheduled to receive a CD4 test result but has since
dropped out of care, invalidating the CD4 test result event), the model
executes that event and updates the current time. The model then checks
to see if any further events need to be scheduled if the situation of
the individual has changed (i.e. received a CD4 test result confirming
eligibility for ART). These events are then pushed into the queue if
required. The model repeats this cycle of executing and scheduling
events until it encounters a death event, at which point the model
terminates that individual. When an individual terminates, the model
returns a data frame containing information about that particular
individual. This data from each individual is then used to calculate our
output metrics.

1.2 - Calendar Time
-------------------

As previously mentioned, the model runs in calendar time. That is to say
that each date generated by the model corresponds exactly to a date in
time. We begin the model in 1970 by creating an initial cohort of
individuals who enter the model on the 1st January 1970. We then
simulate these individuals through time until death, as described above.
From 1975 onwards, we expose our HIV-negative individuals to an annual
age and sex specific hazard of acquiring HIV. This hazard updates each
year and is specified by estimates from Kenya extracted from the UNAIDS
Spectrum Software, developed by the Futures
Institute[[*link*](http://www.unaids.org/en/dataanalysis/datatools/spectrumepp2013/)].
We allow HIV-tests to be scheduled from 2004 onwards to simulate the
rollout of HIV-testing in Kenya. ART also becomes available in 2004 for
eligible individuals. Treatment guidelines in 2004 are a CD4 count of
\<200 or WHO Stage IV{WorldHealthOrganization:2005ws}. This is updated
in 2011 to a CD4 count of \<350 or WHO Stage III/IV as per Kenyan
Guidelines{WorldHealthOrganization:2010wj}.

When all individuals who were part of the initial cohort beginning in
1970 have died, the model then creates a new cohort of individuals that
enter the model in 1971. The size of this cohort is determined by the
size of the previous cohort adjusted for population growth reported from
Kenya between 1970 and 1971 by the World Bank[[*World
Bank*](http://data.worldbank.org/indicator/SP.POP.TOTL/countries/KE?page=6&display=default)].
This cohort is then simulated until all individuals are terminated. This
process repeats each year between 1970 and 2030 where the model
finishes. After 2013, we hold the population growth rate constant and
after 2015 we hold the hazard of HIV acquisition constant as this was
the last estimate from Spectrum.

1.3 - C++ / R Interface
-----------------------

The model, while written in C++, is controlled through R. We use R to
pass a series of arguments to the model, including: the population size,
the initial time and any interventions that we wish to implement along
with the time at which to implement them. We access our C code through R
using a wrapper function .Call() after compiling our model in C using a
couple of R specific headers:

R.h

Rdefines.h

Rinternals.h

In our C++ code, the arguments passed from R appear as R objects of the
datatype SEXP (S-expression). Our C++ code takes SEXPs as inputs and
returns SEXPs as outputs. Therefore, we must create an output matrix
using S-expressions and fill in a row per individual that is simulated
using an output array that captures the desired information from each
individual.

<span id="h.vulgnhh4e9tu" class="anchor"></span>E.g. in C++

// Create an S-expression cohort;

SEXP cohort;

// Allocate a matrix to cohort which contains numeric vectors, nPersons
tall and nOutputs wide, and protect it (this prevents it from being
deleted by the garbage collector in C);

PROTECT(cohort = allocMatrix(REALSXP, nPersons, nOutputs));

// Create a pointer to cohort;

double \*ptr\_cohort = REAL(cohort);

// When each individual terminates, in row i for individual i, for each
output j, fill in column j of cohort using the variable held in
myout[j];

for(int j=0; j\<nOutputs; j++)

ptr\_cohort[i+j\*(nPersons)] = myout[j];

When this has been completed for every individual in the simulation, the
completed cohort matrix is return to R. Further details on calling C
functions from R can be found in “Advanced R” by Hadley Wickham
(2014)[[*link*](http://adv-r.had.co.nz/C-interface.html)].

2 - Natural History Model
=========================

2.1 - Structure
---------------

Now we have covered how the model is designed and how the code is
structured, we can explain the events that individuals can encounter. As
previously mentioned, individuals enter the model as HIV-negative and
are exposed to an annual hazard of acquiring HIV which is age and sex
specific. Upon acquiring HIV, the individual is assigned an initial CD4
count category (\<200, 200-350, 350-500, \>500 cells/μl) by sampling
from a uniform distribution such that 58% of individuals are in
the \>500 CD4 category, 23% in the 350-500 category, 16% in the 200-350
category and 3% in the \<200 category{Lodi:2011fg}. Individuals
acquiring HIV are assumed to begin with WHO Clinical Stage I
infection{WorldHealthOrganization:1990wd}. We capture HIV progression by
describing CD4 count decline through our four categories and the
acquisition of WHO Stage defining conditions. Progression to the next
health state (e.g. from \>500 WHO Stage I) is modelled by scheduling a
time to progress to the next CD4 category (e.g. 350-500 WHO Stage I) and
scheduling a time to progress to the next WHO stage (e.g. \>500 WHO
Stage II). These hazards compete and the event that happens first is
executed and prevails. Additionally, in each health state, individuals
are exposed to a CD4 category / WHO Stage specific HIV-related mortality
hazard (e.g using the same example, mortality in \>500 WHO Stage I).
This hazard, as before, competes with the hazards of CD4 decline and WHO
Stage progression. This mortality rate schedules an HIV-related death
date; this is in addition to the natural death date. If the model
encounters the HIV-related death date prior to encountering the natural
death date, the individual is said to have died from an HIV-related
death. The natural death date sets the upper bound on life span but HIV
can reduce life-years-lived considerably.

![](media/image42.png)

*Figure 1. Model Representation of The Natural History Model*

All individuals acquiring HIV first progress through the pre-ART side of
the Natural History Model; shown in figure 1. Once individuals receive a
CD4 test result confirming their eligibility for ART in the Cascade
Model (explained in detail below), if they adhere to ART, they
transition to the on-ART side of the Natural History model. Propensity
to adhere to ART is an innate characteristic that is determined for each
individual at initialisation. When transitioning to the on-ART side of
the Natural History model, individuals stay in the same health status
category but switch sides of the model (i.e. when an individual with CD4
\<200 and in WHO Stage III on the pre-ART side of the model initiates
ART, they move into the \<200 WHO Stage III category of the On-ART
Model). The pre-ART and on-ART sides of the Natural History Model are
shown in figure 1.

Once an individual moves to the on-ART side of the Natural History
model, CD4 count decline reverses and patients can recover from their
WHO Stage defining conditions. It should be noted that WHO Stage
conditions can still develop on this side of the model; thus allowing
the model to capture potential failures of treatment among patients
adhering to ART. If a patient’s CD4 count falls below 500 cells/μl prior
to ART initiation, if this patient subsequently initiates ART, their CD4
count will not recover to more than 500 cells/μl. This assumption was
made in response to findings by Lawn *et al.* (2006) illustrating CD4
count reconstitution among patients initiating ART in Cape Town, South
Africa{Lawn:2006ht}. As with mortality hazards on the pre-ART side of
the Natural History model, mortality hazards are associated with each
health status category on the on-ART side of the model. The mortality
hazard for a particular health status category on the on-ART side of the
model is less than the same health status category on the pre-ART side
of the model, thereby giving ART a survival advantage (explained in more
detail in the calibration section). Below is a description of each model
parameter:

  **Parameter**       **Definition**
  ------------------- ------------------------------------------------------------------------------------------------------
  **y~p1~**           Pre-ART CD4 progression rate from \>500 to 350-500 cells/μl (\# individuals per year)
  **y~p2~**           Pre-ART CD4 progression rate from 350-500 to 200-350 cells/μl (\# individuals per year)
  **y~p3~**           Pre-ART CD4 progression rate from 200-350 to \<200 cells/μl (\# individuals per year)
  **β~pA~**           Weight applied to Pre-ART CD4 progression rate for patients in WHO Stage III
  **β~pB~**           Weight applied to Pre-ART CD4 progression rate for patients in WHO Stage IV
  **S~1~**            WHO Stage progression rate from Stage I to II (\# individuals per year)
  **S~2~**            WHO Stage progression rate from Stage II to III (\# individuals per year)
  **S~3~**            WHO Stage progression rate from Stage III to IV (\# individuals per year)
  **α~A~**            Weight applied to WHO Stage progression rate for patients in CD4 category \<200
  **α~B~**            Weight applied to WHO Stage progression rate for patients in CD4 category \>500
  **μ~1~^\>500^**     Pre-ART Mortality rate for CD4 category \>500 and WHO Stage I (\# individuals per year)
  **μ~1~^350-500^**   Pre-ART Mortality rate for CD4 category 350-500 and WHO Stage I (\# individuals per year)
  **μ~1~^200-350^**   Pre-ART Mortality rate for CD4 category 200-350 and WHO Stage I (\# individuals per year)
  **μ~1~^\<200^**     Pre-ART Mortality rate for CD4 category \<200 and WHO Stage I (\# individuals per year)
  **μ~2~^\>500^**     Pre-ART Mortality rate for CD4 category \>500 and WHO Stage II (\# individuals per year)
  **μ~2~^350-500^**   Pre-ART Mortality rate for CD4 category 350-500 and WHO Stage II (\# individuals per year)
  **μ~2~^200-350^**   Pre-ART Mortality rate for CD4 category 200-350 and WHO Stage II (\# individuals per year)
  **μ~2~^\<200^**     Pre-ART Mortality rate for CD4 category \<200 and WHO Stage II (\# individuals per year)
  **μ~3~^\>500^**     Pre-ART Mortality rate for CD4 category \>500 and WHO Stage III (\# individuals per year)
  **μ~3~^350-500^**   Pre-ART Mortality rate for CD4 category 350-500 and WHO Stage III (\# individuals per year)
  **μ~3~^200-350^**   Pre-ART Mortality rate for CD4 category 200-350 and WHO Stage III (\# individuals per year)
  **μ~3~^\<200^**     Pre-ART Mortality rate for CD4 category \<200 and WHO Stage III (\# individuals per year)
  **μ~4~^\>500^**     Pre-ART Mortality rate for CD4 category \>500 and WHO Stage IV (\# individuals per year)
  **μ~4~^350-500^**   Pre-ART Mortality rate for CD4 category 350-500 and WHO Stage IV (\# individuals per year)
  **μ~4~^200-350^**   Pre-ART Mortality rate for CD4 category 200-350 and WHO Stage IV (\# individuals per year)
  **μ~4~^\<200^**     Pre-ART Mortality rate for CD4 category \<200 and WHO Stage IV (\# individuals per year)
  **𝛕**               Weight applied to Pre-ART mortality rates in on-ART model; giving survival advantage to on-ART model
  **ɣ**               Weight applied to WHO Stage progression rates in on-ART model
  **y~2~**            On-ART CD4 reconstitution rate from 200-350 to 350-500 cells/μl (\# individuals per year)
  **y~3~**            On-ART CD4 reconstitution rate from \<200 to 200-350 cells/μl (\# individuals per year)
  **β~A~**            Weight applied to On-ART CD4 reconstitution rate for patients in WHO Stage III
  **β~B~**            Weight applied to On-ART CD4 reconstitution rate for patients in WHO Stage IV
  **r~1~**            On-ART WHO Stage recovery rate from WHO Stage II to I (\# individuals per year)
  **r~2~**            On-ART WHO Stage recovery rate from WHO Stage III to II (\# individuals per year)
  **r~3~**            On-ART WHO Stage recovery rate from WHO Stage IV to III (\# individuals per year)

<span id="h.wae02lx642yr" class="anchor"></span>Table 1. Natural History
Model Parameters

2.2 - Calibration
-----------------

Calibration of the Natural History model was undertaken by prototyping a
deterministic version of the pre-ART and on-ART models in Berkeley
Madonna and fitting to data using the least squares
method[[*link*](http://www.berkeleymadonna.com/)]. A review of the
literature was conducted to identify relevant studies that would enable
us to calibrate every aspect of the Natural History Model. Where
possible, data from cohort studies was utilised; although, in some
situations data from observational studies was used. Data was sought to
parameterise every aspect of the Natural History. Below is a list of
data sources identified:

![](media/image32.png)

<span id="h.48oapnpergjp" class="anchor"></span>Table 2. Data sources
for Natural History pre-ART model fitting

![](media/image34.png)

<span id="h.3bzgrxmclrwc" class="anchor"></span>Table 3. Data sources
for Natural History on-ART model fitting

Once data was identified for calibrating both the pre-ART and on-ART
Natural History models, the data needed to be weighted to ensure that
each dataset had equal influence during calibration.

Therefore, if we consider the following:

> $\varepsilon_{\text{ij}} = \ \frac{\left| D_{\text{ij}}\  - \ M_{\text{ij}} \right|}{D_{\text{ij}}}$
> (1)

Where $\varepsilon_{\text{ij}}\ $is the proportion of model error for
data point $j$ in study $i$, $D_{\text{ij}}$ refers to the value of
datapoint $j$ in study $i$ and $M_{\text{ij}}$ refers to the value of
the model at datapoint $j$ in study $i$. It then follows that $e_{i}$,
the average proportion of model error for study $i$ is:

> $e_{i} = \ \frac{1}{n_{i}}\varepsilon_{\text{ij}}$ (2)

Where $n_{i}$ is the total number of data points in study $i$.
Therefore, the total error across all studies, can be represented by:

> $E\  = \ e_{i}$ (3)

Now considering (1), we can re-write (3), where $k$ is the total number
of datasets, as:

> $E\  = \ \frac{1}{n_{i}}\ \frac{{(D_{\text{ij}}\  - \ M_{\text{ij}})}^{2}}{D_{\text{ij}}}$
> (4)
>
> $\ \ E\  = \ \ \frac{1}{n_{i}\ D_{\text{ij}}}{\ (D_{\text{ij}}\  - \ M_{\text{ij}})}^{2}$
> (5)
>
> $\ \ E\  = \ \ w_{\text{ij}}{\ (D_{\text{ij}}\  - \ M_{\text{ij}})}^{2}$
> where $w_{\text{ij}} = \ \frac{1}{n_{i}\ D_{\text{ij}}}$ (6)
>
> $\ \ E\  = \ \ _{\text{ij}}{(D_{\text{ij}}\  - \ M_{\text{ij}})}^{2}$
> where $\ _{i} = \frac{1}{n_{i}}\frac{1}{D_{\text{ij}}}$ (7)

In (6) $w_{\text{ij}}$ refers to the weight of datapoint $j$ in study
$i$. In (7), ${}_{i}$ is therefore the weight of the entire dataset in
study $i$. Using the definitions of $w_{\text{ij}}$ and ${}_{i}$ in (6)
and (7), the weight for each data point ($w_{\text{ij}}$) was
calculated. This was not possible in all cases as some datasets
contained several hundred data points, in such cases a weight for the
dataset as a whole (${}_{i}$) was used. [*not sure if I need to include
a table of weights for each dataset?*]

Owing to the variety of data identified in tables 2 and 3, and to
account for any data sources that may conflict, parameter estimation
involved using least squares to find a compromise between conflicting
data sources, and to find a model fit that minimised the
root-mean-square error (RMSE) between the model and data. Berkeley
Madonna’s “Curve Fit” function allows the user to input a range of
parameters, supply upper and lower bounds, and then fit the model to
data while minimising the RMSE.

In the background, Berkeley Madonna uses a searching algorithm to
estimate values of the independent variable ŷ at time t, ŷ~t~, by taking
the sum of the mean square error for study i in n studies. Taking the
average by dividing by n, taking the square root and multiplying by the
minimum value of the parameter to be estimated p. Thus the least square
estimate of parameter $$ becomes:

> $\  = \ \min_{p}\ \ $ (8)

The value of variable y is a function of time t and the parameter p to
be estimated.

  **Parameter**       **Value**   **Mean (years)**
  ------------------- ----------- ------------------
  **y~p1~**           0.1253      7.9816
  **y~p2~**           0.3715      2.6919
  **y~p3~**           0.3578      2.7946
  **β~pA~**           1.4142      -
  **β~pB~**           3.3361      -
  **S~1~**            0.2771      3.6084
  **S~2~**            0.2221      4.5018
  **S~3~**            0.4056      2.4655
  **α~A~**            1.0000      -
  **α~B~**            0.0323      -
  **μ~1~^\>500^**     0.0002      4100.2024
  **μ~1~^350-500^**   0.0069      145.1224
  **μ~1~^200-350^**   0.0529      18.8954
  **μ~1~^\<200^**     0.0918      10.8967
  **μ~2~^\>500^**     0.0124      80.7345
  **μ~2~^350-500^**   0.0331      30.1923
  **μ~2~^200-350^**   0.0608      16.4528
  **μ~2~^\<200^**     0.1800      5.5556
  **μ~3~^\>500^**     0.0435      23.0061
  **μ~3~^350-500^**   0.0889      11.2443
  **μ~3~^200-350^**   0.1134      8.8193
  **μ~3~^\<200^**     0.3000      3.3333
  **μ~4~^\>500^**     0.1255      7.9669
  **μ~4~^350-500^**   0.2547      3.9263
  **μ~4~^200-350^**   0.3615      2.7660
  **μ~4~^\<200^**     1.2362      0.8090
  **𝛕**               0.8943      -
  **ɣ**               0.9369      -
  **y~2~**            2.2402      0.4464
  **y~3~**            5.7582      0.1737
  **β~A~**            0.6301      -
  **β~B~**            0.1227      -
  **r~1~**            2.1197      0.4718
  **r~2~**            3.1014      0.3224
  **r~3~**            26.4328     0.0378

<span id="h.6eygjapwzlwh" class="anchor"></span>**Table 4. Fitted
parameter values for Natural History Model**

The figures below, show comparisons between the calibrated Natural
History model and the data sources shown in tables 2 and 3.

![](media/image43.png)

![](media/image41.png)

![](media/image36.png)

![](media/image39.png)
======================

3 - Cascade Model
=================

3.1 - Structure
---------------

The Cascade Model describes the events that make up an ART-programme in
sub-Saharan Africa. The model describes the flow of individuals and
captures all possible routes through care. The structure of the Cascade
Model is show in figure 2. As discussed previously, individuals enter
the model as care naïve and HIV-negative. The Natural History Model
tracks HIV progression over time and assigns dynamic HIV-related
mortality rates. The Natural History model interacts with the Cascade
Model by driving care-seeking behaviour and by allowing patients to
initiate ART if their health status deems them to be eligible.

As the model begins with care naïve individuals, all persons start in
the “never engaged in care” state on the left-hand side of figure 2.
With HIV-testing starting in 2004, individuals can start to progress
through HIV-care. HIV-testing can occur through one of three routes:
HBCT where individuals are sought and tested at home, VCT where
individuals voluntarily attend an HIV-clinic or PICT where individuals
seek care due to being symptomatic or having had previous healthcare
experience. If an individual is found to be HIV-negative, they do not
progress any further through care. They may be tested multiple times
through their lives and care will only progress if they are found to be
HIV-positive.

Once identified as HIV-positive, individuals must be linked to care to
be bled for an initial CD4 count. Linkage involves travelling to a
nearby clinic, and depending upon the route of entry to care
(HBCT/VCT/PICT) a proportion of tested individuals will be lost prior to
their initial CD4 test. Individuals lost from care can re-engage at a
later date, either by being picked up through HBCT, voluntarily
appearing at VCT clinic or upon the onset of HIV-related symptoms
seeking care through PICT. However for individuals that successfully
link to pre-ART care, these patients see a clinician and blood is drawn
for an initial CD4 count. These CD4-tests are typically lab-based and
have a turnaround time of around two weeks{Larson:2012dq}. Therefore,
patients must return at a later date to receive the results of their CD4
test, in which their eligibility for ART is determined.

Unfortunately, a proportion of individuals are lost between being bled
for their initial CD4 test and returning to receive the results. These
individuals, like those who were unsuccessful in linking to care, can
re-engage at a later date through being tested via HBCT or VCT, or if
symptomatic, through PICT. The individuals who were not lost from care
after being bled for their initial CD4 test, return to the clinic to
receive their CD4 results. However, on the day of the clinic
appointment, a small proportion fail to attend and are lost. Of those
that attend the initial CD4 test result appointment, these individuals
learn of their eligibility for treatment. If a patient is found to be
ineligible for treatment at this time, they must be retained in pre-ART
care until such a time as they are found to be eligible for treatment.
Pre-ART retention involves returning after a period of time, usually 6
months to a year, to receive a secondary CD4 test. During this period a
certain proportion of individuals will be lost from care, but can
subsequently re-engage as described before. Of patients that return for
a secondary CD4 test, these individuals will have blood drawn and will
need to return at a later date to receive the results. As before, a
certain proportion of patients will not return to receive the results
and will be lost from care. This cycle of pre-ART care for HIV-positive
patients continues until the results of a CD4 count reveal that a
patient is eligible for treatment. When this occurs, a patient will be
allowed to initiate ART after a small period of time during which they
will receive ART counselling.

Upon initiating ART, the patient will either adhere or not adhere to
treatment. The propensity of a patient to adhere to ART is an innate
characteristic of each individual. Whether an individual is adhering or
not to ART, they are assumed to be in ART care. These individuals are
exposed to a hazard of dropping out of ART, where treatment would stop.
This hazard changes over time, depending upon the time since ART
initiation. If a patient drops out of ART care, treatment stops, and for
adherent individuals, their health would begin to deteriorate again.
Yet, patients failing to adhere to treatment, do not receive any health
benefits from ART; as such their health is declining as if they were not
on treatment. Therefore, if a non-adhering patient was to drop out of
ART care, their health would continue to deteriorate as before. Once
lost from ART care, patients can only re-engage with care and treatment
if identified through an outreach programme.

![](media/image38.png)

<span id="h.pvxkvbdxxebv" class="anchor"></span>Figure 2. Model
Representation of The Cascade of Care

3.2 - Calibration
-----------------

To calibrate the Cascade Model describing the experience of HIV-positive
individuals as they move through the various stages of HIV care, we
utilised a unique high resolution longitudinal dataset from western
Kenya. The Academic Model for Providing Access To Healthcare (AMPATH),
based in Eldoret, is made up of Moi University, Moi Teaching and
Referral Hospital and a consortium of North American academic health
centers led by Indiana University working in partnership with the
Government of Kenya.

AMPATH’s ability to look back at the care history of individual
patients, through tracing their unique identification number allowed us
to ask very specific questions regarding the flow of individuals through
care. The list of questions submitted to AMPATH is shown in table 5.

<span id="h.jn837bmr9sgj" class="anchor"></span>Table 5. Data request
submitted to AMPATH for the purposes of calibrating the Cascade
Model![](media/image22.png)

To capture fluctuations in the dynamics of care over time, we asked for
data to be split into three discrete time periods:

1.  ***Time split 1*** - (01/01/2007 to 31/12/2009) - This time period
    > will inform us about the state of care prior to HBCT, when only
    > VCT and PICT were available, and utilises data from the earliest
    > possible point in time.

2.  ***Time split 2*** - (01/01/2010 to 31/12/2010) - This time period
    > covers the initial rollout of HBCT in the community prior to the
    > adoption of new treatment guidelines in 2011.

3.  ***Time split 3*** - (01/01/2011 to 03/06/2014) - This time period
    > covers the state of care after the adoption of new treatment
    > guidelines in 2011 (CD4 \<350 or WHO Stage III/IV), together with
    > the full perpetual HBCT rollout as part of the FLTR programme.

Two definitions were used to separate a “gap in care” from “lost from
care”, for pre-ART care a period of 90 days must elapse after a clinic
appointment for an individual to be considered lost from care. While in
ART care, an individual was considered to be disengaged with care if
they had a gap in care of more than 1 year. These definitions allowed us
to separate individuals into those currently engaged or disengaged with
care and understand the time delay between events.

Owing to the large volume of data contained within the AMRS and the need
to merge multiple datasets in order to answer the specific questions
listed in table 5, we were only able to receive data from the Port
Victoria catchment area of AMPATH clinics (shown in blue circle in
figure 3). This dataset contains information on 3,788 HIV-positive
individuals tracked between the 1st January 2007 and the 3rd June 2014.
To calibrate the Cascade Model, the data received from AMPATH was split
into two groups: input parameters and calibration points. The questions
placed into each category are shown in the last column of table 5.

![](media/image23.jpg)

<span id="h.19ze1eqppm72" class="anchor"></span>Figure 3. Map of
Ministry of Health-AMPATH Clinic Sites in western Kenya. Port Victoria
is number 26 (blue circle).

Calibration began by adding the input parameter values to the model.
Model outputs were then designed to produce identical metrics to the
calibration point data (e.g. CD4 distribution of individuals initiating
ART in each time split, as in question *Art1*). With model output
metrics matching the calibration point data, fitting was conducted by
hand. Calibration was done systematically, starting with data regarding
the state of care at the end of 2009. According to AMPATH, 62% of
HIV-positive individuals were diagnosed, with ⅔ diagnosed through PICT
services and the remaining ⅓ through VCT. By adjusting the baseline rate
of seeking care through VCT and the health care seeking rates driving
individuals to seek care through PICT, we matched these values exactly
as shown below in figure 4.

![](media/image37.png)

<span id="h.gzje1jvo6re" class="anchor"></span>Figure 4. Awareness of
HIV status at end of 2009 - Cascade Model calibration result

With knowledge of AMPATH’s HBCT programme rollout in 2010, followed by
the addition of the FLTR programme where HBCT becomes perpetual
(home-team does not leave an area until everyone is tested, resulting in
100% coverage), we looked at the proportion of individuals entering
through each of the three routes into care over the three time splits
and compared AMPATH data to model outputs. We modelled HBCT rollout in
2010 but with 100% coverage obtained immediately. As can be seen in
figure 5, we over represent the impact of HBCT in 2010 but much more
closely match the fit in the third time split (2011 to 2014).

![](media/image40.png)

<span id="h.9kcmn59zn56w" class="anchor"></span>Figure 5. Distribution
of individuals among the three routes into care - Cascade Model
calibration result

The CD4 distribution of individuals entering care was then compared
between the data and the model output. Figure 6, illustrates the results
with the proportion of individuals entering care through VCT and PICT
with low CD4 counts increasing in the last time split in the data
[**WHY!?**], this is not captured by the model [Further investigation
pending].

![](media/image12.png)

<span id="h.iaf8ky62bmrx" class="anchor"></span>Figure 6. CD4 count
distribution at entry to care - Cascade Model calibration result

The CD4 distribution among individuals initiating ART was then
considered. This distribution is altered by changes in treatment
guidelines, treatment seeking rates and the natural history of HIV. As
can be seen in figure 7, the model currently does not match the AMPATH
data correctly. Many individuals initiate ART in AMPATH with very high
CD4 counts, this is due to a high prevalence of opportunistic
infections, something that the model doesn’t capture [**YET, still
working on it!**].

![](media/image24.png)

<span id="h.9bp2t2wtsoga" class="anchor"></span>Figure 7. CD4 count
distribution at ART initiation - Cascade Model calibration result

Finally, the proportion of HIV-positive individuals initiating ART per
year was compared between data and model output. We can see from figure
8, that in the first time split (2007 to 2010), the model fails to
capture the 7% or so of individuals initiating ART [**Still working on
this calibration, stay tuned!**].

![](media/image35.png)

<span id="h.jqsnqmcjy3cr" class="anchor"></span>Figure 8. Proportion of
HIV-positive individuals initiating ART per year - Cascade Model
calibration result

Next, HIV-prevalence was compared to national estimates from the Kenya
AIDS Indicator Survey
2007[[*KAIS*](http://www.nacc.or.ke/nacc%20downloads/official_kais_report_2009.pdf)].
Figure 9, shows the results stratified by gender.

<span id="h.w914n23ednqb"
class="anchor"></span>![](media/image33.png)Figure 9. Comparison of
HIV-prevalence in the model to KAIS 2007 estimates - Cascade Model
calibration result

Then, the model was compared to data from the more recent KAIS 2012
study. Model outputs were compared to national HIV-prevalence estimates
as well as estimates from Nyanza Province [**Port Victoria is actually
in the Western Province!**], shown in figures 10 and 11 respectively.

<span id="h.2xlrjhoyjoul"
class="anchor"></span>![](media/image02.png)Figure 10. Comparison of
HIV-prevalence in the model to National KAIS 2012 estimates - Cascade
Model calibration result

<span id="h.zgsmlmlfl9dh"
class="anchor"></span>![](media/image10.png)Figure 11. Comparison of
HIV-prevalence in the model to KAIS 2012 estimates from Nyanza
Province - Cascade Model calibration result

Finally, the model was compared HIV-prevalence estimates from UNAIDS and
also the proportion of HIV-related deaths among total population over
time, shown on the left and right side of figure 12 respectively.

<span id="h.dm5c2k8s57pc"
class="anchor"></span>![](media/image11.png)Figure 12. Comparison to
HIV-prevalence estimates over time from UNAIDS (left), comparison of the
proportion of AIDS-related deaths out of the total population to UNAIDS
(right) - Cascade Model calibration result

***Note: Cascade model calibration is still ongoing, hence figures 4 to
12 and currently placeholders.***

4 - Cost Derivation
===================

Costs in the model were broken down into individual components. This was
done to ensure that different events could easily be compared; for
example, the cost of a HBCT visit would be composed of the visit cost
plus the cost of a rapid HIV-test. The majority of costs, including the
cost of ART care, pre-ART clinic visits and CD4 lab-based tests, were
derived from a multi-country analysis of 161 treatment facilities across
five countries in sub-Saharan
Africa[[*MATCH*](http://thedata.harvard.edu/dvn/dv/chaighf/faces/study/StudyPage.xhtml?studyId=85882&tab=catalog)].
The remaining costs were sourced from the literature. All costs are
shown in table 6. A flow diagram of of these costs accumulate to
describe the cost of HIV-care is shown in the following sections.

![](media/image09.png)

<span id="h.o629aetzqibz" class="anchor"></span>Table 6. Cost of HIV
care illustrating the source and GDP deflator (NGDP\_D) calculations to
adjust for country and inflation. Values shown in bold are used in the
model.

5 - DALY Weighting
==================

The health benefits afforded by ART are summarised as DALYs averted,
which capture the direct effects of ART in prolonging life and from
reducing HIV transmission. The disability weights used in this model
were sourced from the Global Burden of Disease Study 2010, comparing
life-years lived in different health states to full health, values used
as shown in table 7{Salomon:2012ib}. It is assumed that untreated
HIV-infection with a CD4 count of \>350 cells/μl carries the same weight
as an HIV-positive individual receiving ART.

  **Health State**                                       **Disability Weight**
  ------------------------------------------------------ -----------------------
  HIV-positive, CD4 count \>350 cells/μl (untreated)     0.053
  HIV-positive, CD4 count 200-350 cells/μl (untreated)   0.221
  HIV-positive, CD4 count \<200 cells/μl (untreated)     0.547
  HIV-positive, on ART                                   0.053

<span id="h.962dcdfqitkq" class="anchor"></span>Table 7. Disability
weights by health state

6 - Intervention Detail
=======================

The 12 interventions designed to impact at various points along the
cascade are shown in table 8. These interventions can be grouped into:
testing interventions, linkage interventions, pre-ART retention
interventions, ART interventions and large scale sweeping change
interventions. Where possible, each intervention has two scenarios: a
“maximum impact” scenario illustrating the best possible impact of the
intervention and a “realistic impact” scenario which aims to demonstrate
the impact of a more obtainable intervention. The cost of each
intervention is shown in the last column of table 8. Where no additional
costs are applied for an intervention, costs may be incurred due to the
additional life-years spent on ART or HIV/CD4 tests that occur after an
intervention is applied. A flow diagram illustrating how costs
accumulate in the model, together with the cost of interventions is
shown in figure 12. Interventions were implemented in the model from
2010 onwards and their impact on DALYs averted, costs accrued and the
care experience of individuals dying from HIV-related deaths quantified.

![](media/image27.png)

<span id="h.58sf00s78t4i" class="anchor"></span>Table 8. Summary of
interventions applied from 2010 to 2030. [INCLUDE REFERENCES]

![](media/image13.jpg)

<span id="h.7bbva1q09hbb" class="anchor"></span>Figure 12. Flow diagram
illustrating how baseline costs accumulate and interact with the
additional costs applied by interventions in the Cascade Model

7 - Intervention Impact on Incidence

Prior to 2010, HIV incidence is entirely driven by the age and sex
specific hazard of acquiring HIV sourced from the Spectrum software by
the Futures
Institute[[*link*](http://www.unaids.org/en/dataanalysis/datatools/spectrumepp2013/)].
While the model does not include a full transmission component, we model
the impact of our interventions on incident cases by weighting the
infectiousness of HIV-positive individuals each year, taking the sum of
these individuals and multiplying that by a baseline transmission
probability that we define in a reference year, when incidence has
stabilised (2002).

To identify our baseline transmission probability in 2002 𝛃~(2002)~ we
look at the proportion of incident cases out of the weighted total of n
health categories containing HIV-positive individuals of infectiousness
i with infectiousness weight w (infectiousness weights are shown in
table 9).

> $\beta_{(2002)}\  = \frac{\text{New\ Infections}}{w_{i}\  \cdot \ \text{HIV\ individuals}_{i}}$
> (9)

With 𝛃~(2002)~ fixed we rearrange (9) to calculate the number of new
infections per year after 2010 as follows:

> $New\ Infections\  = \beta_{(2002)}\  \cdot \ (w_{i}\  \cdot \ \text{HIV\ individuals}_{i}\ )$
> (10)

  **Health State Category**                              **Infectiousness Weight *(w)***   **Source**
  ------------------------------------------------------ --------------------------------- -----------------------------------------------------------------------------------------------------------------
  HIV-positive, CD4 count \>500 cells/μl (untreated)     1.35                              Based on 3 months with acute infection and 6.25 years at CD4 \>500, and 10-fold infectious with acute infection
  HIV-positive, CD4 count 350-500 cells/μl (untreated)   1.00                              Reference
  HIV-positive, CD4 count 200-350 cells/μl (untreated)   1.64                              Donnell *et al.* (2010)
  HIV-positive, CD4 count \<200 cells/μl (untreated)     5.17                              Donnell *et al.* (2010)
  HIV-positive, on ART                                   0.1                               Estimate

<span id="h.2j7tqsq477xh" class="anchor"></span>Table 9. Infectiousness
weights by health state
