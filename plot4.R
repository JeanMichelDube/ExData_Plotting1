#Merges the training and the test sets to create one data set.

##install downloader and data.table

install.packages("downloader")
library(downloader)
install.packages("data.table")
library(data.table)

##Easily download and unzip the data
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",dest="dataset.zip",mode="wb")
unzip ("dataset.zip")

##Read and subset Data
data <- read.csv("household_power_consumption.txt",header = TRUE, sep=';')
subdata <- subset(data, as.character(Date) == "1/2/2007" | as.character(Date) == "2/2/2007")

##Set Date as Date class
subdata$Date = as.Date(subdata$Date,format="%d/%m/%Y")
subdata$DateTime = paste(subdata$Date,subdata$Time)
subdata$DateTime = strptime(subdata$DateTime,format = "%Y-%m-%d %H:%M:%S")

##Set multiple plots
par(mfcol = c(2,2))

##Build Plot 2
plot(subdata$DateTime,as.numeric(as.character(subdata$Global_active_power)), type = "l",xlab="",ylab="Global Active Power (kilowatts)")

##Build Plot 3
plot(subdata$DateTime,as.numeric(as.character(subdata$Sub_metering_1)),type = "l",xlab = "",ylab = "Energy sub metering")
lines(subdata$DateTime,as.numeric(as.character(subdata$Sub_metering_2)), type="l",col="red")
lines(subdata$DateTime,as.numeric(as.character(subdata$Sub_metering_3)), type="l",col="blue")
legend("topright", pch = "_", col=c("black","red","blue") , legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),bty = "n")

##Build New Plot 1
plot(subdata$DateTime,as.numeric(as.character(subdata$Voltage)), type = "l", xlab ="datetime", ylab="Voltage")

##Build New Plot 4
plot(subdata$DateTime,as.numeric(as.character(subdata$Global_reactive_power)), type = "l", xlab ="datetime", ylab="Global_reactive_power")

##Copy as png
dev.copy(png, file = "plot4.png")
dev.off()

