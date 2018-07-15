//
//  Portfolio+CoreDataClass.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 7/15/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Portfolio)
public class Portfolio: NSManagedObject {
    static let name = "Portfolio"
    
    convenience init(ticker: String, companyName: String, context: NSManagedObjectContext){
        if let ent = NSEntityDescription.entity(forEntityName: Portfolio.name, in: context) {
            self.init(entity: ent, insertInto: context)
            self.ticker = ticker
            self.companyName = companyName
            self.createdAt = Date() as NSDate
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
