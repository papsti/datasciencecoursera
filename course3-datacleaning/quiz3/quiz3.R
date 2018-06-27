################
## Question 1

## Download file
the_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
filename <- "communities-idaho.csv"
download.file(the_url, filename,
              method="curl")

## Read data
communities <- read.csv(csv_filename)

## Identify househols on greater than 10 acres
## who sold more than $10,000 worth of agriculture products
agricultureLogical <- with(communities, ACR==3 & AGS==6)

## Get first 3 indicies for above logical vector
head(which(agricultureLogical), n=3)

################
## Question 2

## Download file
the_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
filename <- "jeff.jpeg"
download.file(the_url, filename,
              method="curl")

## Read jpeg data
library(jpeg)
jeff <- readJPEG(filename, native = TRUE)

## Get desired quantiles
quantile(jeff, probs = c(0.3,0.8))

################
## Question 3

## Download and read files
the_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
filename <- "gdp.csv"
download.file(the_url, filename,
              method="curl")
gdp <- read.csv(filename, skip = 5, header = FALSE, nrows = 190)
gdp <- gdp[,c(1,2,4,5)]
names(gdp) <- c("shortcode", "gdp_ranking", "economy", "gdp")

the_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
filename <- "edu.csv"
download.file(the_url, filename,
              method="curl")
library(dplyr)
edu <- read.csv(filename, header = TRUE) %>% rename(shortcode = "CountryCode")

## Merge data
intersect(names(gdp),names(edu))
merged <- merge(gdp, edu, by="shortcode")

## Check number of id matches
nrow(merged)

## Sort df in descending order by GDP rank and find 13th country
sorted <- arrange(merged, desc(gdp_ranking))
sorted[13,]

################
## Question 4

## Group by income group and calculate means for each category
sorted %>%
  group_by(Income.Group) %>%
  summarize(mean = mean(gdp_ranking, na.rm = TRUE))

################
## Question 5

## Cut GDP ranking into 5 quantile groups
library(Hmisc)
sorted$gdp_ranking_q <- cut2(sorted$gdp_ranking, g = 5)

## Make contingency table counting number of countries in each
## pair of categories (between gdp ranking quantile groups
## and income groups)
table(sorted$gdp_ranking_q, sorted$Income.Group)
