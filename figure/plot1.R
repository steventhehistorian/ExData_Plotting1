## Yo, Yo, Yo, Whatup - This is the script for the Coursera/ Johns Hopkins "Exploratory Data Analysis" week 1 assignment, plot 1 of 4.
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

# Convert the Date and Time variables from factor to POSIXct, brah. 
assignment_One_Raw_Data <- mutate(assignment_One_Raw_Data, Date = dmy(Date))
assignment_One_Raw_Data <- mutate(assignment_One_Raw_Data, Time = hms(Time))
## Subset the full set down to Feb 1 & 2, 2007. 
februaryData <- filter(assignment_One_Raw_Data, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))
## Remove the rest of the dataset for some extra memoryz up in my RAM, yo.
rm(assignment_One_Raw_Data)

# Make dem mathy variablez all mathy and not factory...
februaryData <- mutate(februaryData, Global_active_power = as.numeric(Global_active_power))

par(mfrow=c(1,1))
png(filename = "plot1.png", 
    width = 480, height = 480, 
    units = "px")
# Plot ONE!  Histogram wit' da RED BARZZZZZZZZZZ!!!!!!!
hist(februaryData$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()






