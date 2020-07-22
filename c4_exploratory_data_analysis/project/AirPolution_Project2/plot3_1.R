# QUESTION 3
# Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases 
# in emissions from 1999–2008 for Baltimore City? Which have seen increases 
# in emissions from 1999–2008? Use the ggplot2 plotting system to make a 
# plot answer this question.

library(dplyr)
library(ggplot2)

# Download database from the National Emissions Inventory (NEI) website
fromUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
localFile <- "data/NEI_data.zip"
# Two data files source_Classification_Code.rds and summarySCC_PM25.rds
sourceFilePath <- "data/Source_Classification_Code.rds"
summaryFilePath <- "data/summarySCC_PM25.rds"

if (!file.exists("data")) dir.create("data")
if (!file.exists(localFile)) 
    download.file(fromUrl,destfile = localFile, method = "curl", extra = '-L')

# SCC <- readRDS(sourceFilePath)
NEI <- readRDS(summaryFilePath)

# project from peer
baltimore <- subset(NEI, fips=="24510")
baltimore$year <- as.factor(baltimore$year)
agg <- aggregate(Emissions ~ (year+type), baltimore, sum)

ggplot(data=agg, aes(fill=type, y=Emissions, x=year)) +
    geom_bar(stat="identity") +
    facet_wrap(~type) +
    ggtitle("Total PM2.5 Emissions in Baltimore City By Source Type") +
    labs(x="Year", y="PM2.5 Emissions (Tons)")
