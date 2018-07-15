//
//  StockPortfolioService.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/29/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation

class StockPortfolioService {
    static let client = Client.sharedInstance
    static func getStockPrice(_ ticker: String) -> DelayedQuote? {
        _ = client.request(ticker, API.delayedQuote()).subscribe(onSuccess: { (delayedQuote) in
            print(delayedQuote)
        }, onError: { (error) in
            print(error)
        })
        return nil
    }
}
