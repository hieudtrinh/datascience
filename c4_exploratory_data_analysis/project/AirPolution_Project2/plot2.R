# QUESTION 2
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
# to make a plot answering this question.

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

# extract data for the Baltimore City
# baltimoreSubset <- subset(NEI, fips == "24510")
# OR 
emissionSubset <- filter(NEI, fips == "24510")
baltimoreEmissionByYear <- aggregate(Emissions ~ year, data = emissionSubset, FUN = sum)
rm(NEI, emissionSubset)

png(filename = "plot2.png", width=600, height=480)
# create a scatter plot using type b for both point and line
plot(baltimoreEmissionByYear$year,
     baltimoreEmissionByYear$Emissions,
     type = "b",
     main = "Baltimore Aggregated PM2.5 Emission by year",
     ylab = "Emission PM2.5 (tons)",
     xlab = "Year"
)

dev.off()




