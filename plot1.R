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
png("plot1.png", width = 480, height = 480, units = "px")

## Construct the requested histogram
hist(consumption$Global_active_power, col = "red", 
xlab = "Global Active Power (kilowatts)", main = "Global Active Power") # add title

## Close the device
dev.off()