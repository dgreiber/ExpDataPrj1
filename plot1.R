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
hist(data$Global_active_power, main = "Global Active Power", ylab = "Frequency", xlab = "Global Active Power (kilowatts)", col = "red", breaks = 13, ylim = c(0, 1200), xlim = c(0, 6), xaxp = c(0, 6, 3))

## creates plot png file
dev.copy(png, file = "./data/plot1.png", width = 480, height = 480)

## close graphics device
dev.off()