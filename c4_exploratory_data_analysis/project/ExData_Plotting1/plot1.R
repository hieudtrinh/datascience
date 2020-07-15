library(ggplot2)
library(dplyr)

# commonFunctions.R - contains function to download and extract data
source("commonFunctions.R")

dataFilePath <- "powerDataSubset.txt"
if (!file.exists(dataFilePath)) {
    downloadAndExtractData(dataFilePath)
}

# read power data into data frame
powerData <- read.table(dataFilePath, header = TRUE)
powerData$Date <- as.Date(powerData$Date)

# plot the plot1.png
with(
    powerData,
    hist(
        Global_active_power,
        main = "Global Active Power",
        xlab = "Global Active Power (kilowatts)",
        ylab = "Frequency",
        col = "Red"
    )
)

# Save it to Plot1.png using png ploting device
dev.copy(png,
         file = "Plot1.png",
         height = 480,
         width = 480)
dev.off()
