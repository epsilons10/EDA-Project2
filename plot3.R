###########################################################################################
# Coursera Exploratory Data Analysis Week 4 Course Project
# Author: Sandeep Agarwal
# Date: Jun 15, 2017
#
# plot3.R File Description:
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

# Load ggplot2 library
library(ggplot2)

# Getting the subset of Baltimore NEI data
BaltimoreNEI <- subset(NEI, fips == 24510)

# Get the aggregate by sources for Baltimore city
BaltAggBySource <- aggregate(BaltimoreNEI[c("Emissions")], list(type = BaltimoreNEI$type, year = BaltimoreNEI$year), sum)

# open the PNG device
png("plot3.png", width=640, height=480)

# we will use the ggplot2 plotting system to make a plot showing specific sources of emissions 
# (point, nonpoint, onroad, nonroad) in Baltimore City (fips 24510) for each of the years from 1999 to 2008

qplot(year, Emissions, data = BaltAggBySource, color = type, geom= "line")+ 
     ggtitle("Total PM2.5 Emissions in Baltimore City by Source Type") + xlab("Year") + ylab("PM2.5 Emissions (in tons)") 

# The plot shows that for source type "POINT" the PM2.5 emissions has increased and then decreased.

# close the device
dev.off()
# The ggplot2 plot diagram is now ready in the plot3.png file and can be opened and checked
############# End of Script #############
