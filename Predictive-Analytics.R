#install packages
install.packages("survival")
install.packages("ranger")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("ggfortify")
install.packages("smooth")
install.packages("tseries")
install.packages("lubridate") 
install.packages("forecast")
install.packages("MASS") 
install.packages("prophet")
install.packages("zoo")
install.packages("xts")


#load libraries
library(survival)
library(ranger)
library(ggplot2)
library(dplyr)
library(ggfortify)
library(smooth)
library(tseries)
library(lubridate) 
library(forecast)
library(MASS) 
library(prophet)
library(zoo)
library(xts)

# Import CSV
dati <- read.csv("C:\\Users\\...\\TimeSeries-Days.csv", sep = ";", header = TRUE) 

dati  

# Trasform Time in date 
Ddati <- mutate_at(dati, "Time", ~ymd(paste(., "01")))	

# ts(data, start, frequency, ...)
dati_ts = ts(Ddati[, 2], start = c(2017, 2), frequency = 12)

dati_ts


# Comparing auto.arima() and ets() on seasonal data
train <- window(dati_ts, start = 2017, end = c(2020, 6))

# Fit Naive, ARIMA and an ETS model to the training data
fit1 <- snaive(train)
fit2 <- ets(train)
fit3 <- auto.arima(train, stepwise = FALSE)

# Check that both models have white noise residuals
checkresiduals(fit1)
checkresiduals(fit2)
checkresiduals(fit3)

# Produce forecasts for each model
fc1 <- forecast(fit1, h = 8)
fc2 <- forecast(fit2, h = 8)
fc3 <- forecast(fit3, h = 8)

# Use accuracy() to find best model based on RMSE
a1 <- accuracy(fc1, dati_ts)["Test set", "RMSE"]
a1
a2 <- accuracy(fc2, dati_ts)["Test set", "RMSE"]
a2
a3 <- accuracy(fc3, dati_ts)["Test set", "RMSE"]
a3

a <- c(a1, a2, a3)
BestModel <- which.min(a)

# Create a plot of historical data and the forecast
if (BestModel == 1) { 
  forecastSN <- snaive(dati_ts, h = 8)
  plot(forecastSN, main = "Simple Naive Forecast")
} else if (BestModel == 2) {
  forecastETS <- forecast(ets(dati_ts), h = 8)
  plot(forecastETS, main = "ETS Forecast")
} else {
  fittARIMA <- auto.arima(dati_ts, lambda = 0, stepwise = FALSE)
  forecastARIMA <- forecast(fittARIMA, h = 8) 
  plot(forecastARIMA, main = "ARIMA Forecast")
}


Fc <- if (BestModel == 1) { 
    forecastSN <-snaive(dati_ts, h = 8)
	summary(forecastSN)
    } else if (BestModel == 2) {
	forecastETS <- forecast(ets(dati_ts), h = 8)
	forecastETS
    } else {
    fittARIMA <- auto.arima(dati_ts, lambda = 0, stepwise = FALSE)
	forecastARIMA <- forecast(fittARIMA, h = 8) 
	forecastARIMA
}

Fc

# Point forecast
forecast <- Fc$mean  

# add the forecast to the data
ts1<-as.xts(dati_ts)
ts2<-as.xts(forecast)
ts3 <- c(ts1, ts2)
ts3

# Export to CSV with write.zoo
write.zoo(ts3, file="...", sep=";")
