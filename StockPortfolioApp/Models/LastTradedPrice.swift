//
//  LastTradedPrice.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/26/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation

struct LastTradedPrice: Codable {
    let symbol: String?
    let price: String?
    let size: Int?
    let lastTradedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case price
        case size
        case lastTradedAt = "time"
    }
}
extension LastTradedPrice {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(String.self, forKey: .symbol)
        let dPrice = try container.decode(Double.self, forKey: .price)
        price = String(format: "%.2f", dPrice)
        size = try container.decode(Int.self, forKey: .size)
        let ts = try container.decode(Int.self, forKey: .lastTradedAt) / 1000 // covert to seconds
        let fmt = DateFormatter.fortmatter
        let date = Date(timeIntervalSince1970: TimeInterval(ts))
        lastTradedAt = fmt.date(from: fmt.string(from: date))!
    }
}

extension DateFormatter {
    static let fortmatter: DateFormatter =  {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = NSLocale.current
        return formatter
    }()
}
