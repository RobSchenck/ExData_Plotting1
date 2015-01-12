#Project 1 for Coursera: Exploratory Data Analysis https://class.coursera.org/exdata-010 January 2015

# Data description: Measurements of electric power consumption in one household with a one-minute sampling rate over
# a period of almost 4 years. From UC Irvine Machine Learning Repository http://archive.ics.uci.edu/ml/

install.packages("data.table")
library(data.table)
if (!file.exists("household_power_consumption")){
  message("Downloading data")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}
#Checks to see if the data is downloaded to the working directory, and if not gets it, tells you such, and unzips it


# Only convecerned with 2-3-2007--2-4-2007, two days of data. So will skip to starting row, 
# and then read ahead for two days worth of data
dtime <- difftime(as.POSIXct("2007-02-03"), as.POSIXct("2007-02-01"),units="mins")  
rowsToRead <- as.numeric(dtime) 
#figures out how many minutes in the time interval of interest, dumps that number into an object
d <- fread("household_power_consumption.txt", skip="1/2/2007", nrows = rowsToRead, na.strings = c("?", "")) 
#skips to start date, reads ahead as many rows as there are minutes in 2 days
# fread requires the data.table package
#this leaves out the headers
setnames(d, colnames(fread("household_power_consumption.txt", nrows=0)))
#restore the headers

d$DateTime <- as.POSIXct(paste(d$Date, d$Time), format="%d/%m/%Y %H:%M:%S") 
#puts converts data and time columns into date and time formats and then combines them into a datetime column
d[,Time:=NULL]
d[,Date:=NULL]
#Remove the remainder date and time columns

png(filename="plot3.png", width=480, height=480)
plot(d$DateTime,d$Sub_metering_1, col="black", type="n", ylab="Energy sub metering", xlab="")
legend("topright", title=NULL, c("Sub-metering_1","Sub-metering_2","Sub-metering_3"), lty=c(1,1), lwd=c(2.5,2.5),col=c("black", "blue","red"))
points(d$DateTime, d$Sub_metering_1, type="l", col="black")
points(d$DateTime, d$Sub_metering_2, type="l", col="red")
points(d$DateTime, d$Sub_metering_3, type="l", col="blue")
dev.off()

