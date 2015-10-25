NEI <- readRDS("summarySCC_PM25.rds") # Read in the data
str(NEI)
SCC <- readRDS("Source_Classification_Code.rds") # Read in the Source classification code
str(SCC)

library(plyr)
library(ggplot2)
## Q3. plot with ggplot2
Balt <- subset(NEI, NEI$fips == "24510")
str(Balt) # Examine the baltimore dataset


emitB1 <- ddply(Balt, c("year", "type"), summarise,
                emitBt = sum (Emissions))
png(filename="plot3.png", width=480, height=480, units="px")
p <- ggplot(emitB1, aes(x=year, y=emitBt, colour=type)) + geom_line() # Plot of emissions/year for 4 types of sources
p <- p + xlab("Year") + ylab("Emissions")
p <- p + ggtitle("Baltimore City: 4 types of sources") ## This works
p
dev.off()

## Shows that "type" = "POINT" source emission has increased from 1999 to 2008.
# Other 3 types have all decreased.