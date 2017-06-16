###########################################################################################
# Coursera Exploratory Data Analysis Week 4 Course Project
# Author: Sandeep Agarwal
# Date: Jun 15, 2017
#
# plot6.R File Description:
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

# we will use the ggplot2 plotting system to make a plot showing the comparison between
# Motor Vehicle related PM2.5 emission in Baltimore City & Los Angeles County (fips 06037)
# for each of the years from 1999 to 2008
# As it's motor vehoicle related, we will use the source type ("ON-ROAD")

# Getting the subset of Baltimore NEI data
MV_BaltimoreNEI <- subset(NEI, fips == "24510" & type=="ON-ROAD")

# Aggregate using sum the Baltimore emissions data by year & zip
MV_BaltAggData <- aggregate(MV_BaltimoreNEI[c("Emissions")], list(year = MV_BaltimoreNEI$year, zip = MV_BaltimoreNEI$fips), sum)

# Getting the subset of Los Angeles NEI data
MV_LA_NEI <- subset(NEI, fips == "06037" & type=="ON-ROAD")

# Aggregate using sum the Los Angeles emissions data by year & zip
MV_LA_AggData <- aggregate(MV_LA_NEI[c("Emissions")], list(year = MV_LA_NEI$year, zip = MV_LA_NEI$fips), sum)

# combine the rows for aggregates for Baltimore City & LA County
Comb_data <- rbind(MV_BaltAggData, MV_LA_AggData)

library(ggplot2)

# open the PNG device
png("plot6.png", width=640, height=480)

## Now lets draw the plot using ggplot2
qplot(year, Emissions, data = Comb_data, color = zip, geom= "line") + 
     ggtitle("Motor Vehicle Emissions in Baltimore (zip 24510) vs. LA Counties (zip 06037)") + 
     xlab("Year") + ylab("Total Emission Levels (in tons)")

# The plot shows that total PM2.5 emissions for LA Counties is far more than Baltimore City

# close the device
dev.off()
# The plot diagram is now ready in the plot6.png file and can be opened and checked
############# End of Script #############
