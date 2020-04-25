//
//  RidesViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

class RidesViewModel: ObservableObject  {

    // MARK: - View properties
    
    @Published var rides: [Ride] = []
    
    // MARK: - Private properties
    
    private var anyCancellables: [AnyCancellable] = []
    private let coordinator: AppCoordinatorProtocol
    private let rideService: RideServiceProtocol
    private var actualPage: Int = 0

    // MARK: - Lifecycle
    
    init(coordinator: AppCoordinatorProtocol,
         rideService: RideServiceProtocol) {
        self.coordinator = coordinator
        self.rideService = rideService
    }
    
    // MARK: - User Actions
    
    func addRideAction() {
        coordinator.showAddRide()
    }
    
    // MARK: - Private methods
    
    func fetchNextRides() {
        anyCancellables += [
            rideService
                .fetchRides(page: actualPage)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (rides) in
                    self?.rides += rides
                    self?.actualPage += 1
                })
        ]
    }
}
