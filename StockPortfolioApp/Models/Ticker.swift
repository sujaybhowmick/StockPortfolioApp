//
//  Ticker.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 7/14/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation

struct Ticker: Codable {
    let symbol: String?
    let name: String?
    let enabled: Bool
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case enabled = "isEnabled"
    }
}
