## THIS SCRIPT HANDLES AND PROCESSES CLINICAL DATA FOR METHOTREXATE

### load necessary packages ----
if (!require('openxlsx')) install.packages('openxlsx')
library(openxlsx) # to read in excel files
if (!require('dplyr')) install.packages('dplyr')
library(dplyr) # to form some of the files

### functions needed ----
# function to read in GDSC clinical data
read_gdsc_clinical <- function(sheet_number) {
  drug_data <- read.xlsx(gdsc_files, sheet_number)
  return(drug_data[, c(3:6, 12)])
}

# function to read in CCLE clinical data
read_ccle_clinical <- function(sheet_number) {
  drug_data <- read.xlsx(ccle_files, sheet_number)
  drug_data <- drug_data[, c(4:6)]
  drug_data_new <- drug_data %>% group_by(Cell.line.name) %>% summarise(AUC = mean(area_under_curve))
  drug_data <- merge(drug_data, drug_data_new, by = 'Cell.line.name')
  drug_data <- drug_data[, -3]
  return(unique(drug_data))
}

# function to read in TCGA clinical data
read_tcga_clinical <- function(tcga_file_number) {
  tcga_phenos <- read.delim(tcga_files[tcga_file_number], sep = '\t', stringsAsFactors = FALSE, header = TRUE)
  tcga_phenos_short <- tcga_phenos[, c('submitter_id.samples', 'days_to_new_tumor_event_after_initial_treatment', 'drug_name', 'lost_follow_up', 
                                       'days_to_death.diagnoses', 'days_to_last_follow_up.diagnoses', 'vital_status.diagnoses')]
  tcga_phenos_not_lost <- tcga_phenos_short[tcga_phenos_short$lost_follow_up != 'YES', ]
  tcga_phenos_w_drug <- tcga_phenos_not_lost[tcga_phenos_not_lost$drug_name != '', ]
  tcga_phenos_w_drug$OS <- ifelse(tcga_phenos_w_drug$vital_status.diagnoses == 'dead', tcga_phenos_w_drug[, 5], tcga_phenos_w_drug[, 6])
  tcga_phenos_w_drug$PFS <- ifelse(is.na(tcga_phenos_w_drug[, 2]), tcga_phenos_w_drug$OS, tcga_phenos_w_drug[, 2])
  return(tcga_phenos_w_drug)
}

# function for dummy variables in GDSC data
sens_res <- function(drug_data, ic50) {
  ifelse(drug_data$LN_IC50 > ic50, 1, 0) # 1 is resistant, 0 sensitive
}

# functions for dummy variables in TCGA data
# most sensitive
most_sens_bin_tcga <- function(drug_data) {
  ifelse(drug_data$PFS < quantile(drug_data$PFS, probs = 0.20, na.rm = TRUE), 1, 0)
}
# least sensitive
least_sens_bin_tcga <- function(drug_data) {
  ifelse(drug_data$PFS > quantile(drug_data$PFS, probs = 0.80, na.rm = TRUE), 1, 0)
}

### import data -----
# GDSC (ln(IC50))
gdsc_files <- 'Clinical_Files/v17_fitted_dose_response_noblood_breakdown_DNAdamageagents.xlsx'

# bring in clinical data for methotrexate
methotrexate <- read_gdsc_clinical(9)

### create dummy binary variables for methotrexate -------
methotrexate$res_sens <- sens_res(methotrexate, -2.4743)
table(methotrexate$res_sens) # Display counts of resistant and sensitive cases

### write to file for later ----
# GDSC
write.csv(methotrexate, file = 'Processed_Clinical_Data/methotrexate_gdsc_clinical_processed.csv')

# CCLE - methotrexate data
ccle_files <- 'Clinical_Files/Drug sensitivity data - cytotoxics only - no heme.xlsx'
methotrexate_ccle <- read_ccle_clinical(15) # Assuming the sheet number for methotrexate is 15
write.csv(methotrexate_ccle, file = 'Processed_Clinical_Data/methotrexate_ccle_clinical_processed.csv')
