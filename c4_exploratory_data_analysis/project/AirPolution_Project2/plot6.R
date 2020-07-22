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

# extract data for motor vehicle emission in the Baltimore City and LA
emissionSubset <- subset(NEI, (fips == "24510" | fips == "06037") & type == "ON-ROAD")
emissionByYearAndFips <- aggregate(Emissions ~ year + fips, data = emissionSubset, FUN = sum)
rm(NEI, emissionSubset)

# add city column for two locations
emissionByYearAndFips$city[emissionByYearAndFips$fips=="24510"] <- "Baltimore City"
emissionByYearAndFips$city[emissionByYearAndFips$fips=="06037"] <- "Los Angeles County"
png("plot6.png", width=1040, height=480)

# geom_bar(aes(fill=year) add color
g <- ggplot(emissionByYearAndFips, aes(x=factor(year), y=Emissions)) +
    facet_grid(. ~ city) +
    geom_bar(aes(fill=year), stat = "identity") +
    ylab(expression('Emission PM'[2.5]*" (tons)")) +
    xlab("Year") +
    ggtitle(expression('Aggregated Emission PM'[2.5]*" from Motor Vehicle in Baltimore City vs Los Angeles"))

print(g)

dev.off()

