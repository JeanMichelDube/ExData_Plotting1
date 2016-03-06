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

##Build Histograph 1
hist(as.numeric(as.character(subdata$Global_active_power)),main="Global Active Power",xlab = "Global Active Power (kilowatts)", col = "red")

##Copy as png
dev.copy(png, file = "plot1.png")
dev.off()
