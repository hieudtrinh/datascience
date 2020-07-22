NEI$type <- as.factor(NEI$type)
NEI$year <- as.integer(NEI$year)
baltimore_emissions <- NEI %>%
  filter(fips == "24510")%>%
  group_by(type, year) %>%
  summarize(sum_emissions = sum(Emissions, na.rm = T))

png(filename = "plot3.png", width=800, height=800)

ggplot(baltimore_emissions, aes(year, sum_emissions, col = type)) + 
  ylab("Total PM2.5 Emissions (tons)") +
  ggtitle("PM 2.5 Levels by Source Type in Baltimore from 1998-2008") + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

dev.off()