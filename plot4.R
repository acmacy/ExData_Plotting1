#Check for Directory
setwd("./Downloads/RStuff")
if(!file.exists("./Electricity")){dir.create("./Electricity")}
setwd("./Electricity")

#Download Zip File
fil <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fil,destfile="./EPC.zip",method="curl")

#Unzip downloaded file
unzip(zipfile="./EPC.zip",exdir="./")

#Read EPC Data
epc<-read.table("household_power_consumption.txt",sep=";",header = T,as.is = T)
for(i in 3:9)
{ epc[,i]<-as.numeric(epc[,i])
}
View(epc)

#Conversion of first 2 variables
epc$Date<-as.Date(epc$Date, format="%d/%m/%Y")
epc$Time<-strptime(epc$Time,format = "%X")
epc$Time<-format(epc$Time, format="%H:%M:%S")

#Subsetting Data
feb<-subset(epc, Date == "2007-02-01" | Date == "2007-02-02")

##Save Plot4 as png
png("./plot4.png",width = 480,height = 480)

#Output window setup
par(mfrow=c(2,2))

#Sub Plot 1
plot(feb$Global_active_power,xaxt="n",type="l",xlab="",ylab = "Global Active Power")
c<-nrow(feb)
axis(1, at=c(0,c/2,c), labels=c("Thu","Fri","Sat"))

#Sub Plot 2
plot(feb$Voltage,xaxt="n",type="l",xlab="datetime",ylab = "Voltage")
axis(1, at=c(0,c/2,c), labels=c("Thu","Fri","Sat"))

#Sub Plot 3
plot(feb$Sub_metering_1,xaxt="n",ylim=range(c(feb$Sub_metering_1,feb$Sub_metering_2,feb$Sub_metering_3)),type="l",ylab="Energy sub metering",xlab="")
par(new=TRUE)
plot(feb$Sub_metering_2,xaxt="n",ylim=range(c(feb$Sub_metering_1,feb$Sub_metering_2,feb$Sub_metering_3)),type="l",col="red",ylab="Energy sub metering",xlab="")
par(new=TRUE)
plot(feb$Sub_metering_3,xaxt="n",ylim=range(c(feb$Sub_metering_1,feb$Sub_metering_2,feb$Sub_metering_3)),type="l",col="blue",ylab="Energy sub metering",xlab="")
axis(1, at=c(0,c/2,c), labels=c("Thu","Fri","Sat"))
legend("topright", col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=1,bty="n")

#Sub Plot 4
plot(feb$Global_reactive_power,xaxt="n",type="l",xlab="datetime",ylab = "Global_reactive_power")
axis(1, at=c(0,c/2,c), labels=c("Thu","Fri","Sat"))

dev.off()
