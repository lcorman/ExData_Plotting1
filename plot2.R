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
png(file = "plot2.png",
    width = 480, height = 480)

# Plot over time
plot(df$Date_time, df$Global_active_power,
     type = "l",
     lty = 1,
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Turn off graphics device
dev.off()
