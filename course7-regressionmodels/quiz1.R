## 1. weighted least squares minimizer
x <- c(0.18, -1.54, 0.42, 0.95) # data
w <- c(2, 1, 3, 1) # weights
mu <- sum(w*x)/sum(w)
print(mu)

## 2. regression thru origin
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm(y~0+x)

## 3. linear regression
data(mtcars)
lm(mpg~wt, data=mtcars)

## 6. normalization
x <- c(8.58, 10.46, 9.01, 9.64, 8.86) 
xbar <- mean(x)
s <- sd(x)
x1tilde <- (x[1]-xbar)/s
print(x1tilde)

## 7. linear regression
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm(y~x)

## 9. least squares minimizer
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
print(mean(x))
