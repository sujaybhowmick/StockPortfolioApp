//
//  Client.swift
//  StockPortfolioApp
//
//  Created by Sujay Bhowmick on 7/8/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import RxAlamofire

final class Client {
   
    static let sharedInstance = Client()
    private let baseURL = URL(string: Constants.ProductionServer.baseURL)!
    private let queue = DispatchQueue(label: Constants.ClientQueueName)
    
    private init() {}
    
    // Make Alamofile Manager static Singleton Instance
    private static func sharedManager() -> SessionManager {
        struct Singleton {
            static let shared = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        }
        return Singleton.shared
    }
    
    private static func connectivity() -> NetworkReachabilityManager {
        struct Singleton {
            static let shared = NetworkReachabilityManager()
        }
        return Singleton.shared!
    }
    
    func isConnectedToInternet() -> Bool {
        return Client.connectivity().isReachable
    }
    
    func request<Response>(_ endpoint: Endpoint<Response>) -> Single<Response> {
        return request(nil, endpoint)
    }

    func request<Response>(_ pathParam: String?, _ endpoint: Endpoint<Response>) -> Single<Response> {
        return Single<Response>.create { observer in
            let request = Client.sharedManager().request(
                self.url(path: String(format: endpoint.path, pathParam ?? "")),
                method: self.httpMethod(from: endpoint.method),
                parameters: endpoint.parameters
            )
            request
                .validate()
                .responseData(queue: self.queue) { response in
                    let codable: Result<Response> = response.result.flatMap(endpoint.decode)
                    switch codable {
                        case let .success(val): observer(.success(val))
                        case let .failure(err): observer(.error(err))
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    private func url(path: Path) -> URL {
        return baseURL.appendingPathComponent(path)
    }
    
    private func httpMethod(from method: Method) -> Alamofire.HTTPMethod {
        switch method {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .patch: return .patch
        case .delete: return .delete
        }
    }
}

