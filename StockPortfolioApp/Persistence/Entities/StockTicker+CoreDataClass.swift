//
//  StockTicker+CoreDataClass.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 7/15/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//
//

import Foundation
import CoreData

@objc(StockTicker)
public class StockTicker: NSManagedObject {
    static let name = "StockTicker"
    
    convenience init(ticker: String, companyName: String, context: NSManagedObjectContext){
        if let ent = NSEntityDescription.entity(forEntityName: StockTicker.name, in: context) {
            self.init(entity: ent, insertInto: context)
            self.ticker = ticker
            self.companyName = companyName
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
