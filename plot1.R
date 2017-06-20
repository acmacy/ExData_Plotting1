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
View(feb)

#Save Plot1 as png
png("./plot1.png",width = 480,height = 480) 
hist(feb$Global_active_power, main = "Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()


