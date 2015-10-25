NEI <- readRDS("summarySCC_PM25.rds") # Read in the data
str(NEI)
SCC <- readRDS("Source_Classification_Code.rds") # Read in the Source classification code
str(SCC)

library(plyr)
library(ggplot2)
library(dplyr)

# Subset SCC El Sector for Coal combustion sources
SCCcoal <- SCC[grepl("Coal", SCC$EI.Sector),]
str(SCCcoal)
coalNEI <- subset(NEI, NEI$SCC == SCCcoal$SCC) #Subset the relevant data that is related to the coal SCC 
str(coalNEI)

emitCoal <- ddply(coalNEI, c("year"), summarise,
                  sum = sum (Emissions),
                  mean = mean(Emissions)) # split, apply and combine

png(filename="plot4.png", width=480, height=480, units="px")
p <- ggplot(emitCoal, aes(x=year, y=sum)) + geom_line(col="blue")
p <- p + xlab("Year") + ylab("Emissions")
p <- p + ggtitle("Coal-combustion sources")
p
dev.off()


#Plot shows an initial increase 1999-2002 and then overall decrease to 2008
