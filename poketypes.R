# Analysis of Pokémon types
# Nicolas Kim, Carnegie Mellon University

library(sqldf)

# Here, we're just creating a table with two columns: pokemon id and type
dfpokemon <- read.csv("http://www.stat.cmu.edu/~nicolask/share/pokedex/pokemon.csv")[1:npoke, ]
dftypes <- read.csv("http://www.stat.cmu.edu/~nicolask/share/pokedex/pokemon_types.csv")
dftypename <- read.csv("http://www.stat.cmu.edu/~nicolask/share/pokedex/types.csv")
tabletype <- sqldf("SELECT p.id, n.identifier AS type FROM dfpokemon p JOIN dftypes t ON p.id = t.pokemon_id JOIN dftypename n ON t.type_id = n.id")

# Takes a national dex number and returns one or two types
getTypes <- function(pokenum) {
  return(unlist(sqldf(paste0("SELECT a.type FROM tabletype a WHERE a.id=", pokenum))))
}
