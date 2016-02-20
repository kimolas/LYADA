# Some helper functions process the Pokémon data
# Nicolas Kim, Carnegie Mellon University, 2016

# datalist <- list()
# filenames <- list.files("~/git/pokedex/pokedex/data/csv")
# for(ii in 1:length(filenames)) {
#   if(ii != 164) {
#     datalist[[ii]] <- read.csv(paste0("~/git/pokedex/pokedex/data/csv/", filenames[ii]))
#   }
# }
# names(datalist) <- filen

# Names of the pokemon as a vector, indexed by national dex number
pokenames <- as.vector(read.csv("http://www.stat.cmu.edu/~nicolask/share/pokedex/pokemon.csv")[1:649, "identifier"])

# Opposite to 'pokenames': convert name to national dex number
nameToNumber <- function(pokename) {
  return(which(pokename == pokenames)[1])
}

