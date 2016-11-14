###############################################################################
# Filename: plot2.R
# Date: 11/14/2016
# Purpose:Reads in energy usage data and creates requested plots
# Outputs: plot2.png: a l line graph of global active power vs time
###############################################################################
################# Loading and Subsetting data for 2 days in February 2007 ######
setwd("G:/Coursera/Course 4 Exploratory Data Analysis")
library(lubridate)

power_data <- read.table("household_power_consumption.txt", sep = ";", 
              header = TRUE, colClasses = c(Global_active_power = "character"))

# renaming columns to match room
#kitchen
names(power_data)[names(power_data) == "Sub_metering_1"] <- "Sub_metering_kitchen"
#laundry room
names(power_data)[names(power_data) == "Sub_metering_2"] <- "Sub_metering_laundry_room"
# water heater and air conditioning
names(power_data)[names(power_data) == "Sub_metering_3"] <- "Sub_metering_water_heater_air_conditioner"

# change date column to date class
power_data$Date <- dmy(power_data$Date)

# creates  a time range for the dates we want to look at with the date class
time_interval <- interval(start = ymd("2007-02-01"), end = ymd("2007-02-02"))

# Finds subset of data for our time range
power_data_2days <- power_data[power_data$Date %within% time_interval,]
# combining dates into one column
power_data_2days$Exact_Time <- ymd_hms(paste(power_data_2days$Date, power_data_2days$Time))

############################## Plot 2 #########################################
# opens a png graphics device
png(filename = "plot2.png", width = 480, height = 480)
## plotting line graph of global active power
# combining dates into one column
power_data_2days$Exact_Time <- ymd_hms(paste(power_data_2days$Date, 
                                             power_data_2days$Time))

# plotting global active power vs weekday with base plotting system
with(power_data_2days, plot (Exact_Time, Global_active_power, type = "l", 
      col = "black", xlab = '', ylab = "Global Active Power (killowatts)"))
# closes graphics device
dev.off()