############################################################################
# R Script to generate Plot 4 as requested by assignment
#
# Author: Mohamed Assari
# Created: 12/8/2016
# Updated: 13/8/2016
#
############################################################################
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

# Get all the obs into the correct datatype prior to plotting
dateTime <- paste(data$Date, data$Time)
dateTime <- strptime(dateTime,"%d/%m/%Y %H:%M:%S")

data$Sub_metering_1        <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2        <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3        <- as.numeric(data$Sub_metering_3)
data$Voltage               <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)

# Open png device
png("plot4.png", width=480, height=480)

# Need a 2x2 plot page
par(mfrow=c(2,2))

# The first plot almost as per plot 2
plot(dateTime, data$Global_active_power, type="l",
     xlab = "",
     ylab="Global Active Power")

# The 2nd plot is new
plot(dateTime, data$Voltage, type="l",
     ylab="Voltage", xlab="datetime")

# 3rd plot, almost the same as Plot 3
plot(dateTime, data$Sub_metering_1, type="l",
     xlab = "",
     ylab="Energy sub metering")

lines(dateTime,data$Sub_metering_2,
       xlab="", ylab="", col="red")

lines(dateTime,data$Sub_metering_3,
       xlab="", ylab="", col="blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1, bty="n")

# Fourth Plot
plot(dateTime, data$Global_reactive_power, type="l", 
     ylab="Global_reactive_power", xlab="datetime")

# Turn off device
dev.off()
