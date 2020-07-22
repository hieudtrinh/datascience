NEI$year <- as.character(NEI$year)

baltimore_emissions <- NEI %>%
  filter(fips == "24510")%>%
  group_by(year)%>%
  summarize(sum_emissions = sum(Emissions, na.rm = T))

png(filename = "plot2.png", width=600, height=600)

with(baltimore_emissions, plot(year, sum_emissions,
                               type = "l", ylab = "Total PM2.5 Emissions in tons", main = 
                                 "Total PM2.5 Emissions by Year in Baltimore, USA"))
with(baltimore_emissions, points(year, sum_emissions, pch = 20, col = "blue"))


dev.off()