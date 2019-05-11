#setup working directory
setwd("C:/Users/nstavisky/OneDrive - Facebook/Study/R")
getwd()

#link to download raw data
zipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#checking for and creating directories
if(!file.exists("ExploreGraph")){
  dir.create("ExploreGraph")
}

path <- "./ExploreGraph"

library(downloader)
library(dplyr)

#download file
?download.file

download(zipURL, dest = "./ExploreGraph/Data.zip", mode = "wb")
unzip("./ExploreGraph/Data.zip", exdir = "./ExploreGraph")
list.files("./ExploreGraph")

#read file into data
data <- read.table(file.path(path,"household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")
#subset data as data1
data1 <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]
#convert the Date and Time variables to Date/Time classes
data1$DateTime <- strptime(paste(data1$Date, data1$Time, sep=" "), format = "%d/%m/%Y %H:%M:%S")
?strptime
?as.Date

#short overview
names(data1)
head(data1)
str(data1)
summary(data1)


#construction  plot1
hist(data1$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

#construction  plot2
plot(data1$DateTime, data1$Global_active_power,  type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")

#construction  plot3
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
linecolor <- c("black", "red", "blue")
plot(data1$DateTime, data1$Sub_metering_1,  type="n", col="black", xlab="", ylab="Energy sub metering")
lines(data1$DateTime, data1$Sub_metering_1,  type="l", col="black")
lines(data1$DateTime, data1$Sub_metering_2,  type="l", col="red")
lines(data1$DateTime, data1$Sub_metering_3,  type="l", col="blue")
legend("topright", legend=labels, col = linecolor, lty = "solid")


#construction plot4
par(mfrow=c(2,2))
plot(data1$DateTime, data1$Global_active_power,  type="l", col="black", xlab="", ylab="Global Active Power")
plot(data1$DateTime, data1$Voltage,  type="l", col="black", xlab="datetime", ylab="Voltage")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
linecolor <- c("black", "red", "blue")
plot(data1$DateTime, data1$Sub_metering_1,  type="n", col="black", xlab="", ylab="Energy sub metering")
lines(data1$DateTime, data1$Sub_metering_1,  type="l", col="black")
lines(data1$DateTime, data1$Sub_metering_2,  type="l", col="red")
lines(data1$DateTime, data1$Sub_metering_3,  type="l", col="blue")
legend("topright", legend=labels, col = linecolor,bty = "n", lty = "solid", xjust = 1)
plot(data1$DateTime, data1$Global_reactive_power,  type="l", col="black", xlab="datetime", ylab="Global_reactive_power")
?legend
