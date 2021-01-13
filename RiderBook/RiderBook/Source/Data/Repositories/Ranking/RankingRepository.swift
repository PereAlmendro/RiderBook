//
//  RankingRepository.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol RankingRepositoryProtocol {
    
}

final class RankingRepository: RankingRepositoryProtocol {
    
    // MARK: - Private properties
    
    private let apiProvider: APIProvider
    
    // MARK: - Lifecycle
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
    
    // MARK: - RankingRepositoryProtocol
    
}
