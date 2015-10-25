NEI <- readRDS("summarySCC_PM25.rds") # Read in the data
str(NEI)
SCC <- readRDS("Source_Classification_Code.rds") # Read in the Source classification code
str(SCC)

library(plyr)
library(ggplot2)
library(dplyr)

## Q.6 Select NEI ON-ROAD data for motor vehicle emission
Balt <- subset(NEI, NEI$fips == "24510") # Baltimore data
LAdata<- subset(NEI, NEI$fips=="06037") #LA data
str(LAdata)
str(Balt)

mergeLAB <- rbind(Balt, LAdata)
mergeVeh<-mergeLAB[which(mergeLAB$type == "ON-ROAD"),] # select "ON-ROAD" subset
str(mergeVeh)
emitLaB <- ddply(mergeVeh,c("fips", "year"), summarise,
                 meanLAB = mean(Emissions), na.rm = TRUE,
                 sum = sum(Emissions), na.rm= TRUE)


# Add city/county names to make plot easier to read
emitLaB$City.County[1:4] <- rep("LA", 4)
emitLaB$City.County[5:8] <- rep("Baltimore", 4)


#Plot total emissions to show change
png(filename="plot6.png", width=480, height=480, units="px")
p <- ggplot(emitLaB, aes(y=sum, x=year, color=City.County)) + geom_line()
p <- p + xlab("Year") + ylab("Emissions (sum)")
p <- p + ggtitle("Motor vehicle sources: Baltimore/LA") ## This works
p
dev.off()

# Plot shows greater change in motor vehicle emissions in LA

