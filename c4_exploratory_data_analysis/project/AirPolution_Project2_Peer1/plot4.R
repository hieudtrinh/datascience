SCC_coal <- SCC[grepl("Coal", SCC$Short.Name), ]
joined_SCC <- inner_join(NEI, SCC_coal, by = "SCC")
## Warning: Column `SCC` joining character vector and factor, coercing into
## character vector
coal_emissions <- joined_SCC %>%
  group_by(year) %>%
  summarise(emissions = sum(Emissions))

png(filename = "plot4.png", width=600, height=600)

ggplot(coal_emissions, aes(year, emissions)) +
  geom_point(color = "red", size = 3) + 
  geom_line() +
  ylab("PM2.5 Emissions (tons)") +
  ggtitle("PM2.5 Emissions from Coal Combustion in the USA")

dev.off()