###########################################################################################
# Coursera Exploratory Data Analysis Week 4 Course Project
# Author: Sandeep Agarwal
# Date: Jun 15, 2017
#
# plot2.R File Description:
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

# we will use the base plotting system to make a plot showing the total PM2.5 emission
# for Baltimore City (fips 24510) for each of the years from 1999 to 2008

# Getting the subset of Baltimore NEI data
BaltimoreNEI <- subset(NEI, fips == 24510)

# Aggregate using sum the Baltimore emissions data by year
BaltAggData <- aggregate(Emissions ~ year, BaltimoreNEI, sum)

# open the PNG device
png("plot2.png", width=640, height=480)

## Now lets draw the base plot
plot(BaltAggData, type = "o", main = "Total PM2.5 Emissions in Baltimore City", xlab = "Year", 
     ylab = "PM2.5 Emissions (in tons)", pch = 19, col = "darkblue", lty = 2)

# The plot shows that total PM2.5 emissions have decreased, then increased for an year and decreased again

# close the device
dev.off()
# The plot diagram is now ready in the plot2.png file and can be opened and checked
############# End of Script #############
