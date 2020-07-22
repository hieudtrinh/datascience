# QUESTION 1
# Have total emissions from PM2.5 decreased in the United States from 1999 
# to 2008? Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
# and 2008.

# Download database from the National Emissions Inventory (NEI) website
source("commonFunctions.R")
downloadAndUnzipData("data")

# Two data files source_Classification_Code.rds and summarySCC_PM25.rds
sourceFilePath <- "data/Source_Classification_Code.rds"
summaryFilePath <- "data/summarySCC_PM25.rds"

# SCC = readRDS(sourceFilePath)
NEI = readRDS(summaryFilePath)
# dim(NEI)
# [1] 6497651       6

# names(NEI)
# [1] "fips"      "SCC"       "Pollutant" "Emissions" "type"      "year" 

# head(NEI)
# fips      SCC Pollutant Emissions  type year
# 4  09001 10100401  PM25-PRI    15.714 POINT 1999
# 8  09001 10100404  PM25-PRI   234.178 POINT 1999
# 12 09001 10100501  PM25-PRI     0.128 POINT 1999
# 16 09001 10200401  PM25-PRI     2.036 POINT 1999
# 20 09001 10200504  PM25-PRI     0.388 POINT 1999
# 24 09001 10200602  PM25-PRI     1.490 POINT 1999



# Compute Summary Statistics of Data Subsets
# aggregate(formula, data, FUN, ..., subset, na.action = na.omit)
totalEmissionByYear <- aggregate(Emissions ~ year, data = NEI, FUN=sum)
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


