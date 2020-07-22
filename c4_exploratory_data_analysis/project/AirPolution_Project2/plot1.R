# QUESTION 1
# Have total emissions from PM2.5 decreased in the United States from 1999 
# to 2008? Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
# and 2008.

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

# Compute Summary Statistics of Data Subsets
# aggregate(formula, data, FUN, ..., subset, na.action = na.omit)
totalEmissionByYear <- aggregate(Emissions ~ year, data = NEI, FUN=sum)

# removing intermediate in memory data objects
rm(NEI)

# head(totalEmissionByYear)
# year Emissions
# 1 1999   7332967
# 2 2002   5635780
# 3 2005   5454703
# 4 2008   3464206

# plot(x, y = NULL, type = "p",  xlim = NULL, ylim = NULL,
# log = "", main = NULL, sub = NULL, xlab = NULL, ylab = NULL,
# ann = par("ann"), axes = TRUE, frame.plot = axes,
# panel.first = NULL, panel.last = NULL, asp = NA,
# xgap.axis = NA, ygap.axis = NA,
# ...)

png(filename = "plot1.png", width=600, height=480)
# create a scatter plot using type b for both point and line
plot(totalEmissionByYear$year,
     totalEmissionByYear$Emissions,
     type = "b",
     main = "Aggregated PM2.5 Emission in the United States",
     ylab = "Emission PM2.5 (tons)",
     xlab = "Year"
     )

dev.off()


