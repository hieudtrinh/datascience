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

# plot the plot4.png
# Set or Query Graphical Parameter
# mfcol, mfrow - A vector of the form c(nr, nc). Subsequent figures will be 
# drawn in an nr-by-nc array on the device by columns (mfcol), or rows 
# (mfrow), respectively.
# mar - A numerical vector of the form c(bottom, left, top, right)
# oma - A vector of the form c(bottom, left, top, right) giving the size of 
# the outer margins in lines of text.
par(
    mfrow = c(2, 2),
    mar = c(4, 4, 2, 1),
    oma = c(0, 0, 2, 0)
)

with(powerData, {
    with(
        powerData,
        plot(
            Global_active_power ~ Date.and.Time,
            type = "l",
            xlab = "",
            ylab = "Global Active Power (kilowatts)"
        )
    )
    with(
        powerData,
        plot(
            Voltage ~ Date.and.Time,
            type = "l",
            xlab = "datetime",
            ylab = "Voltage"
        )
    )
    
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
    
    with(
        powerData,
        plot(
            Global_reactive_power ~ Date.and.Time,
            type = "l",
            xlab = "datetime",
            ylab = "Global_reactive_power"
        )
    )
})

# Save it to Plot1.png using png ploting device
dev.copy(png,
         file = "Plot4.png",
         height = 480,
         width = 480)
dev.off()