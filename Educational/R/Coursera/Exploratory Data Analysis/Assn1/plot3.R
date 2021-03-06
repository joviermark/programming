# Coursera Exploratory Data Analysis Project 1
# Plot 3
# 3 overlaid linegraphs of Energy sub metering (1,2,3) over Thu to Sat
# "base" plotting system
# 5/5/14
# Ethan Petuchowski

power_consumption <- '/Users/ethan/code/non_apple/data/household_power_consumption.txt'

# initial rough estimate
plot3 <- function (data_loc = power_consumption) {

    # Read raw data
    data <- read.csv(data_loc, sep = ';', na.strings = c('?'),
                     colClasses = c(rep('character', 2), rep('numeric', 7)),
                     comment.char = '', nrows = 69518)
    
    # only plot date range we care about
    filtered <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')
    
    png('plot3.png') # open PNG device
    
    # construct base line graph
    plot(filtered$Sub_metering_1, col = 'black', type = 'l',
         ylab = 'Energy sub metering', xlab = '', xaxt = 'n')
    
    # overlay other line graphs
    lines(filtered$Sub_metering_2, col = 'red', type = 'l')
    lines(filtered$Sub_metering_3, col = 'blue', type = 'l')
    len <- length(filtered$Global_active_power)
    
    # add x-axis
    axis(side = 1, at = c(1, len/2, len), labels = c('Thu', 'Fri', 'Sat'))
    
    # add caption
    legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
           col = c('black', 'red', 'blue'), lty = c(1,1,1))
    
    dev.off() # save PNG to filesystem
}
