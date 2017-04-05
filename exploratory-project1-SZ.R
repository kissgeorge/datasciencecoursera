# coursera folder
setwd("C:/Users/shan zhou/Downloads/New folder/coursera")

# download data
if(!file.exists('data.zip')){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url,destfile = "data.zip")
}

# unzip file
unzip("data.zip") 

# read in data
data <- read.table("household_power_consumption.txt",header = TRUE, sep= ";")

# processing
data1 <- data[which(data$Date == "1/2/2007" | data$Date == "2/2/2007"), ] # get two days data
rm(data)
data1$DateTime <- paste(data1$Date, data1$Time) # get timestamp
data1$DateTime <- strptime(data1$DateTime, "%d/%m/%Y %H:%M:%S")

# plot1
png("plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(data1$Global_active_power)),
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
dev.off()

# plot2
png("plot2.png", width = 480, height = 480)
plot(data1$DateTime, as.numeric(as.character(data1$Global_active_power)), 
                type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()

# plot3
png("plot3.png", width = 480, height = 480)
with(data1, {
  plot(DateTime, Sub_metering_1, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(DateTime, Sub_metering_2, col = 'Red')
  lines(DateTime, Sub_metering_3, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

# plot4
png("plot4.png", width = 480, height = 480)

par(mfcol=c(2,2))
plot(data1$DateTime, as.numeric(as.character(data1$Global_active_power)),     
     type = 'l', ylab = "Global Active Power", xlab = "")
plot(data1$DateTime, as.numeric(as.character(data1$Sub_metering_1)), type = 'l', 
     xlab = "", ylab ="Energy sub metering")
  lines(data1$DateTime, as.numeric(as.character(data1$Sub_metering_2)), 
      type = 'l', col = 'red')
  lines(data1$DateTime, data1$Sub_metering_3,type = 'l', col = "blue")
  legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1, lwd = 2, bty = "n", col = c("black","red","blue"))
plot(data1$DateTime, as.numeric(as.character(data1$Voltage)), type = 'l', 
     ylab = "Voltage",xlab = "datetime" )
plot(data1$DateTime, as.numeric(as.character(data1$Global_reactive_power)),
     type = 'l', 
     ylab = "Global_reactive_power", xlab = "datetime")

dev.off()


