
# Download and unzip files ------------------------------------------------

file <- file.path(getwd(), "power.zip")
if (!file.exists(file)){
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, file)
}
if (!file.exists("household_power_consumption")) { 
  unzip(file)
}



# Read and subset in electric power consumption data -----------------------

power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c(rep("character", 2), rep("numeric", 7)))
power$DateTime <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

power <- subset(power, Date == "2007-02-01" | Date == "2007-02-02")



# Create plot 1 -------------------------------------------------------------

par(mfrow = c(1, 1))

hist(power$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
