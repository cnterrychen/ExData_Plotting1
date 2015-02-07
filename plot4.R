# clears the environment
rm(list=ls())
# sets the working directory
setwd("D:/Coursera/exdata-01/")

#######################################
#          Reads the data             #
#######################################
# easier way: reads the whole file and discards the unwanted part
# data <- read.table("household_power_consumption.txt", header=TRUE,
#                    sep=";", na.strings="?", stringsAsFactors=FALSE)
# data <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]
# more efficient way: reads the needed part of the file, but the header should
# be set manually (or readed from the file separately, not implemented here)
data <- read.table("household_power_consumption.txt",
                   sep=";", na.strings="?",
                   skip=66637, nrows=2880,
                   stringsAsFactors=FALSE)
colnames(data) <- c("Date", "Time", "Global_active_power",
                    "Global_reactive_power", "Voltage", "Global_intensity",
                    "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
# converts to Date/Time classes
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- strptime(paste(data$Date, data$Time) ,format="%Y-%m-%d %H:%M:%S")

#######################################
#            Plotting                 #
#######################################
png(filename="plot4.png", width=480, height=480, bg="transparent")
par(mfrow=c(2, 2))
# Plot 1
plot(data$Time, data$Global_active_power, type="l",
     ylab="Global Active Power", xlab="")
# Plot 2
plot(data$Time, data$Voltage, type="l", ylab="Voltage",
     xlab="datetime")
# Plot 3
plot(data$Time, data$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
points(data$Time, data$Sub_metering_2, col="red", type="l")
points(data$Time, data$Sub_metering_3, col="blue", type="l")
legend("topright", col=c("black", "red", "blue"), lty=1, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#plot 4
plot(data$Time, data$Global_reactive_power, type="l",
     ylab="Global_reactive_power", xlab="datetime")
dev.off()