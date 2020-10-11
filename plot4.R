library(lubridate)
library(dplyr)

# Read in data
df <- read.table(file = "household_power_consumption.txt",
                 sep = ";",
                 header = T,
                 na.strings = "?",
                 nrows = 2080000,
                 col.names = c("Date", "Time", "Global_active_power",
                               "Global_reactive_power", "Voltage", "Global_intensity",
                               "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                 colClasses = c("character", "character", "numeric", "numeric",
                                "numeric", "numeric", "numeric", "numeric", "numeric"))

# Convert to dates and times

# Add date-time column to use in plot
df$Date_time <- lubridate::dmy_hms(paste(df$Date, df$Time))

# Date format is Day/Month/Year
df$Date <- lubridate::dmy(df$Date)
# Time format is Hours/Minutes/Seconds
df$Time <- lubridate::hms(df$Time)

# Filter to relevant dates
df <- df %>% filter(Date == "2007-02-01" | Date == "2007-02-02")

# Create png file for plot
png(file = "plot4.png",
    width = 480, height = 480)

# Add multiple plots
par(mfrow = c(2,2))
with(df, {
  plot(Date_time, Global_active_power,
       type = "l",
       lty = 1,
       xlab = "",
       ylab = "Global Active Power")
  plot(Date_time, Voltage,
       type = "l",
       lty = 1,
       xlab = "datetime",
       ylab = "Voltage")
  plot(Date_time, Sub_metering_1, type = "n",
       ylab = "Energy sub metering", xlab = "")
  lines(Date_time, Sub_metering_1, col = "black")
  lines(Date_time, Sub_metering_2, col = "red")
  lines(Date_time, Sub_metering_3, col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Date_time, Global_reactive_power,
       type = "l",
       lty = 1,
       xlab = "datetime",
       ylab = "Global_reactive_power")
})

# Turn off graphics device
dev.off()
