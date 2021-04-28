### ------------------------------------------- ###
###         Stylo and DataViz Scripts           ###
### ------------------------------------------- ###

# Stylo documentation  console> ?stylo
# Stylo documentation online <https://www.rdocumentation.org/packages/stylo/versions/0.7.4>


library(stylo)

# Stylo with UI----

# setwd("~/stylo"). Set working directory to the folder with the corpus
# stylo()

# Stylo without UI---- 
wynik = stylo(gui = F, corpus.dir = "corpus", 
                  mfw.min = 1500, 
                  mfw.max = 1500,
                  # mfw.incr = 500, 
                  analysis.type = "CA",
                  # analysis.type = "BCT",
                  corpus.lang = "Spanish",
                  # distance.measure="wurzburg",
                  distance.measure="delta",
                  display.on.screen = T,
                  dendrogram.layout.horizontal = T
)

# distance.table
distances <- as.data.frame(t(wynik$distance.table))

all_freqs <- as.data.frame(t(wynik$table.with.all.freqs))

# Plot a matrix of distances

library(tidyverse)

distances %>% 
  as.data.frame() %>%
  rownames_to_column("f_id") %>%
  pivot_longer(-c(f_id), names_to = "works", values_to = "scores") %>%
  na.omit() %>%
  filter(scores > 0.01) %>%
  ggplot(aes(x=works, y=f_id, fill=scores)) + 
  geom_tile() +
  scale_fill_gradient(low="red", high="grey90") +
  theme(axis.text.x = element_text(angle = 80, hjust = 1), 
        legend.position="none"
        # panel.background = element_blank()
  )

# Plot a the distances of one work with respect to the rest

df = select(distances, calderon_ElPrincipeConstante_C6010_CANON) %>%
  rownames_to_column(., var = "works")

df = df[df[,2] != 0, ]  # Remove from the table the work to be compared.

ggplot(df) +
  aes(reorder(works, df[,2]), df[,2], group = 1) +
  # geom_col() +
  geom_line(colour="gray", size=1) + 
  geom_point(size=3) + 
  labs(x = "", y = "", title = "distance.table") +
  theme(axis.text.x = element_text(angle = 80, hjust = 1), 
        legend.position="none"
        # panel.background = element_blank()
  )

# Data as a graph----

edgelist_stylo = read.csv("stylo_CA_1500_MFWs_Culled_0__Classic Delta_EDGES.csv")

library(igraph)

graph <- graph.data.frame(edgelist_stylo, directed = F)

plot(graph, 
     vertex.label = substr(V(graph)$name,1,15),
     edge.width =  E(graph)$Weight,
     edge.curved=0
     )