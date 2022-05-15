# replayNIFTY

This app is intended to provide a starting point for those who would like to intraday trade in nifty derivatives. 10 years of 5 minute data ( from 01-01-2011 to 31-12-2020 ) is provided with the app. 

How to Use?

Select a working day  between 01-01-2011 and 31-12-2020. Wait for the date to get loaded. Once the data is loaded click 'Next Candle'. 
Each click will present the next 5 minute candle. Three simple moving averages (20, 50 and 200) calculated on the close value of the candles also get plotted along with the candles. Dotted lines are Standard pivot levels which are calculated on the previous day hlc data.

A slider is provided to change the visible Nifty range. Long and Short buttons on the side panel can be used to enter and exit positions. On licking the Long button, a new long position is initiated, or an existing short position closed, at the close value of the last candle. The same way, the Short button can be clicked to initiate a new Short position or to exit an existing Long position at the close value of the last candle. PL will give the points covered on each trade. 

References:

1 https://www.kaggle.com/datasets/rohanrao/nifty50-stock-market-data

2 https://www.tradingview.com/support/solutions/43000521824-pivot-points-standard/
