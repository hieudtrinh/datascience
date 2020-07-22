# QUESTION 2
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
# to make a plot answering this question.


# Download database from the National Emissions Inventory (NEI) website
source("commonFunctions.R")
downloadAndUnzipData("data")

# Two data files source_Classification_Code.rds and summarySCC_PM25.rds
sourceFilePath <- "data/Source_Classification_Code.rds"
summaryFilePath <- "data/summarySCC_PM25.rds"
NEI <- readRDS(summaryFilePath)

# extract data for the Baltimore City
# baltimoreSubset <- subset(NEI, fips == "24510")
# OR 
baltimoreSubset <- filter(NEI, fips == "24510")
rm(NEI)
baltimoreEmissionByYear <- aggregate(Emissions ~ year, data = baltimoreSubset, FUN = sum)

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




