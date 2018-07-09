## plot1.R
## Author: Irena Papst

## Question to explore:
## Have total emissions from PM2.5 decreased in the United States from
## 1999 to 2008? Using the base plotting system, make a plot showing 
## the total PM2.5 emission from all sources for each of the years
## 1999, 2002, 2005, and 2008.

## Load packages
library(dplyr)

## Read data
nei <- readRDS("data/summarySCC_PM25.rds")

## Convert column names to lowercase to make them easier to type
names(nei) <- tolower(names(nei))

## Calculate total emmissions by year
total <- nei %>%
  group_by(year) %>%
  summarise(emissions = sum(emissions))

## Set up png device
png("plot1.png",
    width = 600, height = 400)

## Set plot margins
par(mar=c(5,5,3,1))

## Plot total emissions by year
with(total,
     plot(year, emissions,
          pch = 19,
          col = "gray40",
          xlab = "Year",
          ylab = "Emissions (tons)",
          main = "Total emissions of PM2.5",
          cex = 2,
          cex.lab = 1.5,
          cex.axis = 1.2,
          cex.main = 2))

## Add linear regression line
abline(
  lm(emissions ~ year, data = total),
  col = "gray60",
  lwd = 2
  )

## Turn graphics device off
dev.off()