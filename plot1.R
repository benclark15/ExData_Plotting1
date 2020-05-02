library(data.table)
library(dplyr)
library(lubridate)

Sys.setenv(LANG = "en")

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Only download if not yet downloaded
if (!file.exists("household_power_consumption.zip")){
  print("Downloading...")
  download.file(fileURL, destfile = "household_power_consumption.zip")  
  dateDownloaded = date()
  print(dateDownloaded)
}

## Only unzip if not yet unzipped
if (!file.exists("household_power_consumption.txt")){
  print("Unzipping...")
  unzip("household_power_consumption.zip")
}

## Read data, extracting the data for the approximate date range required
energy_ds_all <- read.table("household_power_consumption.txt", skip = 66000, nrows = 4000, na.strings = "?", sep = ";")

## Change the column names to something more descriptive
new_col_names <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

colnames(energy_ds_all) <- new_col_names

## Now just get the data for the dates 1st and 2nd Feb 2007
energy_ds <- subset(energy_ds_all, Date == "1/2/2007" | Date == "2/2/2007")

## Print Plot 1
png("plot1.png", width = 480, height = 480)
hist(energy_ds$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
