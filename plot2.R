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


plot( bclean$datetime,  as.numeric(bclean$Global_active_power) ,   "l", ylab = "Global Active Power(kilowatts)", xlab = "")

dev.copy(png, filename = "plot2.png")
dev.off()





