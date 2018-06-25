//
//  Constants.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/10/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation

struct Constants {
    struct ProductionServer {
        static let baseURL = "https://api.iextrading.com/1.0"
    }
    
    struct DelayedQuoteEndPoint {
        static let apiPath = "delayed-quote"
    }
    struct ChartEndPoint {
        static let apiPath = "chart"
        static let defaultDuration = "1m"
    }
    struct DividendEndPoint {
        static let apiPath = "dividends"
        static let defaultDuration = "3m"
    }
    struct EarningsEndPoint {
        static let apiPath = "earnings"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
