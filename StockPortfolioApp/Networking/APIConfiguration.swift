//
//  APIConfiguration.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 6/10/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    
    var path: String? { get }
    
    var parameters: Parameters? { get }
}
