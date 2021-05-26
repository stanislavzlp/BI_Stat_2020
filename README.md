# Projects on statistic in R Bioinformatic Institute 2020/21


### Content

1. [Project №1 &ndash; Exploratory Data analysis (EDA)](#eda)
2. [Project №2 &ndash; Linear regression analysis](#lr)
3. [Project №3 &ndash; Principal components analysis (PCA)](#pca)
4. [Project №4 &ndash; Survival analysis](#sa)
5. [Project №5 &ndash; Logistic regression](#logreg)


## Exploratory Data analysis (EDA) <a name="eda"></a>

During this project, I performed an analysis of mussel characteristics. Provided data contains information about the number of rings, gender (male, female, child), 
length, diameter, width, shell length, etc. 

All data separated into several csv files. In the first place, I wrote a similar function with one purpose - to unite all separated data to one dataset. 
I performed exploratory data analysis (EDA) and found some features and potential correlations between variables. Also, I found some descriptive statistics and compared different groups of mussels with each other, etc. More detailed information about project aims is presented here (link).

Project code and report stored in [project_1_mussel]() 


## Linear regression analysis <a name="lr"></a>

For this project I used the dataset Boston from the MASS library in R. This dataset contains information about house cost in Boston in 1970-1980 years. Aim of this 
project is to find how the average cost of home-occupied houses depends on various factors. 

Main aims of the project:
1. Make a linear model, including all parameters (standardized)
2. Diagnose the model  
  2.1. Check the linearity of the relationship  
  2.2. Check influential observations  
  2.3. Check the independence of observations  
  2.4. Check the normal distribution and constancy of variance  

3. Make your linear model with the most important predictors

After a diagnosis of the model, I removed some predictors and formed the best model for house price predictions.

Project code and report stored in [project_2_Boston]()


## Principal components analysis (PCA) <a name="pca"></a>

In this project, I analyzed data from research made in 2015. On mouse models were studied how Down syndrome influences the expression level of different proteins. 

Original data is [here](https://archive.ics.uci.edu/ml/datasets/Mice+Protein+Expression#)

The original paper is [here](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0119491)

I analyzed the difference in the production of BDNF_N in different classes of mice using ANOVA. The expression of this protein differs between some classes.

Test linear model for a prediction production level of ERBB4_N protein demonstrated the failure of this analysis due to multicollinearity between predictions. After linear 
model diagnosis I performed PCA. 

Project code and report stored in [project_3_mouse]()

## Survival analysis <a name="sa"></a>

In this project, I performed survival analysis for dataset ovarian from the survival library.

Main aims of the project:
1. EDA for dataset
2. Kaplan-Meier estimator
3. Determine groups with the best survival rate
4. Identify the factors that affect the risk and assess the risk ratio

Project code and report stored in [project_4_survival]()

## Logistic regression <a name="logreg"></a>


Logistic regression project for data from this [sourse](https://stats.idre.ucla.edu/stat/data/binary.csv).

Data information: A researcher is interested in how variables, such as GRE (Graduate Record Exam scores),
GPA (grade point average) and prestige of the undergraduate institution, affect admission into graduate school. 
The response variable, admit/don’t admit, is binary.
 
In this project I performed:
 1. EDA  
 2. Make a logistic regression model  
 3. Checked conditions for the applicability of the model  
 4. Made and visualized predictions using a logistic regression model
 
Project code and report stored in [project_5_amdission]()
