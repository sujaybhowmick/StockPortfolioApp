#  StockTrack App

### Executive Summary

The App is simple Stock Portfolio tracker. A user of the app can create a list of company stock and keep track of the current performance of the company stocks in his portfolio. The App also shows some important information related to the company **Financial, Earnings and Price chart **

Below is the App Screencast which demonstrates the App flow and screens

<a href=""><img src="https://github.com/sujaybhowmick/StockPortfolioApp/blob/master/StockTrackScreenCast.gif?raw=true"></a>

### Implementation

There are three main ViewControllers in this App

1. **MyPortfolioViewController**
2. **PortfolioStockDetailedViewController**
3. **ChartViewController**

##### **MyPortfolioViewController**

This controller is the main initial controller. This controller provides the functionality to search for a stock using the ticker symbol. You can add the stock to a list of stocks called portfolio by hitting return on the matched symbol. The controller uses a table view to display the list of stocks and is stored and fetched in persistent store in the App. 

Further tapping on the selected row will transition the App to the next screen

##### **PortfolioStockDetailedViewController**

This controller display additional financial information. Some of the information are related to stock performance, financial stats and eartnings. The "View Chart" button at the bottom of the screen transitions the App to chart view.

##### **ChartViewController**

This controller displays the price chart of 1 month duration in a line chart

All the screens are navigable using the navigation controllers

### Requirements

1. Xcode 9.2+
2. Swift 4.0
3. Cocoa Pod 1.5.3

*3rd Party Libraries*

1. **Alamofire & RxAlamofire** - Networking
2. **RxSwift** - Dependency on RxAlamofire
3. **Charts** - Line Chart

### How to Build the App

The App using **Xcode** for development and build and Cocoa Pods for dependency management. Following steps are required before the project can be built using Xcode

1. Install Cocoa Pod dependency management tool - https://cocoapods.org/#install
2. Clone the project from the repository https://github.com/sujaybhowmick/StockPortfolioApp.git from github
3. Install the dependencies for the project by executing the `$pod install` command from within the project's parent directory. This will create  ***.xcworkspace*** file after it successfully installs the dependencies
4. Open the project by clicking on the ***.xcworkspace*** file and this should open up Xcode. Now build the App using Xcode `Command + B` keys

### API Provider for Financial Markets Data

The Market data is provided for free by [IEX](https://iextrading.com/developer/) through their [IEX Developer Platform](https://iextrading.com/developer/).

API documentation - https://iextrading.com/developer/docs/

### License

This project is distributed under [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)