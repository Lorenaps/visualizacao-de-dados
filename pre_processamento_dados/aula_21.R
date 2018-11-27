library(readr)
library(dplyr)

read_csv2("/home/lorenasp/Downloads/BA_20171016/BA/Base informaçoes setores2010 universo BA/CSV/Domicilio01_BA.csv",
          locale = locale(encoding = "latin1")) %>% filter(Nome_do_municipio == "SALVADOR") %>% write_csv("dados-salvador-domicilio-utf8.csv")
