//
//  RankingService.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol RankingServiceProtocol {
    
}

final class RankingService: RankingServiceProtocol {
    
    // MARK: - Private properties
    private let rankingRepository: RankingRepositoryProtocol
    // MARK: - Lifecycle
    
    init(rankingRepository: RankingRepositoryProtocol) {
        self.rankingRepository = rankingRepository
    }
    
    // TODO: - fetch ranking
}
