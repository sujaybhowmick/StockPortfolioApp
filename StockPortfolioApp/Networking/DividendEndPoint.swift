//
//  DividendEndPoint.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/25/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Alamofire

enum DividendEndPoint: APIConfiguration {
    case dividend(symbol: String, duration: String, endPoint: String)
    
    var parameters: Parameters? {
        switch self {
        case .dividend( _, _, _):
            return nil
        }
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .dividend( _, _, _):
            return .get
        }
    }
    
    var path: String? {
        switch self {
        case .dividend(let symbol, let duration, let endPoint):
            return String(format: Constants.apiPathTemplate.apiPathWithDuration, symbol, endPoint, duration)
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path!))
        print(urlRequest.url!)
        
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
    }
}
