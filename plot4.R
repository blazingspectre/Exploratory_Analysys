download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "Fhousehold_power_consumption.zip")
unzip("Fhousehold_power_consumption.zip")
b <- read.table("household_power_consumption.txt", sep = ";", skip = 1, stringsAsFactors = FALSE)

library(data.table)
setnames(b , c( "V1" = "Date", "V2" = "Time",  "V3" = "Global_active_power", "V4" = "Global_reactive_power",  "V5" = "Voltage", "V6" = "Global_intensity", "V7" = "Sub_metering_1" , "V8" = "Sub_metering_2", "V9" = "Sub_metering_3" ))

b$Date <- as.Date(b$Date, "%d/%m/%Y")

bclean <- filter(b, b$Date  == "2007-02-01" | b$Date  ==  "2007-02-02" )

bclean$Date <- format(bclean$Date, "%d/%m/%Y")

datetime <- strptime(paste(bclean$Date, bclean$Time, sep = " " ), "%d/%m/%Y %H:%M")


datetime<-  as.POSIXct(grep("[^A-Z]", datetime, value = TRUE))

bclean <- cbind(bclean, datetime)



par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

plot( bclean$datetime,  as.numeric(bclean$Global_active_power) ,   "l", ylab = "Global Active Power", xlab = "")

plot( bclean$datetime,  as.numeric(bclean$Voltage ) ,   "l", ylab = "Voltage", xlab = "")

plot( bclean$datetime,  as.numeric(bclean$Sub_metering_1 ) ,   "l", ylab = "Energy sub metering", xlab = "")

lines( bclean$datetime,  as.numeric(bclean$Sub_metering_2 ) ,   "l", col = "red")

lines( bclean$datetime,  as.numeric(bclean$Sub_metering_3 ) ,   "l", col = "blue")

legend("topright", lty = c(1 , 1, 1), col = c("black","red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")) 

plot( bclean$datetime,  as.numeric(bclean$Global_reactive_power ) ,   "l", ylab = "Global_reactive_power", xlab = "")

dev.copy(png, filename = "plot4.png")

dev.off()


