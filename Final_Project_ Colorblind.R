#Title: Final Project - Is the U.S. Judicial System Colorblind?  
#Author: Gustav Rasmussen Hjalf
#Date: 2021-01-10
#License - Creative Commons Legal Code - CC0 1.0 Universal (CC0 1.0)

#Barplot Race of Executed and Victim

#First i clear my environment
rm(list = ls())

#Now i load my libraries
library(readxl)
library(plyr)
library(ggplot2)
library(RColorBrewer)

#About the data - The data is puplished by NAACP Legal Defense and Educational Fund, Inc. 
#The clean version of the data is present in my Github: link her
#Link to data: https://www.naacpldf.org/wp-content/uploads/DRUSASpring2021.pdf 



#Now i import my datasheet from exel, and skip the first row because it is irrellevante
Roster_of_the_Executed2 <- read_excel("Desktop/Roster-of-the-Executed2.xlsx", 
                                      col_types = c("date", "text", "text", 
                                                    "text", "text", "text"), skip = 1)
#The focus is on defendants and ecexuted, therefore I pull these informations out by selection column 4 and 5. 
#Hereafter I use the table function to count the selected data
#To eayse my work later on, i chose to transponder the matrix from table function. 
Overview <- t(table(Roster_of_the_Executed2[c(1:1532), c(4:5)]))

#Now I pull the three races: White, Black and Latino. This I do to make the visualization more manageable. 
#The remaining races constitute such a small part, that they would only disturb the outcome.  
Subinformation = Overview[c(2, 4, 8), c(2,3,5)]

#I am naming the columns, this will make the later plot look better.
colnames(Subinformation) = c("Black", "Latino", "White")

#I am setting the background color 
par(bg = "lightgrey")

#Now I am plotting the distribution of victims, race of defandants and number of cases. 
#Furthermore, I am naming the bars and choosing their color. 
barplot(Subinformation, main = "Distribution of victim", xlab = "Race of defended", ylab = "Number of cases", 
        legend = c("Black", "Latino", "White"), col = c("black", "red", "white"), args.legend=list(x="top"))


#----------------------------------------------------------------------------------------------------------------#

# Barplot number of executed pr. decade sorted in race

#Now i import my datasheet from exel
decade_number_execuded_race <- read_excel("Desktop/decade_number_execuded_race.xlsx")
col_types = c("text", "numeric", "numeric")

# I am naming the data
Decade_Overview <- decade_number_execuded_race

#Creating equaly long vectors, including number of executions, races and decades
decades <- c(rep("eighties", 2), rep("nineties", 2), rep("zeroes", 2), rep("tens", 2))
race <- rep(c("White", "Black"), 4)
executions <- as.numeric(c(Decade_Overview[1,2], Decade_Overview[1,3], Decade_Overview[2,2], Decade_Overview[2,3], Decade_Overview[3,2], Decade_Overview[3,3], Decade_Overview[4,2], Decade_Overview[4,3]))
 
#Collecting all in a dataframe, which now can be plotted
plotdata <- data.frame(decades, race, executions)

# Plotting the data 
p <- ggplot(plotdata, aes(fill=race, y=executions, x=decades)) + 
  geom_bar(position="dodge", stat="identity")

#Showing the plot
p
