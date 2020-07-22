# QUESTION 4
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

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

SCC = readRDS(sourceFilePath)
NEI = readRDS(summaryFilePath)

# merger two DFs by SCC code
# merge(x, y, by = intersect(names(x), names(y)),
#   by.x = by, by.y = by, all = FALSE, all.x = all, all.y = all,
#   sort = TRUE, suffixes = c(".x",".y"), no.dups = TRUE,
#   incomparables = NULL, ...)
NEIxSCC = merge(NEI, SCC, by = "SCC")


# Select emissions from coal combustion-related row from the merged data frame 
# grepl(pattern, x, ignore.case = FALSE, perl = FALSE,
#   fixed = FALSE, useBytes = FALSE)
coalRelatedMatches <- grepl("coal", NEIxSCC$Short.Name, ignore.case = TRUE)
emissionSubset <- NEIxSCC[coalRelatedMatches,]

coalRelatedEmissionByYearType <- aggregate(Emissions ~ year + type, emissionSubset, sum)

png("plot4.png", width=600, height=480)

ggplot(coalRelatedEmissionByYearType, aes(year, Emissions, col=type)) +
    geom_line() +
    geom_point() +
    ggtitle(expression('Baltimore Aggregated PM'[2.5]*" Coal Related Emission")) +
    ylab(expression('Emission PM'[2.5]*" (tons)")) + 
    xlab("Year") +
    scale_color_discrete(name="Type of sources") +
    theme(legend.title = element_text(face = "bold"))
    
print(g)

dev.off()
