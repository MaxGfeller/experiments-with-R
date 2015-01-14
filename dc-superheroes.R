# read data from csf file
data <- read.csv("test-data/comic-characters/dc-wikia-data.csv", TRUE)

# redirect plot output into file
jpeg("output/number-of-heroes.jpg")
hist(data$YEAR, main="Number of new superheroes", xlab="year", ylab="Number of new superheroes")

# create subset for female characters
femaleCharacters <- subset(data, SEX=='Female Characters')
jpeg("output/number-of-female-characters.jpg")
hist(femaleCharacters$YEAR, main="Number of female characters", xlab="Year", ylab="Number of female characters")

# sign off
dev.off()
