
############
## Plot 1
############

library("data.table")

setwd("C:/Google Drive/0Rdata/Proj1")

#Reading data
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")

# Modifying data type to avoid printing histogram in scientific notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Changing 'Date' column to date data type
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filtering datas required (from 2007-02-01 to 2007-02-02)
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Initiating the graphics device
png("plot1.png", width=480, height=480)

# Creating the histogram
hist(powerDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Stopping graphics device
dev.off()