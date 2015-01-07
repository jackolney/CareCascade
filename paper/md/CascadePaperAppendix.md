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

***7** – HIV Incidence*

***7.1** – Pre-2002*

***7.2** – Post-2002*

1 - Model Description
=====================

An individual-based microsimulation was created in C++ to model the care
experience of HIV-positive individuals concurrently with HIV-progression
and associated mortality in western Kenya. The model is more easily
described as two interacting submodels: The Natural History Model and
The Cascade Model.

1.1 - Model Design
------------------

The model was designed to describe the population of Kenya over time
from 1970 to 2030. This was accomplished by creating an initial cohort
of individuals in 1970 with a predefined size and age distribution to
mimic that of the population of Kenya in 1970. Thereafter new
individuals enter the model after birth at various time points to
replicate population growth.

As individuals are created, they are assigned a gender, an age, HIV
serostatus and a natural death date among other characteristics. Gender
is assigned through sampling from a uniform distribution to obtain a 1:1
ratio of Males:Females{CentralIntelligenceAgency:2013up}. Age is
assigned by randomly sampling from a uniform distribution between 0 and
1. However, if an individual enters the model in 1970, then their age is
matched to the age distribution in Kenya in
1970[[*UNPop*](http://esa.un.org/unpd/wpp/Excel-Data/population.htm)].
All individuals enter the model with an HIV-negative serostatus. Natural
death dates are then sampled from sex-stratified survival distributions
derived from mortality rates from Kenya, extracted from the United
Nations Population Division
Database[[*UNPop*](http://www.un.org/en/development/desa/population/)].

The model simulates the lives of individuals concurrently until death.
During the lifetime of a patient many types of events can occur. As
mentioned previously, a natural death date is assigned to each
individual; signifying the last event that will occur in that particular
individual’s lifespan. Yet, as each individual moves through time they
encounter events that alter their situation (i.e. they are diagnosed
with HIV). As an individual’s situation changes, new events may occur
(i.e. they initiate ART). Thus, this individual-based model allows
events to be scheduled and excuted dynamically dependings on time and
the particular characteristics of a patient.

The model is a time-to-event simulation, meaning that there is no
specific time-step, but rather the model contains a chronologically
ordered queue of events that are stepped through. When an individual is
created, the model is aware of the calendar time point at which they
enter and can calculate the natural death date by taking into
consideration the number of years an individual will live (extracted
from the survival distributions described above). This date is then
pushed into our queue of events, which reshuffles, ensuring that the
next event is the one with the smallest interval in time from the
current model time. Events can be scheduled at any time and pushed into
the queue.

Upon creating an individual, the model runs through a series of
functions to schedule various events (e.g. an HIV-test). These events
are scheduled if certain criteria are met: the current time must be
correct (i.e. an individual will not be scheduled to initiate ART in
1975 if HIV-testing in Kenya was not rolled out until 2004), the
individual’s health status must also meet certain criteria (i.e. an
individual cannot initiate ART if they are not HIV-positive) and finally
the individual’s care status must be correct (i.e. an individual is not
allowed to initiate ART if they have never entered care). The time delay
between events is calculated by sampling a random deviate from an
exponential distribution with a mean value derived from the data
(explained in calibration section). As events are scheduled for
individuals, dates are pushed into the queue along with a pointer to
that particular individual, thereby allowing the model to simulate many
individuals and events simultaneously.

As the model runs, it extracts the next event due to occur from the top
of the event queue, checks that it is still valid, and if so executes it
before updating the current model time and extracting another event from
the queue. Events can take the form of natural history events (such as
the birth or death of an individual) or HIV care related events (such as
an HIV-test or ART initiation). The only requirements of the event queue
are that each event carries with it a time, a validity check and the
ability to be executed. The validity check is used to ensure that no
relevant changes have occurred to the system between the time the event
was scheduled and executed. For instance, if an individual is scheduled
to receive a CD4 test result but is lost from care before the CD4 test
result event occurs, the event is invalidated and not executed. After an
event is executed, the model checks to see if any further events need to
be scheduled (e.g. an individual received a CD4 test result confirming
their eligibility for treatment). These new events are then pushed into
the queue as required and the model carries on scheduling and executing
events until the current time reaches 2030. At this point the model
stops executing events and pushes back a list of vectors containing
output metrics from the simulation.

1.2 - Calendar Time
-------------------

As previously mentioned, the model runs in calendar time. That is to say
that each date generated by the model corresponds exactly to a date in
time. We begin the model in 1970 by creating an initial cohort of
individuals who each enter the model sometime between the 1^st^ January
and the 31^st^ of December 1970. At the beginning of each subsequent
year, a new cohort of individuals is created who each enter the model at
a random time throughout the year so that we capture population growth.
As time progresses, new individuals enter the model, old individuals die
and are removed, and events are executed.

We model the initial spread of HIV infection among our population by
using incidence estimates from the UNAIDS Spectrum Software, developed
by the Futures
Institute[[*link*](http://www.unaids.org/en/dataanalysis/datatools/spectrumepp2013/)].
We use the number of incident cases of HIV per year to determine how
many HIV-negative individuals will contract HIV. We then use incidence
rate-ratios stratified by age and sex to distribute these infections
randomly by age and sex. Infections are then scheduled to occur at a
random point within the year such that the total incidence for the year
follows that described by the data from Spectrum. We allow HIV-tests to
be scheduled from 2004 onwards to simulate the rollout of HIV-testing in
Kenya. ART also becomes available in 2004 for eligible individuals.
Treatment guidelines in 2004 are a CD4 count of \<200 or WHO Stage
IV{WorldHealthOrganization:2005ws}. This is updated in 2011 to a CD4
count of \<350 or WHO Stage III/IV as per Kenyan
Guidelines{WorldHealthOrganization:2010wj}.

1.3 - C++ / R Interface
-----------------------

The model, while written in C++, is controlled through R. We use R to
pass a series of arguments to the model, including: the population size
and any interventions that we wish to implement. We access our C code
through R using the wrapper function .Call() after compiling our model
in C using GCC.

In our C++ code, the arguments passed from R appear as R objects of the
datatype SEXP (S-expression). Our C++ code takes SEXPs as inputs and
returns SEXPs as outputs. Therefore, we must create an output dataframe,
consisting of a list of vectors that is returned from to R at the end of
our simulation. Further details on calling C functions from R can be
found in “Advanced R” by Hadley Wickham
(2014)[[*link*](http://adv-r.had.co.nz/C-interface.html)].

2 - Natural History Model
=========================

2.1 - Structure
---------------

Now we have covered how the code is structured, we can explain the
details of the model in a little more detail. As previously mentioned,
individuals enter the model as HIV-negative, with incidence being driven
by data from Spectrum that defines the number of new infections per
year; this is then split up among individuals of different age and sex
through IRR’s and randomised to individuals within each age and sex
category. Upon acquiring HIV, an individual is assigned an initial CD4
count category (\<200, 200-350, 350-500, \>500 cells/μl) by sampling
from a uniform distribution such that 58% of individuals are in
the \>500 CD4 category, 23% in the 350-500 category, 16% in the 200-350
category and 3% in the \<200 category{Lodi:2011fg}. Individuals
acquiring HIV are assumed to begin with WHO Clinical Stage I
infection{WorldHealthOrganization:1990wd}. We capture HIV progression by
describing CD4 count decline through our four categories and the
acquisition of WHO Stage defining conditions. Progression to the next
health state (e.g. from \>500 WHO Stage I), is modelled by scheduling a
time to progress to the next CD4 category (e.g. 350-500 WHO Stage I),
and scheduling a time to progress to the next WHO stage (e.g. \>500 WHO
Stage II). These hazards compete and the event that occurs first is
executed and prevails. Additionally, in each health state, individuals
are exposed to a CD4 / WHO Stage specific HIV-related mortality hazard
(e.g using the same example, mortality in \>500 WHO Stage I). This
hazard, as before, competes with the hazards of CD4 decline and WHO
Stage progression. This mortality rate schedules an HIV-related death
date; this is in addition to the natural death date. If the model
encounters the HIV-related death date prior to encountering the natural
death date, the individual is said to have died from an HIV-related
death. The natural death date sets the upper bound on life span but HIV
can reduce life-years-lived considerably.

![](media/image1.emf)

*Figure 1. Model Representation of The Natural History Model*

All individuals acquiring HIV first progress through the pre-ART side of
the Natural History Model (figure 1). Once individuals receive a CD4
test result confirming their eligibility for ART in the Cascade Model
(explained in detail below), if they adhere to ART, they transition to
the on-ART side of the Natural History model. Propensity to adhere to
ART is an innate characteristic that is determined for each individual
at initialisation. When transitioning to the on-ART side of the Natural
History model, individuals stay in the same health status category but
switch sides of the model (i.e. when an individual with CD4 \<200 and in
WHO Stage III on the pre-ART side of the model initiates ART, they move
into the \<200 WHO Stage III category of the On-ART Model). The pre-ART
and on-ART sides of the Natural History Model are shown in figure 1.

Once an individual moves to the on-ART side of the Natural History
model, CD4 count decline reverses and patients can recover from their
WHO Stage defining conditions. It should be noted that WHO Stage
conditions can still develop on this side of the model; thus allowing
the model to capture potential failures of treatment among patients
adhering to ART. If a patient’s CD4 count falls below 500 cells/μl prior
to ART initiation and this patient subsequently initiates ART, their CD4
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

  Parameter           DefinitionDefinition
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
  **τ**               Weight applied to Pre-ART mortality rates in on-ART model; giving survival advantage to on-ART model
  **ɣ**               Weight applied to WHO Stage progression rates in on-ART model
  **y~2~**            On-ART CD4 reconstitution rate from 200-350 to 350-500 cells/μl (\# individuals per year)
  **y~3~**            On-ART CD4 reconstitution rate from \<200 to 200-350 cells/μl (\# individuals per year)
  **β~A~**            Weight applied to On-ART CD4 reconstitution rate for patients in WHO Stage III
  **β~B~**            Weight applied to On-ART CD4 reconstitution rate for patients in WHO Stage IV
  **r~1~**            On-ART WHO Stage recovery rate from WHO Stage II to I (\# individuals per year)
  **r~2~**            On-ART WHO Stage recovery rate from WHO Stage III to II (\# individuals per year)
  **r~3~**            On-ART WHO Stage recovery rate from WHO Stage IV to III (\# individuals per year)

<span id="h.wae02lx642yr" class="anchor"></span>Table 1. Natural History
Model Parameters<span id="h.gi684dpza8oo" class="anchor"></span>

2.2 - Calibration
-----------------

Calibration of the Natural History model was undertaken by prototyping a
deterministic version of the pre-ART and on-ART models in Berkeley
Madonna and fitting to data using least
squares[[*link*](http://www.berkeleymadonna.com/)]. To begin, a review
of the literature was conducted to identify relevant studies that would
enable us to calibrate every aspect of the Natural History Model. Where
possible, data from cohort studies was utilised; although, in some
situations data from observational studies was used. Data was sought to
parameterise every aspect of the Natural History. Below is a list of
data sources identified:

  Outcome                                                                Location                            Description                                                                                                                Conditions                                                                        Use in model                                                                                                               Reference
  ---------------------------------------------------------------------- ----------------------------------- -------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Pre-ART survival                                                       East Africa & South Africa          Survival function (calculated from model fits with Weibull distribution)                                                   25-29 years old, 4 years between last negative and first positive HIV test        Fitting pre-ART survival curve                                                                                             Todd J, Glynn JR, Marston M, *et al.* Time from HIV seroconversion to death: a collaborative analysis of eight studies in six low and middle-income countries before highly active antiretroviral therapy. *AIDS* 2007; **21 Suppl 6**: S55–63.
  CD4 count decline                                                      Europe                              Progression rates for each CD4 category (calculated by fitting compartmental model to estimates - Eaton, J & Fraser, C)    ≥16 years old, maximum of 3 years between last negative and first positive test   Fitting CD4 \>500 to 350-500 progression rate, 350-500 to 200-350 progression rate and 200-350 to \<200 progression rate   Lodi S, Phillips AN, Touloumi G, et al. Time from human immunodeficiency virus seroconversion to reaching CD4+ cell count thresholds. Clin Infect Dis 2011; 53: 817–25.
  Initial distribution of CD4 counts                                     Europe                              Distribution of individuals across CD4 categories after seroconversion (estimated by Eaton, J & Fraser, C)                 ≥16 years old, maximum of 3 years between last negative and first positive test   Initial distribution of individuals across pre-ART CD4 categories                                                          Lodi S, Phillips AN, Touloumi G, et al. Time from human immunodeficiency virus seroconversion to reaching CD4+ cell count thresholds. Clin Infect Dis 2011; 53: 817–25.
  Progression through WHO Clinical stages                                Vancouver                           Progression rates through WHO Clinical Stages                                                                              Seroincident homosexual men                                                       Fitting WHO I to WHO II progression rate, WHO II to WHO III progression rate and WHO III to WHO IV progression rate        Schechter MT, Le N, Craib KJ, Le TN, O'Shaughnessy MV, Montaner JSG. Use of the Markov model to estimate the waiting times in a modified WHO staging system for HIV infection. *J Acquir Immune Defic Syndr* 1995; **8**: 474&hyhen.
  Pre-ART mortality rates stratified by CD4 count & WHO Clinical Stage   Cape Town, South Africa             Mortality rates by CD4 count crossed with WHO Clinical Stage                                                               Individuals not receiving antiretroviral therapy (ART)                            Fitting pre-ART mortality rates by CD4 count and WHO Clinical Stage                                                        Badri M, Lawn SD, Wood R. Short-term risk of AIDS or death in people infected with HIV-1 before antiretroviral therapy in South Africa: a longitudinal study. *Lancet* 2006; **368**: 1254–9.
                                                                         Rural south-west Uganda             Median survival time from when first seen in a specific WHO Clinical Stage                                                 Seroconverted in last 7 years                                                     Fitting pre-ART survival by WHO Clinical Stage                                                                             Morgan D, Maude GH, Malamba SS, *et al.* HIV-1 disease progression and AIDS-defining disorders in rural Uganda. *Lancet* 1997; **350**: 245–50.
                                                                         Rural south-west Uganda             Median survival time from when first seen in a specific WHO Clinical Stage                                                 Seroconverted in last 7 years                                                     Fitting pre-ART survival by WHO Clinical Stage                                                                             Malamba SS, Morgan D, Clayton T, Mayanja BN, Okongo MJ, Whitworth JAG. The prognostic value of the World Health Organisation staging system for HIV infection and disease in rural Uganda. *AIDS* 1999; **13**: 2555–62.
  Person-time spent in each CD4 category and WHO Clinical Stage          Rakai, Uganda                       CD4 category distribution (\<200, \>200) stratified by WHO Clinical Stage (1 & 2, 3 & 4) and vice versa                    Not mentioned                                                                     Average person-time spent in each CD4 category, stratified by WHO Clinical Stage                                           Kagaayi J, Makumbi F, Nakigozi G, *et al.* WHO HIV clinical staging or CD4 cell counts for antiretroviral therapy eligibility assessment? An evaluation in rural Rakai district, Uganda. *AIDS* 2007; **21**: 1208–10.
                                                                         Addis Ababa, Ethiopia               CD4 category distribution (\<200, 200-499, \>500) stratified by WHO Clinical Stage (1,2,3,4) and vice versa                18-44 years old                                                                   Average person-time spent in each CD4 category, stratified by WHO Clinical Stage                                           Kassa E, Rinke de Wit TF, Hailu E, *et al.* Evaluation of the World Health Organization staging system for HIV infection and disease in Ethiopia: association between clinical stages and laboratory markers. *AIDS* 1999; **13**: 381–9.
                                                                         Jinja, Uganda                       CD4 category distribution (\<200, \>200 and \<350, \>350) stratified by WHO Clinical Stage (1 & 2, 3 & 4) and vice versa   None mentioned                                                                    Average person-time spent in each CD4 category, stratified by WHO Clinical Stage                                           Jaffar S, Birungi J, Grosskurth H, *et al.* Use of WHO clinical stage for assessing patient eligibility to antiretroviral therapy in a routine health service setting in Jinja, Uganda. *AIDS Res Ther* 2008; **5**: 4.
                                                                         Mengo, Jinja and Kasana in Uganda   CD4 category distribution (\<200, \>200 and \<350, \>350) stratified by WHO Clinical Stage (1,2,3,4) and vice versa        ≥18 years old and ART naïve                                                       Average person-time spent in each CD4 category, stratified by WHO Clinical Stage                                           Baveewo S, Ssali F, Karamagi CA, *et al.* Validation of World Health Organisation HIV/AIDS clinical staging in predicting initiation of antiretroviral therapy and clinical predictors of low CD4 cell count in Uganda. *PLoS ONE* 2011; **6**: e19089.
  Pre-ART mortality stratified by WHO Clinical Stage                     Rural south-west Uganda             Cumulative mortality at year 1 and year 4, crossed by WHO Clinical Stage                                                   Seroconverted in last 7 years                                                     Pre-ART cumulative mortality crossed by WHO Clinical Stage at year 1 and 4                                                 Morgan D, Maude GH, Malamba SS, *et al.* HIV-1 disease progression and AIDS-defining disorders in rural Uganda. *Lancet* 1997; **350**: 245–50.
                                                                         Rural south-west Uganda             Survival estimate at 6 years, crossed by WHO Clinical Stage                                                                Seroconverted in last 7 years                                                     Pre-ART survival at year 6, crossed by WHO Clinical Stage                                                                  Malamba SS, Morgan D, Clayton T, Mayanja BN, Okongo MJ, Whitworth JAG. The prognostic value of the World Health Organisation staging system for HIV infection and disease in rural Uganda. *AIDS* 1999; **13**: 2555–62.

<span id="h.48oapnpergjp" class="anchor"></span>Table 2. Data sources
for Natural History pre-ART model fitting

  Outcome                                                                                    Location                                 Description                                                                                                                                 Conditions                                                                                                                                                                         Use in model                                                                                                                                                                                                                                 Reference
  ------------------------------------------------------------------------------------------ ---------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Cumulative Mortality after ART initiation stratified by CD4 count and WHO Clinical Stage   South Africa, Malawi and Côte d’Ivoire   Cumulative mortality stratified by CD4 count and WHO Clinical Stage at 3, 6 and 12 months since ART initiation                              Predominantly female population. Median age 34 years. Median body weight of 55kg and median CD4 cell count of 111 cells/μl at baseline                                             Fitting weighted on-ART cumulative mortality stratified by CD4 count and WHO Clinical Stage. Back-calculated mortality rate also used in fitting                                                                                             May M, Boulle AM, Phiri S, et al. Prognosis of patients with HIV-1 infection starting antiretroviral therapy in sub-Saharan Africa: a collaborative analysis of scale-up programmes. Lancet 2010; 376: 449–57.
  Mortality rate after ART initiation stratified by CD4 count                                South Africa                             On-ART mortality rates stratified by CD4 count \<200 and \>200 for 0-1 year, 1-2 years, 2-3 years and 3-5 years after ART initiation        Mostly female population with a mean age of 25-35 years old and mean CD4 count of 100-199 cells/μl at baseline                                                                     Fitting a weighted average cumulative mortality rate for each period (0-1 year, 1-2 years, 2-3 years and 3-5 years), averaged across all WHO Clinical Stages                                                                                 Johnson LF, Mossong J, Dorrington RE, et al. Life expectancies of South African adults starting antiretroviral treatment: collaborative analysis of cohort studies. PLoS Med 2013; 10: e1001418.
  On-ART mortality rates stratified by CD4 count                                             Cape Town, South Africa                  Mortality rates after ART initiation, stratified by current CD4 count. Median follow-up time was 2.5 years.                                 Median age at baseline was 33 years, 67% of cohort were female with a median CD4 count of 101 cells/μl at baseline. 53% of cohort had WHO Clinical Stage III defining conditions   Fitting a weighted average on-ART mortality rate stratified by CD4 count at 2.5 years, averaged across all WHO Clinical Stages and weighted to replicate the distribution of CD4 counts and WHO Clinical Stages seen in this papers cohort   Lawn SD, Little F, Bekker L-G, et al. Changing mortality risk associated with CD4 cell response to antiretroviral therapy in South Africa. AIDS 2009; 23: 335–42.
  CD4 count recovery rates after initiation of ART                                           Cape Town, South Africa                  Estimates of CD4 cell count recovery extracted from figure and average time for CD4 count to reach next category from previous calculated   Median age at baseline was 32 years, 75% of cohort were female, median CD4 count was 97 cells/μl and 53% had WHO Clinical Stage III defining conditions                            Fitted on-ART CD4 count recovery rates: y~3~ (\<200 to 200-350) and y~2~ (200-350 to 350-500)                                                                                                                                                Lawn SD, Myer L, Bekker L-G, Wood R. CD4 cell count recovery among HIV-infected patients with very advanced immunodeficiency commencing antiretroviral treatment in sub-Saharan Africa. BMC Infect Dis 2006; 6: 59.

<span id="h.3bzgrxmclrwc" class="anchor"></span>Table 3. Data sources
for Natural History on-ART model fitting

These data were then weighted to ensure that each had equal influence
during model calibration. Therefore, if we consider the following:

> $\varepsilon_{\text{ij}} = \ \frac{\left| D_{\text{ij}}\  - \ M_{\text{ij}} \right|}{D_{\text{ij}}}$
> (1)

Where $\varepsilon_{\text{ij}}\ $is the proportion of model error for
data point $j$ in study $i$, $D_{\text{ij}}$ refers to the value of
datapoint $j$ in study $i$ and $M_{\text{ij}}$ refers to the value of
the model at datapoint $j$ in study $i$. It then follows that $e_{i}$,
the average proportion of model error for study $i$ is:

> $e_{i} = \ \frac{1}{n_{i}}\sum_{j = 1}^{n_{i}}\varepsilon_{\text{ij}}$
> (2)

Where $n_{i}$ is the total number of data points in study $i$.
Therefore, the total error across all studies, can be represented by:

> $E\  = \sum_{}^{}e_{i}$ (3)

Now considering (1), we can re-write (3), where $k$ is the total number
of datasets, as:

> $E\  = \ \sum_{i = 1}^{k}\frac{1}{n_{i}}\ \sum_{j = 1}^{n_{i}}\frac{{(D_{\text{ij}}\  - \ M_{\text{ij}})}^{2}}{D_{\text{ij}}}$
> (4)
>
> $\ \ E\  = \ \sum_{i = 1}^{k}{\sum_{j = 1}^{n_{i}}{\frac{1}{n_{i}\ D_{\text{ij}}}{\ (D_{\text{ij}}\  - \ M_{\text{ij}})}^{2}}}\ $
> (5)

$\ \ E\  = \ \sum_{i = 1}^{k}{\sum_{j = 1}^{n_{i}}{w_{\text{ij}}{\ (D_{\text{ij}}\  - \ M_{\text{ij}})}^{2}}}$
where $w_{\text{ij}} = \ \frac{1}{n_{i}\ D_{\text{ij}}}$ (6)

> $\ \ E\  = \ \sum_{i = 1}^{k}{{\ \overset{\overline{}}{w}}_{\text{ij}}\sum_{j = 1}^{n_{i}}{(D_{\text{ij}}\  - \ M_{\text{ij}})}^{2}}$
> where
> ${\ \overset{\overline{}}{w}}_{i} = \frac{1}{n_{i}}\sum_{j = 1}^{n_{i}}\frac{1}{D_{\text{ij}}}$
> (7)

In (6) $w_{\text{ij}}$ refers to the weight of datapoint $j$ in study
$i$. In (7), ${\overset{\overline{}}{w}}_{i}$ is therefore the weight of
the entire dataset in study $i$. Using the definitions of
$w_{\text{ij}}$ and ${\overset{\overline{}}{w}}_{i}$ in (6) and (7), the
weight for each data point ($w_{\text{ij}}$) was calculated. This was
not possible in all cases as some datasets contained several hundred
data points, in such cases a weight for the dataset as a whole
(${\overset{\overline{}}{w}}_{i}$) was used. [*not sure if I need to
include a table of weights for each dataset?*]

Owing to the variety of data identified and to account for any data
sources that may conflict, parameter estimation involved using least
squares to find a compromise between conflicting data sources, and to
find a model fit that minimised the root-mean-square error (RMSE)
between the model and data. Berkeley Madonna’s “Curve Fit” function
allows the user to input a range of parameters, supply upper and lower
bounds, and then fit the model to data while minimising the RMSE.

In the background, Berkeley Madonna uses a searching algorithm to
estimate values of the independent variable ŷ at time t, ŷ~t~, by taking
the sum of the mean square error for study i in n studies. Taking the
average by dividing by n, taking the square root and multiplying by the
minimum value of the parameter to be estimated p. Thus the least square
estimate of parameter $\overset{\overline{}}{p}$ becomes (where the
value of variable y is a function of time t and the parameter p to be
estimated):

> $\overset{\overline{}}{p}\  = \ \min_{p}\ \sqrt{\frac{1}{n}\sum_{i}^{n}{(y_{i}\  - {y\hat{}}_{i})}^{2}}\ $
> (8)

  Parameter           Value     Mean (years)
  ------------------- --------- --------------
  **y~p1~**           0.1253    7.9816
  **y~p2~**           0.3715    2.6919
  **y~p3~**           0.3578    2.7946
  **β~pA~**           1.4142    -
  **β~pB~**           3.3361    -
  **S~1~**            0.2771    3.6084
  **S~2~**            0.2221    4.5018
  **S~3~**            0.4056    2.4655
  **α~A~**            1.0000    -
  **α~B~**            0.0323    -
  **μ~1~^\>500^**     0.0002    4100.2024
  **μ~1~^350-500^**   0.0069    145.1224
  **μ~1~^200-350^**   0.0529    18.8954
  **μ~1~^\<200^**     0.0918    10.8967
  **μ~2~^\>500^**     0.0124    80.7345
  **μ~2~^350-500^**   0.0331    30.1923
  **μ~2~^200-350^**   0.0608    16.4528
  **μ~2~^\<200^**     0.1800    5.5556
  **μ~3~^\>500^**     0.0435    23.0061
  **μ~3~^350-500^**   0.0889    11.2443
  **μ~3~^200-350^**   0.1134    8.8193
  **μ~3~^\<200^**     0.3000    3.3333
  **μ~4~^\>500^**     0.1255    7.9669
  **μ~4~^350-500^**   0.2547    3.9263
  **μ~4~^200-350^**   0.3615    2.7660
  **μ~4~^\<200^**     1.2362    0.8090
  **𝛕**               0.8943    -
  **ɣ**               0.9369    -
  **y~2~**            2.2402    0.4464
  **y~3~**            5.7582    0.1737
  **β~A~**            0.6301    -
  **β~B~**            0.1227    -
  **r~1~**            2.1197    0.4718
  **r~2~**            3.1014    0.3224
  **r~3~**            26.4328   0.0378

<span id="h.6eygjapwzlwh" class="anchor"></span>**Table 4. Fitted
parameter values for Natural History Model**

The results of calibrating the Natural History model to data are shown
in the following figures:

![](media/image2.emf)![](media/image3.emf)![](media/image4.emf)![](media/image5.emf)![](media/image6.emf)![](media/image7.emf)![](media/image8.emf)![](media/image9.emf)![](media/image10.emf)![](media/image11.emf)![](media/image12.emf)![](media/image13.emf)![](media/image14.emf)![](media/image15.emf)![](media/image16.emf)![](media/image17.emf)![](media/image18.emf)![](media/image19.emf)![](media/image20.emf)![](media/image21.emf)![](media/image22.emf)![](media/image23.emf)![](media/image24.emf)![](media/image25.emf)

<span id="h.zfe6nawv4mjv" class="anchor"></span>

3 - Cascade Model
=================

3.1 - Structure
---------------

The Cascade Model describes the events that make up an ART-programme in
western Kenya (figure 2). It captures all possible routes through care
and provides insight into the flow of individuals into and out of HIV
care. As discussed previously, individuals enter the model as care naïve
and HIV-negative. The Natural History Model tracks HIV progression over
time and assigns dynamic HIV-related mortality rates. The Natural
History model interacts with the Cascade Model by driving care-seeking
behaviour and by allowing patients to initiate ART if their health
status deems them to be eligible.

As the model begins with care naïve individuals, all persons start in
the “never engaged in care” state on the left-hand side of figure 2.
With HIV-testing starting in 2004, individuals start to progress through
HIV-care. HIV-testing can occur through one of three routes: HBCT
(home-based counselling and testing) where individuals are sought and
tested at home, VCT (voluntary counselling and testing) where
individuals voluntarily attend an HIV-clinic or PICT (provider-initiated
counselling and testing) where individuals seek care due to being
symptomatic or having had previous healthcare experience. If an
individual is found to be HIV-negative, they do not progress any further
through care. They may be tested multiple times throughout their lives
and care will only progress if they are found to be HIV-positive.

Once identified as HIV-positive, individuals must “link” to care where
they are seen by a clinician and are bled for an initial CD4 count.
Linkage involves travelling to a nearby clinic, and depending upon the
route of entry to care, a proportion of tested individuals will be lost
prior to their initial CD4 test. Individuals lost from care can
re-engage at a later date, either by being picked up through HBCT,
voluntarily appearing at a VCT clinic or upon the onset of HIV-related
symptoms, seeking care through PICT. For patients that successfully link
to pre-ART care, these individuals see a clinician who draws blood for
an initial CD4 count. These CD4-tests are typically lab-based and have a
turnaround time of around two weeks{Larson:2012dq}. Therefore, patients
must return at a later date to receive the results of their CD4 test, in
which their eligibility for treatment can be determined.

Unfortunately, a certain proportion of individuals are lost between
being bled for their initial CD4 test and returning to receive the
results. These individuals, like those who were unsuccessful in linking
to care, can re-engage at a later date through being tested via HBCT or
VCT, or if symptomatic, through PICT. The individuals, who were not lost
from care after being bled for their initial CD4 test, return to the
clinic to receive their CD4 results. However, on the day of the clinic
appointment, a small proportion fails to attend and is lost. Of those
that attend the initial CD4 test result appointment, individuals learn
of their eligibility for treatment and if a patient is found to be
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

Upon initiating ART, the patient will either adhere to treatment and
achieve viral suppression or not adhere and continue to suffer declining
health. The propensity of a patient to adhere to ART is an innate
characteristic of each individual. Whether an individual is adhering or
not to ART, they are assumed to be in ART care. These individuals are
exposed to a hazard of dropping out of ART, whereupon treatment ceases.
This hazard changes over time, depending upon the time since ART
initiation. If a patient drops out of ART care, treatment stops, and for
adherent individuals, their health would begin to deteriorate again.
Yet, patients failing to adhere to treatment, do not receive any health
benefits from ART; as such their health declines as if they were not on
treatment. Therefore, if a non-adhering patient were to drop out of ART
care, their health would continue to deteriorate as before. Once lost
from ART care, patients can only re-engage with care and treatment if
identified through an outreach programme.

![](media/image26.png)<span id="h.pvxkvbdxxebv" class="anchor"></span>
Figure 2. Model Representation of The Cascade of Care

3.2 - Calibration
-----------------

To calibrate the Cascade Model, we utilised a unique longitudinal
dataset from western Kenya. The Academic Model for Providing Access To
Healthcare (AMPATH), based in Eldoret, is made up of Moi University, Moi
Teaching and Referral Hospital and a consortium of North American
academic health centers led by Indiana University working in partnership
with the Government of Kenya. AMPATH was initiated in 2001 with an
initial goal to “establish an HIV care system to serve the needs of both
urban and rural patients and to assess the barriers to and outcomes of
antiretroviral therapy”{Braitstein:2012bt}. Since then AMPATH clinics
have enrolled \>140,000 HIV-infected adults and children across multiple
sites in western Kenya{Braitstein:2012bt}.

With a well established VCT and PICT programme, AMPATH launched a pilot
HBCT programme in 2010 in Kosirai and Turbo before rolling out perpetual
HBCT in 2011 to all AMPATH clinic catchment areas ensuring perfect
coverage of testing to the community{Kimaiyo:2010tq}[
[*http://news.medicine.iu.edu/releases/2014/05/ampath-abbvie-hiv-testing.shtml*](http://news.medicine.iu.edu/releases/2014/05/ampath-abbvie-hiv-testing.shtml)].
Together with a network-wide database capturing the information of every
patient encountered (known as the AMRS, the AMPATH Medical Record
System), AMPATH are able to provide unique insight into the inner
workings of an HIV care system in sub-Saharan Africa. Their ability to
look back at the care history of individual patients, through tracing
their unique identification number allowed us to ask very specific
questions regarding the flow of individuals through care. Our data
request is detailed in table 5 below:

  Question type    Question                                                                                                                                                                            Stratified by                                        Use in model
  ---------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------------------------- -------------------
  Testing          The proportion of individuals that enter care through HBCT, VCT and PICT                                                                                                            CD4 count at entry to care                           Calibration point
  Linkage          The proportion of tested persons who are bled for an initial CD4 test within one month of HIV-test                                                                                  Route of entry to care                               Input parameter
                   Mean time between HIV-test and initial CD4 test (days)                                                                                                                              Route of entry to care, CD4 count at entry to care   Input parameter
                   Mean CD4 count at first CD4 measurement                                                                                                                                             Route of entry to care                               Calibration point
                   Proportion of individuals who received 1^st^ CD4 test returning for test results within one month of test                                                                           Route of entry to care, CD4 count at entry to care   Input parameter
                   Mean time between initial CD4 test and receiving test result (days)                                                                                                                 Route of entry to care, CD4 count at entry to care   Input parameter
  Retention        Mean time between receiving results of CD4 test and being bled for next CD4 test (days)                                                                                             Route of entry to care                               Input parameter
                   Proportion that ever return for secondary CD4 test prior to ART eligibility                                                                                                         Route of entry to care                               Input parameter
                   Mean number of secondary CD4 test appointments prior to becoming eligible for treatment                                                                                             Route of entry to care                               Calibration point
                   Mean gap between secondary CD4 test appointments (days)                                                                                                                             Route of entry to care                               Input parameter
                   Proportion of individuals returning to receive results of secondary CD4 tests                                                                                                       Route of entry to care                               Input parameter
                   Mean time to return to care if lost between CD4 test and receiving CD4 test results (days)                                                                                          Route of entry to care                               Calibration point
                   Mean CD4 count when receiving secondary CD4 test results                                                                                                                            Route of entry to care                               Calibration point
  ART Initiation   Mean CD4 count at ART initiation                                                                                                                                                    Route of entry to care                               Calibration point
                   Mean time to ART initiation from becoming eligible for treatment (days)                                                                                                             Route of entry to care                               Input parameter
                   Mean number of pre-ART clinic visits prior to ART initiation                                                                                                                        Route of entry to care                               Calibration point
                   Proportion of patients initiating ART after diagnosis and successful retention in care until becoming eligible for treatment                                                        Route of entry to care                               Calibration point
                   Mean time from positive HIV-test to initiating ART for patients diagnosed and successfully retained in care until becoming eligible for treatment (days)                            Route of entry to care                               Calibration point
                   Proportion of patients initiating ART at their enrolment visit                                                                                                                      Route of entry to care                               Calibration point
                   Mean time from HIV-test to initiating ART for patients initiating ART at their enrolment visit (days)                                                                               Route of entry to care                               Calibration point
                   Proportion of patients initiating ART after diagnosis, subsequent loss form pre-ART care (i.e. had at least one CD4 count) but returning prior to becoming eligible for treatment   Route of entry to care                               Calibration point
                   Mean time to initiating ART after diagnosis, subsequent loss from pre-ART care but returning prior to becoming eligible for treatment (days)                                        Route of entry to care                               Calibration point
                   Proportion of patients initiating ART after diagnosis, subsequent loss form pre-ART care and returning when already eligible for treatment                                          Route of entry to care                               Calibration point
                   Mean time to initiating ART after diagnosis, subsequent loss from pre-ART care and returning when already eligible for treatment (days)                                             Route of entry to care                               Calibration point
                   Proportion of patients initiating ART who had previously been on ART                                                                                                                Route of entry to care                               Calibration point
  ART Retention    Mortality rate \<1yr after ART initiation for patients retained in care (deaths/ppy)                                                                                                (not currently used in model)                        Input parameter
                   Mortality rate \>1yr after ART initiation for patients retained in care (deaths/ppy)                                                                                                (not currently used in model)                        Input parameter
                   Dropout rate from ART care \<1yr after ART initiation (dropout/ppy)                                                                                                                 -                                                    Input parameter
                   Dropout rate from ART care \>1yr after ART initiation (dropout/ppy)                                                                                                                 -                                                    Input parameter
                   Of patients lost from ART care, proportion that will ever return                                                                                                                    (not currently used in model)                        Input parameter
                   Among those returning to ART care following LTFU on ART, CD4 count at re-entry to care                                                                                              (not currently used in model)                        Calibration point
                   Among those lost from ART care, mean time to return to ART care (days)                                                                                                              (not currently used in model)                        Calibration point
                   Incidence of inter-clinic transfer                                                                                                                                                  (not currently used in model)                        -

<span id="h.jn837bmr9sgj" class="anchor"></span>Table 5. Data request
submitted to AMPATH for the purposes of calibrating the Cascade Model

To capture longitudinal fluctuations in the dynamics of care, we asked
for data to be split into three discrete time periods:

1.  ***Time split 1*** - (01/01/2007 to 31/12/2009) - This time period
    will inform us about the state of care prior to HBCT, when only VCT
    and PICT were available, and utilises data from the earliest
    possible point in time.

2.  ***Time split 2*** - (01/01/2010 to 31/12/2010) - This time period
    covers the initial rollout of HBCT in the community prior to the
    adoption of new treatment guidelines in 2011.

3.  ***Time split 3*** - (01/01/2011 to 03/06/2014) - This time period
    covers the state of care after the adoption of new treatment
    guidelines in 2011 (CD4 \<350 or WHO Stage III/IV), together with
    the full perpetual HBCT rollout as part of the Find, Link, Treat,
    Retain (FLTR) programme.

Two definitions were used to separate a “gap in care” from “lost from
care”, for pre-ART care a period of 90 days must elapse after a clinic
appointment for an individual to be considered lost from care. While for
ART care, an individual was considered disengaged from care if they had
a gap in care of more than 1 year. These definitions allowed us to
separate individuals into those currently engaged or disengaged with
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

![](media/image27.jpg)

<span id="h.19ze1eqppm72" class="anchor"></span>Figure 3. Map of
Ministry of Health-AMPATH Clinic Sites in western Kenya. Port Victoria
is number 26 (blue circle).

Calibration began by adding the input parameter values to the model.
Model outputs were then designed to produce identical metrics to the
calibration point data (e.g. CD4 distribution of individuals initiating
ART in each time split). With model output metrics matching the
calibration point data, fitting was conducted by hand. Calibration was
done systematically, starting with data regarding the state of care at
the end of 2009. According to AMPATH, 62% of HIV-positive individuals
were diagnosed, with ⅔ diagnosed through PICT services and the remaining
⅓ through VCT. By adjusting the baseline rate of seeking care through
VCT and the health care seeking rates driving individuals to seek care
through PICT, we matched these values exactly as shown below in figure
4.

![](media/image28.emf)

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

<span id="h.9kcmn59zn56w" class="anchor"></span> Figure 5. Distribution
of individuals among the three routes into care - Cascade Model
calibration result

The CD4 distribution of individuals entering care was then compared
between the data and the model output. Figure 6, illustrates the results
with the proportion of individuals entering care through VCT and PICT
with low CD4 counts increasing in the last time split in the data, but
this is not captured by the model.

<span id="h.iaf8ky62bmrx" class="anchor"></span> Figure 6. CD4 count
distribution at entry to care - Cascade Model calibration result

The CD4 distribution among individuals initiating ART was then
considered. This distribution is altered by changes in treatment
guidelines, treatment seeking rates and the natural history of HIV. As
can be seen in figure 7, the model currently does not match the AMPATH
particularly well. Many individuals initiate ART in AMPATH with very
high CD4 counts, this is due to a high prevalence of opportunistic
infections, something that the model doesn’t capture.

<span id="h.9bp2t2wtsoga" class="anchor"></span>Figure 7. CD4 count
distribution at ART initiation - Cascade Model calibration result

Finally, the proportion of HIV-positive individuals initiating ART per
year was compared between data and model output. We can see from figure
8, that in the first time split (2007 to 2010), the model fails to
capture the 7% of individuals initiating ART.

<span id="h.jqsnqmcjy3cr" class="anchor"></span> Figure 8. Proportion of
HIV-positive individuals initiating ART per year - Cascade Model
calibration result

Next, HIV-prevalence was compared to national estimates from the Kenya
AIDS Indicator Survey
2007[[*KAIS*](http://www.nacc.or.ke/nacc%20downloads/official_kais_report_2009.pdf)].
Figure 9, shows the results stratified by gender.

![](media/image29.emf)![](media/image30.emf)<span id="h.w914n23ednqb"
class="anchor"></span> Figure 9. Comparison of HIV-prevalence in the
model to KAIS 2007 estimates - Cascade Model calibration result

![](media/image31.emf)![](media/image32.emf)Then, the model was compared
to data from the more recent KAIS 2012 study. Model outputs were
compared to national HIV-prevalence estimates as well as estimates from
Nyanza Province and Western Province, shown in figures 10 to 12.

<span id="h.2xlrjhoyjoul"
class="anchor"></span>![](media/image33.emf)![](media/image34.emf)Figure
10. Comparison of HIV-prevalence in the model to National KAIS 2012
estimates - Cascade Model calibration result<span id="h.zgsmlmlfl9dh"
class="anchor"></span>

Figure 11. Comparison of HIV-prevalence in the model to KAIS 2012
estimates from Nyanza Province - Cascade Model calibration result

![](media/image35.emf)![](media/image36.emf) Figure 12. Comparison of
HIV-prevalence in the model to KAIS 2012 estimates from Western
Province - Cascade Model calibration result

![](media/image37.emf)![](media/image38.emf)Finally, the model was
compared HIV-prevalence estimates from UNAIDS and also the proportion of
HIV-related deaths among total population over time, shown on the left
and right side of figure 13, respectively.

<span id="h.dm5c2k8s57pc" class="anchor"></span>Figure 12. Comparison to
HIV-prevalence estimates over time from UNAIDS (left), comparison of the
proportion of AIDS-related deaths out of the total population to UNAIDS
(right) - Cascade Model calibration result

4 - Cost Derivation
===================

Costs were broken down into individual components. This was done to
ensure that different events could easily be compared; for example, the
cost of a HBCT visit would be composed of the visit cost plus the cost
of a rapid HIV-test. The majority of costs, including the cost of ART
care, pre-ART clinic visits and CD4 lab-based tests, were derived from
the MATCH Study, a multi-country analysis of 161 treatment facilities
across five countries in sub-Saharan
Africa[[*MATCH*](http://thedata.harvard.edu/dvn/dv/chaighf/faces/study/StudyPage.xhtml?studyId=85882&tab=catalog)].
The remaining costs were sourced from the literature. All costs are
shown in table 6. A flow diagram describing how these costs accumulate
over the course of a patient’s time in HIV-care is shown in the
following sections.

  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  **Source**               **Item**                     **Country**    **Original Year**   **Cost in original year**   **GDP Deflator in original year**   **GDP Deflator in 2013**   **Difference**   **Adjusted Cost**   **Average **        **Previous value**
                                                                                                                                                                                                                                               
                                                                                                                                                                                                                           **(if required)**   
                                                                                                                                                                                                                                               
  ------------------------ ---------------------------- -------------- ------------------- --------------------------- ----------------------------------- -------------------------- ---------------- ------------------- ------------------- --------------------
  Wright (2004)            Rapid HIV-test               Zambia         2003                \$2.00                      178.22                              569.53                     391.31           ***\$10***          **-**               \$3

  Larson (2012)            POC CD4 test                 South Africa   2010                \$23.76                     145.077                             169.826                    24.749           ***\$30***          **-**               \$25

  Barnabas (unpublished)   HBCT home visit              South Africa   2013                \$8.46                      169.826                             169.826                    0                ***\$8***           **-**               \$8

  CHAI MATCH               CD4-test (lab)               Ethiopia       2010                \$7.11                      90.517                              160.574                    70.057           \$12                ***\$12***          \$7

                                                        Malawi         2010                \$7.21                      126.448                             196.915                    70.467           \$12                                    

                                                        Rwanda         2010                \$6.28                      140.213                             167.404                    27.191           \$8                                     

                                                        Zambia         2010                \$6.20                      444.354                             569.53                     125.176          \$14                                    

                           Pre-ART Clinic Appointment   Ethiopia       2010                \$6.64                      90.517                              160.574                    70.057           \$11                ***\$28***          \$15

                                                        Malawi         2010                6.89                        126.448                             196.915                    70.467           \$12                                    

                                                        Rwanda         2010                19.61                       140.213                             167.404                    27.191           \$25                                    

                                                        Zambia         2010                28.56                       444.354                             569.53                     125.176          \$64                                    

                           ART Cost                     Ethiopia       2010                \$158.00                    90.517                              160.574                    70.057           \$269               ***\$367***         \$206

                                                        Malawi         2010                \$124.00                    126.448                             196.915                    70.467           \$211                                   

                                                        Rwanda         2010                \$245.00                    140.213                             167.404                    27.191           \$312                                   

                                                        Zambia         2010                \$300.00                    444.354                             569.53                     125.176          \$676                                   
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

<span id="h.o629aetzqibz" class="anchor"></span>Table 6. Cost of HIV
care, illustrating the source and GDP deflator calculations to adjust
for country and inflation. Values shown in bold are used in the model.

5 - DALY Weighting
==================

The health benefits afforded by ART are summarised as DALYs averted,
which capture the direct effects of ART in prolonging life and from
reducing HIV transmission. The disability weights used in this model
were sourced from the Global Burden of Disease Study 2010, comparing
life-years lived in different health states to full health, values used
as shown in table 7{Salomon:2012ib}. It is assumed that untreated
HIV-infection with a CD4 count of \>350 cells/μl carries the same weight
as an HIV-positive individual receiving ART. Upon death from HIV, an
individual carries a disability weight of one until they reach their
natural death date.

  Health State                                           Disability Weight
  ------------------------------------------------------ -------------------
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
intervention and a “realistic impact” scenario, which aims to
demonstrate the impact of a more obtainable intervention. The cost of
each intervention is shown in the last column of table 8. Where no
additional costs are applied for an intervention, costs may be incurred
due to the additional life-years spent on ART or HIV/CD4 tests that
occur after an intervention is applied. A flow diagram illustrating how
costs accumulate in the model, together with the cost of interventions
is shown in figure 13. Interventions were implemented in the model from
2010 onwards and their impact on DALYs averted, costs accrued and the
care experience of individuals dying from HIV-related deaths quantified.

  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  **Intervention**                        **What happens at baseline**   **What this intervention does**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                **Cost**
  --------------------------------------- ------------------------------ ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------
                                                                         **Maximum Impact**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             **Realistic Impact**

  > **Testing Interventions**             **HBCT**                       People can be tested in VTC and can be tested when they present for care. The rates for these are determined by fitting to the data on routes of entry to care in AMPATH                                                                                                                                                                                                                                                                                                                                                                                                                       In an active year (every 4 years), 90% of the population are reached by testing in their home. 100% are linked to care.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

                                          **Enhanced VCT**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              There is a low rate of HIV testing among all people (mean time to test of 3.6 years), all of the time. This rate is equal to twice the rate of VCT at baseline.

  > **Linkage Interventions**             **HBCT **                      There is a chance that a person who receives an HIV test does not connect to the ART clinic and have a first appointment (defined as an initial staging CD4 cell count.)                                                                                                                                                                                                                                                                                                                                                                                                                       At HBCT, a POC CD4 test reduces the risk of not linking to zero (because first CD4 test is considered the beginning of pre-ART care (as it provides an opportunity when ART can start))
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
                                          **(with POC)**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

                                          **Facilitated linkage**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       The risk of failure-to-link is reduced to 0%.

                                          **VCT POC**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   At VCT, a PoC CD4 test is provided that effectively reduces the risk of not linking to zero (because the first CD4 test is considered the beginning of Pre-ART care, as it provides an opportunity when ART can start)

  > **Pre-ART Retention Interventions**   **Pre-ART outreach**           During the course of routine pre-ART scheduled appointments, a patient may fail to attend an appointment and subsequently cease attending any further pre-ART appointments. The risk of this loss is 20% each time the patient is scheduled to attend an appointment. There is a further risk that a patient, once bled for a CD4 measurement, does not return shortly (after 1 month) to receive the result and action against that result is delayed until the next scheduled appointment (if it occurs). The risk that a patient does not return to receive their results shortly is 56%.   In the middle of each year, 100% of all those persons who have tested for HIV but are not known to have initiated ART, and are not currently in care are returned to care.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

                                          **Improved care**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Services for the patient are improved such that the risk that a patient misses any appointment is reduced to 0%.

                                          **POC**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       The risk that a patient that does not receive their CD4 result shortly after being bled is reduced to 0%, as the bleeding and the result become instantaneous.

  > **ART Retention Interventions**       **On-ART outreach**            During the course of ART, persons may cease taking ART. The risk of this occurring is related to their current health status.                                                                                                                                                                                                                                                                                                                                                                                                                                                                  In the middle of each year, a fraction (100%) all those persons who have initiated ART and are not currently in care are returned to care. 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

                                          **Adherence**                  At ART initiation, 75% of individuals are flagged are 'adherers' to ART and will become virally suppressed                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     At ART initiation, 100% of individuals are flagged are 'adherers' to ART and will become virally suppressed

  > **Sweeping Changes**                  **Immediate ART**              ***-***                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        No pre-ART care. Treat anyone who tests at any venue.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        

                                          **Universal test and treat**   ***-***                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        HBCT + immediate ART initiation
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

<span id="h.58sf00s78t4i" class="anchor"></span>Table 8. Summary of
interventions applied from 2010 to 2030.

![](media/image39.emf)

<span id="h.7bbva1q09hbb" class="anchor"></span>Figure 13. Flow diagram
illustrating how baseline costs accumulate and interact with the
additional costs applied by interventions in the Cascade Model

7 – HIV Incidence

7.1 – Pre-2002
--------------

In the model, before the year 2010 HIV incidence is entirely driven by
estimates of incident cases sourced from the Spectrum software by the
Futures
Institute[[*link*](http://www.unaids.org/en/dataanalysis/datatools/spectrumepp2013/)].
Spectrum provides us with the number of incident infections that are
estimated to have occurred in a particular year (table 9). We then
divide these infections up by age and sex according to age and sex
specific incidence rate ratios (IRR’s) also provided by Spectrum (table
10).

  Year   Incident Cases
  ------ ----------------
  1970   0
  1971   0
  1972   0
  1973   0
  1974   0
  1975   0
  1976   0
  1977   0
  1978   0
  1979   0
  1980   140
  1981   355
  1982   1134
  1983   1791
  1984   3418
  1985   6444
  1986   11887
  1987   21704
  1988   38623
  1989   66784
  1990   108993
  1991   165074
  1992   226131
  1993   269547
  1994   275327
  1995   243681
  1996   195612
  1997   152571
  1998   121318
  1999   101327
  2000   99767
  2001   93594

Table 9. Incident cases of HIV per year, from Spectrum.

  Age category   Male       Female
  -------------- ---------- ----------
  0 to 4         0          0
  5 to 9         0          0
  10 to 14       0          0
  15 to 19       0.244859   0.431475
  20 to 24       0.790423   0.979206
  25 to 29       1          1
  30 to 34       0.989385   0.848891
  35 to 39       0.854318   0.684447
  40 to 44       0.670484   0.550791
  45 to 49       0.493512   0.440263
  50 to 54       0.358977   0.336719
  55 to 59       0.282399   0.239474
  60 to 64       0.259244   0.16789
  64 to 69       0.264922   0.146594
  70 to 74       0.254788   0.171352
  75 to 79       0.164143   0
  \>80           0          0

Table 10. Incident Rate Ratios (IRR’s) stratified by age and sex, from
Spectrum.

At the beginning of each year we calculate the number of new infections
(*I*) occurring in each age category (*a*) and sex category (*s*)
through the following equations:

$$I_{a,s} = \ \lambda \bullet S_{a,s} \bullet \text{IRR}_{a,s}$$

Where *S* is the number of susceptible individuals stratified by age
category (*a*) and sex category (*s*). IRR is the incidence rate ratio
for the corresponding age and sex category from table 10. λ is the
transmission rate and is calculated annually through dividing the number
of incident cases in the current year (from table 9) by the sum of all
susceptible individuals multiplied by their IRR in each age and sex
category as follows:

$$\lambda = \ \frac{\text{Incident\ Cases}}{\sum_{a,s}^{}\left( S_{a,s} \bullet \text{IRR}_{a,s} \right)}$$

7.2 – Post-2002
---------------

![](media/image40.emf)While the model does not include a full
transmission component, we model the impact of our interventions on
incident cases by weighting the infectiousness of HIV-positive
individuals and using that to derive incidence. The year 2002 is
significant as by this time incidence has already peaked and is
relatively stable as seen in the figure below:

Figure 14. HIV incidence in the model over time compared to the values
derived from Spectrum.

From the year 2002 onwards we allow incidence to be driven by the number
of HIV-positive individuals in the model weighted by their relative
infectiousness. Therefore, we calculate incident cases through the
following:

$$Incident\ Cases = \ \beta\ \sum_{\text{all\ k}}^{}{(w_{k} \bullet I_{k})}$$

Where β is the transmission probability, *w* is the infectiousness
weighting and *I* is the number of HIV-positive individuals in each
infectiousness category *k*, shown in table 11.

  Health State Category                                  Infectiousness Weight *(w)*   Source
  ------------------------------------------------------ ----------------------------- -----------------------------------------------------------------------------------------------------------------
  HIV-positive, CD4 count \>500 cells/μl (untreated)     1.35                          Based on 3 months with acute infection and 6.25 years at CD4 \>500, and 10-fold infectious with acute infection
  HIV-positive, CD4 count 350-500 cells/μl (untreated)   1.00                          Reference
  HIV-positive, CD4 count 200-350 cells/μl (untreated)   1.64                          Donnell *et al.* (2010)
  HIV-positive, CD4 count \<200 cells/μl (untreated)     5.17                          Donnell *et al.* (2010)
  HIV-positive, on ART                                   0.1                           Estimate

Table 11. Infectiousness weights by health state

However, before we switch to this new calculation of incident cases in
the model, we first need to calculate the transmission probability.
Therefore, we rearrange the above equation to the following and extract
the value of β on the 31^st^ of December 2001.

$$\beta = \ \frac{\text{Incident\ Cases}}{\sum_{\text{all\ k}}^{}{(w_{k} \bullet}I_{k})}$$

With the value of β calculated, we then alter the calculation of λ from
above to become:

$$\lambda = \ \frac{\text{β\ }\sum_{\text{all\ k}}^{}{(w_{k} \bullet I_{k})}}{\sum_{a,s}^{}\left( S_{a,s} \bullet \text{IRR}_{a,s} \right)}$$

This equation is used from 1^st^ January 2002 onwards and allows the
transmission rate to be controlled by the number of infectious
individuals in the model. λ is then used in the calculation of new
infections by age and sex category and replaces the previous definition
of λ in section 7.1. Thus, when interventions are rolled out in 2010,
the indirect impact of these interventions on reducing HIV incidence is
accounted for by allowing incidence to be driven by the number of
infected individuals circulating in the population<span
id="h.2j7tqsq477xh" class="anchor"></span>.
