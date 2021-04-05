---
title: "Generalized Linear Models for Binary Data"
author: "Me"
date: "05/04/2021"
output:
  html_document: default
  pdf_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
library(ggplot2)
library(ggcorrplot)
library(ggpubr)
```
 
## Admitting to the graduate school

A researcher is interested in how variables, such as GRE (Graduate Record Exam scores), GPA (grade point average) and prestige of the undergraduate institution, effect admission into graduate school. The response variable, admit/don’t admit, is a binary variable. 

For our analysis we will take data from publicly available resources.
```{r cars}
data = read.csv('https://stats.idre.ucla.edu/stat/data/binary.csv')
```

### Exploratory Data Analysis
```{r echo=FALSE}
str(data)
```
We do not have any NA in our data. 
```{r echo=FALSE}
sum(is.na(data))
```

### Distribution of variables and correlation
```{r}
corr <- round(cor(data), 2)
corr_plot <- ggcorrplot(corr)

hist1 = ggplot(data) +
  geom_bar(mapping = aes(x = gre))
hist2 = ggplot(data) +
  geom_bar(mapping = aes(x = gpa))
hist3 = ggplot(data) +
  geom_bar(mapping = aes(x = rank))
ggarrange(hist1, hist2, hist3, corr_plot)
```

Distribution of variables are close to normal distribution, but with large deviations at the end. Also there is low correlation between GPA and GRE. 

```{r}
data$admit = as.factor(data$admit)
data$rank = as.factor(data$rank)
ggplot(data, aes(x=gpa, y=gre, group = rank, color = admit))+
  geom_violin(trim = FALSE)+
  geom_point()+
  facet_grid(cols = vars(rank))+
  theme_classic2()+
  ylab('Graduate Record Exam scores')+
  xlab('Grade Point average')+
  labs(color = 'Admited')
```
```{r}
ggplot(data, aes(x = gpa, y = gre, color = rank))+
  geom_point()+
  facet_grid(rows = vars(rank))
```

As I said earlier, there is a correlation between GRE and GPA, but it is not high. Most of the students with the highest scores on one variable do not have the highest scores on the other. Undergraduate institutions with different ranks have the same point grid patterns, but the lowest-ranked higher education institutions have fewer students with the highest GPA scores. 

### Log reg model

Let's analyze the full model first 
```{r}
model_1 <- glm(admit ~., family = 'binomial', data = data)
summary(model_1)
```
### Model diagnosis
```{r}
drop1(model_1, test = "Chi")
```
As we can see, our complete model is perfect. Removing any of the predictors will reduce the quality of our model and lead to an increase in **AIC**. In this regard, I am using the complete model 

### Conditions of model applicability 

#### Overdispersion 
First lest check overdispersion of our model using function of Ben Bolker (http://bbolker.github.io/mixedmodels-misc/glmmFAQ.html)
```{r echo=FALSE}
overdisp_fun <- function(model) {
  rdf <- df.residual(model)  
  if (any(class(model) == 'negbin')) rdf <- rdf - 1 
  rp <- residuals(model,type='pearson') 
  Pearson.chisq <- sum(rp^2) 
  prat <- Pearson.chisq/rdf 
  pval <- pchisq(Pearson.chisq, df=rdf, lower.tail=FALSE)
  c(chisq=Pearson.chisq,ratio=prat,rdf=rdf,p=pval)       
}
```

Overdispersion ratio are close to 1, so everything is **OK**.
```{r}
overdisp_fun(model_1)
```

#### Linearity check
Linear pattern in residuals are **OK**
```{r message=FALSE}
model_1_diag <- fortify(model_1)
ggplot(model_1_diag, aes(x = .fitted, y = .stdresid))+
  geom_point()+
  geom_smooth()
```

### Model prediction
```{r}
MyData = expand.grid(gpa = seq(min(data$gpa), max(data$gpa), 0.01),
                     gre = seq(min(data$gre), max(data$gre), 10),
                     rank = levels(data$rank))
MyData$Predicted <- predict(model_1, newdata = MyData, type = 'response')

ggplot(MyData, aes(x = gre, y = Predicted, color = gpa, group = gpa))+
  geom_line()+
  facet_grid(rows = vars(rank))+
  scale_color_gradient(low = 'green', high = 'red') +
  xlab('Graduate Record Exam scores')+
  ylab('Chance to admit')+
  labs(color = 'Grade Point average')+
  ggtitle('Model Prediction')
```

Due to our model prediction we can make a conclusion that GRE and GPA scores play significant role in change to admit to the graduate school, but most significant factor is prestige of the undergraduate institution. 

Worst student from top rank undergraduate institution has the same chance to admit to the graduate school as best student from low rank institution.


**How many times will the probability of enrollment change depending on the rank of the undergraduate institution:**
```{r echo=FALSE}
exp(coef(model_1)[4])
exp(coef(model_1)[5])
exp(coef(model_1)[6])
```
### Conclusion
Points play significant role in admission success, but you need to study in top rank institution for highly increased chances to admit. 





