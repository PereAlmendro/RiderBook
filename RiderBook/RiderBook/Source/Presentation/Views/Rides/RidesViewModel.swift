//
//  RidesViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import Combine

class RidesViewModel: ObservableObject  {

    // MARK: - View properties
    
    @Published var rides: [Ride] = []
    
    // MARK: - Private properties
    
    private var anyCancellables: [AnyCancellable] = []
    private let coordinator: AppCoordinatorProtocol
    private let rideService: RideServiceProtocol
    private var actualPage: Int = 1

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
    
    func showAlertToDeleteRide(_ ride: Ride) {
        let alert = UIAlertController(title: "Warning!".localizedString(),
                                      message: "You are going to delete a ride, all laps for this ride will be deleted".localizedString(),
                                      preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title: "Delete".localizedString(), style: .destructive, handler: { [weak self] (action) in
                self?.deleteRideAction(ride)
            })
        )
        alert.addAction(UIAlertAction(title: "Cancel".localizedString(), style: .cancel))
     
        coordinator.showAlert(alert: alert)
    }
    
    // MARK: - Private functions
    
    private func fetchRides(page: Int) {
        anyCancellables += [
            rideService
                .fetchRides(page: page)
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
                })
        ]
    }
    
    private func deleteRideAction(_ ride: Ride) {
        anyCancellables += [
            rideService
            .deleteRide(ride: ride)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .failure, .finished:
                        break
                    }
                }, receiveValue: { [weak self] (success) in
                    self?.refreshList()
                })
        ]
    }
    
    private func editRideAction(_ ride: Ride) {
        // TODO: Implement
    }
    
    // MARK: - Public functions
    
    func refreshList() {
        rides = []
        actualPage = 1
        fetchRides(page: actualPage)
    }
    
    func selectedRide(_ ride: Ride) {
        coordinator.showRideDetail(for: ride)
    }
}
