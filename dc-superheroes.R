data <- read.csv("test-data/comic-characters/dc-wikia-data.csv", TRUE)
jpeg("output/number-of-heroes.jpg")
hist(data$YEAR, main="Number of new superheroes", xlab="year", ylab="Number of new superheroes")
dev.off()
