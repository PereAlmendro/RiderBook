//
//  ServiceAssembly.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import CoreData

protocol ServiceAssemblyProtocol {
    func getUserService() -> UserServiceProtocol
    func getLapService() -> LapServiceProtocol
    func getRideService() -> RideServiceProtocol
    func getLoginService() -> LoginServiceProtocol
    func getCircuitService() -> CircuitServiceProtocol
}

final class ServiceAssembly: ServiceAssemblyProtocol {
    
    // MARK: - Private properties
    
    private let repositoryAssembly: RepositoryAssemblyProtocol
    
    // MARK: - Lifecycle
    
    init(repositoryAssembly: RepositoryAssemblyProtocol) {
        self.repositoryAssembly = repositoryAssembly
    }
    
    // MARK: - ServiceAssemblyProtocol
    
    func getUserService() -> UserServiceProtocol {
        let userRepository = repositoryAssembly.getUserRepository()
        let localRepository = repositoryAssembly.getLocalRepository()
        return UserService(userRepository: userRepository,
                           localRepository: localRepository)
    }

    func getLapService() -> LapServiceProtocol {
        let localRepository = repositoryAssembly.getLocalRepository()
        let lapRepository = repositoryAssembly.getLapRepository()
        return LapService(lapRepository: lapRepository,
                          localRepository: localRepository)
    }

    func getRideService() -> RideServiceProtocol {
        let rideRepository = repositoryAssembly.getRideRepository()
        let localRepository = repositoryAssembly.getLocalRepository()
        return RideService(rideRepository: rideRepository,
                           localRepository: localRepository)
    }

    func getLoginService() -> LoginServiceProtocol {
        let userRepository = repositoryAssembly.getUserRepository()
        let localRepository = repositoryAssembly.getLocalRepository()
        return LoginService(userRepository: userRepository,
                            localRepository: localRepository)
    }
    
    func getCircuitService() -> CircuitServiceProtocol {
        let circuitRepository = repositoryAssembly.getCircuitRepository()
        return CircuitService(circuitRepository: circuitRepository)
    }
}
