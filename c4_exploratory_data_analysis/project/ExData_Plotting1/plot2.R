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
powerData$Date.and.Time <- paste(powerData$Date, powerData$Time)
powerData$Date.and.Time <-
    strptime(powerData$Date.and.Time, format = "%Y-%m-%d %H:%M:%S")
powerData$Date.and.Time <- as.POSIXct(powerData$Date.and.Time)

# plot the plot2.png
with(
    powerData,
    plot(
        Global_active_power ~ Date.and.Time,
        type = "l",
        xlab = "",
        ylab = "Global Active Power (kilowatts)"
    )
)

# Save it to Plot1.png using png ploting device
dev.copy(png,
         file = "Plot2.png",
         height = 480,
         width = 480)
dev.off()