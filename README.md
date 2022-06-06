# SOC401-2, Spring 2022
STATA code for data cleaning and analyses for final project (logistic regression models).

Author: Valerie Gruest
SOC 401-2, Final Project (Spring 2022) 

**Project:** "Eating Disorders and New Media: Exploring Negative Article Valence in U.S. News Coverage"

**Original Dataset:** ED & New Media 
  - Excluded 2 observations with missing values for DV - negative article 
	  valence (N=624)
	- Excluded 19 influential observations for the full logistic regression 
	  model (N=605)
   
**Research Questions: **
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

**Key Variables:**
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

**Files:**
 - Data:
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
			    *Changes were documented using the "data_cleaning_USA_EDandNM_SP22.do" script. 
			
		~ edited_original_USA_EDandNM_v2.dta : Second edited version of the data 
			from the dataset. This version modified the 
			"edited_original_USA_EDandNM_v1.dta" data using Stata -
			subsetted the data I used for analyses, keeping only key variables:
	        * Changes were documented using the "data_cleaning_USA_EDandNM_SP22.do" script.

		~ edited_original_USA_EDandNM_v3.dta : Third edited version of the data
			from the dataset. This version modified the 
			"edited_original_USA_EDandNM_v2.dta" data using Stata -
			subsetted the data used for analyses, excluding influential 
			observations. 
	        * Changes were documented using the "data_analyses_USA_EDandNM_SP22.do" script.



**- Scripts:**
	~ data_cleaning_USA_EDandNM_SP22.do : Exploring and cleaning data for the project
	    * Data: raw_USA_EDandNM_v1.dta (raw data)

          ~ Managing missing values
          ~ Cleaning variables 
            - Creating indicator/dummy variables
            - Recoding variables
            - Labeling variables
          ~ Exploring original data
            - Summary statistics and visualizing variables
          ~ Subsetting data to keep key variables 
            - Saved data as: edited_original_USA_EDandNM_v2.dta 

	~ data_analyses_USA_EDandNM_SP22.do : Exploring Project Data and Running Logistic 
    Regression Models
	    *Data: edited_original_USA_EDandNM_v2.dta 

          ~ Exploring and visualizing data for the project
            - Checked for influential observations
                 ~ Saved data as: edited_original_USA_EDandNM_v3.dta
            - Summary statistics and visualizing variables
          ~ Assessing logistic regression assumptions
          ~ Running logistic regression models
            - Various interpretations
            - Compared models 
          ~ Tables 
            - Descriptive statistics and regression results 

	    *Note: The "data_cleaning.do" script needs to be run prior to this script, 
	     "data_analyses.do".


**Order in which to run analyses:**
    1. Create a main folder, which will be the working directory for the project.
        	~ Original folder is called "SP22_SOC401".
    2. Create sub-folders within the main folder to house raw data, working data, scripts, figures 
       and outputs, and log files.
        	~ Original sub-folders called "data_raw", "data_work", "scripts", "figs_outputs" and 
        	  "log_files".
    3. Save the raw data file in the raw data folder (serves as backup) and in the working data 	 
       folder (servers as working file). 
        	~ raw data: "raw_USA_EDandNM_v1.dta"
    4. Save the working data file in the working data folder (servers as working file). 
          ~ working data (removed 2 missing values from DV): edited_original_USA_EDandNM_v2.dta
          ~ working data (excluded 19 influential observations): edited_original_USA_EDandNM_v3.dta
    5. Open the "data_cleaning.do" script in Stata and click "Execute (do). 
          ~ Make sure to change the working directory for the project and adjust any file paths in the 
            "Set Up Environment" section of the script to ensure all the data is being routed 
            correctly. 
    6. Open the "data_analyses.do" script in Stata and click "Execute (do). 
          ~ Make sure to change the working directory for the project and adjust any file paths in the 
            "Set Up Environment" section of the script to ensure all the data is being routed 
            correctly. 




