//
//  RideRepositoryTest.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 26/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import XCTest
import Combine
@testable import RiderBook

final class RideRepositoryTest: XCTestCase {
    private var rideRepository: RideRepositoryProtocol!
    private var cancellables: [AnyCancellable] = []
    
    override func tearDownWithError() throws {
        rideRepository = nil
    }
    
    func testAddRideSuccess() {
        let apiService = MockAddRideSuccessApiService()
        let mockLocalRepository = MockLocalRepositorySuccess()
        rideRepository = RideRepository(riderBookApiService: apiService, localRepository: mockLocalRepository)
        
        let expectation = XCTestExpectation()
        cancellables += [
            rideRepository
                .addRide(circuitId: 4, date: Date())
                .sink(receiveCompletion: { print($0) },
                      receiveValue: { (success) in
                        if success {
                            expectation.fulfill()
                        }
                })
        ]
        wait(for: [expectation], timeout: 10)
    }
    
    func testAddRideSuccessWithNilResponse() {
        let apiService = MockNilApiService()
        let mockLocalRepository = MockLocalRepositorySuccess()
        rideRepository = RideRepository(riderBookApiService: apiService, localRepository: mockLocalRepository)
        
        let expectation = XCTestExpectation()
        cancellables += [
            rideRepository
                .addRide(circuitId: 4, date: Date())
                .sink(receiveCompletion: { print($0) },
                      receiveValue: { (success) in
                        if !success {
                            expectation.fulfill()
                        }
                })
        ]
        wait(for: [expectation], timeout: 10)
    }
    
    func testAddRideFailure() {
        let apiService = MockAddRideFailureApiService()
        let mockLocalRepository = MockLocalRepositoryNil()
        rideRepository = RideRepository(riderBookApiService: apiService, localRepository: mockLocalRepository)
        
        let expectation = XCTestExpectation()
        cancellables += [
            rideRepository
                .addRide(circuitId: 4, date: Date())
                .sink(receiveCompletion: { print($0) },
                      receiveValue: { (success) in
                        if !success {
                            expectation.fulfill()
                        }
                })
        ]
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchRidesSuccessWithNilResponse() {
        let apiService = MockAddFetchRidesSuccessApiService()
        let mockLocalRepository = MockLocalRepositorySuccess()
        rideRepository = RideRepository(riderBookApiService: apiService, localRepository: mockLocalRepository)
        
        let expectation = XCTestExpectation()
        cancellables += [
            rideRepository
                .fetchRides(page: 1)
                .sink(receiveCompletion: { print($0) }, receiveValue: { (rides) in
                    if rides.count > 0 {
                        expectation.fulfill()
                    }
                })
        ]
        wait(for: [expectation], timeout: 10)
    }
    
    func testFetchRidesFailure() {
        let apiService = MockNilApiService()
        let mockLocalRepository = MockLocalRepositoryNil()
        rideRepository = RideRepository(riderBookApiService: apiService, localRepository: mockLocalRepository)
        
        let expectation = XCTestExpectation()
        cancellables += [
            rideRepository
            .fetchRides(page: 1)
            .sink(receiveCompletion: { print($0) }, receiveValue: { (rides) in
                if rides.count == 0 {
                    expectation.fulfill()
                }
            })
        ]
        wait(for: [expectation], timeout: 10)
    }
}
