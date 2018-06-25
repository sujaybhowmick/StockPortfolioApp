//
//  Chart.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/23/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation

struct Chart: Codable {
    let date: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Int64
    let unadjustedVolume: Int64
    let change: Double
    let changePercent: Double
    let vwap: Double
    let label: String
    let changeOverTime: Double
    
    enum CodingKeys: String, CodingKey {
        case date
        case label
        case high
        case low
        case open
        case close
        case volume
        case unadjustedVolume
        case change
        case changePercent
        case vwap
        case changeOverTime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        open = try container.decode(Double.self, forKey: .open)
        high = try container.decode(Double.self, forKey: .high)
        low = try container.decode(Double.self, forKey: .low)
        close = try container.decode(Double.self, forKey: .close)
        volume = try container.decode(Int64.self, forKey: .volume)
        unadjustedVolume = try container.decode(Int64.self, forKey: .unadjustedVolume)
        change = try container.decode(Double.self, forKey: .change)
        changePercent = try container.decode(Double.self, forKey: .changePercent)
        vwap = try container.decode(Double.self, forKey: .vwap)
        label = try container.decode(String.self, forKey: .label)
        changeOverTime = try container.decode(Double.self, forKey: .changeOverTime)
    }
}
