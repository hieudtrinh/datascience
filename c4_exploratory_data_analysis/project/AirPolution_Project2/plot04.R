# QUESTION 4
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

library(ggplot2)

# Download database from the National Emissions Inventory (NEI) website
source("commonFunctions.R")
downloadAndUnzipData("data")

# Two data files source_Classification_Code.rds and summarySCC_PM25.rds
sourceFilePath <- "data/Source_Classification_Code.rds"
summaryFilePath <- "data/summarySCC_PM25.rds"

SCC = readRDS(sourceFilePath)
NEI <- readRDS(summaryFilePath)

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
coalRelatedSubset <- NEIxSCC[coalRelatedMatches,]

coalRelatedEmissionByYear <- aggregate(Emissions ~ year, coalRelatedSubset, sum)

rm(NEI, SCC, NEIxSCC, coalRelatedMatches, coalRelatedSubset)

# ggplot(data = NULL, mapping = aes(), ..., environment = parent.frame())
# ggplot(df, aes(x, y, other aesthetics))
png("plot4.png", width=600, height=480)
g <- ggplot(coalRelatedEmissionByYear, aes(factor(year), Emissions)) +
    geom_bar(aes(fill=year), stat = "identity") + 
    ylab(expression('Emission PM'[2.5]*" (tons)")) + 
    xlab("Year") + 
    ggtitle(expression('Baltimore Aggregated PM'[2.5]*" Coal Related Emission"))
print(g)

dev.off()
