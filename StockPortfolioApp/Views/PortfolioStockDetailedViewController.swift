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
    
    //MARK: - Earnings
    
    @IBOutlet weak var eps: UILabel!
    @IBOutlet weak var estEps: UILabel!
    @IBOutlet weak var dollarEps: UILabel!
    @IBOutlet weak var change: UILabel!
    @IBOutlet weak var earningPeriod: UILabel!
    @IBOutlet weak var earningReportedDate: UILabel!
    
    
    static var df = DateFormatter()
    static let currencyFormatter = NumberFormatter()
    
    
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
    
    @IBAction func showChart(_ sender: Any) {
        performSegue(withIdentifier: "chartViewSegue", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PortfolioStockDetailedViewController.currencyFormatter.usesGroupingSeparator = true
        PortfolioStockDetailedViewController.currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        PortfolioStockDetailedViewController.currencyFormatter.locale = Locale(identifier: "en_US")
        self.showStockQuote()
        self.showFinancials()
        self.showEarnings()
    }
    
    //MARK: - Stock Quote Section
    private func showStockQuote() {
       
        let client = Client.sharedInstance
        _ = client.request(selectedPortfolio?.ticker, API.delayedQuote()).subscribe(onSuccess: { (delayedQuote) in
            self.performUIUpdatesOnMain {
                self.ticker.text = self.selectedPortfolio?.ticker
                self.price.text = PortfolioStockDetailedViewController.currencyFormatter.string(from: delayedQuote.price! as NSNumber)
                self.high.text = PortfolioStockDetailedViewController.currencyFormatter.string(from: delayedQuote.high! as NSNumber)
                self.low.text = PortfolioStockDetailedViewController.currencyFormatter.string(from: delayedQuote.low! as NSNumber)
                PortfolioStockDetailedViewController.df.dateFormat = "MMM dd, yyyy HH:mm:ss"
                self.date.text = PortfolioStockDetailedViewController.df.string(from: delayedQuote.priceTime!)
            }
        }, onError: { (error) in
            self.showInfo(withMessage: "Error fetching Stock Quote")
        })
    }
    
    //MARK: - Financials Section
    private func showFinancials() {
        let client = Client.sharedInstance
        _ = client.request(selectedPortfolio?.ticker, API.financials()).subscribe(onSuccess: { (financials) in
            
            self.performUIUpdatesOnMain {
                let financialLatest = financials.financials.compactMap { $0 }.first
                if let profit = financialLatest?.grossProfit {
                    var inBillions = PortfolioStockDetailedViewController.currencyFormatter.string(from: self.covertToBillion(profit)! as NSNumber)
                    inBillions?.append("B")
                    self.profit.text = inBillions
                }
                if let income = financialLatest?.netIncome {
                    var inBillions = PortfolioStockDetailedViewController.currencyFormatter.string(from: self.covertToBillion(income)! as NSNumber)
                    inBillions?.append("B")
                    self.netIncome.text = inBillions
                }
                if let revenue = financialLatest?.totalRevenue {
                    var inBillions = PortfolioStockDetailedViewController.currencyFormatter.string(from: self.covertToBillion(revenue)! as NSNumber)
                    inBillions?.append("B")
                    self.revenue.text = inBillions
                }
                if let debt = financialLatest?.totalDebt {
                    var inBillions = PortfolioStockDetailedViewController.currencyFormatter.string(from: self.covertToBillion(debt)! as NSNumber)
                    inBillions?.append("B")
                    self.debt.text = inBillions
                    if let shareHolderEquity = financialLatest?.shareholderEquity {
                        let debtEq = (Double(debt) / Double(shareHolderEquity)) * 100
                        self.debtEq.text = String(format: "%.2f", debtEq)
                    }
                }
                if let cash = financialLatest?.totalCash {
                    var inBillions = PortfolioStockDetailedViewController.currencyFormatter.string(from: self.covertToBillion(cash)! as NSNumber)
                    inBillions?.append("B")
                    self.cash.text = inBillions
                }
                PortfolioStockDetailedViewController.df.dateFormat = "yyyy-MM-dd"
                let reportedDate = PortfolioStockDetailedViewController.df.date(from: (financialLatest?.reportDate)!)
                PortfolioStockDetailedViewController.df.dateFormat = "MMM dd, yyyy"
                self.reportedDate.text = PortfolioStockDetailedViewController.df.string(from: reportedDate!)
            }
        }, onError: { (error) in
            self.showInfo(withMessage: "Error fetching Financials")
        })
    }
    
    //MARK: - Earnings Section
    private func showEarnings() {
        let client = Client.sharedInstance
        _ = client.request(selectedPortfolio?.ticker, API.earnings()).subscribe(onSuccess: { (earning) in
            self.performUIUpdatesOnMain {
                let earningsLatest = earning.earnings.compactMap{ $0 }.first
                if let eps = earningsLatest?.actualEPS {
                    self.eps.text = String(format: "%.2f", eps)
                }
                if let estEps = earningsLatest?.estimatedEPS {
                    self.estEps.text = String(format: "%.2f", estEps)
                }
                if let dollarEps = earningsLatest?.epsSurpriseDollar {
                    self.dollarEps.text = String(format: "%.2f", dollarEps)
                }
                
                if let change = earningsLatest?.yearAgoChangePercent {
                    self.change.text = String(format: "%.2f", change)
                }
                if let earningsReportedDate = earningsLatest?.epsReportDate {
                    PortfolioStockDetailedViewController.df.dateFormat = "yyyy-MM-dd"
                    let date = PortfolioStockDetailedViewController.df.date(from: earningsReportedDate)
                    PortfolioStockDetailedViewController.df.dateFormat = "MMM dd, yyyy"
                    self.earningReportedDate.text = PortfolioStockDetailedViewController.df.string(from: date!)
                }
                if let fiscalPeriod = earningsLatest?.fiscalPeriod {
                    self.earningPeriod.text = fiscalPeriod
                }
            }
        }, onError: { (error) in
            self.showInfo(withMessage: "Error fetching Earnings")
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
    private func covertToBillion(_ value: Int) -> Double? {
        return Double(value / 1000000000)
    }
    
    private func showInfo(withTitle: String = "Info", withMessage: String, action: (() -> Void)? = nil) {
        performUIUpdatesOnMain {
            let ac = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alertAction) in
                action?()
            }))
            self.present(ac, animated: true)
        }
    }
}
