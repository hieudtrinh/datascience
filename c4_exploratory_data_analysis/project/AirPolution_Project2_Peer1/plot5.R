baltimore_motor_emissions <- NEI %>%
  filter(fips == "24510" & type == "ON-ROAD") %>%
  group_by(year)%>%
  summarize(emissions = sum(Emissions, na.rm = T))

png(filename = "plot5.png", width=600, height=600)

ggplot(baltimore_motor_emissions, aes(year, emissions)) +
  geom_point(color = "blue", size = 3) +
  geom_line(color = "blue") +
  ylab("PM2.5 Emissions (tons)") +
  ggtitle("PM2.5 Emissions from Motor Vehicles in Baltimore (1998-2008)")

dev.off()