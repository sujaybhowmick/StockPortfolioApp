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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //reloadTableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
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
        if client.isConnectedToInternet() {
            _ = client.request(portfolio.ticker!, API.delayedQuote()).subscribe(onSuccess: { (delayedQuote) in
                DispatchQueue.main.async {
                    cell.priceLabel.text = String(format: "%.2f", delayedQuote.price ?? "Not Available")
                }
            }, onError: { (error) in
                self.showInfo(withMessage: "Error fetching Stock Quote")
            })
        }else {
            self.showInfo(withMessage: "Network connection not available")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "detailedSegue", sender: nil)
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
            
            if let stockTicker = getStockTicker(ticker){
                _ = savePortfolioStock(stockTicker)
                reloadTableView()
                return true
            }else {
                return false
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedSegue" {
            if let destination = segue.destination as? PortfolioStockDetailedViewController {
                let rowIndex = self.tableView.indexPathForSelectedRow?.row
                destination.selectedPortfolio = self.porfolios[rowIndex!]
            }
        }
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
            for item in autoCompletionPossibilities! {
                let ticker = item.ticker!
                if let substringRange = ticker.range(of: userText){
                    if (!(substringRange.isEmpty)) {
                        possibleMatches.append(ticker)
                    }
                }
            }
        } catch {
            showInfo(withMessage: "Error fetching autocomplete list of tickers")
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
            showInfo(withMessage: "Error fetching \(ticker)")
        }
        return nil
    }
    
    func resetValues() {
        searchTextField.text = ""
    }
    
    //MARK: - Save Stock ticker to Portfolio
    func savePortfolioStock(_ stockTicker: StockTicker) -> Portfolio? {
        if let portfolio = getPortfolio(stockTicker.ticker!){
            return portfolio
        }else {
            _ = Portfolio(ticker: stockTicker.ticker!, companyName: stockTicker.companyName!, context: CoreDataStack.shared().context)
            CoreDataStack.shared().save()
            let predicate = NSPredicate(format: "ticker == %@", stockTicker.ticker!)
            do {
                let portfolio = try CoreDataStack.shared().fetchPortfolio(predicate, entityName: Portfolio.name)
                resetValues()
                return portfolio
            }catch{
                showInfo(withMessage: "Error Saving \(stockTicker.ticker!)")
            }
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
            showInfo(withMessage: "Error fetching Portfolio List")
        }
    }
    
    func getPortfolio(_ ticker: String) -> Portfolio? {
        do {
            if let portfolio = try CoreDataStack.shared().fetchPortfolio(NSPredicate(format: "ticker == %@", ticker), entityName: Portfolio.name) {
                return portfolio
            }else {
                return nil
            }
        }catch {
            showInfo(withMessage: "Error fetching portfolio for \(ticker)")
        }
        return nil
    }
    
    /*func toggleActivityIndicator(){
        DispatchQueue.main.async {
            if self.activityIndicator.isAnimating {
                self.activityIndicator.stopAnimating()
            }else {
                self.activityIndicator.startAnimating()
            }
        }
    }*/
    
    private func showInfo(withTitle: String = "Info", withMessage: String, action: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alertAction) in
                action?()
            }))
            self.present(ac, animated: true)
        }
    }
}

