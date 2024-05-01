# Precious Metals Analysis 🪙📊

## Description
This project provides an analysis of gold and silver prices using historical data. The aim is to identify correlations, trading volume trends, and candlestick patterns in the prices of these precious metals to aid investment decisions.

## Repository Contents
- `GC=F.csv`: Adjusted close prices of gold by date.
- `SI=F.csv`: Adjusted close prices of silver by date.
- `all_commodities_data.csv`: Original dataset from Kaggle with various commodity data.
- `gold_silver_2023_date.csv`: Merged dataset of gold and silver.
- `combined_gold_silver_data.csv`: Dataset with adjusted close prices for both gold and silver.
- `Analysis_Q1-Q3.R`: R script containing the data analysis and visualization for Q1-Q3 2023.

## How to Run the Code

### Prerequisites
Ensure you have R and RStudio installed. You will also need the following R packages:
- `dplyr`
- `ggplot2`
- `tidyr`
- `readr`
- `plotly`
- `reshape2`
- `ggridges`

You can install these packages using R command:
```R
install.packages(c("dplyr", "ggplot2", "tidyr", "readr", "plotly", "reshape2", "ggridges"))

## Running the Analysis

To execute the analysis, follow these steps:

1. **Open RStudio.** Start RStudio on your computer.

2. **Set your working directory** to the folder containing the project files. You can do this from RStudio, or by using the `setwd` command:
   ```R
   setwd("path_to_your_directory")
3. **Run the script by hitting 'Run' or using 'source' command in the console. **
