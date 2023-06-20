# Insect_Responses_Climate_Change
This repository contains the data and scripts for the manuscript "Temperature sensitivity of fitness components across life cycles drives insect responses to climate change"

Folder Structure:
* Biological data: contains field census data from Benin and China and laboratory temperature response data
* Climate data: contains "Climate station data.xlsx" and climate data files for each site in the recent and future climates
* Documentation: contains ReadMe files for downloading Python and climate data as well as running all scripts in "Scripts" folder
* Model parameters: contains "Habitat temperature parameters.csv" and "Temperature response parameters.csv"
* Model predictions: contains model prediction files of climate change effects on fitness metrics/components and population dynamics
* Scripts: contains all scripts for running models and analyses, which are briefly described below:
  * DDE population dynamics.py: Python script for simulating insect population dynamics
  * Download future climate data.py: Python script for accessing and downloading future climate data
  * Fitness metrics and components.R: R script for plotting fitness metrics and components for conceptual Figure 1
  * Habitat temperatures.R: R script for fitting habitat temperature parameters (saved in "Model parameters" folder)
  * Population analyses.R: R script for quantifying climate change effects on population dynamics
  * Read climate data.R: R script for reading downloaded climate data and producing the climate data files in "Climate data" folder
  * Statistical analyses.R: R script for analyzing and plotting fitness metrics/components and population dynamics for Figures 3-5
  * Temperature responses.R: R script for fitting temperature response parameters (saved in "Model parameters" folder)
  * Time series.R: R code for plotting predicted population dynamics for case studies in Figure 2
  * TPC and model analyses.R: R script for quantifying climate change effects on fitness metrics/components
* Time series data: contains density-dependent time-series data predicted by the population model
* Time series DI data: contains density-independent ("DI") time-series data predicted by population model

## Setting up working directories and paths
Scripts in this repository produce and/or read data files that are saved within the folders of the repository. It is therefore important to download the entire repository with all files and folders having the same names, locations, and file extensions as in this repository. As long as the working directory in R or Python matches the main folder of the downloaded repository on the user's computer (i.e., the folder containing "Insect_responses_Climate_Change.rproj"), all paths _should_ work without any changes to the scripts; however, it may be necessary to explicitly specify the paths on the user's computer as detailed in the script's ReadMe file below or in the "Documentation" folder. 

## Using the scripts:
Each script does a specific task as detailed in its ReadMe below or in the "Documentation" folder. It is not necessary to run all scripts to see the results reported in the manuscript. To produce the conceptual Figure 1, run "Fitness metrics and components.R". To produce the time-series plots in Figure 2, run "Time series.R". To produce the plots reported in Figures 3-5, run "Statistical analyses.R".

To run all scripts used in the manuscript in the correct order, please see the order of the ReadMe files in the "Documentation" folder. In general, this involves the following steps:
1. Install Python in order to access future climate data and run DDE population models (see "ReadME1 Install Python")
2. Download recent climate data (see "ReadMe2 Download recent climate data")
3. Run "Download future climate data.py" to download the recent and future climate data
4. Run "Read climate data.R" to produce climate files in "climate data" folder
5. Run "Habitat temperatures.R" to estimate habitat temperature parameters
6. Run "Temperature responses.R" to estimate temperature response parameters
7. Run "DDE population dynamics.py" to simulate the model for four cases involving two factors: recent climate (recent = True) and future climate (recent = false) as well as with competition (competition = True) and without competition (competition = False)
8. Run "Fitness metrics and components.R" to produce the conceptual Figure 1
9. Run "Time series.R" to produce Figure 2
10. Run "TPC and model analyses.R" to quantify climate change effects on fitness metrics/components
11. Run "Population dynamics analyses.R" to quantify climate change effects on population dynamics
12. Run "Statistical analyses.R" to analyze model predictions and produce Figures 3-5

## Software and package versions:
* R (v. 4.1.2)
* Python (v. 3.8.8)
* tidyverse R package (v. 2.0.0)
* lubridate R package (v. 1.9.2)
* ncdf4 R package (v. 1.19)
* ggplot2 R package (v. 3.4.1)
* cowplot R package (v. 1.1.1)
* stringr R package (v. 1.5.0)
* cubature R package (v. 2.0.4.5)
* jitcdde Python package (v. 1.8.1)
* jitcxde_common Python package (v. 1.5.4)
* cdsapi Python package (v. 0.5.1)
* netcdf4 Python package (v. 1.6.2)
* numpi Python package (v. 1.21.5)
* pandas Python package (v. 1.4.4)
* symengine Python package (v. 0.9.2)
* matplotlib Python package (v. 3.5.2)

## Script ReadME files (see "Documentation" folder for more information):
**1. ReadMe Install Python**
The following ReadMe provides a brief overview of how to install and run Python in the context of this project. This ReadMe is certainly not exhaustive and there are many far better sources of information on installing and running Python. This is also far from the only way to set up Python, it is just what worked for me and what I found useful. This ReadMe is meant only to provide a basic set of instructions for installing Python for anyone who is interested in running the population model (DDE population dynamics.py). I run Python using Spyder (v. 5.0.2). Because standalone Spyder installers do not yet support installing third-party Spyder plugins not already bundled with them, I use Anaconda (v. 4.10.1) to install and run Spyder.

Installing Anaconda, Spyder, and Python
1.	Download Anaconda: https://www.anaconda.com/products/distribution (for more help see: https://towardsdatascience.com/how-to-successfully-install-anaconda-on-a-mac-and-actually-get-it-to-work-53ce18025f97)
2.	Update Python
a.	Go to terminal
b.	Check Python version: conda list python
c.	Update Python: conda update python
3.	Open Anaconda-Navigator in Launchpad
4.	Click on Launch in Spyder box on Anaconda

Downloading “cdsapi” Python module for accessing climate data from the KNMI Climate Explorer (climexp.knmi.nl). Detailed instructions from KNMI can also be found here: https://confluence.ecmwf.int/display/CKB/How+to+install+and+use+CDS+API+on+macOS
1.	Login to CDS
2.	Go to https://cds.climate.copernicus.eu/api-how-to and copy the 2 line code displayed in the black box in the "Install the CDS API key" section
3.	Create your key file in your home directory in your Terminal window: touch ~/.cdsapirc 
4.	Edit your key file and paste the two lines you copied in Step 2 above to your .cdsapirc key file
5.	Install the CDS API client by running the following command in your Terminal window: pip install cdsapi

**2. ReadMe Download Recent Climate Data**
The following ReadMe provides a brief overview of how to download recent climate data from the KNMI Climate Explorer (http://climexp.knmi.nl). Note that the script was written to read the maximum and minimum daily temperatures and then take the mean in “Read climate data.R”. It is also possible to download average daily temperatures and modify the script in “Read climate data.R”.
1.	Navigate web browser to: http://climexp.knmi.nl/selectdailyseries.cgi?id=someone@somewhere 
2.	Under GHCN-D, click “minimum temperature”
3.	Enter latitude and longitude under the second bullet point of the “Select” section that starts with “10 stations near” (these can come from “Climate station data.xlsx” for insects in the manuscript or “/Extensions/Insect database.xlxs” for other insects or can be added for new populations)
4.	Under “Time, distance” section, click “Get stations”
5.	Select climate station (the following criteria were used in the manuscript):
a.	Select the climate station with the closest latitude (1st priority) and longitude (2nd priority) to those entered in step 3 (generally, this is the top result and is the station used in the analyses)
b.	Scan the other climate stations and select any stations with more than 15 years of data or more than 5 years of more recent data than the station in step 5a and then calculate the difference in latitude and longitude between these stations and those of the insect population
c.	The CMIP6 climate model has a resolution of 1° latitude and 1.5° longitude, so if a station in step 5b is <1° latitude and <1.5° longitude from those of the insect population, then select that station; otherwise, select the station in step 5a
d.	Click “get data” under the selected climate station
e.	Under “Time series”, view the top graph plotting temperature [Celsius] versus year. If there are significant time gaps (>5 years) between the data, then view the graphs for any stations from step 5b and select the station with the fewest gaps in the record
6.	If desired, click “raw data” for the selected station, open “Climate station data.xlsx”, and add a new row with the station name (“Name”), its latitude (“Lat”) and longitude (“Lon”), elevation (“Elev”), station code (“Code”), WMO code (“WMO”), start date (“Start_yr”, “Start_mo”, and “Start_day”) and end date (“End_yr”, “End_mo”, and “End_day”)
7.	Return to the webpage in step 5, and click on “netcdf” and then “Download netcdf file”
8.	Rename the file “Recent Tmin <location>.nc” and move the file to the “Climate data” folder of the downloaded GitHub repo
9.	Repeat steps 1-8 for the maximum temperature using the same climate station from step 5 for the minimum temperature. In “raw data” (step 6), confirm that the start date for the maximum temperature is after the start date from the minimum temperature; if not, use this start date in “Climate station data.xlxs”. Rename this netcdf file: “Recent Tmax <location>.nc”
10.	Confirm that there are two files (“Recent Tmin <location>.nc” and “Recent Tmax <location>.nc”) in the “Climate data” folder of the downloaded GitHub repo

**3. ReadMe for “Read future climate data.py”**
The following ReadMe provides a brief overview of how to use “Read future climate data.py”. I first outline how to download the required cdsapi Python module that allows climate data to be downloaded from the Copernicus Climate Data Store. I then give the minimum instructions to allow a user to run the Python script to read future climate data for any location in “Climate station data.xlsx” or for any new location, with small modifications to the script. Please note that running this script is not strictly necessary for the populations analyzed in the manuscript as all climate data already exists in the “Climate data” folder.
We obtained CMIP6 climate model projections (O’Neill et al. 2016) of daily maximum and minima near-surface air temperatures for the years 2025-2100 using the Copernicus Climate Data Store (cds.climate.copernicus.eu), under the CMIP6 licensing agreement. We used the Shared Socioeconomic Pathway experiments SSP3-7.0 scenario and used the CESM2 model from the National Center for Atmospheric Research (Danabasoglu 2019).

Downloading cdsapi module for accessing climate data from the Copernicus Climate Data Store
(See: https://confluence.ecmwf.int/display/CKB/How+to+install+and+use+CDS+API+on+macOS)
1.	Login to CDS
2.	Go to https://cds.climate.copernicus.eu/api-how-to and copy the 2 line code displayed in the black box in the "Install the CDS API key" section
3.	Create your key file in your home directory in your Terminal window: touch ~/.cdsapirc 
4.	Edit your key file and paste the two lines you copied in Step 2 above to your .cdsapirc key file
5.	Install the CDS API client in your Terminal window: pip3 install cdsapi

Read future climate data.py
Input: User-defined latitude, longitude, location for climate data (from “Climate station data.xlsx” or new location)
Output: CSV files for daily maximum and minimum near-surface air temperatures (“Future Tmax <location>.csv” and “Future Tmin <location>.csv”)

To run:
1.	Download cdsapi module (see above)
2.	Login to CDS
3.	In “Read future climate data.py”, set path to “Climate data” folder of downloaded GitHub repo (line 20)
4.	Update variables lat, lon, and loc (lines 23-25) with the latitude, longitude, and location from “Climate station data.xlsx” (NOTE: use the “Latitude” column for the latitude of the insect population as in the manuscript or the “Lat” column for the latitude of the historical climate station)
5.	Run the script (by pressing the green right-arrow in Spyder)

Potential issues:

•	If console yields “WARNING Recovering from HTTP error [500 Internal Server Error]”, then try refreshing browser or logging into https://cds.climate.copernicus.eu/#!/home

•	Remember to specify the full path to the appropriate folder on line 20

•	The variables lat and lon are required to delineate the region of the world over which the climate data is extracted, while loc is simply for naming the assembled CSV files (be careful with spelling, however, because these files are used by other scripts)

**4. ReadMe for “Read climate data.R”**
The following ReadMe gives a brief overview of how to use “Read climate data.R”. Please first consult “ReadME download recent climate data.docx” and “ReadME download recent climate data.docx” and confirm that “Recent Tmax <location>.nc”, “Recent Tmin <location>.nc”, “Future Tmax <location>.nc”, “Future Tmin <location>.nc” exist in the “Climate data” folder. Please note that running this script is not strictly necessary for the populations in the manuscript as all climate data already exists in the “Climate data” folder.

Input: User-defined location for climate data (from “Climate station data.xlsx”)
Output: CSV files of recent and future climates, starting with the first day for which there is climate data in “Recent climate data <location>.csv” and day 0 (Jan 1, 2025; see “time” column) in “Future climate data <location>.csv”.

To run: 
1.	Update variable location (line 17) with the location name from “Climate station data.xlsx”
2.	To save climate files (over any existing files), change “save” from FALSE to TRUE in line 20
3.	To remove climate netCDF data files, change “remove” from FALSE to TRUE in line 23
4.	Run the script

Potential issues:

•	The script only works if the working directory (see line 11) is in the main folder of the downloaded GitHub repo

•	The variable loc (line 17) must exist within “Climate station data.xlsx” and match the “Location” column exactly

•	The NC files for recent and future climates must have been previously downloaded and exist within “Climate data” folder of the downloaded GitHub repo (see “ReadMe download recent climate data.docx” and “ReadMe Python download future climate data.docx”)

**5. ReadMe for “Habitat temperature parameters.R”**
The following ReadMe gives a brief overview of how to use “Habitat temperature parameters.R”. Please note that running this script is not strictly necessary for the populations in the manuscript as all habitat temperature parameters already exist in “Habitat temperature parameters.csv” in the “Model Parameters” folder. Also, please note that the nonlinear least squares regression function nls in R must be given a ‘start’ list of rough parameter estimates. To do this efficiently, this script uses the parameter estimates in “Habitat temperature parameters.csv” in the ‘start’ list of nls, which is a circular method for parameter estimation. All parameters, however, were initially estimated by providing rough estimates in the ‘start’ list of nls, and can thus be estimated a priori by ‘seeding’ each parameter column in “Habitat temperature parameters.csv” with a rough estimate of each parameter.

Input: User-defined location for climate data or all = TRUE
Output: Updated “Habitat temperature parameters.csv” file (if save = TRUE) or print out (if save = FALSE) with the habitat temperature parameters for either a specified population (if all = FALSE) or all populations (if all = FALSE)

To run: 
1.	Update variable location (line 12) with location name from “Habitat temperature parameters.csv” (if a new population is added, please add relevant information to a new line in “Habitat temperature parameters.csv” and then ‘seed’ the parameter columns by adding a rough estimate of each parameter (used for the “start” list in nls in order to estimate parameters via nonlinear regression). Set all = TRUE if the script is to be run for all locations in “Habitat temperature parameters.csv”  or set all = FALSE if the script is to be run just for the specified location.
2.	To save parameter fits (over existing values in “Habitat temperature parameters.csv”), change save from FALSE to TRUE in line 16
3.	Run the script

Potential issues:

•	The script only works if the working directory (see line 9) is in the main folder of the downloaded GitHub repo

•	The variable location (line 12) must exist within “Habitat temperature parameters.csv” and match the “Location” column exactly

•	Some modifications to the “start” list in nls (lines 63, 66) may be needed for new populations not in “Habitat temperature parameters.csv”

**6. ReadMe for “Temperature response parameters.R”**
The following ReadMe gives a brief overview of how to use “Temperature response parameters.R”. Please note that running this script is not strictly necessary for the populations in the manuscript as all temperature response parameters already exist in “Temperature response parameters.csv” in the “Model Parameters” folder. Also, please note that the nonlinear least squares regression function nls in R must be given a ‘start’ list of rough parameter estimates. To do this efficiently, this script uses the parameter estimates in “Temperature response parameters.csv” in the ‘start’ list of nls, which is a circular method for parameter estimation. All parameters, however, were initially estimated by providing rough estimates in the ‘start’ list of nls, and can thus be estimated a priori by ‘seeding’ each parameter column in “Temperature response parameters.csv” with a rough estimate of each parameter.

Input: User-defined species name and location for an insect population or all = TRUE
Output: Updated “Temperature response parameters.csv” file (if save = TRUE) and print out of the temperature response parameters for either a specified population (if all = FALSE) or all populations (if all = FALSE)

To run: 
1.	Update variable species (line 13) and location (line 14) with a species name and location from “Temperature response parameters.csv”. If a new population is added to “Temperature response parameters.csv”, then parameters must be ‘seeded’ by adding a rough estimate to each parameter column (this is used in the ‘start’ list of nls to estimate parameters via nonlinear regression). Set all = TRUE (line 15) if the script is to be run for all populations in “Temperature response parameters.csv” or set all = FALSE if the script is to be run just for the specified population. 
2.	To save parameter fits (over existing values in “Temperature response parameters.csv”), change save from FALSE to TRUE in line 18
3.	Run the script

Potential issues:

•	The script only works if the working directory (see line 10) is in the main folder of the downloaded GitHub repo

•	The variable species (line 13) and location (line 14) must exist within “Temperature response parameters.csv” and match the “Population” and “Location” columns exactly

•	Some modifications to the “start” list of the various nls functions throughout the script may be needed for new populations not in “Temperature response parameters.csv”

•	If script yields Error: “singular gradient matrix at initial parameter estimates”, it may be that a parameter value is 0 in “Temperature response parameters.csv”. In this case, ‘seed’ the parameter with a small non-zero number and try to run the script again.

**7. ReadMe for “DDE population dynamics.py”**
The following ReadMe gives a brief overview of how to use “DDE population dynamics.py”. Please note that running this script is not strictly necessary for the populations in the manuscript as all population dynamics data already exist in the “Time series data” and “Time series data DI” folders. 

Input: User-defined species name and location for a population (or all = True)
Output: Updated CSV files containing population dynamics data (if save = True)

To run: 
1.	Update variable species (line 36) and location (line 37) with a species name and location from “Temperature response parameters.csv”. Set all = True in line 38 if the script is to be run for all populations or set all = False if the script is to be run just for the specified population.
2.	Set recent = True for the recent time period or recent = False for the future time period in line 41. 
3.	To save population dynamics (over existing files), change save from False to True in line 48.
4.	To include competition in the model, set competition to True in line 51. (Note that if competition = False, the script will model density-independent population dynamics, which will then be saved in the “Time series data DI” folder (if save = True).
5.	To run models for validation with field census data, set census to True in line 54 (note that field census data was found only for Clavigralla shadabi and Apolygus lucorum). 
6.	Set or confirm the paths to “Temperature response parameters.csv” and “Habitat temperature parameters.csv” in lines 58 and 59.
7.	Run the script by pressing the green ‘play’ button.

Potential issues:

•	Several error messages and potential solutions are listed in lines 4-13

•	The variable species (line 36) and location (line 37) must exist within “Temperature response parameters.csv” and match the “Population” and “Location” columns exactly

•	The script downloads the ‘jitcdde’ package from GitHub (https://github.com/neurophysik/jitcdde) if it is not installed. It may, however, be necessary to download and install the package directly.

•	The script only works if the working directory (line 32) is in the main folder of the GitHub repo

**8. ReadMe for “Fitness metrics and components.R”**
The following ReadMe gives a brief overview of how to use “Fitness metrics and components.R” to produce the temperature response panels in Figure 1 of the manuscript.

Input: User-defined response for a fitness metric or fitness component
Output: Plots of temperature responses as in Figure 1 of the manuscript.

To run: 
1.	Select the fitness metric or fitness component by removing the “#” in front of the desired response (making sure that there is a "#" in front of all other responses)
2.	Run the script

Potential issues:

•	The script only works if the working directory (see line 9) is in the main folder of the downloaded GitHub repo

**9. ReadMe for “Time series.R”**
The following ReadMe gives a brief overview of how to use “Time series.R” to plot the population dynamics predicted by the DDE model as well as produce the panels in Figure 2 of the manuscript.

Input: User-defined species name and location for an insect population
Output: Plots of habitat temperature in the recent and future climates, predicted adult density and field census data (if desired, for Clavigralla shadabi or Apolygus lucorum), and juvenile and adult densities in the recent and future climates.

To run: 
1.	Update variable species (line 19) and location (line 20) with a species name and location from “Temperature response parameters.csv”.
2.	To plot model population dynamics with field census data, set census to TRUE in line 23
3.	To change plotting parameters (such as x- and y- axes values), change values in lines 53-58
4.	Run the script

Potential issues:

•	The script only works if the working directory (see line 10) is in the main folder of the downloaded GitHub repo

•	The variable species (line 19) and location (line 20) must exist within “Temperature response parameters.csv” and match the “Population” and “Location” columns exactly

•	If elapsed time limit error occurs or lines are missing from the plots, try clearing the global environment and then running the script again (see line 15).

**10. ReadMe for “TPC and model analyses.R”**
This ReadMe gives a brief overview of how to use “TPC and model analyses.R”. Please note that running this script is not strictly necessary for the populations in the manuscript as all model predictions already exist in the “Model predictions” folder.

Input: User-defined species name and location for an insect population or all = TRUE
Output: Updated CSV files in the “Model predictions” folder (if save = TRUE) for either a specified population (if all = FALSE) or all populations (if all = FALSE)

To run: 
1.	Update variable species (line 13) and location (line 14) with a species name and location from “Temperature response parameters.csv” or set all = TRUE to run the analyses for all populations
2.	To save model predictions (over existing files in “Model predictions” folder), change save from FALSE to TRUE in line 18
3.	Run the script

Potential issues:

•	The script only works if the working directory (see line 10) is in the main folder of the downloaded GitHub repo

•	The variable species (line 13) and location (line 14) must exist within “Temperature response parameters.csv” and match the “Population” and “Location” columns exactly

**11. ReadMe for “Population dynamics analyses.R”**
This ReadMe gives a brief overview of how to use “Population dynamics analyses.R”. Please note that running this script is not strictly necessary for the populations in the manuscript as all model predictions already exist in “Predictions population dynamics.csv” the “Model predictions” folder.

Input: User-defined species name and location for an insect population or all = TRUE
Output: Updated “Predictions population dynamics.csv” in the “Model predictions” folder (if save = TRUE) for either a specified population (if all = FALSE) or all populations (if all = FALSE)

To run: 
1.	Update variable species (line 13) and location (line 14) with a species name and location from “Temperature response parameters.csv” or set all = TRUE to run the analyses for all populations
2.	To save model predictions (over existing files in “Model predictions” folder), change save from FALSE to TRUE in line 18
3.	Run the script

Potential issues:

•	The script only works if the working directory (see line 9) is in the main folder of the downloaded GitHub repo

•	The variable species (line 13) and location (line 14) must exist within “Temperature response parameters.csv” and match the “Population” and “Location” columns exactly

**12. ReadMe for “Statistical analyses.R”**
This ReadMe gives a brief overview of how to use “Statistical analyses.R”. Please note that this script is sufficient alone to report the main results (including Figs. 3-5) discussed in the manuscript.

Input: Model predictions from “Model predictions” folder
Output: Statistical analyses and plots presented in Figures 3-5 of the manuscript

To run: 
1.	Simply run the script

Potential issues:

•	The script only works if the working directory (line 11) is in the main folder of the downloaded GitHub repo
