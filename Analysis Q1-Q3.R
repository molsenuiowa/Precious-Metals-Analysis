#Mike Olsen
#12/4/2023
#Project Analysis
#Data Wrangling Project
rm(list=ls())

#Q1 Analysis - What is the correlation between gold and silver prices?

# Load required libraries
library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(plotly)
library(reshape2)
library(ggridges)

# Read the combined gold and silver dataset
combined_gold_silver_data <- read_csv("combined_gold_silver_data.csv")

# Convert column names to snake case
colnames(combined_gold_silver_data) <- make.names(colnames(combined_gold_silver_data), unique = TRUE)

# Ensure the date column is in Date format for both datasets
combined_gold_silver_data$date <- as.Date(combined_gold_silver_data$date, format = "%m/%d/%Y")

# Extract required variables
gold_silver_correlation_data <- combined_gold_silver_data %>%
  select(date, Adj.Close_gold, Adj.Close_SI)

# Calculate daily percentage change in closing prices
gold_silver_correlation_data <- gold_silver_correlation_data %>%
  mutate(
    percent_change_gold = (Adj.Close_gold - lag(Adj.Close_gold))/lag(Adj.Close_gold) * 100,
    percent_change_silver = (Adj.Close_SI - lag(Adj.Close_SI))/lag(Adj.Close_SI) * 100
  )

# Drop rows with NAs resulting from percentage change calculation
gold_silver_correlation_data <- na.omit(gold_silver_correlation_data)

# Calculate correlation between gold and silver
correlation_coefficient <- cor(gold_silver_correlation_data$percent_change_gold, gold_silver_correlation_data$percent_change_silver)

# Visualization 1: Line plot of daily percentage change over time with improved date format
ggplot(gold_silver_correlation_data, aes(x = date)) +
  geom_line(aes(y = percent_change_gold, color = "Gold"), size = 0.75) +
  geom_line(aes(y = percent_change_silver, color = "Silver"), size = 0.75) +
  labs(
    title = "Line Plot of Daily Percentage Change in Gold and Silver Prices",
    x = "Date",
    y = "Percentage Change",
    color = "Commodity"
  ) +
  scale_color_manual(values = c("Gold" = "gold", "Silver" = "#C0C0C0")) +  
  theme_minimal()

# Visualization 2: Density plot of daily percentage change
ggplot(gold_silver_correlation_data, aes(x = percent_change_gold, fill = "Gold")) +
  geom_density(alpha = 0.5) +
  geom_density(aes(x = percent_change_silver, fill = "Silver"), alpha = 0.5) +
  labs(
    title = "Density Plot of Daily Percentage Change in Gold and Silver Prices",
    x = "Percentage Change",
    fill = "Commodity"
  ) +
  scale_fill_manual(values = c("Gold" = "gold", "Silver" = "#C0C0C0")) +
  theme_minimal()

# Visualization 3: Boxplot of daily percentage change
ggplot(gold_silver_correlation_data, aes(x = "Commodity", y = percent_change_gold)) +
  geom_boxplot(fill = "gold", color = "black") +
  labs(title = "Boxplot of Daily Percentage Change in Gold",
       x = "Commodity",
       y = "Percentage Change") +
  theme_minimal()

#Q2 Analysis - Volume

# Data Preprocessing
combined_gold_silver_data$date <- as.Date(combined_gold_silver_data$date)

# Extract Month and Year from the 'date' column
combined_gold_silver_data$month_year <- format(combined_gold_silver_data$date, "%Y-%m")

# Filter data for Gold (GC=F) and Silver (SI=F)
gold_silver_volume_data <- combined_gold_silver_data %>%
  filter(ticker %in% c("GC=F", "SI=F"))

# Visualization 1: Monthly trading volumes for gold and silver
ggplot(gold_silver_volume_data, aes(x = month_year, y = volume, color = ticker)) +
  geom_point() +
  labs(title = "Monthly Trading Volumes for Gold and Silver",
       x = "Year-Month",
       y = "Trading Volume",
       color = "Commodity") +
  scale_color_manual(values = c("GC=F" = "gold", "SI=F" = "#C0C0C0")) +  # Use hexadecimal code for silver color
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Calculate highest monthly trading volumes for Gold and Silver
highest_volumes <- gold_silver_volume_data %>%
  group_by(month_year, ticker) %>%
  summarise(max_volume = max(volume, na.rm = TRUE))

# Visualization 2: Bar plot for highest monthly trading volumes without legend
ggplot(highest_volumes, aes(x = month_year, y = max_volume, fill = ticker)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Highest Monthly Trading Volumes for Gold and Silver in 2023",
       x = "Year-Month",
       y = "Highest Trading Volume") +
  scale_fill_manual(values = c("GC=F" = "gold", "SI=F" = "#C0C0C0")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Q3 Analysis - How do the candlestick patterns for Gold and Silver, represented by open, high, low, and close prices, evolve over time? 

# Data Preprocessing
combined_gold_silver_data$date <- as.Date(combined_gold_silver_data$date)

# Candlestick Chart
candlestick_data <- combined_gold_silver_data %>%
  filter(ticker %in% c("GC=F", "SI=F"))

candlestick_chart <- plot_ly(candlestick_data, type = "candlestick",
                             x = ~date,
                             open = ~open, close = ~close,
                             high = ~high, low = ~low,
                             color = ~ticker, colors = c("GC=F" = "gold", "SI=F" = "#C0C0C0"))

# Visualization 1: Candlestick
candlestick_chart %>%
  layout(title = "Candlestick Chart for Gold and Silver",
         xaxis = list(title = "Date"),
         yaxis = list(title = "Price"),
         showlegend = FALSE)

# Visualization 2: Area chart for daily price range
ggplot(candlestick_data, aes(x = date, y = high - low, fill = ticker)) +
  geom_area() +
  labs(title = "Daily Price Range Evolution for Gold and Silver",
       x = "Date",
       y = "Daily Price Range",
       fill = "Commodity") +
  scale_fill_manual(values = c("GC=F" = "gold", "SI=F" = "#C0C0C0")) +
  theme_minimal()













