NEI <- readRDS("summarySCC_PM25.rds") # Read in the data
str(NEI)
SCC <- readRDS("Source_Classification_Code.rds") # Read in the Source classification code
str(SCC)

library(plyr)
library(ggplot2)

Balt <- subset(NEI, NEI$fips == "24510")
str(Balt)

# Q5. Using NEI$type = ON-ROAD to select motor vehicles.
onRoadB <- Balt[which(Balt$type == "ON-ROAD"),] # Select motor vehicles emissions for each year   
onRoadB1 <- ddply(onRoadB, c("year"), summarise,
                  emission = sum(Emissions, na.rm=TRUE))

png(filename="plot5.png", width=480, height=480, units="px")
p <- ggplot(onRoadB1, aes(x=year, y=emission)) + geom_line()
p <- p + xlab("Year") + ylab("Motor Vehicle Emission")
p <- p + ggtitle("Motor vehicle Emission: Baltimore") ## This works
p
dev.off()

# Total motor vehicle emissions in Baltimore has decreased from 1999 to 2008