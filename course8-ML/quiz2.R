## Quiz 2

## 1.
library(AppliedPredictiveModeling)
data(AlzheimerDisease)

adData <- data.frame(diagnosis, predictors)
trainIndex <- createDataPartition(diagnosis, p=0.5, list = FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]

## 2.

library(AppliedPredictiveModeling)
data(concrete)
library(Hmisc)

library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

for (cov in names(training)){
  p <- qplot(1:nrow(training), CompressiveStrength, data = training,
        colour = cut2(get(cov), g = 4),
        xlab = "Index") +
    labs(colour = cov)
  show(p)
}

## 3.

library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

hist(training$Superplasticizer)
hist(log(training$Superplasticizer+1))

## 4.

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

library(stringr)
covars <- names(training)[str_detect(names(training),
                                     regex("^IL"))]
training_subset <- training[,covars]

pp_obj <- preProcess(training_subset,
                     method = "pca",
                     thresh = 0.9)

print(pp_obj)

## 5.

library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

## subset covars
library(stringr)
covars <- names(training)[str_detect(names(training),
                                     regex("^IL"))]
subset_vars <- c(covars, "diagnosis")
training_subset <- training[, subset_vars]

## train models
model_plain <- train(diagnosis ~ ., data = training_subset,
                     method = 'glm')
ctrl <- trainControl(preProcOptions = list(thresh = 0.8))
model_pca <- train(diagnosis ~ ., data = training_subset,
                   method = 'glm',
                   preProcess = 'pca', trControl = ctrl)

## predict test data
testing_subset <- testing[, subset_vars]
test_plain <- predict(model_plain, testing_subset)
m_plain <- confusionMatrix(test_plain, testing_subset[,"diagnosis"])
test_pca <- predict(model_pca, testing_subset)
m_pca <- confusionMatrix(test_pca, testing_subset[,"diagnosis"])

## Print accuracy
print("Plain model accuracy:")
m_plain$overall["Accuracy"]
print("PCA model accuracy:")
m_pca$overall["Accuracy"]
