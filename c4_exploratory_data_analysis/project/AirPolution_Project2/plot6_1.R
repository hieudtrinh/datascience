# QUESTION 6 
# Compare emissions from motor vehicle sources in Baltimore City 
# (fips == "24510") with emissions from motor vehicle sources in Los Angeles 
# County, California (fips == "06037"). Which city has seen greater changes 
# over time in motor vehicle emissions?

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

subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",]
agg <- aggregate(Emissions ~ year + fips, subsetNEI, FUN = sum)
agg$fips[agg$fips=="24510"] <- "Baltimore, MD"
agg$fips[agg$fips=="06037"] <- "Los Angeles, CA"

qplot(year, Emissions, data = agg, color = fips, facets = fips ~ .) + 
    facet_grid(fips ~ ., scales = "free_y") + 
    geom_smooth(method = "lm") + 
    labs(title = "Total PM2.5 Motor Vehicls Emissions in Baltimore and Los Angeles County from 1999-2008")
