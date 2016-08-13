############################################################################
# R Script to generate Plot 2 as requested by assignment
#
# Author: Mohamed Assari
# Created: 12/8/2016
# Updated: 13/8/2016
#
############################################################################
#
# Download the zipped dataset from provided URL
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "HouseholdPower.zip"

# Download the dataset, if it doesnt already exist in working directory
if (!file.exists(zipFile)) {
    download.file(url,zipFile)
}

fname <- "household_power_consumption.txt"
# Uncompress data file, if data file not there
if (!file.exists(fname)) {
    unzip(zipFile)
}

# Read in the whole dataset
PowerCons <- read.table(fname, header=TRUE, sep=";", na.strings = "?")

# Get a subset of the data only
data <- subset(PowerCons,(Date == "1/2/2007" | Date == "2/2/2007"))

# We need to plot the date-time vs Global Active Power
dateTime <- paste(data$Date, data$Time)
dateTime <- strptime(dateTime,"%d/%m/%Y %H:%M:%S")

# Open png device
png("plot2.png", width=480, height=480)

# Plot the graph
plot(dateTime, data$Global_active_power, type="l",
     xlab = "",
     ylab="Global Active Power (kilowatts)")

# Turn off device
dev.off()
