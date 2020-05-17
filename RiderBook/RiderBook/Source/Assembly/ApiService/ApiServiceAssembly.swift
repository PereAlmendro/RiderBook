//
//  ApiServiceAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol ApiServiceAssemblyProtocol {
    func getRiderBookApiService() -> RiderBookApiServiceProtocol
}

final class ApiServiceAssembly: ApiServiceAssemblyProtocol {
    
    // MARK: - Lifecycle
    
    init() { }
    
    // MARK: - ApiServiceAssemblyProtocol
    
    func getRiderBookApiService() -> RiderBookApiServiceProtocol {
        return RiderBookApiService()
    }
}

