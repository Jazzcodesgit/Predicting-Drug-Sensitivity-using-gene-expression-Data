### load necessary packages ----
if (!require ('glmnet')) install.packages('glmnet')
library(glmnet) #for handling glm models already built

if (!require ('flextable')) install.packages('flextable')
library(flextable) #for nice tables


## METHOTREXATE -----
### load models ----
methotrexate_most_fit_elnet   <- readRDS('GLM_Models/methotrexate_most_model.rds')
methotrexate_least_fit_elnet  <- readRDS('GLM_Models/methotrexate_least_model.rds')

### capture genes used in models ----
## METHOTREXATE MOST SENSITIVE
methotrexate_most_min_tmp_coefs <- coef(methotrexate_most_fit_elnet, s = 'lambda.min')
methotrexate_most_model_min <- data.frame(name = methotrexate_most_min_tmp_coefs@Dimnames[[1]][methotrexate_most_min_tmp_coefs@i + 1], coefficient = methotrexate_most_min_tmp_coefs@x)
write.csv(methotrexate_most_model_min, file = 'GLM_Models/methotrexate_most_model_min.csv', row.names = FALSE)

methotrexate_most_1se_tmp_coefs <- coef(methotrexate_most_fit_elnet, s = 'lambda.1se')
methotrexate_most_model_1se <- data.frame(name = methotrexate_most_1se_tmp_coefs@Dimnames[[1]][methotrexate_most_1se_tmp_coefs@i + 1], coefficient = methotrexate_most_1se_tmp_coefs@x)
write.csv(methotrexate_most_model_1se, file = 'GLM_Models/methotrexate_most_model_1se.csv', row.names = FALSE)

## METHOTREXATE LEAST SENSITIVE
methotrexate_least_min_tmp_coefs <- coef(methotrexate_least_fit_elnet, s = 'lambda.min')
methotrexate_least_model_min <- data.frame(name = methotrexate_least_min_tmp_coefs@Dimnames[[1]][methotrexate_least_min_tmp_coefs@i + 1], coefficient = methotrexate_least_min_tmp_coefs@x)
write.csv(methotrexate_least_model_min, file = 'GLM_Models/methotrexate_least_model_min.csv', row.names = FALSE)

methotrexate_least_1se_tmp_coefs <- coef(methotrexate_least_fit_elnet, s = 'lambda.1se')
methotrexate_least_model_1se <- data.frame(name = methotrexate_least_1se_tmp_coefs@Dimnames[[1]][methotrexate_least_1se_tmp_coefs@i + 1], coefficient = methotrexate_least_1se_tmp_coefs@x)
write.csv(methotrexate_least_model_1se, file = 'GLM_Models/methotrexate_least_model_1se.csv', row.names = FALSE)

### Extract and compare gene lists ----
methotrexate_most_min_genes <- as.character(methotrexate_most_model_min$name[-1])
methotrexate_most_1se_genes <- as.character(methotrexate_most_model_1se$name[-1])

methotrexate_least_min_genes <- as.character(methotrexate_least_model_min$name[-1])
methotrexate_least_1se_genes <- as.character(methotrexate_least_model_1se$name[-1])

# Combine unique genes from Methotrexate models
methotrexate_genes <- unique(c(methotrexate_most_min_genes, methotrexate_least_1se_genes)) # Unique genes

### Convert gene names (assuming conversion was done previously) ----
methotrexate_gene_names <- read.csv('methotrexate_gene_names.csv', stringsAsFactors = FALSE, header = TRUE)
methotrexate_gene_names <- methotrexate_gene_names$name

### Table creation ----
gene_table <- data.frame(Methotrexate_Genes = methotrexate_gene_names)
ft <- flextable(gene_table, cheight = 0.01)
ft

