##Course Project 1 - Plot 2

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

#Plot 2 - Plot of the household global minute-averaged active power
with(hh_pc, plot(Global_active_power~date, ylab="Global Active Power (kilowatts)",
                 xlab="", type="l"))

#save the plot as a png. file
dev.print(png, file="plot2.png", width=480, height=480)
dev.off()
