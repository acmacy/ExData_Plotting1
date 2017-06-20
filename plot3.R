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

#Save Plot3 as png
png("./plot3.png",width = 480,height = 480)
plot(feb$Sub_metering_1,xaxt="n",ylim=range(c(feb$Sub_metering_1,feb$Sub_metering_2,feb$Sub_metering_3)),type="l",ylab="Energy sub metering",xlab="")
par(new=TRUE)
plot(feb$Sub_metering_2,xaxt="n",ylim=range(c(feb$Sub_metering_1,feb$Sub_metering_2,feb$Sub_metering_3)),type="l",col="red",ylab="Energy sub metering",xlab="")
par(new=TRUE)
plot(feb$Sub_metering_3,xaxt="n",ylim=range(c(feb$Sub_metering_1,feb$Sub_metering_2,feb$Sub_metering_3)),type="l",col="blue",ylab="Energy sub metering",xlab="")
c<-nrow(feb)
axis(1, at=c(0,c/2,c), labels=c("Thu","Fri","Sat"))
legend("topright", col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=1)
dev.off()


