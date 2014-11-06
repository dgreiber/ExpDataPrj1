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
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## creates plot png file
dev.copy(png, file = "./data/plot2.png", width = 480, height = 480)

## close graphics device
dev.off()