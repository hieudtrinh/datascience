# QUESTION 3
# Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases 
# in emissions from 1999–2008 for Baltimore City? Which have seen increases 
# in emissions from 1999–2008? Use the ggplot2 plotting system to make a 
# plot answer this question.

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

emissionSubset <- filter(NEI, fips == "24510")
emissionByYearAndType <- aggregate(Emissions ~ year + type, emissionSubset, sum)
rm(NEI, emissionSubset)

# ggplot(data = NULL, mapping = aes(), ..., environment = parent.frame())
# ggplot(df, aes(x, y, other aesthetics))
png("plot3.png", width=600, height=480)
g <- ggplot(emissionByYearAndType, aes(year, Emissions, color = type)) +
    geom_line() + 
    ylab(expression('Emission PM'[2.5]*" (tons)")) + 
    xlab("Year") + 
    ggtitle(expression('Baltimore Aggregated PM'[2.5]*" Emission by year by type"))
print(g)

dev.off()
