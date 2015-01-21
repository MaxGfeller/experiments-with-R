# install.packages("ggplot2", dependencies=c("Depends", "Imports"), repos = "http://cran.us.r-project.org")
library("ggplot2")

# read data from csf file
data <- read.csv("test-data/comic-characters/dc-wikia-data.csv", TRUE)

# create an empty data frame
characters <- data.frame(
  Year=integer(),
  femaleCharacters=integer(),
  maleCharacters=integer()
)

addToFrame <- function(x) {
  if (!is.na(x["YEAR"]) && !is.null(x["YEAR"])) {
    if (!(as.integer(x["YEAR"]) %in% row.names(characters))) {
      # add a new year
      newYear <- data.frame(
        Year=as.integer(x["YEAR"]),
        femaleCharacters=0,
        maleCharacters=0
      )
      row.names(newYear) <- as.integer(x["YEAR"])
      characters <<- rbind(characters, newYear)
    }

    columnToUpdate <- "femaleCharacters"
    if (x["SEX"] == "Male Characters") {
      columnToUpdate <- "maleCharacters"
    }
    characters[x["YEAR"], columnToUpdate]<<-as.integer(characters[x["YEAR"], columnToUpdate]) + 1
  }
}

invisible(apply(data, 1, addToFrame))
invisible(characters <- characters[order(rownames(characters)), ])

jpeg("output/dc-superheroes/male-vs-female-superheroes.jpg", width=1200, height=400)
ggplot(data=characters, aes(
  x=Year
)) +
labs(y="Characters created") +
scale_color_discrete(name="Sex") +
scale_x_continuous(breaks = round(seq(min(characters$Year), max(characters$Year), by = 5), 1)) +
geom_line(aes(y=maleCharacters, ylab="Characters created", colour="male")) +
geom_line(aes(y=femaleCharacters, colour="female"))
