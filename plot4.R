##Course Project 1 - Plot 4

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


#Plot 4 - Set of plots
par(mfrow=c(2,2), mar=c(4,4,2,2))
with(hh_pc, {
  plot(Global_active_power~date, ylab="Global Active Power",
       xlab="", type="l")
  plot(Voltage~date, ylab="Voltage", xlab="datetime", type="l")
  plot(Sub_metering_1~date, type="l", xlab="", ylab="Energy sub metering")
  lines(Sub_metering_2~date, col="red")
  lines(Sub_metering_3~date, col="blue")
  legend("topright", col=c("black", "red", "blue"), lwd=2, bty="n", cex=0.9, 
         adj = c(0.05,0.2), pt.lwd=1,
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~date,ylab="Global_reactive_power",
       xlab="datetime", type="l" )
})

#save the plot as a png. file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
