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

# 2) create a plot2.png file that graphs Global_active_power 
png("plot2.png") # starts the png file
par(mar=c(3,4,4,2)) # change the margins
# plots a line with global active power over time
plot(Edata[,1]~Edata[,8],ylab="Global Active Power(Kilowatts)",type = "l")
dev.off() # finishs the png file
