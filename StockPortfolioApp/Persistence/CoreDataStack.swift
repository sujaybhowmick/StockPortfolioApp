//
//  CoreDataStack.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/27/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataStack {
    
    private let model: NSManagedObjectModel
    internal let coordinator: NSPersistentStoreCoordinator
    private let modelURL: URL
    internal let dbURL: URL
    internal let persistingContext: NSManagedObjectContext
    internal let backgroundContext: NSManagedObjectContext
    let context: NSManagedObjectContext
    
    static func shared() -> CoreDataStack {
        struct Singleton {
            static var shared = CoreDataStack(modelName: "StockPortfolio_v1")!
        }
        return Singleton.shared
    }
    
    init?(modelName: String) {
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            print("Unable to find \(modelName)in the main bundle")
            return nil
        }
        self.modelURL = modelURL
        
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            print("unable to create a model from \(modelURL)")
            return nil
        }
        self.model = model
        
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        persistingContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        persistingContext.persistentStoreCoordinator = coordinator
        
        
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = persistingContext
        
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = context
        
        
        let fm = FileManager.default
        
        guard let docUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Unable to reach the documents folder")
            return nil
        }
        
        self.dbURL = docUrl.appendingPathComponent("model.sqlite")
        
        let options = [
            NSInferMappingModelAutomaticallyOption: true,
            NSMigratePersistentStoresAutomaticallyOption: true
        ]
        
        do {
            try addStoreCoordinator(NSSQLiteStoreType, configuration: nil, storeURL: dbURL, options: options as [NSObject : AnyObject]?)
        } catch {
            print("unable to add store at \(dbURL)")
        }
    }
    
    func addStoreCoordinator(_ storeType: String, configuration: String?, storeURL: URL, options : [NSObject:AnyObject]?) throws {
        try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dbURL, options: nil)
    }
}

internal extension CoreDataStack  {
    
    func dropAllData() throws {
        try coordinator.destroyPersistentStore(at: dbURL, ofType:NSSQLiteStoreType , options: nil)
        try addStoreCoordinator(NSSQLiteStoreType, configuration: nil, storeURL: dbURL, options: nil)
    }
}


extension CoreDataStack {
    
    func saveContext() throws {
        context.performAndWait() {
            
            if self.context.hasChanges {
                do {
                    try self.context.save()
                } catch {
                    print("Error while saving main context: \(error)")
                }
                
                self.persistingContext.perform() {
                    do {
                        try self.persistingContext.save()
                    } catch {
                        print("Error while saving persisting context: \(error)")
                    }
                }
            }
        }
    }
    
    func autoSave(_ delayInSeconds : Int) {
        
        if delayInSeconds > 0 {
            do {
                try saveContext()
                print("Autosaving")
            } catch {
                print("Error while autosaving")
            }
            
            let delayInNanoSeconds = UInt64(delayInSeconds) * NSEC_PER_SEC
            let time = DispatchTime.now() + Double(Int64(delayInNanoSeconds)) / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.autoSave(delayInSeconds)
            }
        }
    }
}

extension CoreDataStack {
    
    func fetchStockTickers(_ predicate: NSPredicate, entityName: String, sorting: NSSortDescriptor? = nil) throws -> [StockTicker]? {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fr.predicate = predicate
        if let sorting = sorting {
            fr.sortDescriptors = [sorting]
        }
        guard let stockTickers = try context.fetch(fr) as? [StockTicker] else {
            return nil
        }
        return stockTickers
    }
    
    func fetchPortfolio(_ predicate: NSPredicate, entityName: String, sorting: NSSortDescriptor? = nil) throws -> Portfolio? {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fr.predicate = predicate
        if let sorting = sorting {
            fr.sortDescriptors = [sorting]
        }
        guard let portfolio = (try context.fetch(fr) as! [Portfolio]).first else {
            return nil
        }
        return portfolio
    }
    
    func fetchAllPortfolios(entityName: String, sorting: NSSortDescriptor? = nil) throws -> [Portfolio]? {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        if let sorting = sorting {
            fr.sortDescriptors = [sorting]
        }
        guard let portfolios = try context.fetch(fr) as? [Portfolio] else {
            return nil
        }
        return portfolios
    }
    
    func fetchStockTicker(_ predicate: NSPredicate) throws -> StockTicker? {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: StockTicker.name)
        fr.predicate = predicate
        guard let stockTicker = (try context.fetch(fr) as! [StockTicker]).first else {
            return nil
        }
        return stockTicker
    }
    
    func preLoadData() {
        let client = Client.sharedInstance
        _ = client.request(API.symbols()).subscribe(onSuccess: { (tickers) in
            tickers.forEach({ (ticker) in
                _ = StockTicker(ticker: ticker.symbol!, companyName: ticker.name!, context: CoreDataStack.shared().context)
            })
            self.save()
        }) { (error) in
            print(error)
        }
    }
    
    func save() {
        do {
            try CoreDataStack.shared().saveContext()
        } catch {
            print(error)
        }
    }
}
