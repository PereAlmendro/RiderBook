//
//  RepositoryAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import CoreData

protocol RepositoryAssemblyProtocol {
    func getUserRepository() -> UserRepositoryProtocol
    func getLocalRepository() -> LocalRepositoryProtocol
    func getRideRepository() -> RideRepositoryProtocol
    func getCircuitRepository() -> CircuitRepositoryProtocol
    func getLapRepository() -> LapRepositoryProtocol
    func getRankingRepository() -> RankingRepositoryProtocol
}

final class RepositoryAssembly: RepositoryAssemblyProtocol {
    
    // MARK: - Private properties
    
    private let coreDataContext: NSManagedObjectContext
    private let apiServiceAssembly: ApiServiceAssemblyProtocol
    private var riderBookApiService: RiderBookApiServiceProtocol {
        return apiServiceAssembly.getRiderBookApiService()
    }
    
    // MARK: - Lifecycle
    
    init(coreDataContext: NSManagedObjectContext,
         apiServiceAssembly: ApiServiceAssemblyProtocol) {
        self.apiServiceAssembly = apiServiceAssembly
        self.coreDataContext = coreDataContext
    }
    
    // MARK: - RepositoryAssemblyProtocol
    
    func getUserRepository() -> UserRepositoryProtocol {
        return UserRepository(riderBookApiService: riderBookApiService)
    }
    
    func getLocalRepository() -> LocalRepositoryProtocol {
        return LocalRepository(context: coreDataContext)
    }
    
    func getRideRepository() -> RideRepositoryProtocol {
        return RideRepository(riderBookApiService: riderBookApiService)
    }
    
    func getCircuitRepository() -> CircuitRepositoryProtocol {
        return CircuitRepository(riderBookApiService: riderBookApiService)
    }
    
    func getLapRepository() -> LapRepositoryProtocol {
        return LapRepository(riderBookApiService: riderBookApiService)
    }
    
    func getRankingRepository() -> RankingRepositoryProtocol {
        return RankingRepository(riderBookApiService: riderBookApiService)
    }
}
