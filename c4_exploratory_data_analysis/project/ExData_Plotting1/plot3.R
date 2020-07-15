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

# plot the plot3.png
with(powerData, {
    plot(
        Sub_metering_1 ~ Date.and.Time,
        type = "l",
        xlab = "",
        ylab = "Energy sub metering",
        col = "black"
    )
    
    lines(Sub_metering_2 ~ Date.and.Time, col = "red")
    lines(Sub_metering_3 ~ Date.and.Time, col = "blue")
    
    legend(
        "topright",
        col = c("black", "red", "blue"),
        lty = 1,
        lwd = 2,
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    )
})

# Save it to Plot1.png using png ploting device
dev.copy(png,
         file = "Plot3.png",
         height = 480,
         width = 480)
dev.off()