## plot6.R
## Author: Irena Papst

## Question to explore:
## Compare emissions from motor vehicle sources in Baltimore City with
## emissions from motor vehicle sources in Los Angeles County, 
## California (fips == "06037"). Which city has seen greater changes
## over time in motor vehicle emissions?

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

## Extract emissions data from motor vehicle sources
## for each city (Baltimore City and Los Angeles County)
vehicle <- nei[nei$scc %in% scc$scc[indx],] %>%
  subset(fips == "24510"|fips == "06037")

## Replace fips labels with city names
city_names <- data.frame(fips = c("24510", "06037"),
                         city = c("Baltimore City",
                                  "Los Angeles County"))
vehicle <- cbind(city = city_names$city[match(vehicle$fips,
                                         city_names$fips)],
                 vehicle)

## Calculate total emissions by city and year
vehicle <- vehicle %>%
    group_by(year, city) %>%
    summarise(emissions = sum(emissions))

## Define function to create text labels for linear model equation
lm_label <- function(df){
  ## df: (data frame) data upon which to perform regression
  ## (must have columns x = year, y = emissions)
  
  ## Return text string that gives regression slope ready for
  ## annotation
  m <- lm(emissions ~ year, df);
  paste0("slope = ", format(coef(m)[2], digits = 2))
}

## Make equation labels for each city
baltimore_lab <- lm_label(subset(vehicle,
                   city == "Baltimore City")[,c("year","emissions")])
la_lab <- lm_label(subset(vehicle,
            city == "Los Angeles County")[,c("year","emissions")])

## Set up png device
png("plot6.png",
    width = 600, height = 400)

## Plot emissions
p <- ggplot(vehicle, aes(x = year, y = emissions)) +
  geom_point(aes(col = city)) +
  geom_smooth(aes(col = city), method = "lm", se = FALSE) +
  labs(title = "Total emissions of PM2.5",
       subtitle = "(motor vehicle sources)",
       x = "Year",
       y = "Emissions (tons)",
       col = "City") +
  theme(title = element_text(size = 16),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 12),
        legend.text = element_text(size = 12)) +
  ## Annotate with linear model equation
  geom_text(x = 2006, y = 200,
            label = baltimore_lab, size = 5,
            aes(col = "Baltimore City"),
            show.legend = FALSE) +
  geom_text(x = 2006, y = 1400,
            label = la_lab, size = 5,
            aes(col = "Los Angeles County"),
            show.legend = FALSE)

plot(p)

## Turn graphics device off
dev.off()
