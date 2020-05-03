//
//  RiderBookApiServiceTest.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 14/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import XCTest
import Combine
@testable import RiderBook

final class RiderBookApiServiceTest: XCTestCase {
    
    private var rbApiService: RiderBookApiService!
    private var anyCancellables: [AnyCancellable] = []
    
    override func setUp() {
        super.setUp()
        rbApiService = RiderBookApiService()
    }
    
    override func tearDown() {
        super.tearDown()
        rbApiService = nil
        for cancellable in anyCancellables {
            cancellable.cancel()
        }
        anyCancellables = []
    }
    
    func testSuccessResult() {
        let expectation = XCTestExpectation()
        
        let request = rbApiService
            .loadRequest(MockTarget.success, responseModel: UserResponse.self)
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: {
                $0?.email == "test@test.com" ? expectation.fulfill() : XCTFail()
            })
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testInvalidBaseUrl() {
        let expectation = XCTestExpectation()
        
        let request = rbApiService
            .loadRequest(MockTarget.invalidUrl, responseModel: String.self)
            .sink(receiveCompletion: { (completion) in
                print(completion)
                switch completion {
                case .failure(let error):
                    if error.description() == "Malformed URL" {
                        expectation.fulfill()
                    }
                case .finished: return
                }
            }, receiveValue: { print($0 as Any) })
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testInvalidPathUrl() {
        let expectation = XCTestExpectation()
        
        let request = rbApiService
            .loadRequest(MockTarget.invalidPath, responseModel: UserResponse.self)
            .sink(receiveCompletion: { (completion) in
                print(completion)
                switch completion {
                case .failure(let error):
                    if error.description() == "Malformed URL" {
                        expectation.fulfill()
                    }
                case .finished: return
                }
            }, receiveValue: { print($0 as Any) })
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }

    func testErrorResult() {
        let expectation = XCTestExpectation()
        
        let request = rbApiService
            .loadRequest(MockTarget.error, responseModel: UserResponse.self)
            .sink(receiveCompletion: { (completion) in
                print(completion)
                switch completion {
                case .failure(let error):
                    if error.description() == "Response error" {
                        expectation.fulfill()
                    }
                case .finished: return
                }
            }, receiveValue: { print($0 as Any) })
        
        anyCancellables += [
            request
        ]
        
        wait(for: [expectation], timeout: 10)
    }
}
