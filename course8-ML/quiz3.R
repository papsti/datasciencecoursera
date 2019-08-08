## Quiz 3

## Check packages
library(AppliedPredictiveModeling)
packageDescription("AppliedPredictiveModeling")$Version 
library(caret)
packageDescription("caret")$Version 
library(ElemStatLearn)
packageDescription("ElemStatLearn")$Version 
library(pgmm)
packageDescription("pgmm")$Version 
library(rpart)
packageDescription("rpart")$Version 

## 1.
data(segmentationOriginal)

## Subset data
inTrain <- createDataPartition(segmentationOriginal$Class,
                               list = FALSE)
training <- segmentationOriginal[inTrain,]
testing <- segmentationOriginal[-inTrain,]

## Set seed and fit CART model (classification and regression trees)
## to predict class w/ rpart method and all predictor variables
## (with default caret settings)
set.seed(125)
model_fit <- train(Class ~ . , method = "rpart", data = training)

## Check model predictions
final_model <- model_fit$finalModel
library(rattle)
fancyRpartPlot(final_model)

## 3.
data(olive)
olive = olive[,-1]

## Train model
model_fit <- train(Area ~ . , method = "rpart", data = olive)

## Make predictions
newdata <- as.data.frame(t(colMeans(olive)))
predict(model_fit, newdata)

## 4.
data(SAheart)
set.seed(8484)
train <- sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA <- SAheart[train,]
testSA <- SAheart[-train,]

## Fit logistic regression model (method = "glm", family = "binomial")
## with Coronary Heart Disease (chd) as the outcome and age at onset
## (age), current alcohol consumption (alcohol), obesity levels 
## (obesity), cumulative tobacco (tobacco), type-A behavior (typea),
## and low density lipoprotein cholesterol (ldl) as predictors
set.seed(13234)
model_fit <- train(chd ~ age + alcohol + obesity + tobacco +
                     typea + ldl,
                   method = "glm", family = "binomial",
                   data = trainSA)

## Predict on training and test sets
predict_chd_trainSA <- predict(model_fit)
predict_chd_testSA <- predict(model_fit, newdata = testSA)

## Calculate misclassification rate
missClass <- function(values,prediction){
  sum(((prediction > 0.5)*1) != values)/length(values)
  }
missClass(trainSA$chd, predict_chd_trainSA)
missClass(testSA$chd, predict_chd_testSA)

## 5. 
data(vowel.train)
data(vowel.test)

## Set variable y to be a factor variable in training and test sets
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

## Set seed and fit random forest predictor for y ~ .
set.seed(33833)
library(randomForest)
model_fit <- randomForest(y ~ ., data = vowel.train)

## Calculate variable importance
var_importance <- varImp(model_fit)
order(var_importance, decreasing = TRUE)
