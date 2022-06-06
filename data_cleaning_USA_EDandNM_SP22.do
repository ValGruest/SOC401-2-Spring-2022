*------------------------
/* Final Project - SOC 401-2, Spring 2022:
   "Eating Disorders and New Media: Exploring Negative Article Valence 
    in U.S. News Coverage" */

* data_cleaning_USA_EDandNM_SP22.do
* Created: 05/22/2022
* Valerie Gruest, Northwestern University
*------------------------


*------------------------
* Project Description
*------------------------

/* Project: "Eating Disorders and New Media: Exploring Negative Article Valence 
in U.S. News Coverage" 

   Original Dataset: ED & New Media 
   - Excluded 2 observations with missing values for DV
   
   Research Questions: 
   1)  1) RQ1. How does the negative valence of the relationship between eating 
	disorders and new media in the news coverage change over time from 2010 to 
	2019?
	2) RQ2. Is having specific eating disorder diagnoses, a)anorexia or 
	b)bulimia, referenced in the article associated with a negative valence of 
	the relationship between eating disorders and new media? 
	3) RQ3. Is having a specific social media platform, a)Facebook, b)Instagram, 
	c)Tumblr or d)YouTube), referenced in the article associated with a negative 
	valence of the relationship between eating disorders and new media? 

   
   Outcome I am estimating: Negative Article Valence 

   Key Variables:
	 - Dependent variable: 
		~ Article_Valence_Binary_Negative (binary)

	 - Independent variables: 
		~ Article_Year
		~ ED_Anorexia
		~ ED_Bulimia
		~ NM_SM_Facebook
		~ NM_SM_Instagram 
		~ NM_SM_Tumblr
		~ NM_SM_YouTube

	Missing Values: The only variable with missing data values was the variable 	
	"State", with 11 missing values accounting for 8.4% of missing cases for 
	the variable. Respondents were asked the item in the survey but chose not 
	to respond. All other variables do not have any missing values. 
		
		
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
			subsetted the data I used for analyses, keeping only key variables.
	
		~ edited_original_USA_EDandNM_v3.dta : Third edited version of the data
			from the dataset. This version modified the 
			"edited_original_USA_EDandNM_v2.dta" data using Stata -
			subsetted the data used for analyses, excluding influential 
			observations. 
			
			Changes were documented using the 
			"data_cleaning_USA_EDandNM_SP22.do" script.
			
			
	Task for this script file: Exploring and cleaning data for the project, 
	Logistic Regression Models 
	* Data: raw_USA_EDandNM_v1.dta
		~ Managing missing values
		~ Cleaning variables 
			- Creating indicator/dummy variables
			- Recoding variables
			- Labeling variables
		~ Exploring original data
			- Summary statistics and visualizing variables
		~ Subsetting data to keep key variables 
		
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

log using data_cleaning.smcl, replace 
/* Sets up a log file (tracks all the code you run in the session 
it is opened for). */

version 17
/* Tells Stata what version you wrote this .do file in, in case you are running
it in a different version later. Sometimes commands can change between versions. 
This prevents any inconsistencies between versions from causing errors. */

set linesize 80
/* The linesize limit makes output more readable. It prevents tables from being
too wide*/ 

use "data_work/raw_USA_EDandNM_v1.dta"
/* Open the .dta file in STATA
   
   This is the data I'll be using for data cleaning in this script. The 
   original format (starting point) of this datset came from the full raw data 
   from the project. */

*-------------------------------------
* Exploring Data - Original Variables
*-------------------------------------

* 1) Overview of the dataset
describe

* 2) Look at missing values 
mdesc

* 3) Look at missing values for specific variables

/* a) Note: For the variables "Article_Type, Article_Valence, and NM_Internet" 
I am leaving them as a "." for missing given that I need to check with my 
co-author if there was a mutual decision on coding for the missing values that appear on the data set. */

/* b) Need to adjustfor missing values: I need to work on the following 
variables to fix the large numbers of missing in these variables referring to sources in the articles. Missing values for SRC_ED_Affected_Gender 1 and 2 are 
due to cells not being applicable to be coded. Also, the missing variables in 
the rest of these variables are due to being part of the subset of data for 
celebrities and influencers. If there is a celebrity or influencer in the 
article, we coded additional information for up to 4 of these public figures. 
So, missing values just refer to the cell not being appliable to be coded. */


* ----- Source: Affected, Gender 

mdesc SRC_ED_Affected_Gender1
*468 missing values 

mdesc SRC_ED_Affected_Gender2
*591 missing values 



* ----- Source: Celebrity 1 

mdesc SRC_CLB_1_ID
* 468 missing values 

mdesc SRC_CLB_1_Affected
* 468 missing values

mdesc SRC_CLB_1_Gender
* 468 missing values

mdesc SRC_CLB_1_Race1
* 468 missing values

mdesc SRC_CLB_1_Race2
* 614 missing values

mdesc SRC_CLB_1_Ethnicity							
* 468 missing values

mdesc SRC_CLB_1_SexualOrientation
* 468 missing values

/* Note: 468 missing values on average (nothing out of order),
		Race2 NA for everyone except 12 (multiracial) */




* -----  Source: Celebrity 2 

mdesc SRC_CLB_2_ID
* 594 missing values

mdesc SRC_CLB_2_Affected
* 594 missing values

mdesc SRC_CLB_2_Gender
* 594 missing values

mdesc SRC_CLB_2_Race1
* 594 missing values

mdesc SRC_CLB_2_Race2
* 624 missing values

mdesc SRC_CLB_2_Ethnicity	
* 594 missing values

mdesc SRC_CLB_2_SexualOrientation
* 594 missing values

/* Note: 594 missing values on average (nothing out of order),
		Race2 NA for everyone except 2 (multiracial) */




* ----- Source: Influencer 1
mdesc SRC_INF_1_ID
* 595 missing values

mdesc SRC_INF_1_Affected
* 595 missing values

mdesc SRC_INF_1_Gender
* 595 missing values

mdesc SRC_INF_1_Race1
* 595 missing values

mdesc SRC_INF_1_Race2
* 626 missing values

mdesc SRC_INF_1_Ethnicity
* 595 missing values

mdesc SRC_INF_1_SexualOrientation
* 595 missing values

/* Note: 595 missing values on average (nothing out of order),
		Race2 NA for everyone */



* ----- Source: Influencer 2

mdesc SRC_INF_2_ID
* 618 missing values

mdesc SRC_INF_2_Affected
* 618 missing values

mdesc SRC_INF_2_Gender
* 618 missing values

mdesc SRC_INF_2_Race1
* 618 missing values

mdesc SRC_INF_2_Race2
* 626 missing values

mdesc SRC_INF_2_Ethnicity
* 618 missing values

mdesc SRC_INF_2_SexualOrientation
* 618 missing values

/* Note: 618 missing values on average (nothing out of order), 
		 Race2 NA for everyone */



		 
*-----------------------------
* Dealing with Missing Values  
*-----------------------------

* ----- Source: Affected, Gender 


/* SRC_ED_Affected_Gender1
		Recode: Missing values as new category (4): NA/Missing 
		~ 468 missing values */
gen SRC_ED_Affected_Gender1_rc = SRC_ED_Affected_Gender1
replace SRC_ED_Affected_Gender1_rc = 4 if SRC_ED_Affected_Gender1 == . 
tab SRC_ED_Affected_Gender1_rc SRC_ED_Affected_Gender1, missing
	

	/* SRC_ED_Affected_Gender2
		Recode: Missing values as new category (4): NA/Missing 
		~ 591 missing values */
gen SRC_ED_Affected_Gender2_rc = SRC_ED_Affected_Gender2
replace SRC_ED_Affected_Gender2_rc = 4 if SRC_ED_Affected_Gender2 == . 
tab SRC_ED_Affected_Gender2_rc SRC_ED_Affected_Gender2, missing


* ----- Source: Celebrity 1 

/* SRC_CLB_1_ID
		Recode: Missing values as new number (0): NA/Missing 
			This can be done given that IDs begin with a 1, so it will be easy
			to distinguish that the ones that have a 0 are not applicable. 
		~  468 missing values */
gen SRC_CLB_1_ID_rc = SRC_CLB_1_ID
replace SRC_CLB_1_ID_rc = 0 if SRC_CLB_1_ID == . 
tab SRC_CLB_1_ID_rc SRC_CLB_1_ID, missing


/* SRC_CLB_1_Affected
		Recode: Missing values as new category (2): NA/Missing 
		~  468 missing values */
gen SRC_CLB_1_Affected_rc = SRC_CLB_1_Affected
replace SRC_CLB_1_Affected_rc = 2 if SRC_CLB_1_Affected == . 
tab SRC_CLB_1_Affected_rc SRC_CLB_1_Affected, missing
		

/* SRC_CLB_1_Gender
		Recode: Missing values as new category (4): NA/Missing 
		~  468 missing values */
gen SRC_CLB_1_Gender_rc = SRC_CLB_1_Gender
replace SRC_CLB_1_Gender_rc = 4 if SRC_CLB_1_Gender == . 
tab SRC_CLB_1_Gender_rc SRC_CLB_1_Gender, missing
		

/* SRC_CLB_1_Race1
		Recode: Missing values as new category (7): NA/Missing 
		~  468 missing values */
gen SRC_CLB_1_Race1_rc = SRC_CLB_1_Race1
replace SRC_CLB_1_Race1_rc = 7 if SRC_CLB_1_Race1 == . 
tab SRC_CLB_1_Race1_rc SRC_CLB_1_Race1, missing
		

/* SRC_CLB_1_Race2
		Recode: Missing values as new category (7): NA/Missing 
		~  614 missing values */
gen SRC_CLB_1_Race2_rc = SRC_CLB_1_Race2
replace SRC_CLB_1_Race2_rc = 7 if SRC_CLB_1_Race2 == . 
tab SRC_CLB_1_Race2_rc SRC_CLB_1_Race2, missing
		

/* SRC_CLB_1_Ethnicity	
		Recode: Missing values as new category (4): NA/Missing 
		~  468 missing values */
gen SRC_CLB_1_Ethnicity_rc = SRC_CLB_1_Ethnicity	
replace SRC_CLB_1_Ethnicity_rc = 4 if SRC_CLB_1_Ethnicity == . 
tab SRC_CLB_1_Ethnicity_rc SRC_CLB_1_Ethnicity, missing
		

/* SRC_CLB_1_SexualOrientation
		Recode: Missing values as new category (7): NA/Missing 
		~  468 missing values */
gen SRC_CLB_1_SexualOrientation_rc = SRC_CLB_1_SexualOrientation
replace SRC_CLB_1_SexualOrientation_rc = 7 if SRC_CLB_1_SexualOrientation == . 
tab SRC_CLB_1_SexualOrientation_rc SRC_CLB_1_SexualOrientation, missing
		




* -----  Source: Celebrity 2 


/* SRC_CLB_2_ID
		Recode: Missing values as new value (0): NA/Missing 
		This can be done given that IDs begin with a 1, so it will be easy
		to distinguish that the ones that have a 0 are not applicable. 
		~  594 missing values */
gen SRC_CLB_2_ID_rc = SRC_CLB_2_ID
replace SRC_CLB_2_ID_rc = 0 if SRC_CLB_2_ID == . 
tab SRC_CLB_2_ID_rc SRC_CLB_2_ID, missing
		


/* SRC_CLB_2_Affected
		Recode: Missing values as new category (2): NA/Missing 
		~  594 missing values */
gen SRC_CLB_2_Affected_rc = SRC_CLB_2_Affected
replace SRC_CLB_2_Affected_rc = 2 if SRC_CLB_2_Affected == . 
tab SRC_CLB_2_Affected_rc SRC_CLB_2_Affected, missing
		


/* SRC_CLB_2_Gender
		Recode: Missing values as new category (4): NA/Missing 
		~  594 missing values */
gen SRC_CLB_2_Gender_rc = SRC_CLB_2_Gender
replace SRC_CLB_2_Gender_rc = 4 if SRC_CLB_2_Gender == . 
tab SRC_CLB_2_Gender_rc SRC_CLB_2_Gender, missing
		


/* SRC_CLB_2_Race1
		Recode: Missing values as new category (7): NA/Missing 
		~  594 missing values */
gen SRC_CLB_2_Race1_rc = SRC_CLB_2_Race1
replace SRC_CLB_2_Race1_rc = 7 if SRC_CLB_2_Race1 == . 
tab SRC_CLB_2_Race1_rc SRC_CLB_2_Race1, missing
		


/* SRC_CLB_2_Race2
		Recode: Missing values as new category (7): NA/Missing 
		~  624 missing values */
gen SRC_CLB_2_Race2_rc = SRC_CLB_2_Race2
replace SRC_CLB_2_Race2_rc = 7 if SRC_CLB_2_Race2 == . 
tab SRC_CLB_2_Race2_rc SRC_CLB_2_Race2, missing
		


/* SRC_CLB_2_Ethnicity	
		Recode: Missing values as new category (4): NA/Missing 
		~  594 missing values */
gen SRC_CLB_2_Ethnicity_rc = SRC_CLB_2_Ethnicity	
replace SRC_CLB_2_Ethnicity_rc = 4 if SRC_CLB_2_Ethnicity == . 
tab SRC_CLB_2_Ethnicity_rc SRC_CLB_2_Ethnicity, missing
		


/* SRC_CLB_2_SexualOrientation 
		Recode: Missing values as new category (7): NA/Missing 
		~  594 missing values */
gen SRC_CLB_2_SexualOrientation_rc = SRC_CLB_2_SexualOrientation
replace SRC_CLB_2_SexualOrientation_rc = 7 if SRC_CLB_2_SexualOrientation == . 
tab SRC_CLB_2_SexualOrientation_rc SRC_CLB_2_SexualOrientation, missing
		





* ----- Source: Influencer 1

/* SRC_INF_1_ID
		Recode: Missing values as new value (0): NA/Missing 
		This can be done given that IDs begin with a 1, so it will be easy
		to distinguish that the ones that have a 0 are not applicable. 
		~  595 missing values */
gen SRC_INF_1_ID_rc = SRC_INF_1_ID
replace SRC_INF_1_ID_rc = 0 if SRC_INF_1_ID == . 
tab SRC_INF_1_ID_rc SRC_INF_1_ID, missing
		


/* SRC_INF_1_Affected
		Recode: Missing values as new category (2): NA/Missing 
		~  595 missing values */
gen SRC_INF_1_Affected_rc = SRC_INF_1_Affected
replace SRC_INF_1_Affected_rc = 2 if SRC_INF_1_Affected == . 
tab SRC_INF_1_Affected_rc SRC_INF_1_Affected, missing
		


/* SRC_INF_1_Gender
		Recode: Missing values as new category (4): NA/Missing 
		~  595 missing values */
gen SRC_INF_1_Gender_rc = SRC_INF_1_Gender
replace SRC_INF_1_Gender_rc = 4 if SRC_INF_1_Gender == . 
tab SRC_INF_1_Gender_rc SRC_INF_1_Gender, missing



/* SRC_INF_1_Race1
		Recode: Missing values as new category (7): NA/Missing 
		~  595 missing values */
gen SRC_INF_1_Race1_rc = SRC_INF_1_Race1
replace SRC_INF_1_Race1_rc = 7 if SRC_INF_1_Race1 == . 
tab SRC_INF_1_Race1_rc SRC_INF_1_Race1, missing
		

/* SRC_INF_1_Race2
		Recode: Missing values as new category (7): NA/Missing 
		~  626 missing values */
gen SRC_INF_1_Race2_rc = SRC_INF_1_Race2
replace SRC_INF_1_Race2_rc = 7 if SRC_INF_1_Race2 == . 
tab SRC_INF_1_Race2_rc SRC_INF_1_Race2, missing
		

/* SRC_INF_1_Ethnicity
		Recode: Missing values as new category (4): NA/Missing 
		~  595 missing values */
gen SRC_INF_1_Ethnicity_rc = SRC_INF_1_Ethnicity
replace SRC_INF_1_Ethnicity_rc = 4 if SRC_INF_1_Ethnicity == . 
tab SRC_INF_1_Ethnicity_rc SRC_INF_1_Ethnicity, missing



/* SRC_INF_1_SexualOrientation
		Recode: Missing values as new category (7): NA/Missing 
		~  595 missing values */
gen SRC_INF_1_SexualOrientation_rc = SRC_INF_1_SexualOrientation
replace SRC_INF_1_SexualOrientation_rc = 7 if SRC_INF_1_SexualOrientation == . 
tab SRC_INF_1_SexualOrientation_rc SRC_INF_1_SexualOrientation, missing






* ----- Source: Influencer 2


/* SRC_INF_2_ID
		Recode: Missing values as new category (0): NA/Missing 
		This can be done given that IDs begin with a 1, so it will be easy
		to distinguish that the ones that have a 0 are not applicable. 
		~  618 missing values */
gen SRC_INF_2_ID_rc = SRC_INF_2_ID
replace SRC_INF_2_ID_rc = 0 if SRC_INF_2_ID == . 
tab SRC_INF_2_ID_rc SRC_INF_2_ID, missing


/* SRC_INF_2_Affected
		Recode: Missing values as new category (2): NA/Missing 
		~  618 missing values */
gen SRC_INF_2_Affected_rc = SRC_INF_2_Affected
replace SRC_INF_2_Affected_rc = 2 if SRC_INF_2_Affected == . 
tab SRC_INF_2_Affected_rc SRC_INF_2_Affected, missing


/* SRC_INF_2_Gender
		Recode: Missing values as new category (4): NA/Missing 
		~  618 missing values */
gen SRC_INF_2_Gender_rc = SRC_INF_2_Gender
replace SRC_INF_2_Gender_rc = 4 if SRC_INF_2_Gender == . 
tab SRC_INF_2_Gender_rc SRC_INF_2_Gender, missing


/* SRC_INF_2_Race1
		Recode: Missing values as new category (7): NA/Missing 
		~  618 missing values */
gen SRC_INF_2_Race1_rc = SRC_INF_2_Race1
replace SRC_INF_2_Race1_rc = 7 if SRC_INF_2_Race1 == . 
tab SRC_INF_2_Race1_rc SRC_INF_2_Race1, missing


/* SRC_INF_2_Race2
		Recode: Missing values as new category (7): NA/Missing 
		~  626 missing values */
gen SRC_INF_2_Race2_rc = SRC_INF_2_Race2
replace SRC_INF_2_Race2_rc = 7 if SRC_INF_2_Race2 == . 
tab SRC_INF_2_Race2_rc SRC_INF_2_Race2, missing
		

/* SRC_INF_2_Ethnicity
		Recode: Missing values as new category (4): NA/Missing 
		~  618 missing values */
gen SRC_INF_2_Ethnicity_rc = SRC_INF_2_Ethnicity
replace SRC_INF_2_Ethnicity_rc = 4 if SRC_INF_2_Ethnicity == . 
tab SRC_INF_2_Ethnicity_rc SRC_INF_2_Ethnicity, missing


/* SRC_INF_2_SexualOrientation
		Recode: Missing values as new category (7): NA/Missing 
		~  618 missing values */
gen SRC_INF_2_SexualOrientation_rc = SRC_INF_2_SexualOrientation
replace SRC_INF_2_SexualOrientation_rc = 7 if SRC_INF_2_SexualOrientation == . 
tab SRC_INF_2_SexualOrientation_rc SRC_INF_2_SexualOrientation, missing
		


mdesc 
* Check that new variables converted successfully and have no missing values 


		 
	
*------------------------
* Creating New Variables 
*------------------------
		
/* --- SRC_Public_Figures
		  ~ Binary variable that indicates whether a public figure (celebrity
			or influencer) was referenced in the article. 
				0 = public figure not referenced in the article
				1 = public figure referenced in the article.                 */
 
gen SRC_Public_Figures = . 
replace SRC_Public_Figures = 1 if SRC_Celebrities == 1 | SRC_Influencers == 1
replace SRC_Public_Figures = 0 if SRC_Public_Figures == . 

label define publicfigures 0 "No Public Figures" 1 "Public Figures"
label values SRC_Public_Figures publicfigures
/* Create an object that stores labels you want to apply to each value and 
	assign the object to the variable */

tab SRC_Public_Figures


/* --- SRC_Public_Figures_AffectedED
		  ~ Binary variable that indicates whether a public figure 
			(celebrity or influencer) referenced in the article was affected
			by an eating disorder. 
				0 = no public figure referenced in the article affected by ED
				1 = public figure referenced in the article affected by ED */
 
gen SRC_Public_Figures_AffectedED = . 
replace SRC_Public_Figures_AffectedED = 1 if SRC_CLB_1_Affected == 1 | ///
											 SRC_CLB_2_Affected == 1 | ///
											 SRC_INF_1_Affected == 1 | ///
											 SRC_INF_2_Affected == 1 
											 
replace SRC_Public_Figures_AffectedED = 0 if SRC_Public_Figures_AffectedED == . 

label define publicfiguresED 0 "No Public Figures Affected by ED" ///
							 1 "Public Figures Affected by ED"
label values SRC_Public_Figures_AffectedED publicfiguresED
/* Create an object that stores labels you want to apply to each value and 
	assign the object to the variable */

tab SRC_Public_Figures_AffectedED, missing
/* Note: Total articles referencing public figures in USA, N=177 
		 (Affected by ED = 103) */




/* --- Article_Valence_Ordinal
		  ~ Ordinal variable with 3 levels that indicates whether the valence
			of the relationship between eating disorders and new media was 
			regarded as negative, neutral/split/unclear or positive in the 
			article. 
				1 = negative
				2 = neutral / split / unclear
                3 = positive                                */
 
gen Article_Valence_Ordinal = . 
replace Article_Valence_Ordinal = 1 if Article_Valence == 2 
replace Article_Valence_Ordinal = 2 if Article_Valence == 3 
replace Article_Valence_Ordinal = 3 if Article_Valence == 1 

label define articlevalenceordinal 1 "Negative" 2 "Neutral" ///
	3 "Positive"
label values Article_Valence_Ordinal articlevalenceordinal
/* Create an object that stores labels you want to apply to each value and 
	assign the object to the variable */

tab Article_Valence_Ordinal, missing
*Note: there are 2 values missing (N=624)
	
	
	
/* --- Article_Valence_Binary_Negative
		  ~ Binary variable that indicates if the valence of the relationship 	
			between eating disorders and new media was regarded as negative in 
			the article. 
				1 = negative
                0 = positive/neutral                        */
 
gen Article_Valence_Binary_Negative = . 
replace Article_Valence_Binary_Negative = 0 if Article_Valence == 1
replace Article_Valence_Binary_Negative = 0 if Article_Valence == 3
replace Article_Valence_Binary_Negative = 1 if Article_Valence == 2


label define articlevalencebinarynegative 0 "Positive/Neutral" 1 "Negative"
label values Article_Valence_Binary_Negative articlevalencebinarynegative
/* Create an object that stores labels you want to apply to each value and 
	assign the object to the variable */

tab Article_Valence_Binary_Negative
tab Article_Valence_Binary_Negative, missing
/*Note: There are 2 missing values (N = 624) 
		Negative = 315 articles
		
		If this variable leaves out "Neutral", it has 217 missing values(N=409). 
		So, I decided to combine positive and neutral as the reference 
		category. */
		

		
		
/* --- Article_Valence_Binary_Positive
		  ~ Binary variable that indicates if the valence of the relationship 	
			between eating disorders and new media was regarded as positive in 
			the article. 
				1 = positive
                0 = negative/neutral                        */
 
gen Article_Valence_Binary_Positive = . 
replace Article_Valence_Binary_Positive = 0 if Article_Valence == 2
replace Article_Valence_Binary_Positive = 0 if Article_Valence == 3
replace Article_Valence_Binary_Positive = 1 if Article_Valence == 1


label define articlevalencebinarypositive 0 "Negative/Neutral" 1 "Positive"
label values Article_Valence_Binary_Positive articlevalencebinarypositive
/* Create an object that stores labels you want to apply to each value and 
	assign the object to the variable */

tab Article_Valence_Binary_Positive
tab Article_Valence_Binary_Positive, missing
/*Note: There are 2 missing values (N = 624) 
		Positive =  articles
		
		If this variable leaves out "Neutral", it has 217 missing values(N=409). 
		So, I decided to combine negative and neutral as the reference 
		category. */
		 
		 
		 	 

/* --- SRC_Public_Figures_White
		  ~ Binary variable that indicates whether a white public figure 
			(celebrity or influencer) was referenced in the article. 
				0 = white public figure not referenced in the article
				1 = white public figure referenced in the article.         */
 
gen SRC_Public_Figures_White = . 
replace SRC_Public_Figures_White = 1 if SRC_CLB_1_Race1 == 5 | ///
										SRC_CLB_1_Race2 == 5 | ///
										SRC_CLB_2_Race1 == 5 | ///
										SRC_CLB_2_Race2 == 5 | ///
										SRC_INF_1_Race1 == 5 | ///
										SRC_INF_1_Race2 == 5 | ///
										SRC_INF_2_Race1 == 5 | ///
										SRC_INF_2_Race2 == 5
replace SRC_Public_Figures_White = 0 if SRC_Public_Figures_White == . 

label define whitepublicfigures 0 "No White Public Figures" ///
								1 "White Public Figures"
label values SRC_Public_Figures_White whitepublicfigures
/* Create an object that stores labels you want to apply to each value and 
	assign the object to the variable */

tab SRC_Public_Figures_White, missing
* Note: Total articles referencing public figures in USA, N=177 (white=161)




/* --- SRC_Public_Figures_Black
		  ~ Binary variable that indicates whether a Black public figure 
			(celebrity or influencer) was referenced in the article. 
				0 = Black public figure not referenced in the article
				1 = Black public figure referenced in the article.         */
 
gen SRC_Public_Figures_Black = . 
replace SRC_Public_Figures_Black = 1 if SRC_CLB_1_Race1 == 3 | ///
										SRC_CLB_1_Race2 == 3 | ///
										SRC_CLB_2_Race1 == 3 | ///
										SRC_CLB_2_Race2 == 3 | ///
										SRC_INF_1_Race1 == 3 | ///
										SRC_INF_1_Race2 == 3 | ///
										SRC_INF_2_Race1 == 3 | ///
										SRC_INF_2_Race2 == 3
replace SRC_Public_Figures_Black = 0 if SRC_Public_Figures_Black == . 

label define blackpublicfigures 0 "No Black Public Figures" ///
								1 "Black Public Figures"
label values SRC_Public_Figures_Black blackpublicfigures
/* Create an object that stores labels you want to apply to each value and 
	assign the object to the variable */

tab SRC_Public_Figures_Black, missing
* Note: Total articles referencing public figures in USA, N=177 (Black=16)
		 

		 
		 
/* --- SRC_Public_Figures_Asian
		  ~ Binary variable that indicates whether an Asian public figure 
			(celebrity or influencer) was referenced in the article. 
				0 = Asian public figure not referenced in the article
				1 = Asian public figure referenced in the article.         */
 
gen SRC_Public_Figures_Asian = . 
replace SRC_Public_Figures_Asian = 1 if SRC_CLB_1_Race1 == 2 | ///
										SRC_CLB_1_Race2 == 2 | ///
										SRC_CLB_2_Race1 == 2 | ///
										SRC_CLB_2_Race2 == 2 | ///
										SRC_INF_1_Race1 == 2 | ///
										SRC_INF_1_Race2 == 2 | ///
										SRC_INF_2_Race1 == 2 | ///
										SRC_INF_2_Race2 == 2
replace SRC_Public_Figures_Asian = 0 if SRC_Public_Figures_Asian == . 

label define asianpublicfigures 0 "No Asian Public Figures" ///
								1 "Asian Public Figures"
label values SRC_Public_Figures_Asian asianpublicfigures
/* Create an object that stores labels you want to apply to each value and 
	assign the object to the variable */

tab SRC_Public_Figures_Asian, missing
* Note: Total articles referencing public figures in USA, N=177 (Asian=20)
		 
		 
		 
		 
/* --- SRC_Public_Figures_OtherRace
		  ~ Binary variable that indicates whether a public figure 
			(celebrity or influencer) of a race other than white, Black or 
			Asian was referenced in the article (including American Indian or 
			Alaska Native, Native Hawaiian or Other Pacific Islander and Other 
			(uncertain/unknown)). 
				0 = Public figure of other race not referenced in the article
				1 = Public figure of other race referenced in the article.    */
 
gen SRC_Public_Figures_OtherRace = . 
replace SRC_Public_Figures_OtherRace = 1 if ///
	SRC_CLB_1_Race1 == 1 | SRC_CLB_1_Race2 == 1 | ///
	SRC_CLB_2_Race1 == 1 | SRC_CLB_2_Race2 == 1 | ///
	SRC_INF_1_Race1 == 1 | SRC_INF_1_Race2 == 1 | ///
	SRC_INF_2_Race1 == 1 | SRC_INF_2_Race2 == 1 | ///  
	SRC_CLB_1_Race1 == 4 | SRC_CLB_1_Race2 == 4 | ///
	SRC_CLB_2_Race1 == 4 | SRC_CLB_2_Race2 == 4 | ///
	SRC_INF_1_Race1 == 4 | SRC_INF_1_Race2 == 4 | ///
	SRC_INF_2_Race1 == 4 | SRC_INF_2_Race2 == 4 | ///
	SRC_CLB_1_Race1 == 6 | SRC_CLB_1_Race2 == 6 | ///
	SRC_CLB_2_Race1 == 6 | SRC_CLB_2_Race2 == 6 | ///
	SRC_INF_1_Race1 == 6 | SRC_INF_1_Race2 == 6 | ///
	SRC_INF_2_Race1 == 6 | SRC_INF_2_Race2 == 6 
	
replace SRC_Public_Figures_OtherRace = 0 if SRC_Public_Figures_OtherRace == . 

label define otherracepublicfigures 0 "No Public Figures of Other Race" ///
									1 "Public Figures of Other Race"
label values SRC_Public_Figures_OtherRace otherracepublicfigures
/* Create an object that stores labels you want to apply to each value and 
	assign the object to the variable */

tab SRC_Public_Figures_OtherRace, missing
* Note: Total articles referencing public figures in USA, N=177 (Other race=4)
 
		 
	
	
	
/* --- SRC_Public_Figures_Hispanic
		  ~ Binary variable that indicates whether a Hispanic/Latino/Spanish 
			origin public figure (celebrity or influencer) was referenced in 
			the article. 
				0 = Hispanic public figure not referenced in the article
				1 = Hispanic public figure referenced in the article.       */
 
gen SRC_Public_Figures_Hispanic = . 
replace SRC_Public_Figures_Hispanic = 1 if SRC_CLB_1_Ethnicity == 1 | ///
										   SRC_CLB_2_Ethnicity == 1 | ///
										   SRC_INF_1_Ethnicity == 1 | ///
										   SRC_INF_2_Ethnicity == 1 
										
replace SRC_Public_Figures_Hispanic = 0 if SRC_Public_Figures_Hispanic == . 

label define hispanicpublicfigures 0 "No Hispanic Public Figures" ///
								   1 "Hispanic Public Figures"
label values SRC_Public_Figures_Hispanic hispanicpublicfigures
/* Create an object that stores labels you want to apply to each value and 
	assign the object to the variable */

tab SRC_Public_Figures_Hispanic, missing
* Note: Total articles referencing public figures in USA, N=177 (Hispanic=43)
		 
		 	 

		
	
	
*------------------------
* Labeling Key Variables 
*------------------------

* --- Add label to variable names 

label variable Article_Valence_Binary_Negative "Negative Article Valence"

label variable Article_Valence_Binary_Positive "Positive Article Valence"

label variable Article_Valence_Ordinal "Article Valence (Ordinal)"

label variable Article_Year "Year"

label variable Article_Writer_Gender "Writer Gender"

label variable ED_Anorexia "Anorexia"

label variable ED_Binge_Eating_Disorder "Binge Eating Disorder (BED)"

label variable ED_Bulimia "Bulimia"

label variable NM_SM_Instagram "Instagram"

label variable NM_SM_Facebook "Facebook"

label variable NM_SM_Tumblr "Tumblr"

label variable NM_SM_Twitter "Twitter"

label variable NM_SM_YouTube "YouTube"

label variable SRC_Public_Figures "Public Figures"

label variable SRC_Public_Figures_AffectedED "Public Figures Affected by ED"

label variable SRC_Public_Figures_White "White Public Figures"

label variable SRC_Public_Figures_Black "Black Public Figures"

label variable SRC_Public_Figures_Asian "Asian Public Figures"

label variable SRC_Public_Figures_OtherRace "Public Figures of Other Race"

label variable SRC_Public_Figures_Hispanic "Hispanic Public Figures"


* --- Add labels to variable levels 

* Writer Gender
label define writergender 1 "Female" 2 "Male" 3 "Other"
label values Article_Writer_Gender writergender
tab Article_Writer_Gender, missing


* Anorexia
label define anorexia 0 "No Reference of Anorexia" 1 "Anorexia" 
label values ED_Anorexia anorexia
tab ED_Anorexia, missing


* Binge Eating Disorder (BED)
label define bed 0 "No Reference of BED" 1 "Binge Eating Disorder (BED)" 
label values ED_Binge_Eating_Disorder bed
tab ED_Binge_Eating_Disorder, missing


* Bulimia
label define bulimia 0 "No Reference of Bulimia" 1 "Bulimia" 
label values ED_Bulimia bulimia
tab ED_Bulimia, missing


* Facebook
label define fb 0 "No Reference of Facebook" 1 "Facebook" 
label values NM_SM_Facebook fb
tab NM_SM_Facebook, missing


* Instagram
label define insta 0 "No Reference of Instagram" 1 "Instagram" 
label values NM_SM_Instagram insta
tab NM_SM_Instagram, missing


* Tumblr
label define tumblr 0 "No Reference of Tumblr" 1 "Tumblr" 
label values NM_SM_Tumblr tumblr
tab NM_SM_Tumblr, missing


* Twitter
label define twitter 0 "No Reference of Twitter" 1 "Twitter" 
label values NM_SM_Twitter twitter
tab NM_SM_Twitter, missing


* YouTube
label define youtube 0 "No Reference of YouTube" 1 "YouTube" 
label values NM_SM_YouTube youtube
tab NM_SM_YouTube, missing



*---------------------------------
* Saving Data After Data Cleaning
*---------------------------------

/* Task: I want to save all the changes I made to my data during the data 
cleaning process. All original variables included in this dataset, "edited_original_USA_EDandNM_v1.dta". 
*/

keep Article_ID Article_Title Article_Year Article_Month Article_Day ///
News_Outlet Article_Region Article_Country Article_Language ///
Article_Writer_Name Article_Writer_Gender Article_Type Article_Valence ///
Article_Salience ED_Eating_Disorder ED_Anorexia ED_Bulimia ///
ED_Binge_Eating_Disorder ED_Other ED_Unofficial NM_Internet NM_Websites ///
NM_Blogs NM_Social_Media NM_SM_Facebook NM_SM_Instagram NM_SM_Pinterest ///
NM_SM_Snapchat NM_SM_Tumblr NM_SM_Twitter NM_SM_WhatsApp NM_SM_YouTube ///
NM_SM_Other NM_Online_Therapy NM_Others SRC_Total_Sources ///
SRC_Expert_Healthcare SRC_Expert_Others SRC_NonProfit_Activist ///
SRC_ED_Affected SRC_ED_Affected_Gender1 SRC_ED_Affected_Gender2 ///
SRC_Affected_Acquaintance SRC_Platform_Text SRC_Tech_PlatformCompany ///
SRC_Public_Officials SRC_Celebrities SRC_CLB_1_ID SRC_CLB_1_Affected ///
SRC_CLB_1_Gender SRC_CLB_1_Race1 SRC_CLB_1_Race2 SRC_CLB_1_Ethnicity ///
SRC_CLB_1_SexualOrientation SRC_CLB_2_ID SRC_CLB_2_Affected SRC_CLB_2_Gender ///
SRC_CLB_2_Race1 SRC_CLB_2_Race2 SRC_CLB_2_Ethnicity ///
SRC_CLB_2_SexualOrientation SRC_Influencers SRC_INF_1_ID SRC_INF_1_Affected ///
SRC_INF_1_Gender SRC_INF_1_Race1 SRC_INF_1_Race2 SRC_INF_1_Ethnicity ///
SRC_INF_1_SexualOrientation SRC_INF_2_ID SRC_INF_2_Affected SRC_INF_2_Gender ///
SRC_INF_2_Race1 SRC_INF_2_Race2 SRC_INF_2_Ethnicity ///
SRC_INF_2_SexualOrientation SRC_Other SRC_ED_Affected_Gender1_rc ///
SRC_ED_Affected_Gender2_rc SRC_CLB_1_ID_rc SRC_CLB_1_Affected_rc ///
SRC_CLB_1_Gender_rc SRC_CLB_1_Race1_rc SRC_CLB_1_Race2_rc ///
SRC_CLB_1_Ethnicity_rc SRC_CLB_1_SexualOrientation_rc SRC_CLB_2_ID_rc ///
SRC_CLB_2_Affected_rc SRC_CLB_2_Gender_rc SRC_CLB_2_Race1_rc ///
SRC_CLB_2_Race2_rc SRC_CLB_2_Ethnicity_rc SRC_CLB_2_SexualOrientation_rc ///
SRC_INF_1_ID_rc SRC_INF_1_Affected_rc SRC_INF_1_Gender_rc SRC_INF_1_Race1_rc ///
SRC_INF_1_Race2_rc SRC_INF_1_Ethnicity_rc SRC_INF_1_SexualOrientation_rc ///
SRC_INF_2_ID_rc SRC_INF_2_Affected_rc SRC_INF_2_Gender_rc SRC_INF_2_Race1_rc ///
SRC_INF_2_Race2_rc SRC_INF_2_Ethnicity_rc SRC_INF_2_SexualOrientation_rc ///
SRC_Public_Figures Article_Valence_Ordinal Article_Valence_Binary_Negative ///
SRC_Public_Figures_White SRC_Public_Figures_Black SRC_Public_Figures_Asian ///
SRC_Public_Figures_OtherRace Article_Valence_Binary_Positive ///
SRC_Public_Figures_AffectedED SRC_Public_Figures_Hispanic
describe
/*Subset data to specific variables: identifier variable, and key outcome and 
predictor variables */

save "data_work/edited_original_USA_EDandNM_v1.dta", replace
/*Save subset data - use this dataset for analyses, it contains the key 
dependent and independent variables. */


*------------------------
* Subsetting Data
*------------------------

/* Task: I want to save all, and only, the key outcome and predictor variables 
I will use in my analyses in a single dataset, 
"edited_original_USA_EDandNM_v2.dta". 

		- DV: 
			~ Article_Valence_Binary_Negative (binary)
			~ Article_Valence_Binary_Positive (binary)
			~ Article_Valence_Ordinal (ordinal)
		- IVs:
			~ Article_Year
			~ Article_Writer_Gender
			~ ED_Anorexia
			~ ED_Binge_Eating_Disorder
			~ ED_Bulimia
			~ NM_SM_Facebook
			~ NM_SM_Instagram 
			~ NM_SM_Tumblr
			~ NM_SM_Twitter
			~ NM_SM_YouTube
			~ SRC_Public_Figures
			~ SRC_Public_Figures_AffectedED
			~ SRC_Public_Figures_White
			~ SRC_Public_Figures_Black
			~ SRC_Public_Figures_Asian
			~ SRC_Public_Figures_OtherRace
			~ SRC_Public_Figures_Hispanic
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

drop if Article_Valence_Binary_Negative==.
*Drop missing observations from DV (2 missing values, N=624 new)

tab Article_Valence_Binary_Negative, missing
tab Article_Valence_Binary_Positive, missing
tab Article_Valence_Ordinal, missing
tab NM_SM_Instagram
*Check if now all variables have same N - yes! 
* N

save "data_work/edited_original_USA_EDandNM_v2.dta", replace
/*Save subset data - use this dataset for analyses, it contains the key 
dependent and independent variables. */


*--------------------
* Summary Statistics 
*--------------------

/* Use subsetted data for analyses: edited_original_USA_EDandNM_v2.dta
   New N = 624 articles */


* --- Continuous variables: summary statistics 
summarize Article_Year  


* --- Binary variables: frequency distribution
tabulate Article_Valence_Binary_Negative
*Key DV (main variable)

tabulate Article_Valence_Binary_Positive
*Key DV 

tabulate Article_Valence_Ordinal

tabulate ED_Anorexia

tabulate ED_Binge_Eating_Disorder 

tabulate ED_Bulimia 

tabulate NM_SM_Facebook

tabulate NM_SM_Instagram 

tabulate NM_SM_Tumblr

tabulate NM_SM_Twitter

tabulate NM_SM_YouTube

tabulate SRC_Public_Figures
			 
tabulate SRC_Public_Figures_AffectedED
			 
tabulate SRC_Public_Figures_White
			 
tabulate SRC_Public_Figures_Black
			 
tabulate SRC_Public_Figures_Asian
			 
tabulate SRC_Public_Figures_OtherRace
			 
tabulate SRC_Public_Figures_Hispanic

	

* --- Categorical variables: frequency distribution 
tabulate Article_Valence_Ordinal
* Key DV  
	
	
	
*-----------------------
* Visualizing Variables 
*-----------------------

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
	




*----------------------------------
* Closing Environment
*----------------------------------	
log close
translate data_cleaning.smcl data_cleaning.pdf, replace
