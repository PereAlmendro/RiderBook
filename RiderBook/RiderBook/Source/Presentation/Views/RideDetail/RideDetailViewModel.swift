//
//  RideDetailViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class RideDetailViewModel: ObservableObject  {
    
    // MARK: - View properties
    
    @Published var ride: Ride
    @Published var laps: [Lap] = []
    
    // MARK: - Private properties
    
    private var anyCancellables: [AnyCancellable] = []
    private let lapService: LapServiceProtocol
    private let coordinator: AppCoordinatorProtocol
    private var actualPage: Int = 1
    
    // MARK: - Lifecycle
    
    init(lapService: LapServiceProtocol,
         coordinator: AppCoordinatorProtocol,
         ride: Ride) {
        self.lapService = lapService
        self.coordinator = coordinator
        self.ride = ride
    }
    
    private func fetchLaps(page: Int) {
        anyCancellables += [
            lapService
                .fetchLaps(page: page, rideId: ride.id)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (laps) in
                    self?.laps += laps
                })
        ]
    }
    
    // MARK: - Public functions
    
    func refreshList() {
        laps = []
        actualPage = 1
        fetchLaps(page: actualPage)
    }
    
    // MARK: - User actions
    
    func editRideAction() {
        // TODO: Implement
    }
    
    func deleteRideAction() {
        // TODO: Implement
    }
    
    func addLapAction() {
        // TODO: Implement
    }
    
    func editLapAction(_ lap: Lap) {
        // TODO: Implement
    }
    
    func deleteLapAction(_ lap: Lap) {
        // TODO: Implement
    }
    
    func closeAction() {
        coordinator.dismiss()
    }
}
