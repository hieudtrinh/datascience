downloadAndExtractData <- function(toFile) {
    fromUrl <-
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zipFilePath <- "household_power_consumption.zip"
    
    if (!file.exists(zipFilePath)) {
        download.file(
            fromUrl,
            destfile = zipFilePath,
            method = "curl",
            extra = '-L'
        )
    }
    
    powerData <-
        read.table(
            unzip(zipFilePath),
            sep = ";",
            header = TRUE,
            na.strings = "?"
        )
    powerData$Date <- as.Date(powerData$Date, format = "%d/%m/%Y")
    powerData <-
        filter(powerData,
               Date == as.Date("2007-02-01") |
                   Date == as.Date("2007-02-02"))
    
    write.table(powerData, file = toFile, row.names = FALSE)
}
