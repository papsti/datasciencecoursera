## plot4.R
## Author: Irena Papst

## Question to explore:
## Across the United States, how have emissions from coal
## combustion-related sources changed from 1999–2008?

## Read data
nei <- readRDS("data/summarySCC_PM25.rds")
scc <- readRDS("data/Source_Classification_Code.rds")

## Convert column names to lowercase to make them easier to type
names(nei) <- tolower(names(nei))
names(scc) <- tolower(names(scc))

## Find coal sources
indx <- grep("coal", scc$ei.sector, ignore.case = TRUE)
## Find combustion coal sources
indx <- grep("comb", scc$ei.sector[indx], ignore.case = TRUE)

## Calculate total emmissions by year for coal combustion sources
coalcomb <- nei[nei$scc %in% scc$scc[indx],] %>%
   group_by(year) %>%
   summarise(emissions = sum(emissions))

## Set up png device
png("plot4.png",
    width = 600, height = 400)

## Plot emissions
p <- ggplot(coalcomb, aes(x = year, y = emissions)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Total emissions of PM2.5",
       subtitle = "(coal sources)",
       x = "Year",
       y = "Emissions (tons)") +
  theme(title = element_text(size = 16),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 12))

plot(p)

## Turn graphics device off
dev.off()
