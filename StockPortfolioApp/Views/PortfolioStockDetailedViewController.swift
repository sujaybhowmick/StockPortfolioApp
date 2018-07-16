//
//  PortfolioStockDetailedViewController.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 7/16/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import UIKit
import Charts

class PortfolioStockDetailedViewController: UIViewController {
    var selectedPortfolio: Portfolio?
    
    //MARK: - Stock Quote
    @IBOutlet weak var ticker: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    @IBOutlet weak var date: UILabel!
    
    //MARK: - Financials
    
    @IBOutlet weak var profit: UILabel!
    @IBOutlet weak var netIncome: UILabel!
    @IBOutlet weak var revenue: UILabel!
    @IBOutlet weak var reportedDate: UILabel!
    @IBOutlet weak var debt: UILabel!
    @IBOutlet weak var debtEq: UILabel!
    @IBOutlet weak var cash: UILabel!
    
    //MARK: - Line Chart
   // @IBOutlet weak var lineChartView: LineChartView!
    
    
    static var df = DateFormatter()
    
    
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
    
    @IBAction func showChart(_ sender: Any) {
        performSegue(withIdentifier: "chartViewSegue", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //reloadTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale(identifier: "en_US")

        let client = Client.sharedInstance
        _ = client.request(selectedPortfolio?.ticker, API.delayedQuote()).subscribe(onSuccess: { (delayedQuote) in
            self.performUIUpdatesOnMain {
                self.ticker.text = self.selectedPortfolio?.ticker
                self.price.text = currencyFormatter.string(from: delayedQuote.price! as NSNumber)
                self.high.text = currencyFormatter.string(from: delayedQuote.high! as NSNumber)
                self.low.text = currencyFormatter.string(from: delayedQuote.low! as NSNumber)
                PortfolioStockDetailedViewController.df.dateFormat = "MMM dd, yyyy HH:mm:ss"
                self.date.text = PortfolioStockDetailedViewController.df.string(from: delayedQuote.priceTime!)
            }
        }, onError: { (error) in
            print(error)
        })
        _ = client.request(selectedPortfolio?.ticker, API.financials()).subscribe(onSuccess: { (financials) in
           
            self.performUIUpdatesOnMain {
                let financialLatest = financials.financials.compactMap { $0 }.first
                if let profit = financialLatest?.grossProfit {
                    var inBillions = currencyFormatter.string(from: self.covertToBillion(profit)! as NSNumber)
                    inBillions?.append("B")
                    self.profit.text = inBillions
                }
                if let income = financialLatest?.netIncome {
                    var inBillions = currencyFormatter.string(from: self.covertToBillion(income)! as NSNumber)
                    inBillions?.append("B")
                    self.netIncome.text = inBillions
                }
                if let revenue = financialLatest?.totalRevenue {
                    var inBillions = currencyFormatter.string(from: self.covertToBillion(revenue)! as NSNumber)
                    inBillions?.append("B")
                    self.revenue.text = inBillions
                }
                if let debt = financialLatest?.totalDebt {
                    var inBillions = currencyFormatter.string(from: self.covertToBillion(debt)! as NSNumber)
                    inBillions?.append("B")
                    self.debt.text = inBillions
                    if let shareHolderEquity = financialLatest?.shareholderEquity {
                        let debtEq = (Double(debt) / Double(shareHolderEquity)) * 100
                        self.debtEq.text = String(format: "%.2f", debtEq)
                    }
                }
                if let cash = financialLatest?.totalCash {
                    var inBillions = currencyFormatter.string(from: self.covertToBillion(cash)! as NSNumber)
                    inBillions?.append("B")
                    self.cash.text = inBillions
                }
                PortfolioStockDetailedViewController.df.dateFormat = "yyyy-MM-dd"
                let reportedDate = PortfolioStockDetailedViewController.df.date(from: (financialLatest?.reportDate)!)
                PortfolioStockDetailedViewController.df.dateFormat = "MMM dd, yyyy"
                self.reportedDate.text = PortfolioStockDetailedViewController.df.string(from: reportedDate!)
            }
        }, onError: { (error) in
            print(error)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chartViewSegue" {
            if let destination = segue.destination as? ChartViewController {
                destination.selectedPortfolio = self.selectedPortfolio
            }
        }
    }
}

extension PortfolioStockDetailedViewController {
    func covertToBillion(_ value: Int) -> Double? {
        return Double(value / 1000000000)
    }
}
