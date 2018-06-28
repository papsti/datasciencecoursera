################
## Question 1

## Download file
csv_filename <- "communities-idaho.csv"
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
#               csv_filename,
#               method="curl")

## Read file
communities <- read.csv(csv_filename)

## How many properties are worth $1,000,000 or more?
## VAL: property value
## 24: $1,000,000 +

## Remove NAs
values <- communities$VAL
values <- values[!is.na(values)]
length(values[values==24])

################
## Question 3

## Download data
xlsx_filename <- "natgas.xlsx"
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
#               xlsx_filename,
#               method="curl")

## Read data (using tidyverse package)
library(readxl)
dat <- read_excel(xlsx_filename, range = cell_rows(18:23))
dat <- dat[,7:15]

################
## Question 4

xml_filename <- "restaurants.xml"
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",
#               xml_filename,
#               method="curl")

## Read data
library(XML)
doc <- xmlTreeParse(xml_filename, useInternalNodes = TRUE)

## Get root node
root_node <- xmlRoot(doc)

## Get zipcodes
zipcodes <- xpathSApply(root_node, "//zipcode", xmlValue)

## Count number of restos in zip code 21231
length(zipcodes[zipcodes==21231])

################
## Question 5

## Read file
csv_filename <- "communities-idaho.csv"
library(data.table)
DT <- fread(csv_filename)

## Time expresions
# system.time({mean(DT[DT$SEX==1,]$wgtp15); mean(DT[DT$SEX==2,]$wgtp15)})
# system.time({tapply(DT$wgtp15,DT$SEX,mean)})
# system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
# system.time({sapply(split(DT$wgtp15,DT$SEX),mean)})
# system.time({mean(DT$wgtp15,by=DT$SEX)})
# system.time({DT[,mean(wgtp15),by=SEX]})
