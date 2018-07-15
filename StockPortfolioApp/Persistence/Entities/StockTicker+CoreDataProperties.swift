//
//  StockTicker+CoreDataProperties.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 7/15/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//
//

import Foundation
import CoreData


extension StockTicker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StockTicker> {
        return NSFetchRequest<StockTicker>(entityName: "StockTicker")
    }

    @NSManaged public var ticker: String?
    @NSManaged public var companyName: String?

}
