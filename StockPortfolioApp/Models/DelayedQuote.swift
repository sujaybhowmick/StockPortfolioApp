//
//  TimeSeries.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/12/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation

struct DelayedQuote: Codable {
    let symbol: String?
    let price: Double?
    let high: Double?
    let low: Double?
    let volume: Int?
    let priceTime: Date?
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case price = "delayedPrice"
        case high
        case low
        case volume = "delayedSize"
        case priceTime = "delayedPriceTime"
    }
}

extension DateFormatter {
    static let yyyyMMddhhss: DateFormatter =  {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = NSLocale.current
        return formatter
    }()
}

extension DelayedQuote {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(String.self, forKey: .symbol)
        price = try container.decode(Double.self, forKey: .price)
        high = try container.decode(Double.self, forKey: .high)
        low = try container.decode(Double.self, forKey: .low)
        volume = try container.decode(Int.self, forKey: .volume)
        let ts = try container.decode(Int.self, forKey: .priceTime) / 1000 // covert to seconds
        let fmt = DateFormatter.yyyyMMddhhss
        let date = Date(timeIntervalSince1970: TimeInterval(ts))
        priceTime = fmt.date(from: fmt.string(from: date))!
    }
}
