NEI <- readRDS("summarySCC_PM25.rds") # Read in the data
str(NEI)
SCC <- readRDS("Source_Classification_Code.rds") # Read in the Source classification code
str(SCC)
head(SCC)

library(plyr)

# Split, apply and combine using ddply
emit <- ddply(NEI, c("year"), summarise,
              Total_emission = sum(Emissions, na.rm=TRUE))

# Q.1 Plot
with(emit, plot(year, Total_emission, main = "Total Emissions in U.S."))
lines(emit$year, emit$Total_emission, col = "blue", xlab = "Year", ylab = "Total Emissions")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
