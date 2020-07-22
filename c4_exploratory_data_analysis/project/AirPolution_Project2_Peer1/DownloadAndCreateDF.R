#setwd before running code
data1 <- "pm25_data.zip"

#download the file
if(!file.exists(data1)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL, data1, method = "curl")
}
#unzip the file
if(!file.exists("pm25_data.txt")){
  unzip(data1)
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)
