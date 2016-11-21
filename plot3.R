if(!file.exist("household_power_consumption")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "download.zip")
        unzip(files = "download.zip")
}

elec <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
## select observation on 2007 Feb 1st and 2nd
elec <- subset(elec, Date == "1/2/2007" | Date == "2/2/2007")

library(lubridate)
elec$Date <- dmy(elec$Date)
elec$Date_Time <- paste(elec$Date, elec$Time)
elec$Date_Time <- ymd_hms(elec$Date_Time)
elec$Global_active_power <- as.numeric(as.character(elec$Global_active_power))
elec$Sub_metering_1 <- as.numeric(as.character(elec$Sub_metering_1))
elec$Sub_metering_2 <- as.numeric(as.character(elec$Sub_metering_2))
elec$Sub_metering_3 <- as.numeric(as.character(elec$Sub_metering_3))

## Create plot with axis-labels 
plot(elec$Date_Time, elec$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy sub metering")
## Add lines
lines(elec$Date_Time, elec$Sub_metering_1)
lines(elec$Date_Time, elec$Sub_metering_2, col = "red")
lines(elec$Date_Time, elec$Sub_metering_3, col = "blue")
## Add legends
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.8)

dev.copy(png, file = "plot3.png")
dev.off()