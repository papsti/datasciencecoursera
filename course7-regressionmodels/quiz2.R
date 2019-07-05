## 1. hypothesis test

x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

fit <- lm(y~x)
summary(fit)$coef[2,"Pr(>|t|)"]

## 2. estimate residual standard error from linear regression
summary(fit)$sigma

## 3. confidence interval from linear regression
data(mtcars)
fit <- lm(mpg ~ wt, data = mtcars)
mwt <- mean(mtcars$wt)
pred <- predict(fit, newdata = data.frame(wt = mwt),
                interval = ("confidence"))
pred[,"lwr"]
## ALT SOL
fit <- lm(mpg ~ I(wt - mean(wt)), data = mtcars)
confint(fit)

# p <- ggplot(data=mtcars, aes(x = wt, y = mpg)) +
#   geom_point() +
#   geom_smooth(method='lm')
# p

## 5. prediction interval from linear regression
fit <- lm(mpg ~ wt, data = mtcars)
pred <- predict(fit, newdata = data.frame(wt = 3),
                interval = ("prediction"))
pred[,"upr"]

## 6. scaling linear regression model
fit <- lm(mpg ~ I(wt/2), data = mtcars)
fit_coef <- summary(fit)$coefficients
lwr <- fit_coef[2,1] - qt(.975, df = fit$df) * fit_coef[2,2]
lwr
## ALT SOL
fit <- lm(mpg ~ wt, data = mtcars)
confint(fit)[2,]*2

## 9. ratio of sum of squared errors

fit <- lm(mpg ~ wt, data = mtcars)
se <- summary(fit)$coefficients[,"Std. Error"]
r_se <- se[2]/se[1]
r_se

fit1 <- lm(mpg ~ wt, data = mtcars)
fit2 <- lm(mpg ~ 1, data = mtcars)
sse1 <- sum((predict(fit1)-mtcars$mpg)^2)
sse2 <- sum((predict(fit2)-mtcars$mpg)^2)
sse1/sse2