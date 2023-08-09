# Predictive-Analytics-with-R
Algorithm to choose the best method (*Naive, Simple Exponential Smoothing, ARIMA*) for predicting time series thanks to accuracy function. If **x** is provided, the function measures test set forecast accuracy based on **x-f**. If **x** is not provided, the function only produces training set accuracy measures of the forecasts based on **f["x"]-fitted(f)**. 

# Models:
* **Naive Model**:
The Naive model is the simplest forecasting model. It assumes that the future values of a time series will be equal to the most recent observed value. In other words, it assumes there is no trend, seasonality, or any other pattern in the data. The Naive model is easy to implement but may not perform well for time series data with complex patterns.

* **ETS (Error, Trend, and Seasonality)**
"ETS" stands for "Error, Trend, and Seasonality," which is a more general and flexible approach than simple exponential smoothing. ETS encompasses simple exponential smoothing as a specific case.
The simple exponential smoothing model can be seen as a specific case of ETS where there is neither trend nor seasonality. So, if you have a forecasting model that includes only the level of the data without considering trend or seasonality, you can call it either simple exponential smoothing or ETS(level).
To summarize, simple exponential smoothing can be considered as a specific case of ETS where only the data level is present, while ETS is a more general approach that allows for the modeling of trend and seasonality in addition to the data level.

* **Simple Exponential Smoothing (SES)**:
Simple Exponential Smoothing is a basic forecasting method that takes into account the weighted average of past observations. It assigns exponentially decreasing weights to past observations, with the most recent observations having the highest weight. SES is a time series forecasting technique that considers both the level and trend in the data. It is suitable for data with no or minimal seasonality.

* **ARIMA Model**:
ARIMA stands for Autoregressive Integrated Moving Average. It is a popular and powerful forecasting model for time series data. ARIMA combines three components: autoregressive (AR), differencing (I), and moving average (MA). The AR component captures the relationship between an observation and a certain number of lagged observations. The I component is used to make the time series stationary by differencing the data. The MA component represents the error of the model as a combination of error terms from previous time steps. ARIMA models can handle data with trend, seasonality, and irregular components.

In summary, the **Naive** model assumes the future values will be the same as the most recent observation, the **ETS** model it considers the weighted average of past observations by assigning exponentially decreasing weights to the observations. The weights are determined by the smoothing parameters, which control the rate at which the influence of past observations decreases over time. The ETS model takes into account the current observation, the trend component, and the seasonal component to make forecasts, and **ARIMA** models capture the complex relationships between the past values, differencing to achieve stationarity, and considering the error terms from previous time steps. 

The choice of model depends on the characteristics of the data and the patterns you want to capture in the forecasts. By fitting and comparing multiple models, and then selecting the best model based on RMSE, this code aims to provide a more accurate forecast for the given time series data. The RMSE provides a measure of the typical magnitude of the forecast errors. It represents the standard deviation of the residuals, indicating how close the predicted values are to the actual values on average. A lower RMSE value indicates that the model's predictions are closer to the observed values, suggesting better accuracy.
