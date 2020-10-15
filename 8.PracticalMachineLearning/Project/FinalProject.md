---
title: "Predicting Exercise Activity"
output: 
  html_document: 
    keep_md: yes
---



## Background

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, the goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. 


## Loading data


```r
library(caret)
library(doParallel)
if (!file.exists('train.csv')) {
  download.file(url = 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv', 
                destfile = 'train.csv', method = 'curl') 
}
if (!file.exists('test.csv')) {
  download.file(url = 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv', 
                destfile = 'test.csv', method = 'curl')
}
trainData <- read.csv('train.csv')
testData <- read.csv('test.csv')
```

## Exploring and cleaning data


```r
names(trainData)
names(testData)
```
There's no "classe" column in test data so we'll split the training data

```r
set.seed(10)
inTrain <- createDataPartition(y = trainData$classe, p = 0.7, list = F)
training <- trainData[inTrain, ]
testing <- trainData[-inTrain, ]
```

Deleting irrelevant columns

```r
training <- training[,-1:-7]
testing <- testing[,-1:-7]
```

Deleting columns filled with NAs

```r
training <- training[, (colSums(is.na(training)) == 0)]
testing <- testing[, (colSums(is.na(testing)) == 0)]
```

Removing zero covariates

```r
nzv <- nearZeroVar(training, saveMetrics = T)
training <- training[, row.names(nzv[nzv$nzv == FALSE, ])]
testing <- testing[, row.names(nzv[nzv$nzv == FALSE, ])]
training$classe <- as.factor(training$classe)
testing$classe <- as.factor(testing$classe)
```

## Modeling



Setup cross-validation. It was found out that 3 subsamples is good for accuracy
and speed.

```r
fitControl <- trainControl(method = "cv", number = 3, allowParallel = TRUE)
```

We'll make 3 models and compare their accuracy and speed:

Model 1: Applying Linear Discriminant Analysis (LDA)

```r
set.seed(10)
ldaModel <- train(classe ~. , data = training, method = 'lda')
```

Predict test outcomes using this model

```r
pred.lda <- predict(ldaModel, newdata = testing)
confusionMatrix(pred.lda, testing$classe)$table
```

```
##           Reference
## Prediction    A    B    C    D    E
##          A 1370  177  103   51   41
##          B   42  734   83   36  204
##          C  145  142  704  116   97
##          D  114   43  118  720  104
##          E    3   43   18   41  636
```

```r
confusionMatrix(pred.lda, testing$classe)$overall[1]
```

```
##  Accuracy 
## 0.7075616
```
The accuracy for LDA model is 70.7% 

Model 2: Applying Random Forests

```r
rfModel <- train(classe ~. , data = training, method = 'rf',trControl = fitControl)
```

Predict test outcomes using this model

```r
pred.rf <- predict(rfModel, newdata = testing)
confusionMatrix(pred.rf, testing$classe)$table
```

```
##           Reference
## Prediction    A    B    C    D    E
##          A 1674    8    0    0    0
##          B    0 1126    5    0    0
##          C    0    5 1019   22    4
##          D    0    0    2  942    1
##          E    0    0    0    0 1077
```

```r
confusionMatrix(pred.rf, testing$classe)$overall[1]
```

```
##  Accuracy 
## 0.9920136
```
The accuracy for random forest model is 99.2% 

Model 3: Applying Gradient Boosting Method

```r
gbmModel <- train(classe ~. , data = training, method = 'gbm',trControl = fitControl)
```

```
## Iter   TrainDeviance   ValidDeviance   StepSize   Improve
##      1        1.6094             nan     0.1000    0.2330
##      2        1.4616             nan     0.1000    0.1605
##      3        1.3606             nan     0.1000    0.1265
##      4        1.2814             nan     0.1000    0.1001
##      5        1.2183             nan     0.1000    0.0923
##      6        1.1594             nan     0.1000    0.0814
##      7        1.1094             nan     0.1000    0.0685
##      8        1.0668             nan     0.1000    0.0599
##      9        1.0295             nan     0.1000    0.0613
##     10        0.9917             nan     0.1000    0.0476
##     20        0.7584             nan     0.1000    0.0290
##     40        0.5302             nan     0.1000    0.0143
##     60        0.4031             nan     0.1000    0.0059
##     80        0.3211             nan     0.1000    0.0049
##    100        0.2642             nan     0.1000    0.0036
##    120        0.2242             nan     0.1000    0.0036
##    140        0.1889             nan     0.1000    0.0017
##    150        0.1753             nan     0.1000    0.0031
```

Predict test outcomes using this model

```r
pred.gbm <- predict(gbmModel, newdata = testing)
confusionMatrix(pred.gbm, testing$classe)$table
```

```
##           Reference
## Prediction    A    B    C    D    E
##          A 1636   51    0    0    6
##          B   24 1050   27    4   13
##          C    9   37  983   37   18
##          D    3    0   13  914   12
##          E    2    1    3    9 1033
```

```r
confusionMatrix(pred.gbm, testing$classe)$overall[1]
```

```
##  Accuracy 
## 0.9542906
```
The accuracy for gradient boosting method model is 95.4% 

## Conclusions
It was expected that random forest and boosting would be the most accurate and 
so it was. Random tree forest was the slowest of all three and LDA was the less
accurate.


