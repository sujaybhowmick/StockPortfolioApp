//
//  API.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 7/8/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation

enum API {}

extension API {
    static func delayedQuote() -> Endpoint<DelayedQuote> {
        return Endpoint(path: "/stock/%@/delayed-quote")
    }
    
    static func symbols() -> Endpoint<[Ticker]> {
        return Endpoint(path: "/ref-data/symbols")
    }
    
    static func chart() -> Endpoint<[Chart]> {
        return Endpoint(path: "/stock/%@/chart/1m")
    }
    
    static func financials() -> Endpoint<Financials> {
        return Endpoint(path: "/stock/%@/financials")
    }
}
