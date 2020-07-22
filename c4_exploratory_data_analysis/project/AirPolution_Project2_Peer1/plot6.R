NEI$fips[NEI$fips == "24510"] <- "Baltimore"
NEI$fips[NEI$fips == "06037"] <- "LA"

baltimore_vs_LA_motor_emissions <- NEI %>%
  filter(fips == "Baltimore" & type == "ON-ROAD" | fips == "LA" & type == "ON-ROAD") %>%
  group_by(year, fips)%>%
  summarize(emissions = sum(Emissions, na.rm = T))

png(filename = "plot6.png", width=600, height=600)

ggplot(baltimore_vs_LA_motor_emissions, aes(year, emissions, col = fips)) +
  geom_point(pch = 20, size = 3) +
  geom_smooth(method = "lm", se = FALSE) +
  ylab("PM2.5 Emissions (tons)") +
  ggtitle("PM2.5 Emissions from Motor Vehicles in Baltimore vs LA (1998-2008)")

dev.off()