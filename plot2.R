NEI <- readRDS("summarySCC_PM25.rds") # Read in the data
str(NEI)
SCC <- readRDS("Source_Classification_Code.rds") # Read in the Source classification code
str(SCC)

library(plyr)

# Q2 Total emissions in Baltimore
Balt <- subset(NEI, NEI$fips == "24510")
str(Balt) # Examine the baltimore dataset

emitB <- ddply(Balt, c("year"), summarise,
               emit_Balt = sum(Emissions), na.rm = TRUE)
# Plot2
with(emitB, plot(year, emit_Balt, main="Total Emissions in Baltimore", ylab = "Emissions", xlab = "Year"))
lines(emitB$year, emitB$emit_Balt, col = "blue")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
