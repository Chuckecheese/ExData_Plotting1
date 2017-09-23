# 1) read in the data and subset the data
# set working directory, load in file to r.
Edata<-read.table("household_power_consumption.txt",sep=";",header = T)
# merge the data and time column
Edata["Time & Date"]= paste(Edata$Date, Edata$Time, sep=" ")
# remove data and time columns
Edata<-Edata[,-c(1:2)]
# change Time & Date class POSIXlt
Edata$`Time & Date`<-as.POSIXct(as.character(Edata$`Time & Date`),format="%d/%m/%Y %T")
# Change all other columns to numeric
Edata[,1] <- as.numeric(as.character(Edata[,1]))
Edata[,2] <- as.numeric(as.character(Edata[,2]))
Edata[,3] <- as.numeric(as.character(Edata[,3]))
Edata[,4] <- as.numeric(as.character(Edata[,4]))
Edata[,5] <- as.numeric(as.character(Edata[,5]))
Edata[,6] <- as.numeric(as.character(Edata[,6]))
Edata[,7] <- as.numeric(as.character(Edata[,7]))
# remove all data that is not between 2007-02-01 and 2007-02-02 
Edata<-Edata[which(Edata$`Time & Date`=="2007-02-01 00:00:00 CST"):which(Edata$`Time & Date`=="2007-02-02 23:59:00 CST"),]

# 2) create a plot4.png file that graphs 4 diffrent graphs 
png("plot4.png") # starts the png file
par(mfrow=c(2,2)) # change the margins, and alows multiple graphs

#2.a) first graph of global active power
plot(Edata[,1]~Edata[,8],ylab="Global Active Power(Kilowatts)",
     xlab="DateTime",type = "l")

#2.b) second graph of voltage
plot(Edata[,3]~Edata[,8],ylab="Voltage",xlab="DateTime",type = "l")

#2.c) third graph of sub metering
plot(Edata[,5]~Edata[,8],type = "l",ylab = "Energy sub metering",xlab="Datetime") # creates the plot with sub metering 1
# adds labels into the graph  
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col=c("black","red", "blue"), lty=c(1,1,1), cex=.8, bty="n")
lines(Edata[,6]~Edata[,8],type = "l",col="red")# line for sub metering 2, line is red
lines(Edata[,7]~Edata[,8],type = "l",col="blue")# line for sub metering 3, line is blue

# 2.d) forth graph
plot(Edata[,2]~Edata[,8],ylab="Global_Reactive_Power",xlab="DateTime",type = "l")

dev.off() # finishs the png file