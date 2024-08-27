# Load necessary packages
if (!require('glmnet')) install.packages('glmnet')
library(glmnet) # for model building
if (!require('ROSE')) install.packages('ROSE')
library(ROSE)
if (!require('caret')) install.packages('caret')
library(caret)
if (!require('vip')) install.packages('vip')
library(vip)
if (!require('pdp')) install.packages('pdp')
library(pdp)

# Load clinical data for methotrexate
methotrexate <- read.csv('Processed_Clinical_Data/methotrexate_gdsc_clinical_processed.csv', row.names = 1)

# Load gene expression data
gdsc <- read.csv('gdsc_rna_seq_names.csv', stringsAsFactors = FALSE, header = TRUE, row.names = 1)
gdsc <- apply(gdsc, 2, scale)

# Set up data for model building
methotrexate_lines <- methotrexate$COSMIC_ID

# Split indices for methotrexate
set.seed(5)
methotrexate_train_index <- createDataPartition(methotrexate$Cell_line_tissue_type, p = .8, list = FALSE, times = 1)

# Split clinical data for methotrexate
methotrexate_train <- methotrexate[methotrexate_train_index, ]
methotrexate_test <- methotrexate[-methotrexate_train_index, ]

# Split expression data to match methotrexate
methotrexate_rna_seq <- gdsc[rownames(gdsc) %in% methotrexate$COSMIC_ID, ]
methotrexate_rna_seq <- as.data.frame(methotrexate_rna_seq)
methotrexate_rna_seq$res_sens <- methotrexate$res_sens

# Apply ROSE to methotrexate data
methotrexate_rose <- ROSE(res_sens ~ ., data = methotrexate_rna_seq)$data

# Save the processed data
write.csv(methotrexate_rose, file = 'Processed_Gene_Expression/methotrexate_rose_full.csv', row.names = TRUE)
