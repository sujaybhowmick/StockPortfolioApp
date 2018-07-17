//
//  ChartViewController.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 7/17/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ChartViewController: UIViewController {
    var selectedPortfolio: Portfolio?
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let client = Client.sharedInstance
        _ = client.request(selectedPortfolio?.ticker, API.chart()).subscribe(onSuccess: { (charts) in
            self.performUIUpdatesOnMain {
                var lineChartEntries  = [ChartDataEntry]()
                PortfolioStockDetailedViewController.df.dateFormat = "mm-dd-yy"
                
                for index in 0..<charts.count {
                    let item = charts[index]
                    let entry = ChartDataEntry(x: Double(index + 1),  y:Double(item.close!))
                    lineChartEntries.append(entry)
                }
                let priceLine = LineChartDataSet(values: lineChartEntries, label: "Price")
                priceLine.colors = [NSUIColor.blue]
                let priceData = LineChartData()
                priceData.addDataSet(priceLine)
                self.lineChartView.data = priceData
                self.lineChartView.chartDescription?.text = self.selectedPortfolio?.ticker
            }
        }, onError: { (error) in
            self.showInfo(withMessage: "Error Displaying Chart")
        })
    }
}

extension ChartViewController {
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
