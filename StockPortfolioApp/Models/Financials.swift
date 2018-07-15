//
//  Financials.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/25/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation

struct Financials: Codable {
    let symbol: String
    let financials: [FinancialsData]
    /**
     "reportDate": "2018-03-31",
     "grossProfit": 23422000000,
     "costOfRevenue": 37715000000,
     "operatingRevenue": 61137000000,
     "totalRevenue": 61137000000,
     "operatingIncome": 15894000000,
     "netIncome": 13822000000,
     "researchAndDevelopment": 3378000000,
     "operatingExpense": 7528000000,
     "currentAssets": 130053000000,
     "totalAssets": 367502000000,
     "totalLiabilities": null,
     "currentCash": 45059000000,
     "currentDebt": 20478000000,
     "totalCash": 87940000000,
     "totalDebt": 121840000000,
     "shareholderEquity": 126878000000,
     "cashChange": 17568000000,
     "cashFlow": 15130000000,
     "operatingGainsLosses": null
    **/
    struct FinancialsData: Codable {
        let reportDate: String?
        let grossProfit: Int?
        let costOfRevenue: Int?
        let operatingRevenue: Int?
        let totalRevenue: Int?
        let operatingIncome: Int?
        let netIncome: Int?
        let researchAndDevelopment: Int?
        let operatingExpense: Int?
        let currentAssets: Int?
        let totalAssets: Int?
        let totalLiabilities: Int?
        let currentCash: Int?
        let currentDebt: Int?
        let totalCash: Int?
        let totalDebt: Int?
        let shareholderEquity: Int?
        let cashChange: Int?
        let cashFlow: Int?
        let operatingGainsLosses: Int?
        
    }
}
