//
//  APIClientTests.swift
//  StockPortfolioAppTests
//
//  Created by Sujay Bhowmick on 6/24/18.
//  Copyright © 2018 Sujay Bhowmick. All rights reserved.
//

import Foundation
import XCTest

@testable import StockPortfolioApp

class APIClientTests: XCTestCase {
    
    func testValidateDelayedQuoteRequest() {
        let ex = expectation(description: "Expecting a JSON data not nil")
        APIClient.delayedQuote(symbol: "AAPL") { (success, delayedQuote, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(delayedQuote)
            if let delayedQuote = delayedQuote {
                XCTAssertTrue(delayedQuote.symbol == "AAPL")
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testValidateChartRequest(){
        let ex = expectation(description: "Expecting a JSON data not nil")
        APIClient.chart(symbol: "AAPL", duration: Constants.ChartEndPoint.defaultDuration) { (success, chart, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(chart)
            if let chart = chart {
                XCTAssertTrue(chart.count == 21)
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testValidateDividendRequest(){
        let ex = expectation(description: "Expecting a JSON data not nil")
        APIClient.dividend(symbol: "AAPL", duration: Constants.DividendEndPoint.defaultDuration) { (success, dividend, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(dividend)
            if let dividend = dividend {
                XCTAssertTrue(dividend.count == 1)
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testValidateEarningsRequest(){
        let ex = expectation(description: "Expecting a JSON data not nil")
        APIClient.earning(symbol: "AAPL") { (success, earning, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(earning)
            if let earning = earning {
                XCTAssertTrue(earning.earnings.count == 4)
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
}
