############################################################################
# R Script to generate Plot 3 as requested by assignment
#
# Author: Mohamed Assari
# Created: 12/8/2016
# Updated: 13/8/2016
#
############################################################################
#
# Download the zipped dataset from provided URL if not there
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

data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Open png device
png("plot3.png", width=480, height=480)

# Plot the graph
plot(dateTime, data$Sub_metering_1, type="l",
     xlab = "",
     ylab="Energy sub metering")

lines(dateTime,data$Sub_metering_2,
       xlab="", ylab="", col="red")

lines(dateTime,data$Sub_metering_3,
       xlab="", ylab="", col="blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1)

# Turn off device
dev.off()
