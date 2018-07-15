//
//  Portfolio+CoreDataProperties.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 7/15/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//
//

import Foundation
import CoreData


extension Portfolio {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Portfolio> {
        return NSFetchRequest<Portfolio>(entityName: "Portfolio")
    }

    @NSManaged public var ticker: String?
    @NSManaged public var companyName: String?
    @NSManaged public var createdAt: NSDate?

}
