# Predicting-Drug-Sensitivity-using-gene-expression-Data
This project focuses on predicting the sensitivity of cancer cell lines to Methotrexate using gene expression data. The goal is to develop robust predictive models that can aid in personalized treatment strategies by identifying which cell lines are likely to respond to Methotrexate based on their gene expression profiles.

This code is designed to predict the sensitivity of cancer cell lines to Methotrexate using gene expression data. The goal is to build and evaluate predictive models using various machine learning algorithms, including Generalized Linear Model (GLM), Support Vector Machine (SVM), and Multivariate Adaptive Regression Splines (MARS). The code uses the glmnet, caret, earth, and other related R packages to achieve these objectives.

Key Steps in the Code:
Loading Necessary Packages:

The code first checks if the required R packages (glmnet, ROSE, caret, earth, vip, pdp, kernlab, nnet, quantreg, and gridExtra) are installed. If not, it installs them and loads the libraries.
Data Loading:

The gene expression data (gdsc_rna_seq_names.csv) and the Methotrexate clinical data (methotrexate_gdsc_clinical_processed.csv) are loaded into R. The gene expression data is scaled, and only the relevant cell lines (those treated with Methotrexate) are selected for further analysis.
Data Preparation:

The Methotrexate RNA sequence data is prepared by extracting the relevant rows corresponding to the cell lines and adding the response variable (res_sens) that indicates the sensitivity or resistance of the cell lines to Methotrexate.
Building and Evaluating Models:

GLM Model:
A GLM (Elastic Net) model is built using cross-validation (cv.glmnet). It  predicts the sensitivity of cancer cell lines to Methotrexate using gene expression data. The code leverages several machine learning models, including Generalized Linear Models (GLM), Support Vector Machines (SVM), and Multivariate Adaptive Regression Splines (MARS). Here's a breakdown of what each part of the code does
GLM with Elastic Net Regularization (glmnet):
A GLM with elastic net regularization is trained using cross-validation to predict drug sensitivity. The model is saved, and its performance is visualized and evaluated using accuracy and confusion matrices.
Support Vector Machine (SVM):
An SVM model is trained using the svmLinear method from the caret package. The model is tuned, trained, and evaluated similarly to the GLM model.
Multivariate Adaptive Regression Splines (MARS):
A MARS model is trained to capture non-linear relationships in the data. The model is validated using cross-validation, and its performance is also evaluated using confusion matrices.
5. Saving Models and Results
The trained models (GLM, SVM, MARS) are saved as .rds files for future use.
Confusion matrices are generated to assess the performance of each model in predicting drug sensitivity.


****Learning Objectives
****Gene Expression Analysis: Understand how to preprocess and scale gene expression data for model training.
Machine Learning in Bioinformatics: Explore and apply various machine learning models, including GLM, SVM, and MARS, to predict drug sensitivity.
Model Evaluation: Learn how to evaluate the performance of predictive models using confusion matrices, accuracy, and cross-validation.
Data Imbalance Handling: Address class imbalance in biological datasets using techniques such as ROSE (Random Over-Sampling Examples).
Tools and Technologies
GLM with Elastic Net Regularization: Utilized for building robust predictive models that combine the properties of both ridge and lasso regression.
Support Vector Machines (SVM): Employed to classify cell lines based on their sensitivity to Methotrexate.
Multivariate Adaptive Regression Splines (MARS): Used to capture non-linear relationships in the data, offering an alternative to traditional linear models.
Data Preprocessing: Includes scaling of gene expression data and handling class imbalance.
Visualization and Evaluation: Confusion matrices, accuracy, and AUC (Area Under Curve) metrics are used to assess model performance.
Project Goals
Predictive Modeling: Develop and validate models that predict Methotrexate sensitivity based on gene expression data.
Feature Selection and Importance: Identify key gene expression features that contribute to drug sensitivity.
Personalized Medicine: Contribute to the development of personalized treatment strategies by providing insights into which cancer cell lines may respond favorably to Methotrexate.
Model Preservation: Save models for future use, allowing for further analysis or application to new datasets.
