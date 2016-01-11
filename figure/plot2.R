## Yo, Yo, Yo, Whatup - This is the script for the Coursera/ Johns Hopkins "Exploratory Data Analysis" week 1 assignment, plot 2 of 4.
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

par(mfrow=c(1,1))
png(filename = "plot2.png", 
    width = 480, height = 480, 
    units = "px")
## Here's the plot
plot(februaryData$Time3, februaryData$Global_active_power, type = "l" ,
     xlab = c(""),
     ylab = c("Global active power (kilowatts)"))
dev.off()





