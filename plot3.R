############
## Plot 3
############
library("data.table")

setwd("C:/Google Drive/0Rdata/Proj1")

#Reading data
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")

# Modifying data type to avoid printing histogram in scientific notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filtering datas required (from 2007-02-01 to 2007-02-02)
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime <= "2007-02-02")]

# Initiating the graphics device
png("plot3.png", width=480, height=480)

# Plotting
plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerDT[, dateTime], powerDT[, Sub_metering_2],col="red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

# Stopping graphics device
dev.off()