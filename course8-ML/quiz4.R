## Quiz 4

library(caret)

## 1.
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

## Set y to be factor variable in both sets
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

## Train model
set.seed(33833)
model1 <- train(y ~ ., method = 'rf', data = vowel.train)
model2 <- train(y ~ ., method = 'gbm', data = vowel.train)

## Predict on test set
predict_model1_test <- predict(model1, vowel.test)
predict_model2_test <- predict(model2, vowel.test)

## Get accuracy
accuracy <- function(prediction, actual){
  return(sum(prediction==actual)/length(actual))
}

aggrement_accuracy <- function(pred1, pred2, actual){
  agree_indx <- pred1 == pred2
  return(sum(pred1[agree_indx]==actual[agree_indx])/length(agree_indx))
}

rf_accu <- accuracy(predict_model1_test, vowel.test$y)
gbm_accu <- accuracy(predict_model2_test, vowel.test$y)
both_accu <- aggrement_accuracy(predict_model1_test,
                                predict_model2_test,
                                vowel.test$y)
print(paste0("RF accuracy: ", rf_accu))
print(paste0("GBM accuracy: ", gbm_accu))
print(paste0("Agreement accuracy: ", both_accu))

## 2.

library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

## Train model for diagnosis with all other variables
## using a random forest, boosted trees,
## and linear discriminant analysis
set.seed(62433)
model_rf <- train(diagnosis ~ ., method = 'rf', data = training)
model_gbm <- train(diagnosis ~ ., method = 'gbm', data = training)
model_lda <- train(diagnosis ~ ., method = 'lda', data = training)

## Predict diagnosis for each model
pred_rf <- predict(model_rf, testing)
pred_gbm <- predict(model_gbm, testing)
pred_lda <- predict(model_lda, testing)

## Stack models and predict
preds_df <- data.frame(pred_rf = pred_rf, pred_gbm = pred_gbm,
                       pred_lda = pred_lda,
                       diagnosis = testing$diagnosis)
model_stacked <- train(diagnosis ~ ., method = 'rf', data = preds_df)
pred_stacked <- predict(model_stacked, testing)

## Check accuracy of all models
rf_accu <- accuracy(pred_rf, testing$diagnosis)
gbm_accu <- accuracy(pred_gbm, testing$diagnosis)
lda_accu <- accuracy(pred_lda, testing$diagnosis)
stacked_accu <- accuracy(pred_stacked, testing$diagnosis)
print(paste0("RF accuracy: ", rf_accu))
print(paste0("GBM accuracy: ", gbm_accu))
print(paste0("LDA accuracy: ", lda_accu))
print(paste0("Stacked accuracy: ", stacked_accu))

## 3.
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

## Fit lasso model to predict compressive strength
set.seed(233)
library(dplyr)
predictors <- as.matrix(select(training, -c("CompressiveStrength")))
response <- as.numeric(unlist(
            select(training, c("CompressiveStrength"))
            ))
model <- enet(x = predictors,
              y = response)

## Plot
library(elasticnet)
plot.enet(model, xvar = "penalty")

## 4.
library(lubridate) # For year() function below
dat = read.csv("~/Desktop/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

## Fit model
library(forecast)
model <- bats(tstrain)
pred <- forecast(model, h = nrow(testing))
# pred <- forecast(model, h = 2)

## Function to count proportion of true values within 95% prediction
## bounds
prop_accurate <- function(actual, pred){
  ## Get prediction interval bounds
  n_forecast <- length(pred$lower)/2
  lower_95 <- pred$lower[(n_forecast+1):(2*n_forecast)]
  upper_95 <- pred$upper[(n_forecast+1):(2*n_forecast)]
  ## Check whether actual points are in 95% pred int
  in_pred_int <- ((actual >= lower_95) & (actual <= upper_95))
  prop_in_pred_int <- sum(in_pred_int)/length(in_pred_int)
  return(prop_in_pred_int)
}
print(paste0("Prop. of testing points in prediction interval: ",
             prop_accurate(testing$visitsTumblr, pred)))

## 5.
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

## Fit a support vector machine
library(e1071)
set.seed(325)
model <- svm(CompressiveStrength ~ ., data = training)
pred <- predict(model, testing)
RMSE(pred, testing$CompressiveStrength)
