## plot2.R
## Author: Irena Papst

## Question to explore:
## Have total emissions from PM2.5 decreased in the Baltimore City,
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting
## system to make a plot answering this question.

## Load packages
library(dplyr)

## Read data
nei <- readRDS("data/summarySCC_PM25.rds")

## Convert column names to lowercase to make them easier to type
names(nei) <- tolower(names(nei))

## Calculate total emmissions by year for Baltimore City
baltimore <- nei %>%
    subset(fips == "24510") %>%
    group_by(year) %>%
    summarise(emissions = sum(emissions))

## Set up png device
png("plot2.png",
    width = 600, height = 400)

## Set plot margins
par(mar=c(5,5,3,1))

## Plot total emissions by year for Baltimore City
with(baltimore,
     plot(year, emissions,
          pch = 19,
          col = "gray40",
          xlab = "Year",
          ylab = "Emissions (tons)",
          main = "Total emissions of PM2.5 (Baltimore City)",
          cex = 2,
          cex.lab = 1.5,
          cex.axis = 1.2,
          cex.main = 2))

## Add linear regression line
abline(
  lm(emissions ~ year, data = baltimore),
  col = "gray60",
  lwd = 2
)

## Turn graphics device off
dev.off()