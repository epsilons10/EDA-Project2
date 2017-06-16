###########################################################################################
# Coursera Exploratory Data Analysis Week 4 Course Project
# Author: Sandeep Agarwal
# Date: Jun 15, 2017
#
# plot4.R File Description:
#
# This script will download the data from below URL, unzip it, and create plot as requested
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
###########################################################################################

# Clean up workspace
rm(list=ls())

# Set working directory to existing directory
setwd("/DataScience/R/c4project2")

# Download the zip file if it doesn't exist already
filename <- "dataset.zip"
if (!file.exists(filename)){
     fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
     download.file(fileurl, filename, method="curl")
}  

# unzip the zip file in current working directory if not done so already
if (!file.exists("summarySCC_PM25.rds")) {unzip(filename)}

# Read the entire dataset
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# we will use the ggplot2 plotting system to make a plot showing the total PM2.5 emission 
# from coal combustion-related sources for each of the years 1999, 2002, 2005 and 2008.

# identifying coal related sources
# grepl returns a logical vector (match or not for each element of x)
coalSCC <- SCC[grepl("Coal" , SCC$Short.Name), ]

# fetching only those records from NEI based on above result set
coalNEI <- NEI[NEI$SCC %in% coalSCC$SCC, ]

## Aggregating the above dataset
aggCoalData <- aggregate(Emissions ~ year, coalNEI, sum)

library(ggplot2)

# open the PNG device
png("plot4.png", width=640, height=480)

## Now lets draw the plot using ggplot2
g <- ggplot(aggCoalData, aes(x = factor(year), y = Emissions)) +
     geom_bar(stat = "identity", width = 0.5) +
     xlab("Year") +
     ylab("Coal Related PM2.5 Emissions (in tons)") +
     ggtitle("Total Coal Related PM2.5 Emissions Across US")

print(g)
# The plot shows that total PM2.5 emissions for Coal related sources have decreased 
# except during 2002 to 2005 when it increased slightly.

# close the device
dev.off()
# The plot diagram is now ready in the plot4.png file and can be opened and checked
############# End of Script #############
