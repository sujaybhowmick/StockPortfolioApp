//
//  KeyStats.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 7/17/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation

struct KeyStats: Codable {
    let symbol: String
    let companyName: String?
    let marketcap: Int?
    let beta: Double?
    let week52high: Double?
    let week52low: Double?
    let week52change: Double?
    let ytdChangePercent: Double?
    
}
