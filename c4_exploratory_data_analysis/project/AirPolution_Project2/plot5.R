# QUESTION 5
# How have emissions from motor vehicle sources changed from 1999–2008 
# in Baltimore City?

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

SCC <- readRDS(sourceFilePath)
NEI <- readRDS(summaryFilePath)

# merger two DFs by SCC code
NEIxSCC = merge(NEI, SCC, by = "SCC")
emissionSubset <- filter(NEIxSCC, fips == "24510" & type == "ON-ROAD")
coalRelatedEmissionByYear <- aggregate(Emissions ~ year, emissionSubset, sum)

rm(NEI, SCC, NEIxSCC, emissionSubset)

# ggplot(data = NULL, mapping = aes(), ..., environment = parent.frame())
# ggplot(df, aes(x, y, other aesthetics))
png("plot5.png", width=600, height=480)
g <- ggplot(coalRelatedEmissionByYear, aes(factor(year), Emissions)) +
    geom_bar(aes(fill=year), stat = "identity") + 
    ylab(expression('Emission PM'[2.5]*" (tons)")) + 
    xlab("Year") + 
    ggtitle(expression('Baltimore Aggregated PM'[2.5]*" Motor Vehicle Emission"))
print(g)

dev.off()