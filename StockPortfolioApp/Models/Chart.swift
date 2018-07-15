//
//  Chart.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/23/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation

struct Chart: Codable {
    let date: String?
    let open: Double?
    let high: Double?
    let low: Double?
    let close: Double?
    let volume: Int?
    let unadjustedVolume: Int?
    let change: Double?
    let changePercent: Double?
    let vwap: Double?
    let label: String?
    let changeOverTime: Double?
}
