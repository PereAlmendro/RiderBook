//
//  CircuitRepositoryTest.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 26/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import XCTest
import Combine
@testable import RiderBook

final class CircuitRepositoryTest: XCTestCase {
    private var circuitRepository: CircuitRepositoryProtocol!
    private var cancellables: [AnyCancellable] = []
    
    override func setUpWithError() throws {
        let apiService = MockGetCircuitsSuccessApiService()
        circuitRepository = CircuitRepository(riderBookApiService: apiService)
    }
    
    func testGetCircuitsSuccess() {
        let expectation = XCTestExpectation()
        cancellables += [
            circuitRepository
                .getCircuits()
                .sink(receiveCompletion: { print($0) }, receiveValue: { (circuits) in
                    if circuits?.count ?? 0 > 0 {
                        expectation.fulfill()
                    }
                })
        ]
        wait(for: [expectation], timeout: 10)
    }
}
