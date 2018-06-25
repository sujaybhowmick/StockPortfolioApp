//
//  APIClient.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/24/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Alamofire

class APIClient {
    static func performRequest(route: APIConfiguration, completion:@escaping (Result<Data>) -> Void) {
        Alamofire.request(route).responseData { (response) in
            completion(response.result)
        }
    }
    
    static func delayedQuote(symbol: String, completion: @escaping (_ success: Bool, _ result: DelayedQuote?, _ error: NSError?) -> Void) {
        let delayedQuoteEnum = DelayedQuoteEndPoint.delayedQuote(symbol: symbol, endPoint: Constants.DelayedQuoteEndPoint.apiPath)
        performRequest(route: delayedQuoteEnum) { (result) in
            if let value = result.value {
                do {
                    let delayedQuote = try JSONDecoder().decode(DelayedQuote.self, from: value)
                    completion(true, delayedQuote, nil)
                }catch let error as NSError {
                    completion(false, nil, error)
                }
            }else {
                completion(false, nil, NSError(domain: "Error getting Quoted Response", code: -1, userInfo: nil))
            }
        }
    }
    
    static func chart(symbol: String, duration: String, completion: @escaping (_ success: Bool, _ result: [Chart]?, _ error: NSError?) -> Void) {
        let chartEndPointEnum = ChartEndPoint.chart(symbol: symbol, duration: duration, endPoint: Constants.ChartEndPoint.apiPath)
        performRequest(route: chartEndPointEnum) { (result) in
            if let value = result.value {
                do {
                    let chart = try JSONDecoder().decode([Chart].self, from: value)
                    completion(true, chart, nil)
                }catch let error as NSError {
                    completion(false, nil, error)
                }
            }else {
                completion(false, nil, NSError(domain: "Error getting Quoted Response", code: -1, userInfo: nil))
            }
        }
    }
    
    static func dividend(symbol: String, duration: String, completion: @escaping (_ success: Bool, _ result: [Dividend]?, _ error: NSError?) -> Void) {
        let dividendEndPointEnum = DividendEndPoint.dividend(symbol: symbol, duration: duration, endPoint: Constants.DividendEndPoint.apiPath)
        performRequest(route: dividendEndPointEnum) { (result) in
            if let value = result.value {
                do {
                    let dividend = try JSONDecoder().decode([Dividend].self, from: value)
                    completion(true, dividend, nil)
                }catch let error as NSError {
                    completion(false, nil, error)
                }
            }else {
                completion(false, nil, NSError(domain: "Error getting Dividend Response", code: -1, userInfo: nil))
            }
        }
    }
    
    static func earning(symbol: String, completion: @escaping (_ success: Bool, _ result: Earning?, _ error: NSError?) -> Void) {
        let earningsEndPoint = EarningsEndPoint.earning(symbol: symbol, endPoint: Constants.EarningsEndPoint.apiPath)
        performRequest(route: earningsEndPoint) { (result) in
            if let value = result.value {
                do {
                    let earning = try JSONDecoder().decode(Earning.self, from: value)
                    completion(true, earning, nil)
                }catch let error as NSError {
                    completion(false, nil, error)
                }
            }else {
                completion(false, nil, NSError(domain: "Error getting Dividend Response", code: -1, userInfo: nil))
            }
        }
    }
    
}
