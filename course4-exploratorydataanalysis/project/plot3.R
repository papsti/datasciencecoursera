## plot3.R
## Author: Irena Papst

## Question to explore:
## Of the four types of sources indicated by the type (point,
## nonpoint, onroad, nonroad) variable, which of these four sources
## have seen decreases in emissions from 1999–2008 for Baltimore City?
## Which have seen increases in emissions from 1999–2008? Use the 
## ggplot2 plotting system to make a plot answer this question.

## Load packages
library(dplyr)
library(ggplot2)
library(tools)

## Read data
nei <- readRDS("data/summarySCC_PM25.rds")

## Convert column names to lowercase to make them easier to type
names(nei) <- tolower(names(nei))

## Calculate total emmissions by year for Baltimore City
## for each type of source
baltimore <- nei %>%
  subset(fips == "24510") %>%
  group_by(type, year) %>%
  summarise(emissions = sum(emissions))

## Set up png device
png("plot3.png",
    width = 600, height = 400)

## Plot emissions
p <- ggplot(baltimore, aes(x = year, y = emissions)) +
  geom_point(aes(col = type)) +
  geom_smooth(aes(col = type), method = "lm", se = FALSE) +
  labs(title = "Total emissions of PM2.5 (Baltimore City)",
       x = "Year",
       y = "Emissions (tons)",
       col = "Source Type") +
  theme(title = element_text(size = 16),
        axis.title = element_text(size = 14),
        legend.title = element_text(size = 14),
        axis.text = element_text(size = 12),
        legend.text = element_text(size = 12))

plot(p)

## Turn graphics device off
dev.off()