# US Arrests Dataset

# This data set contains statistics in arrests per 100,000 residents for assault, 
# murder, and rape in each of the 50 US states in 1973. Also given is the percent 
# of the population living in urban areas.

#load libraries

library(tidyverse)
library(tibble)
library(stringr)

arrests.df <- USArrests

# make move rownames to columns

arrests.df <- rownames_to_column(arrests.df, "State")


# select relevant columns

arrests.df <- arrests.df %>% select("State", "Murder", "Assault", "Rape")

# gather columns

arrests.df <- gather(arrests.df, "Crime", "Count", -1 )

# plot

#basic viz


ggplot(arrests.df, aes(x = Crime, y = Count)) +
  geom_bar(stat = "summary", fun = "mean")

# assign title to vector so that it can be passed into str_wrap, to wrap the text

chart_title <-  "IN 1978, ASSAULTS WERE THE MOST COMMON TYPE OF CRIME IN THE US"

# final viz

ggplot(arrests.df, aes(x = Crime, y = Count)) +
  geom_bar(stat = "summary", fun = "mean", fill = "#4F6D7A") +
  geom_text(aes(label = ..y..), stat = "summary", fun = "mean", vjust = -1, size = 5, color = "#4F6D7A") +
  scale_y_continuous(expand = c(.15,-10)) +
  labs(title = str_wrap(chart_title, 45),
       subtitle = "Arrests by Reason per 100,000 Residents",
       x = "Arrest Reason",
       y = "Average Arrests per 100k",
       caption = "Source: Default R dataset, 1978 US Arrest Statistics") +
  theme_minimal() +
  theme(
    plot.margin = margin(1,1,1,1, "cm"),
    panel.grid  = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.title.x = element_blank(),
    plot.title = element_text(size = 15, face = "bold"),
    plot.subtitle = element_text(size = 13),
    aspect.ratio= 4/4,
    axis.text.x = element_text(margin = margin(t = -15, r = 0, b = 0, l = 0), size = 12),
    plot.caption = element_text(hjust = 0, vjust = -10, color = "#AAAAAA")
  )



