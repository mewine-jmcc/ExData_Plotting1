if(!file.exist("household_power_consumption")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "download.zip")
        unzip(files = "download.zip")
}

elec <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
## select observation on 2007 Feb 1st and 2nd
elec <- subset(elec, Date == "1/2/2007" | Date == "2/2/2007")

elec$Global_active_power <- as.numeric(as.character(elec$Global_active_power))
hist(elec$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     main = "Global Active Power", 
     col = "red")
dev.copy(png, file = "plot1.png")
dev.off()