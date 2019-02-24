#Reading, naming and subsetting power consumption data
#reading the data
energy <- read.table("household_power_consumption.txt",skip=1,sep=";")
# name the labels appropiately:instead of v1,v2 ... we name them
names(energy) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
#subsetting to read required dates only
subenergy <- subset(energy,energy$Date=="1/2/2007" | energy$Date =="2/2/2007")

# Transforming the Date and Time variables from characters into objects of type Date and POSIXlt respectively
subenergy$Date <- as.Date(subenergy$Date, format="%d/%m/%Y")
subenergy$Time <- strptime(subenergy$Time, format="%H:%M:%S")
#the Time has to be corrected to the actual dates of 2007-02-01 and 2007-02-02
subenergy[1:1440,"Time"] <- format(subenergy[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subenergy[1441:2880,"Time"] <- format(subenergy[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# calling the basic plot function
plot(subenergy$Time,as.numeric(as.character(subenergy$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)") 

# annotating graph
title(main="Global Active Power Vs Time")

#name and save de plot file
dev.copy(png,file="plot2.png")
dev.off()

