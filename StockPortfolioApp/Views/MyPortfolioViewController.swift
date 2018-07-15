//
//  ViewController.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/4/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import UIKit
import RxSwift
import CoreData

class MyPortfolioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var porfolios = [Portfolio]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //reloadTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return porfolios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! CustomTableViewCell
        let portfolio = self.porfolios[indexPath.row]
        cell.tickerLabel?.text = portfolio.ticker
        cell.companyLabel?.text = portfolio.companyName
        let client = Client.sharedInstance
        _ = client.request(portfolio.ticker!, API.delayedQuote()).subscribe(onSuccess: { (delayedQuote) in
            self.performUIUpdatesOnMain {
                cell.priceLabel.text = String(format: "%.2f", delayedQuote.price ?? "Not Available")
            }
        }, onError: { (error) in
            print(error)
        })
        
        return cell
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let subString = (textField.text!.capitalized as NSString).replacingCharacters(in: range, with: string)
        if subString.count == 0 { // 3 when a user clears the textField
            resetValues()
        }
        return !autoCompleteText(in: textField, using: string, suggestions: getAutocompleteSuggestions(userText: subString.uppercased()))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let ticker = textField.text {
            //TODO: - Add ticker to Portfolio and Fire Network Query
            if let stockTicker = getStockTicker(ticker){
                _ = savePortfolioStock(stockTicker)
                reloadTableView()
            }else {
                return false
            }
            return true
        }
        return false
    }
}

// MARK: - Helper Methods
extension MyPortfolioViewController {
    func autoCompleteText( in textField: UITextField, using string: String, suggestions: [String]) -> Bool {
        //print(suggestions)
        if !string.isEmpty,
            let selectedTextRange = textField.selectedTextRange,
            selectedTextRange.end == textField.endOfDocument,
            let prefixRange = textField.textRange(from: textField.beginningOfDocument, to: selectedTextRange.start),
            let text = textField.text( in : prefixRange) {
            let prefix = text + string
            let matches = suggestions.filter {
                $0.hasPrefix(prefix)
            }
            if (matches.count > 0) {
                textField.text = matches[0]
                if let start = textField.position(from: textField.beginningOfDocument, offset: prefix.count) {
                    searchTextField.selectedTextRange = textField.textRange(from: start, to: textField.endOfDocument)
                    return true
                }
            }
        }
        return false
    }
    
    func getAutocompleteSuggestions(userText: String) -> [String]{
        var possibleMatches: [String] = []
        
        let predicate = NSPredicate(format: "ticker contains[cd] %@", userText)
        
        do {
            let autoCompletionPossibilities = try CoreDataStack.shared().fetchStockTickers(predicate, entityName: StockTicker.name)
            for item in autoCompletionPossibilities! { //2
                let ticker = item.ticker!
                if let substringRange = ticker.range(of: userText){
                    if (!(substringRange.isEmpty)) {
                        possibleMatches.append(ticker)
                    }
                }
            }
        } catch {
            print(error)
        }
        return possibleMatches
    }
    
    func getStockTicker(_ ticker: String) -> StockTicker? {
        let predicate = NSPredicate(format: "ticker == %@", ticker)
        do {
            if let stockTicker = try CoreDataStack.shared().fetchStockTicker(predicate) {
                return stockTicker
            }else {
                return nil
            }
        }catch{
            print(error)
        }
        return nil
    }
    
    func resetValues() {
        searchTextField.text = ""
    }
    
    //MARK: - Save Stock ticker to Portfolio
    func savePortfolioStock(_ stockTicker: StockTicker) -> Portfolio? {
        _ = Portfolio(ticker: stockTicker.ticker!, companyName: stockTicker.companyName!, context: CoreDataStack.shared().context)
        CoreDataStack.shared().save()
        let predicate = NSPredicate(format: "ticker == %@", stockTicker.ticker!)
        do {
            let portfolio = try CoreDataStack.shared().fetchPortfolio(predicate, entityName: Portfolio.name)
            resetValues()
            return portfolio
        }catch{
            print(error)
        }
        return nil
    }
    
    func reloadTableView() {
        do {
            if let porfolios = try CoreDataStack.shared().fetchAllPortfolios(entityName: Portfolio.name){
                self.porfolios = porfolios
                self.tableView.reloadData()
            }
        }catch {
            print(error)
        }
    }
}

