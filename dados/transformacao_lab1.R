library(jsonlite)
library(RJSONIO)
library(dplyr)
library(magrittr)
library(readr)



authors = read.csv("/home/lsp/Projetos/dados/vis_lab1/authors.csv", header = T)
conferences = read.csv("/home/lsp/Projetos/dados/vis_lab1/conferences.csv", header = T)
papers = read.csv("/home/lsp/Projetos/dados/vis_lab1/papers.csv", header = T)
ethnicity = read.csv("/home/lsp/Projetos/dados/vis_lab1/ethnicity.csv", header = T)

author_ethnicity = merge(authors, ethnicity, by="full_name")

author_ethnicity_paper = merge(author_ethnicity, papers, by="paper_key")

dataset = merge(author_ethnicity_paper, conferences, by="conf_key")

dataset = dataset %>% dplyr::select(conf_key, year, paper_key, full_name, et_0, 
                                    et_1, et_2, gender, position, publisher, 
                                    cs, de, se, th) %>% filter(year > 2015)

write.csv(dataset, file = "/home/lsp/Projetos/dados/vis_lab1/dataset_2015.csv")
