## plot5.R
## Author: Irena Papst

## Question to explore:
## How have emissions from motor vehicle sources changed from
## 1999–2008 in Baltimore City?

## Load packages
library(dplyr)
library(ggplot2)

## Read data
nei <- readRDS("data/summarySCC_PM25.rds")
scc <- readRDS("data/Source_Classification_Code.rds")

## Convert column names to lowercase to make them easier to type
names(nei) <- tolower(names(nei))
names(scc) <- tolower(names(scc))

## Find motor vehicle sources
indx <- grep("vehicle", scc$short.name, ignore.case = TRUE)

## Calculate total emmissions by year from motor vehicle sources
## in Baltimore City
baltimore_vehicle <- nei[nei$scc %in% scc$scc[indx],] %>%
  subset(fips == "24510") %>%
  group_by(year) %>%
  summarise(emissions = sum(emissions))

## Set up png device
png("plot5.png",
    width = 600, height = 400)

## Plot emissions
p <- ggplot(baltimore_vehicle, aes(x = year, y = emissions)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Total emissions of PM2.5 in Baltimore City",
       subtitle = "(motor vehicle sources)",
       x = "Year",
       y = "Emissions (tons)") +
  theme(title = element_text(size = 16),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 12))

plot(p)

## Turn graphics device off
dev.off()
