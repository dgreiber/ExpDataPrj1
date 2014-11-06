## check if directory exists
if (!file.exists("data")) {
  dir.create("data")  
}


## downloads file
if (!file.exists("./data/household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data/power_data.zip")
  unzip("./data/power_data.zip", overwrite = T, exdir = "./data")
}

## reads data
data <- read.csv("household_power_consumption.txt", na.string="?", sep=";")

## extract only needed data
data <- data[(data$Date=="1/2/2007" | data$Date=="2/2/2007"),]

## combine date and time data
data$DateTime <- strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

## creates graph
par(mfrow = c(2, 2))
 
# first plot top-left
  plot(data$DateTime, data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

#  second plot top-right
  plot(data$DateTime, data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
 
# third plot bottom-left
  plot(data$DateTime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
  points(data$DateTime, data$Sub_metering_2, type = "l", xlab = "", ylab = "Sub_metering_2", col = "red")
  points(data$DateTime, data$Sub_metering_3, type = "l", xlab = "", ylab = "Sub_metering_3", col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", )
                                                                          
# fourth plot bottom-right
  plot(data$DateTime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", ylim = c(0, 0.5))

## creates plot png file
dev.copy(png, file = "./data/plot4.png", width = 480, height = 480)

## close graphics device
dev.off()