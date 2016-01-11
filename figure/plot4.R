## Yo, Yo, Yo, Whatup - This is the script for the Coursera/ Johns Hopkins "Exploratory Data Analysis" week 1 assignment, plot 4 of 4.
## Written by Steven Reddick, 1/8/2016

# Loadin' the OG (Original Gangsta') librariez dat make dis shit tick.
library(dplyr)
library(lubridate)



## Setting working directory to my machine's file path.  'Dis fo' me only, yo, get yo' own file path.
#setwd("/Users/stevenreddick/coursera/Exploratory_Data_Analysis")
## Test if the dataset exists and download it if it doesn't, else load it.  Bitch.
if(!file.exists("household_power_consumption.txt")) {
        ## File path URL for the dataset download. 
        assignmentOneURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        ## Getting the file downloaded and unzipped in my working directory
        download.file(assignmentOneURL,destfile = "assignment_One_Raw_Data")
        ## Unzipping & reading in the dataset
        unzip(zipfile = "assignment_One_Raw_Data")
}

##  Since the unzipped file is a .txt, use read.table(), 'ya feel me?
assignment_One_Raw_Data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
## Use dplyr to convert to a table df for faster manipulation.  Dplyr strait from 'da West side.
assignment_One_Raw_Data <- tbl_df(assignment_One_Raw_Data)



## <-----------### Fix the time ####

# Convert the Date and Time variables from factor to POSIXct, brah. 
assignment_One_Raw_Data <- mutate(assignment_One_Raw_Data, Date = dmy(Date))

assignment_One_Raw_Data$catDateTime <- paste(assignment_One_Raw_Data$Date , assignment_One_Raw_Data$Time, sep = " ")
assignment_One_Raw_Data$Time2  <- strptime(assignment_One_Raw_Data$catDateTime, "%Y-%m-%d %H:%M:%S" )
## Create the POSIXct class date variable
assignment_One_Raw_Data$Time3 <- as.POSIXct(assignment_One_Raw_Data$Time2)
## Get rid of Time2 because dplyr can't work with POSIXlt, or something...
assignment_One_Raw_Data$Time2 <- "NA"
## Subset the full set down to Feb 1 & 2, 2007. 
februaryData <- filter(assignment_One_Raw_Data, Date == ymd("2007-02-01") |  Date ==ymd("2007-02-02"))


## Sets the "number of plots on a page" parameter to 2 col and 2 row.
par(mfrow=c(2,2))
## Set margins s.t. all plts wil fit.
par(mar = rep(2, 4))

png(filename = "plot4.png", 
    width = 480, height = 480, 
    units = "px")
## Plot 1,1
plot(februaryData$Time3, februaryData$Global_active_power, type = "l" ,
     xlab = c(""),
     ylab = c("Global active power (kilowatts)"))

par(mar = rep(2, 4))
## Plot 1,2
plot(februaryData$Time3, februaryData$Voltage, type = "l" ,
     xlab = c(""),
     ylab = c("Voltage"))


## Plot 2,1

## Here's the plot
plot(februaryData$Time3, februaryData$Sub_metering_1, type = "l" ,
     xlab = c(""),
     ylab = c("Energy sub metering"))
## Adds the other 2 series
lines(februaryData$Time3,februaryData$Sub_metering_2, col = "red")
lines(februaryData$Time3,februaryData$Sub_metering_3, col = "blue")
# Adds a legend
legend('topright', names(februaryData)[7:9] , 
       lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)


## Plot 2,2
plot(februaryData$Time3, februaryData$Global_active_power, type = "l" ,
     xlab = c(""),
     ylab = c("Global reactive power (kilowatts)"))
dev.off()
