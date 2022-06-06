*------------------------
/* Final Project - SOC 401-2: Spring 2022
   "Eating Disorders and New Media: Exploring Negative Article Valence 
    in U.S. News Coverage" */

* data_analyses_USA_EDandNM_SP22.do
* Created: 05/23/2022
* Valerie Gruest, Northwestern University
*------------------------


*------------------------
* Project Description
*------------------------

/* Project: "Eating Disorders and New Media: Exploring Negative Article Valence 
in U.S. News Coverage" 

   Original Dataset: ED & New Media 
    - Excluded 2 observations with missing values for DV - negative article 
	  valence (N=624)
	- Excluded 19 influential observations for the full logistic regression 
	  model (N=605)
   
   Research Questions: 
    1) RQ1. How does the negative valence of the relationship between eating 
	   disorders and new media in the news coverage change over time from 2010 
	   to 2019?
	2) RQ2. Is having specific eating disorder diagnoses, a)anorexia or 
	   b)bulimia, referenced in the article associated with a negative valence 
	   of the relationship between eating disorders and new media? 
	3) RQ3. Is having a specific social media platform, a)Facebook, b)Instagram, 
	   c)Tumblr or d)YouTube), referenced in the article associated with a 
	   negative valence of the relationship between eating disorders and new 
	   media?  

   
   Outcome I am estimating: Negative Article Valence 

   Key Variables:
	 - Dependent variable: 
		~ Article_Valence_Binary_Negative (binary)

	 - Independent variables: 
		~ Article_Year (continuous)
		~ ED_Anorexia (binary)
		~ ED_Bulimia (binary)
		~ NM_SM_Facebook (binary)
		~ NM_SM_Instagram (binary)
		~ NM_SM_Tumblr (binary)
		~ NM_SM_YouTube (binary)

	Missing Values: The only variable with missing data values was the variable 	
	referencing article valence, with 2 missing values accounting for 0.32% of 
	cases for the variable. This was corrected by dropping the two observations
	until further evaluation of why those two cases were missing from the raw 
	data. 
		
		
	Data files for project:
		~ raw_USA_EDandNM_v1.dta : Raw data for the project uploaded to
			Stata as a .dta file. This dataset contains the original variables
			and formatting of the USA dataset.
			This is the original dataset used to generate the clean and 
			subsetted data for the project, "edited_original_v1.dta".
			
		~ edited_original_USA_EDandNM_v1.dta : First edited version of the data 
			from the dataset. This version modified the "raw_USA_EDandNM_v1.dta" 
			data using Stata.
			This includes new variables, recoded variables (X) and handling of 
			missing values. 
			
			Changes were documented using the 
			"data_cleaning_USA_EDandNM_SP22.do" script. 
			
		~ edited_original_USA_EDandNM_v2.dta : Second edited version of the data 
			from the dataset. This version modified the 
			"edited_original_USA_EDandNM_v1.dta" data using Stata -
			subsetted the data I used for analyses, keeping only key variables:

		~ edited_original_USA_EDandNM_v3.dta : Third edited version of the data
			from the dataset. This version modified the 
			"edited_original_USA_EDandNM_v2.dta" data using Stata -
			subsetted the data used for analyses, excluding influential 
			observations. 
			
			
			Changes were documented using the 
			"data_cleaning_USA_EDandNM_SP22.do" script.
			
	Data cleaning: The "data_cleaning_USA_EDandNM_SP22.do" script needs to be 
	run prior to this script, "data_analyses_USA_EDandNM_SP22.do". 
	
		The "data_cleaning_USA_EDandNM_SP22.do" script explored and cleaned 
		data for the project, which will be working with Logistic Regression 
		Models. The following was done to prepare the data: 
	 
		 *Data: edited_original_USA_EDandNM_v2.dta
			~ Subsetted data (only kept variables needed for analyses)
				- saved data : edited_original_USA_EDandNM_v2.dta
				- this has 2 missing obs. removed for Negative Article Valence
				  (N=624)
			~Subsetted data (only kept variables needed for analyses)
				- saved data: edited_original_USA_EDandNM_v3.dta
				- this excluded 19 influential observations for the full 
				  logistic regression model (N=605)
	
	
	Task for this script file: Analyses - Exploring Project Data and Running  
	Logistic Regression Models
	 *Data: edited_original_USA_EDandNM_v2.dta
		~ Exploring and visualizing data for the project
			- Checked for influential observations
			- Summary statistics and visualizing variables
		~ Assessing logistic regression assumptions
		~ Running logistic regression models
			- Various interpretations
			- Compared models 
		~ Tables 
			- Descriptive statistics and regression results 
	
   */



*------------------------
* Set Up Environment
*------------------------

cd "/Users/val/Desktop/SP22_SOC401"
* Set working directory

clear all
* Clear the environment before starting a new task

capture log close 
* If there's a previous log set up, close it

log using data_analyses.smcl, replace 
/* Sets up a log file (tracks all the code you run in the session 
it is opened for). */

version 17
/* Tells Stata what version you wrote this .do file in, in case you are running
it in a different version later. Sometimes commands can change between versions. 
This prevents any inconsistencies between versions from causing errors. */

set linesize 80
/* The linesize limit makes output more readable. It prevents tables from being
too wide*/ 

use "data_work/edited_original_USA_EDandNM_v2.dta"
/* Open the .dta file in STATA
   
   This is the data I'll be using for data analyses in this script - it includes
   clean data with new and recoded variables and only includes the key variables
   needed for the data analyses.  
   The original format (starting point) of this datset came from the full raw 
   data from the project, "raw_USA_EDandNM_v1.dta". Then, I cleaned the data and 
   recoded variables as needed, creating the dataset 
   "edited_original_USA_EDandNM_v2.dta", which contains all clean and recoded 
   variables that came from the original datatset. */

*------------------------
* Data Check
*------------------------

describe
* Overview of the Dataset

mdesc
* Check for missing values 
/* Note: currently I am working with an N=624 since I removed 2 missing values
	from the article valence DV to have all variables match the N  */

	
*------------------------------------
* Check for Influential Observations
*------------------------------------

* 1) Run logistic regression & calculate dbeta 
logit Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia ///
	NM_SM_Facebook NM_SM_Instagram NM_SM_Tumblr NM_SM_YouTube 
eststo est1

predict dbeta, dbeta
label variable dbeta "Pregibon Delta Beta"

predict phat, p
label variable phat "Predicted Probability"


* 2) Visualize dbeta over predicted probabilities

scatter dbeta phat, mlab(Article_ID) 

	
* 3) List the outliers 

list Article_ID Article_Year dbeta if dbeta > 1 & dbeta != .
	
	
* 4) Run regression excluding potential influential observations

logit Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia ///
	NM_SM_Facebook NM_SM_Instagram NM_SM_Tumblr NM_SM_YouTube ///
		if dbeta < 1, nolog
eststo est2


*5) Create a table to compare how the coefficients changed 

esttab est1 est2
	
	

*------------------------
* Subsetting Data
*------------------------

/* Task: Exclude influential observations
*/

keep Article_ID Article_Valence_Binary_Negative Article_Valence_Binary_Positive ///
Article_Valence_Ordinal Article_Year ED_Anorexia ///
ED_Binge_Eating_Disorder ED_Bulimia NM_SM_Facebook NM_SM_Instagram ///
NM_SM_Tumblr NM_SM_Twitter NM_SM_YouTube SRC_Public_Figures ///
SRC_Public_Figures_AffectedED SRC_Public_Figures_White ///
SRC_Public_Figures_Black SRC_Public_Figures_Asian ///
SRC_Public_Figures_OtherRace SRC_Public_Figures_Hispanic
describe
/*Subset data to specific variables: identifier variable, and key outcome and 
predictor variables */

drop if Article_ID==162 
drop if Article_ID==173 
drop if Article_ID==178 
drop if Article_ID==553 
drop if Article_ID==556 
drop if Article_ID==558 
drop if Article_ID==559 
drop if Article_ID==560 
drop if Article_ID==569 
drop if Article_ID==573 
drop if Article_ID==578 
drop if Article_ID==579 
drop if Article_ID==581 
drop if Article_ID==585 
drop if Article_ID==586 
drop if Article_ID==597 
drop if Article_ID==599 
drop if Article_ID==616 
drop if Article_ID==621
*Drop influential observations - new N = 605

describe
sum Article_Valence_Binary_Negative
*check N - new N = 605 


save "data_work/edited_original_USA_EDandNM_v3.dta", replace
/*Save subset data - use this dataset for analyses, it contains the key 
dependent and independent variables and excludes missing observations. */

	
	
*----------------------------
* Plot DV & Key IV 	
*----------------------------
	
scatter Article_Valence_Binary_Negative Article_Year || ///
	lowess Article_Valence_Binary_Negative Article_Year

	
	
*----------------------------
* Logistic Regression Models
*----------------------------

****** DV: Negative Article Valence 

*--- Output: Odds ratios 

* 1) Model 1: Basic Model 
logistic Article_Valence_Binary_Negative Article_Year 


* 2) Model 2: Add Eating Disorders 
logistic Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia


* 3) Model 3: Add Social Media
logistic Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia ///
	NM_SM_Facebook NM_SM_Instagram NM_SM_Tumblr NM_SM_YouTube 


	
	
*----------------------------
* Predicted Probabilities
*----------------------------

* --- Year

* 1) Predicted probabilities with all other variables held at means

margins, at(Article_Year = (2010(3)2019)) atmeans
marginsplot


* 2) Predicted probabilities with all other variables at representative values

margins, at(Article_Year = (2010(3)2019) ED_Anorexia == 1 ED_Bulimia == 1 ///
	NM_SM_Facebook == 1 NM_SM_Instagram == 1 NM_SM_Tumblr == 1 /// 
	NM_SM_YouTube == 1)
marginsplot


* 3) Average predicted probabilities 

margins, at(Article_Year = (2010(3)2019))
marginsplot


*----------------------------
* Marginal Effects (dydx)
*----------------------------
	
* 1)  Marginal effect of a one unit change in X AT MEANS (MEM)
	
margins, dydx(Article_Year) atmeans
	
margins, dydx(ED_Anorexia) atmeans
	
margins, dydx(ED_Bulimia) atmeans
	
margins, dydx(NM_SM_Facebook) atmeans

margins, dydx(NM_SM_Instagram) atmeans
	
margins, dydx(NM_SM_Tumblr) atmeans
	
margins, dydx(NM_SM_YouTube) atmeans
	
margins, dydx(*) atmeans
		* See all marginal effects at means for all X variables 
	
	
* 2) Marginal effect of one unit change in X at REPRESENTATIVE VALUES (MER)

margins, dydx(Article_Year) at (ED_Anorexia == 1 ED_Bulimia == 1 ///
	NM_SM_Facebook == 1 NM_SM_Instagram == 1 NM_SM_Tumblr == 1 /// 
	NM_SM_YouTube == 1)
	

margins, dydx(ED_Bulimia) at (Article_Year == 2019 ED_Anorexia == 1 ///
	NM_SM_Facebook == 1 NM_SM_Instagram == 1 NM_SM_Tumblr == 1 /// 
	NM_SM_YouTube == 1)
	
margins, dydx(NM_SM_Tumblr) at (Article_Year == 2019 ED_Anorexia == 1 ///
	ED_Bulimia == 1 NM_SM_Facebook == 1 NM_SM_Instagram == 1 /// 
	NM_SM_YouTube == 1)
	
margins, dydx(NM_SM_YouTube) at (Article_Year == 2019 ED_Anorexia == 1 ///
	ED_Bulimia == 1 NM_SM_Facebook == 1 NM_SM_Instagram == 1 /// 
	NM_SM_Tumblr == 1)
	
	
* 3) AVERAGE marginal effects (AME)

margins, dydx(Article_Year) 
	
margins, dydx(ED_Anorexia)
	
margins, dydx(ED_Bulimia)
	
margins, dydx(NM_SM_Facebook)

margins, dydx(NM_SM_Instagram) 
	
margins, dydx(NM_SM_Tumblr) 
	
margins, dydx(NM_SM_YouTube) 
	
margins, dydx(*) 
		/* See all marginal effects with representative values for all 
		X variables */

	

*----------------------------
* Check Assumptions
*----------------------------
	
*  1) Outcome is binary - YES

/* 2) The log-odds of the outcome and independent variable have a 
	 linear relationship - YES  */ 

predict logits, xb 
scatter logits Article_Year || /// 
	lowess logits Article_Year
	*(small bend at beginning but should hold)
	
		/* Predict the logits (aka the log odds), save them to dataset, and 
		   then plot them against each independent variable (lowess line). 
		   Do this with continuous variables*/
 
 
*  3) Errors are independent - YES (no clustering)

*  4) No severe multicollinearity - YES (no multicollinearity)
net describe collin, from(https://stats.idre.ucla.edu/stat/stata/ado/analysis)
net install collin
	
collin Article_Year ED_Anorexia ED_Bulimia NM_SM_Facebook NM_SM_Instagram ///
	NM_SM_Tumblr NM_SM_YouTube 
		* Run with all covariates 
		* No multicollinearity as VIF below 10 for all covariates. 
	
	
*----------------------------
* Compare Models 
*----------------------------

* Full model 
logistic Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia ///
	NM_SM_Facebook NM_SM_Instagram NM_SM_Tumblr NM_SM_YouTube 

	
	
* ----- Likelihood Ratio Test

* 1) Run two or more "nested" models and store the estimates

* Model 1: ED
logit Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia
eststo m100 

* Model 2: NM_SM
logit Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia ///
	NM_SM_Facebook NM_SM_Instagram NM_SM_Tumblr NM_SM_YouTube 
eststo m101


* 2) Run the liklihood ratio test

lrtest m100 m101

/* p = 0.0011 
	~ p < 0.5, so we reject the null (2 models have equal fit)
	~ Model 101 (full model) has a better fit */
	

	
	
	
* ----- AIC and BIC 

* Model 1: Year 
quietly logistic Article_Valence_Binary_Negative Article_Year
estat ic

* AIC = 825.56
* BIC = 834.37



* Model 2: Year + ED 
quietly logistic Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia
estat ic

* AIC = 817.96
* BIC = 835.58



* Model 3: Year + ED + NM_SM
quietly logistic Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia ///
	NM_SM_Facebook NM_SM_Instagram NM_SM_Tumblr NM_SM_YouTube 
estat ic

* AIC = 811.48
* BIC = 846.72


* Reminder: Smaller = better fit
	
	
	
	
*----------------------------
* Visualizing Variables 
*----------------------------

**** Continuous Variables ****

* --- Independent Variables (IVs)

* Year
histogram Article_Year
	* Histogram 
graph box Article_Year
	* Box Plot 
graph box Article_Year, over(Article_Valence_Binary_Negative)
graph box Article_Year, over(Article_Valence_Binary_Positive)
graph box Article_Year, over(ED_Anorexia)
graph box Article_Year, over(ED_Binge_Eating_Disorder)
graph box Article_Year, over(ED_Bulimia)
graph box Article_Year, over(NM_SM_Instagram)
graph box Article_Year, over(NM_SM_Facebook)
graph box Article_Year, over(NM_SM_Twitter)
	* Box Plot of Year by various variables

	

**** Categorical/Binary Variables ****

* --- Dependent Variables (DVs)

* Negative Valence (binary)
graph bar, over(Article_Valence_Binary_Negative)
	* Bar plot 
	
* Positive Valence (binary)
graph bar, over(Article_Valence_Binary_Positive)
	* Bar plot 

* Article Valence (ordinal)
graph bar, over(Article_Valence_Ordinal)
	* Bar plot 



* --- Independent Variables (IVs)

* Anorexia
graph bar, over(ED_Anorexia)
	* Bar plot 

* Binge Eating Disorder (BED)
graph bar, over(ED_Binge_Eating_Disorder)
	* Bar plot 

* Bulimia
graph bar, over(ED_Bulimia)
	* Bar plot 

* Facebook
graph bar, over(NM_SM_Facebook)
	* Bar plot 

* Instagram
graph bar, over(NM_SM_Instagram)
	* Bar plot 

* Tumblr
graph bar, over(NM_SM_Tumblr)
	* Bar plot 

* Twitter
graph bar, over(NM_SM_Twitter)
	* Bar plot 
	
* YouTube
graph bar, over(NM_SM_YouTube)
	* Bar plot 

* Public Figures
graph bar, over(SRC_Public_Figures)
	* Bar plot 

* Public Figures Affected by ED
graph bar, over(SRC_Public_Figures_AffectedED)
	* Bar plot 
	
* White Public Figures
graph bar, over(SRC_Public_Figures_White)
	* Bar plot 

* Black Public Figures
graph bar, over(SRC_Public_Figures_Black)
	* Bar plot 

* Asian Public Figures
graph bar, over(SRC_Public_Figures_Asian)
	* Bar plot 
	
* Public Figures of Other Race
graph bar, over(SRC_Public_Figures_OtherRace)
	* Bar plot 

* Hispanic/Latino/Spanish Origin Public Figures
graph bar, over(SRC_Public_Figures_Hispanic)
	* Bar plot 
	



*-----------------------------------------
* Summary Statistics - Tables 
*-----------------------------------------

* Check skewness of continuous variable 
summarize Article_Year, detail

tab Article_Valence_Ordinal

*Summary Statistics Table
*--------------------------

asdoc sum Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia ///
	NM_SM_Facebook NM_SM_Instagram NM_SM_Tumblr NM_SM_YouTube,  ///
	save(SummmaryStats) label ///
	title(Table 1. Descriptive Statistics) ///
	dec(2) ///
	replace


*Frequency Tables for categorical variables
*-----------------------------------------------------------

tabulate Article_Valence_Binary_Negative

tabulate ED_Anorexia

tabulate ED_Bulimia

tabulate NM_SM_Facebook

tabulate NM_SM_Instagram

tabulate NM_SM_Tumblr

tabulate NM_SM_YouTube


*----------------------------
* Regression Results Tables
*----------------------------
/* Task: Build a final results table that starts with a simple regression 
and adds the covariates in chunks. */

ssc install estout

**** Model 1: Basic Model ****
eststo m1: logistic Article_Valence_Binary_Negative Article_Year 


**** Model 2: Add Generation ****
eststo m2: logistic Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia


**** Model 3: Add Age ****
eststo m3: logistic Article_Valence_Binary_Negative Article_Year ///
	ED_Anorexia ED_Bulimia ///
	NM_SM_Facebook NM_SM_Instagram NM_SM_Tumblr NM_SM_YouTube 
	
	

* Build final regression results table 
	esttab m1 m2 m3 using logisticregression_results.doc, eform /// 
			label ///
			b(a2) ///
			se ///
			aic ///
			pr2 ///
			constant ///
			title (Table 1. Logistic Regression Models Predicting Negative ///
			Article Valence (N = 605) ) ///
			nonumbers mtitles ("Model A" "Model B" "Model C") ///
			addnote ("Coefficients are in odds ratios") ///
			replace
	
*Note: This table shows coefficients in odds ratios

*----------------------------------
* Closing Environment
*----------------------------------	
log close
translate data_analyses.smcl data_analyses.pdf, replace


