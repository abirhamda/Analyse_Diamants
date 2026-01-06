
library(ggplot2)  # Pour visualisations et dataset diamonds
library(dplyr)    # Pour manipuler données (ex. group_by)
library(corrplot) # Pour matrice de corrélation

# 2. Charger le dataset
data(diamonds)

# 3. Aperçu des données
head(diamonds)  # Premières lignes 
str(diamonds)   # Types
dim(diamonds)  
summary(diamonds)  # Stats de base : ex. prix moyen ~3932 USD

# 4. Statistiques sommaires par groupe (ex. par qualité de coupe 'cut')
diamonds_summary <- diamonds %>%
  group_by(cut) %>%  # Grouper par 'cut' (Fair, Good, etc.)
  summarise(         # Calculer stats
    count = n(),                # Nombre d'observations
    avg_price = mean(price),    # Prix moyen
    median_price = median(price),  # Prix médian
    avg_carat = mean(carat),    # Carat moyen
    sd_price = sd(price)        # Écart-type du prix
  ) %>%
  arrange(desc(avg_price))  # Trier par prix moyen décroissant
print(diamonds_summary)  # Affiche le tableau dans console

# 5. Visualisations univariées (une variable)
# Histogramme du prix (distribution)
ggplot(diamonds, aes(x = price)) +
  geom_histogram(bins = 50, fill = "skyblue", color = "black") +  # 50 barres, couleur bleue
  labs(title = "Distribution des Prix des Diamants", x = "Prix (USD)", y = "Nombre de Diamants") +
  theme_minimal()  # Style simple

# Histogramme du carat
ggplot(diamonds, aes(x = carat)) +
  geom_histogram(bins = 50, fill = "gold", color = "black") +
  labs(title = "Distribution du Poids (Carat)", x = "Carat", y = "Nombre") +
  theme_minimal()

# Barplot pour catégories : Répartition par 'cut'
ggplot(diamonds, aes(x = cut, fill = cut)) +
  geom_bar() +
  labs(title = "Nombre de Diamants par Qualité de Coupe", x = "Cut", y = "Nombre") +
  theme_minimal()

# 6. Visualisations bivariées (deux variables)
# Scatterplot : Prix vs Carat, coloré par 'cut'
ggplot(diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point(alpha = 0.5) +  # Points semi-transparents
  labs(title = "Prix vs Poids (Carat) par Qualité de Coupe", x = "Carat", y = "Prix (USD)") +
  theme_minimal()

# Boxplot : Prix par 'cut'
ggplot(diamonds, aes(x = cut, y = price, fill = cut)) +
  geom_boxplot() +
  labs(title = "Distribution du Prix par Qualité de Coupe", x = "Cut", y = "Prix (USD)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Tourner labels

# Boxplot : Prix par 'color' (D meilleur, J pire)
ggplot(diamonds, aes(x = color, y = price, fill = color)) +
  geom_boxplot() +
  labs(title = "Distribution du Prix par Couleur", x = "Color", y = "Prix (USD)") +
  theme_minimal()

# 7. Matrice de corrélation (relations entre numériques)
numeric_vars <- diamonds %>% select(carat, depth, table, price, x, y, z)  # Seulement numériques
cor_matrix <- cor(numeric_vars)  # Calculer corrélations
corrplot(cor_matrix, method = "color", type = "upper", tl.cex = 0.8,  # Visualiser
         title = "Corrélations entre Variables Numériques", mar = c(0,0,1,0))

# 8. Insights supplémentaires (exemples d'analyses)
# Top 10 combinaisons cut + color par prix moyen
top_combinations <- diamonds %>%
  group_by(cut, color) %>%
  summarise(avg_price = mean(price), count = n()) %>%
  arrange(desc(avg_price)) %>%  # Trier décroissant
  head(10)  # Top 10
print(top_combinations)

# Pourcentage de diamants chers (> 5000 USD)
high_price_pct <- mean(diamonds$price > 5000) * 100
cat("Pourcentage de diamants > 5000 USD :", high_price_pct, "%\n")  # Affiche ex. ~28%

# Sauvegarder un plot (optionnel, dans 'outputs')
ggsave("outputs/prix_vs_carat.png", width = 8, height = 6)  # Sauvegarde le dernier ggplot