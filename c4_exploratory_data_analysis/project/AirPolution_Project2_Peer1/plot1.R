NEI$year <- as.character(NEI$year)

total_emissions <- with(NEI, tapply(Emissions, year, sum, na.rm = TRUE))

png(filename = "plot1.png", width=600, height=600)

plot(total_emissions/10^6,xaxt ='n', type = "l", xlab = "Year", 
     ylab = "Total PM2.5 Emissions in Megatons",
     main = "PM2.5 Trend in the USA from 1999-2008")
axis(1, 1:4, labels = c("1999", "2002", "2005", "2008"))

dev.off()