library("data.table")

path <- getwd()

SCC <- data.table::as.data.table(x = readRDS(file = paste0(path,"/Source_Classification_Code.rds")))
NEI <- data.table::as.data.table(x = readRDS(file = paste0(path,"/summarySCC_PM25.rds")))

# Converting variables
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]

totalNEI <- NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

png(filename='plot1.png')

barplot(totalNEI[, Emissions]
        , names = totalNEI[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")

dev.off()
