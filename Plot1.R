
png(filename="plot1.png", width=480, height=480)
hist(d$Global_active_power, freq=T, plot=T, main= "Global Active Power", xlab="Gloal Active Power (kilowatts)", col="red")
dev.off() 