//
//  Dividends.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/24/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation

struct Dividend: Codable {
    let exDate: String?
    let paymentDate: String?
    let recordDate: String?
    let declaredDate: String?
    let amount: Double?
    let flag: String?
    let type: String?
    let qualified: String?
    let indicated: String?
    
}
