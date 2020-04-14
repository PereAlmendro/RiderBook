//
//  RiderBookApiServiceTest.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 14/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import XCTest
import RxSwift
@testable import RiderBook

final class RiderBookApiServiceTest: XCTestCase {
    
    private var rbApiService: RiderBookApiService!
    private var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        rbApiService = RiderBookApiService()
    }
    
    override func tearDown() {
        super.tearDown()
        rbApiService = nil
    }
    
    func testInvalidUrl() {
        let expectation = XCTestExpectation(description: "Empty URL")
        
        rbApiService
            .loadRequest(MockTarget.invalidUrl, responseModel: String.self)
            .subscribe(onError: { (error) in
                guard let error = error as? RiderBookApiServiceError else { return }
                if error.getError().message == expectation.description {
                    expectation.fulfill()
                }
            }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testInvalidDomainUrl() {
        let expectation = XCTestExpectation(description: "www.testAbsolutelyAFakeDomain.com")
        
        rbApiService
            .loadRequest(MockTarget.errorDomain, responseModel: String.self)
            .subscribe(onError: { (error) in
                guard let error = error as? RiderBookApiServiceError else { return }
                if error.getError().requestPath == expectation.description {
                    expectation.fulfill()
                }
            }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testErrorResult() {
        let expectation = XCTestExpectation()
        
        rbApiService
            .loadRequest(MockTarget.error, responseModel: UserResponse.self)
            .subscribe(onError: { (error) in
                guard let error = error as? RiderBookApiServiceError else { return }
                if error.getError().code == 400 {
                    expectation.fulfill()
                }
            }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testErrorDecodingResult() {
        let expectation = XCTestExpectation(description: "Unable to decode the response")
        
        rbApiService
            .loadRequest(MockTarget.success, responseModel: String.self)
            .subscribe(onError: { (error) in
                guard let error = error as? RiderBookApiServiceError else { return }
                if error.getError().message == expectation.description {
                    expectation.fulfill()
                }
            }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testSucessResult() {
        let expectation = XCTestExpectation()
        
        rbApiService
            .loadRequest(MockTarget.success, responseModel: UserResponse.self)
            .subscribe(onNext: { (result) in
                guard let userData = try? result.get() else { return }
                if userData.name == "test" && userData.email == "test@test.com" {
                    expectation.fulfill()
                }
            }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 10)
    }
    

    
}
