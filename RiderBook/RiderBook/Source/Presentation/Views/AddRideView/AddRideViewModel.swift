//
//  AddRideViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class AddRideViewModel: ObservableObject  {

    // MARK: - View properties
    
    @Published var loading: Bool = false
    @Published var circuits: [Circuit] = []
    @Published var selectedCircuit: Circuit?
    
    // MARK: - Private properties
    
    private var anyCancellables: [AnyCancellable] = []
    private let rideService: RideServiceProtocol
    private let circuitService: CircuitServiceProtocol
    private let coordinator: AppCoordinatorProtocol
    
    // MARK: - Lifecycle
    
    init(rideService: RideServiceProtocol,
         circuitService: CircuitServiceProtocol,
         coordinator: AppCoordinatorProtocol) {
        self.rideService = rideService
        self.circuitService = circuitService
        self.coordinator = coordinator
        
        fetchCirctuis()
    }
    
    // MARK: - User Actions
    
    func addRideAction() {
        
    }
    
    // MARK: - Private functions
    
    private func fetchCirctuis() {
        loading = true
        
        anyCancellables += [
            circuitService.getCircuits().receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .failure(let error):
                        // TODO: Show error
                        print(error)
                        break
                    case .finished:
                        break
                    }
                    self?.loading = false
                }) { [weak self] (result) in
                    guard let result = result else {  return }
                    self?.circuits = result
            }
        ]
    }
}
