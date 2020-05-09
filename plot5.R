library("data.table")
library("ggplot2")

path <- getwd()

SCC <- data.table::as.data.table(x = readRDS(file = paste0(path,"/Source_Classification_Code.rds")))
NEI <- data.table::as.data.table(x = readRDS(file = paste0(path,"/summarySCC_PM25.rds")))

# Filtering data for vehicles
vehicles_filter<-grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles_filter, SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Filtering for Baltimore
baltimoreVehiclesNEI <- vehiclesNEI[fips=="24510",]

png("plot5.png")

ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()
