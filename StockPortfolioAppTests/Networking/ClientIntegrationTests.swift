//
//  ClientTests.swift
//  StockPortfolioAppTests
//
//  Created by Sujay Bhowmick on 7/12/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import XCTest
import Alamofire
import RxSwift
import RxAlamofire

@testable import StockPortfolioApp

class ClientIntegrationTests: XCTestCase {
   
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testClientRequest() {
        /*let client = Client()
        client.request("MSFT", API.delayedQuote()).subscribe(onSuccess: { (delayedQuote) in
            XCTAssertNotNil(delayedQuote)
        }) { (error) in
            XCTAssertNil(error)
        }*/
    }
}
