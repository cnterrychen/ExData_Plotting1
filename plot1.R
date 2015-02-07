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
png(filename="plot1.png", width=480, height=480, bg="transparent")
hist(data$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()