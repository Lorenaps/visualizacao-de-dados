library(readr)
library(dplyr)

domicilio = read_csv2("/home/lorenasantos/Downloads/BA/Base informaçoes setores2010 universo BA/CSV/Domicilio01_BA.csv",
                      locale = locale(encoding = "latin1")) 

basico = read_csv2("/home/lorenasantos/Downloads/BA/Base informaçoes setores2010 universo BA/CSV/Basico_BA.csv",
                      locale = locale(encoding = "latin1")) 

join_csv = merge(basico, domicilio, by="Cod_setor")
  
dados_salvador = join_csv %>% filter(Nome_do_municipio == "SALVADOR")

dados_salvador %>% write_csv("dados-salvador-join-utf8.csv")
