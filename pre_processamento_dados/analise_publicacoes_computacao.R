library(jsonlite)
library(dplyr)
library(magrittr)
library(readr)


authors = read.csv("/home/lsp/dados/vis_lab1/authors.csv", header = T)
conferences = read.csv("/home/lsp/dados/vis_lab1/conferences.csv", header = T)
papers = read.csv("/home/lsp/dados/vis_lab1/papers.csv", header = T)
ethnicity = read.csv("/home/lsp/dados/vis_lab1/ethnicity.csv", header = T)

author_ethnicity = merge(authors, ethnicity, by="full_name")

author_ethnicity_paper = merge(author_ethnicity, papers, by="paper_key")

dataset = merge(author_ethnicity_paper, conferences, by="conf_key")

# Selecionando papers publicados depois de 2009
dataset = dataset %>% dplyr::select(conf_key, year, paper_key, full_name, et_0, 
                                    et_1, et_2, gender, position, publisher, 
                                    cs, de, se, th) %>% filter(year > 2009) 

# Verificando margem de valores dos dados
dataset %>% group_by(gender) %>% summarise(length(gender))
dataset %>% group_by(et_2) %>% summarise(length(et_2))
dataset %>% group_by(et_1) %>% summarise(length(et_1))
dataset %>% group_by(et_0) %>% summarise(length(et_0))

# Tratando valores não informados para o gênero
dataset = mutate(teste, gender = case_when(gender == '-' ~ "Não Informado", 
                                          gender == 'F' ~ "Feminino", 
                                          gender == 'M' ~ "Masculino"))

# Tratando valores não informados para o etnia 2
dataset = mutate(dataset, et_2 = ifelse(et_2 == "\\N", "Não Informado", as.character(et_2)))

# Verificando margem de valores dos dados após tratamento
dataset %>% group_by(gender) %>% summarise(length(gender))
dataset %>% group_by(et_2) %>% summarise(length(et_2))
dataset %>% group_by(et_1) %>% summarise(length(et_1))
dataset %>% group_by(et_0) %>% summarise(length(et_0))

teste = dataset

te = dataset %>% group_by(gender, publisher, year, et_1) %>% tally()

write.csv(te, file = "Projetos/Python/visualizacao-de-dados/dados/publisher_agregado.csv")

