##Course Project 1 - Plot 1

getwd()
#Read the dataset Electric power consumption
hh_pc <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?", stringsAsFactors = 1)

#Format the date column to Type Date
hh_pc$Date <- as.Date(hh_pc$Date, "%d/%m/%Y")

hh_pc <- subset(hh_pc, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#Assemble in one variable Date and Time. Name the column.
date <- paste(hh_pc$Date, hh_pc$Time)
date <- setNames(date, "DateTime")

#Remove from the original dataset the columns Date and Time and add the new created variable
remove <- c("Date","Time")
hh_pc <- hh_pc[, !(names(hh_pc) %in% remove)]
hh_pc <- cbind(date, hh_pc)

#Format the date column
hh_pc$date <- as.POSIXct(date)
#set the local time - Enables the week days to appear in english in the plot
Sys.setlocale("LC_TIME", "English")
#hh_pc


##Plot 1 - histogram of the household global minute-averaged active power data from 1st to 2nd february of 2007
par(mar=c(5,4,3,2))
hist(hh_pc$Global_active_power, breaks= 12, main=paste("Global Active Power"),
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

#save the histogram as a png. file
dev.print(png, file="plot1.png", width=480, height=480)
dev.off()
