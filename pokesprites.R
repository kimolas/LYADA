# Analysis of Pokémon Data
# This is an exploration of the sprite data
# Nicolas Kim, Carnegie Mellon University, 2016

require(png)
# require(ggplot2)
require(Hmisc)

# This is for Gen 5 as of Pokemon Black and White
npoke <- 649
sprites <- lapply(1:npoke, function(x) readPNG(paste0("./sprites5/", x, ".png")))

# Kanto starters!
bulbasaur <- sprites[[1]]
charmander <- sprites[[4]]
squirtle <- sprites[[7]]

# Given a list of Pokemon images, it will return the "average image"
avgImg <- function(lst) {
  result <- lst[[1]]
  for(ii in 2:length(lst)) {
    result <- result + lst[[ii]]
  }
  # result <- pmin(result/qrt(length(lst)), 1)
  for(ii in 1:4) {
    result[,,ii] <- result[,,ii]/result[,,4]
  }
  result[is.na(result)] <- 0
  result[,,4] <- ceiling(result[,,4])
  return(result)
}

# Experimenting with the transparancy layer
# for(ii in 1:dim(bulbasaur)[1]) {
#  for(jj in 1:dim(bulbasaur)[2]) {
#    if(bulbasaur[ii, jj, 4] == 0) {
#      bulbasaur[ii, jj, 4] <- 1
#    }
#  }
#}

# Plot the sprites in R!
plotSprite <- function(pokemon) {
  plot(c(-10, 10), c(-10, 10), type="n", xlab="Pokemon Width", ylab="Pokemon Height", xaxt="n", yaxt="n")
  rasterImage(sprites[[pokemon]], -10, -10, 10, 10)
}

# Normalized RGB color distribution of a given Pokemon (by Pokedex number)
pokeColor <- function(pokenum, plothist=FALSE) {
  dist <- sapply(1:3, function(x) sum(sprites[[pokenum]][, , x]))
  dist <- dist/sum(dist)
  if(plothist) {
    barplot(dist, col=c("Red", "Green", "Blue"), main=paste(capitalize(pokenames[pokenum]), "Color Distribution"), names.arg=c("Red", "Green", "Blue"), ylab="Pixel Intensity", xlab="Color")
  }
  return(dist)
}

# The top 'npoke' Pokemon by match to the given color vector
colorRanking <- function(color, num=npoke) {
  return(rev(order(sapply(1:npoke, function(x) pokeColor(x) %*% color)))[1:num])
}

