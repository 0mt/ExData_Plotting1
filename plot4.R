## The base plotting system is employed for this assignment
##
## We read the data with fread() from the data.table package as it is typically 
## much faster than read.table()
library(data.table)

## We will also use the lubridate package for date/time operations
library(lubridate)

## Let us start by reading the entire dataset assuming it is in the current
## working directory
df <- fread("household_power_consumption.txt", header = TRUE, sep = ";", 
            na.strings = "?", stringsAsFactors = FALSE, data.table = FALSE)

## Select data for the dates 2007-02-01 and 2007-02-02
consumption <- subset(df, Date == "1/2/2007" | Date == "2/2/2007")

## Combine the date and time columns (character at this point) into a new date/
## time column with dmy() and hms() from lubridate
consumption$DateTime <- with(consumption, dmy(Date) + hms(Time))


##
## Open a PNG graphics device
png("plot4.png", width = 480, height = 480, units = "px")

## Construct the requested scatterplots
## First, change the layout to 2x2
par(mfcol = c(2,2))   # plots will appear columnwise

## Plot at the position (1,1)
with(consumption, plot(DateTime, Global_active_power, type = "l",
                       xlab = "", ylab = "Global Active Power"))

## Plot at the position (2,1) is identical to the Plot 3
lineName <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
lineType <- c(1, 1, 1)
lineColor <- c("black", "red", "blue")
plot(consumption[ ,"DateTime"], consumption[ ,lineName[1]], type = "n",
     xlab = "", ylab = "Energy sub metering")
for (i in seq(lineName)) lines(consumption[ ,"DateTime"], consumption[ ,lineName[i]],
                               lty = lineType[i], col = lineColor[i])
legend("topright", legend = lineName, lty = lineType, col = lineColor)

## Plot at the position (1,2)
with(consumption, plot(DateTime, Voltage, type = "l",
                       xlab = "datetime", ylab = "Voltage"))

## Plot at the position (2,2)
with(consumption, plot(DateTime, Global_reactive_power, type = "l",
                       xlab = "datetime", ylab = "Global_reactive_power"))


## Close the device
dev.off()