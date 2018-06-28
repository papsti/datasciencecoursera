################
## Question 1

## Download file
the_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
filename <- "communities-idaho.csv"
download.file(the_url, filename,
              method="curl")

## Read data
communities <- read.csv(csv_filename)

## Split names of df
splitnames <- strsplit(names(communities), "wgtp")
splitnames[123]

################
## Question 2

## Download and read files
the_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
filename <- "gdp.csv"
download.file(the_url, filename,
              method="curl")
gdp <- read.csv(filename, skip = 5, header = FALSE, nrows = 190)
gdp <- gdp[,c(1,2,4,5)]
names(gdp) <- c("shortcode", "gdp_ranking", "economy", "gdp_val")

## Replace commas in gdp values
mean(as.numeric(gsub(",", "", gdp$gdp_val)))

################
## Question 3
grep("^United", gdp$economy)

################
## Question 4

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

## Make colnames lowercase
names(merged) <- tolower(names(merged))

## Find number of countries with fiscal year end in June
length(grep("Fiscal year end: June", merged$special.notes))

################
## Question 5

library(quantmod)
## Get historical stock prices for Amazon
amzn = getSymbols("AMZN",auto.assign=FALSE)
## Get times the data were sampled
sampleTimes = index(amzn)

## Find number of samples in 2012
indx <- grep("2012", sampleTimes)
length(indx)

## Find number of samples on Mondays in 2012
sum(weekdays(sampleTimes[indx])=="Monday")
