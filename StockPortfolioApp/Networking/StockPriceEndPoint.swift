//
//  UserEndPoint.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/10/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Alamofire

enum StockPriceEndPoint {
   /*
    case TIME_SERIES_DAILY(function: String,  symbol: String, apiKey: String)
    case TIME_SERIES_INTRADAY(function: String, symbol: String, interval: String, apiKey: String)
    
    var method: HTTPMethod {
        switch self {
        case .TIME_SERIES_DAILY:
            return .get
        case .TIME_SERIES_INTRADAY:
            return .get
        }
    }
    
    var path: String? {
        switch self {
        case .TIME_SERIES_DAILY:
            return nil
        case .TIME_SERIES_INTRADAY:
            return nil
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .TIME_SERIES_DAILY(let function, let symbol, let apiKey):
            return [Constants.TimeSeriesParameters.function: function, Constants.TimeSeriesParameters.symbol: symbol,
                    Constants.TimeSeriesParameters.apiKey: apiKey]
        case .TIME_SERIES_INTRADAY(let function, let symbol, let interval, let apiKey):
            return [Constants.TimeSeriesParameters.function: function, Constants.TimeSeriesParameters.symbol: symbol,
                    Constants.TimeSeriesParameters.interval: interval, Constants.TimeSeriesParameters.apiKey: apiKey]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path!))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }*/
}
