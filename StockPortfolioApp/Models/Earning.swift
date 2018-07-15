//
//  Earnings.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/24/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

/**
 {
 "symbol": "AAPL",
     "earnings": [
         {
         "actualEPS": 2.73,
         "consensusEPS": 2.69,
         "estimatedEPS": 2.69,
         "announceTime": "AMC",
         "numberOfEstimates": 10,
         "EPSSurpriseDollar": 0.04,
         "EPSReportDate": "2018-05-01",
         "fiscalPeriod": "Q2 2018",
         "fiscalEndDate": "2018-03-31",
         "yearAgo": 2.1,
         "yearAgoChangePercent": 0.29999999999999993,
         "estimatedChangePercent": 0.2809523809523809,
         "symbolId": 11
         }
     ]
 }
**/
 
import Foundation

struct Earning: Codable {
    let symbol: String
    let earnings: [EarningsData]
    
    
    struct EarningsData: Codable {
        let actualEPS: Double?
        let consensusEPS: Double?
        let estimatedEPS: Double?
        let announceTime: String?
        let numberOfEstimates: Int?
        let epsSurpriseDollar: Double?
        let epsReportDate: String?
        let fiscalPeriod: String?
        let fiscalEndDate: String?
        let yearAgo: Double?
        let yearAgoChangePercent: Double?
        let estimatedChangePercent: Double?
        let symbolId: Int?
        
        enum CodingKeys: String, CodingKey {
            case actualEPS, consensusEPS, estimatedEPS, announceTime, numberOfEstimates, epsSurpriseDollar = "EPSSurpriseDollar", epsReportDate = "EPSReportDate", fiscalPeriod, fiscalEndDate, yearAgo, yearAgoChangePercent, estimatedChangePercent,
            symbolId
        }
    }
}

