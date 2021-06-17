# install.packages("minval")
library(minval)
library(dplyr)
setwd("C:/Users/da.salazarb/Google Drive/Tutorial_2018-10/07_ResearchArticles/Research_article_IV/")
ng_model <- readxl::read_xls("Neuron-Glia_GEM.xls",sheet = 1)
ng_model <- ng_model %>% 
  # dplyr::select(Rxn_name, Formula,gene_reaction_association, LB, UB, Objective) %>% 
  dplyr::rename(ID=Rxn_name, REACTION=Formula,GPR=gene_reaction_association, LOWER.BOUND=LB, UPPER.BOUND=UB, OBJECTIVE=Objective)

ng_model <- as.data.frame(ng_model)

minval::writeSBMLmod(ng_model, modelID = "Neuron_Glia_GEM",outputFile = "Neuron_Glia_GEM.xml")
warnings()