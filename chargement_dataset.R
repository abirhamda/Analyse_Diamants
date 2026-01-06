# Charger le package ggplot2 (qui inclut diamonds)
library(ggplot2)

# Charger le dataset diamonds
data(diamonds)

# Aperçu rapide
head(diamonds)  # Affiche les 6 premières lignes
str(diamonds)   # Structure : types de variables
summary(diamonds)  # Statistiques de base (min, max, moyenne)
dim(diamonds)   # Nombre de lignes et colonnes (53940 x 10)