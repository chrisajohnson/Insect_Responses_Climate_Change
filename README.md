# Insect_Responses_Climate_Change
This repository contains the data and scripts for the manuscript "Temperature sensitivity of fitness components across life cycles drives insect responses to climate change"

Folder Structure:
* Biological data: contains field census data from Benin and China and laboratory temperature response data
* Climate data: contains "Climate station data.xlsx" and climate data files for each site in the recent and future climates
* Documentation: contains ReadMe files for downloading Python and climate data as well as all scripts
* Model parameters: contains "Habitat temperature parameters.csv" and "Temperature response parameters.csv"
* Model predictions: contains data files of model predictions of climate change effects on fitness metrics/components and population dynamics
* Scripts: contains all scripts for running models and analyses, which are briefly described below
** DDE population dynamics.py: Python script for modeling insect population dynamics
** Download future climate data.py: Python script for accessing and downloading future climate data from the Copernicus Climate Data Store
** Fitness metrics and components.R: R script for plotting fitness metrics and components for conceptual Figure 1
** Habitat temperatures.R: R script for fitting temperature response parameters (Eq. 5), which are saved in "Habitat temperature parameters.csv" in the "Model parameters" folder
** Population analyses.R: R script for analyzing predicted population dynamics for Figure 5
** Read climate data.R: R script for reading downloaded climate data and producing the climate data files in "Climate data" folder
** Statistical analyses.R: R script for analyzing and plotting fitness metrics/components and population dynamics for Figures 3-5
** Temperature responses.R: R script for fitting parameters of fitness metricts/components (Eqs. 1,2), which are saved in "Temperature response parameters.csv" in the "Model parameters" folder
** Time series.R: R code for plotting predicted population dynamics for Figure 2
** TPC and model analyses.R: R script for analyzing fitness metrics/components directly from TPCs and from the population model for Figures 3,4
* Time series data: contains density-dependent time-series data predicted by population model (DDE population dynamics.py)
* Time series DI data: contains density-independent ("DI") time-series data predicted by population model (DDE population dynamics.py)

Setting up working directories and paths
Scripts in this repository produce and/or read data files that are saved within the folders of the repository. It is therefore important to download the entire repository with all files and folders having the same names, locations, and file extensions as in this repository. As long as the working directory in R or Python matches the main folder of the downloaded repository on the user's computer (i.e., the folder containing "Insect_responses_Climate_Change.rproj"), all paths _should_ work without any changes to the scripts. As noted in all of the ReadMe files, however, it may be necessary to explicitly specify the paths on the user's computer as detailed in the ReadMe files. 

Using the scripts:
Each script does a specific task as detailed in its ReadMe. It is not necessary to run all scripts to see model predictions and results reported in the manuscript. To produce the analyses and plots reported in Figures 3-5, for example, it is only necessary to run "Statistical analyses.R". To produce the conceputal conceptual Figure 1, run "Fitness metrics and components.R" and to produce the time-series plots in Figure 2, run "Time series.R". To run all scripts used in the manuscript, see the order of the ReadMe files in the "Documentation" folder. To fully reproduce all analyses, in general, one must: (1) install Python in order to access future climate data and run DDE population models (see ReadME1 Install Python); (2) download recent climate data (see "ReadMe2 Download recent climate data") and (3) run "Download future climate data.py" to obtain the recent and future climate data; (4) run "Read climate data.R" to produce climate files for subequent analyses; (5) run "Habitat temperatures.R" to estimate habitat temperature parameters; (6) run "Temperature responses.R" to estimate temperature response parameters; (7) run "DDE population dynamics.py" to simulate four cases with two factors - recent climate (recent = True) and future climate (recent = false) and with competition (competition = True) and without competition (competition = False); (8) run "Fitness metrics and components.R" to produce Figure 1; (9) run "Time series.R" to produce Figure 2; (10) run "TPC and model analyses.R" to quantify climate change effects on fitness metrics/components; (11) run "Population dynamics analyses.R" to quantify climate change effects on population dynamics; (12) run "Statistical analyses.R" to analyze results and produce Figures 3-5.
