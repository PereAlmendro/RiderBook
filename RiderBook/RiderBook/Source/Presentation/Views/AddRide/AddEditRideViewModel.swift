//
//  AddEditRideViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

protocol AddEditRideViewModelProtocol: AnyObject {
    
}

final class AddEditRideViewModel: ObservableObject, AddEditRideViewModelProtocol  {
    
    // MARK: - View properties
    
    @Published var reloadPicker: Bool = false
    @Published var loading: Bool = false
    @Published var circuits: [Circuit] = []
    @Published var circuitIndex = 0
    @Published var selectedDate: Date = Date()
    @Published var showAlert: Bool = false
    var alertTitle = ""
    var alertMessage = ""
    
    // MARK: - Private properties
    
    private var anyCancellables: [AnyCancellable] = []
    private let rideService: RideServiceProtocol
    private let circuitService: CircuitServiceProtocol
    private let coordinator: CoordinatorProtocol
    private let screenMode: ScreenMode
    private let ride: Ride?
    
    //MARK: - Public properties
    
    enum ScreenMode {
        case edit
        case add
    }
    
    // MARK: - Lifecycle
    
    init(rideService: RideServiceProtocol,
         circuitService: CircuitServiceProtocol,
         coordinator: CoordinatorProtocol,
         screenMode: ScreenMode,
         ride: Ride? = nil) {
        self.rideService = rideService
        self.circuitService = circuitService
        self.coordinator = coordinator
        self.screenMode = screenMode
        self.ride = ride
        
        fetchCirctuis()
    }
    
    // MARK: - User Actions
    
    func submitAction() {
        loading = true
        
        switch screenMode {
        case .add:
            addRideAction()
        case .edit:
            editRideAction()
        }
    }
    
    func editRideAction() {
        guard let ride = ride else { return }
        let selectedCircuit = circuits[circuitIndex]
        let rideWithChanges = Ride(id: ride.id,
                                   date: selectedDate,
                                   circuit: selectedCircuit.name,
                                   circuitId: selectedCircuit.id,
                                   circuitLocation: selectedCircuit.location)
        
        anyCancellables += [
            rideService
                .editRide(ride: rideWithChanges)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        self?.showMessage(title: "Error",
                                          message: "Something went wrong editing the ride, please try again later")
                    case .finished:
                        break
                    }
                    self?.loading = false
                    }, receiveValue: { [weak self] (success) in
                        if success {
                            self?.showMessage(title: "Sucess",
                                              message: "Ride Edited successfully")
                        } else {
                            self?.showMessage(title: "Error",
                                              message: "Something went wrong editing the ride, please try again later")
                        }
                })
        ]
    }
    
    func addRideAction() {
        let selectedCircuit = circuits[circuitIndex]
        let ride = Ride(id: 0,
                        date: selectedDate,
                        circuit: selectedCircuit.name,
                        circuitId: selectedCircuit.id,
                        circuitLocation: selectedCircuit.location)
        
        anyCancellables += [
            rideService
                .addRide(ride: ride)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        self?.showMessage(title: "Error",
                                          message: "Something went wrong creating the ride, please try again later")
                    case .finished:
                        break
                    }
                    self?.loading = false
                    }, receiveValue: { [weak self] (success) in
                        if success {
                            self?.showMessage(title: "Sucess",
                                              message: "Ride added successfully")
                        } else {
                            self?.showMessage(title: "Error",
                                              message: "Something went wrong creating the ride, please try again later")
                        }
                })
        ]
    }
    
    // MARK: - Private functions
    
    private func fetchCirctuis() {
        loading = true
        anyCancellables += [
            circuitService.getCircuits().receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .failure:
                        self?.showMessage(title: "Error",
                                          message: "Something went wrong fetching the circuits, please try again later")
                    case .finished:
                        break
                    }
                    self?.loading = false
                }) { [weak self] (result) in
                    guard let result = result else {  return }
                    self?.circuits = result
                    self?.setupView()
            }
        ]
    }
    
    private func setupView() {
        if screenMode == .edit, let ride = ride {
            selectedDate = ride.date
            circuitIndex = circuits.firstIndex(where: { $0.id == ride.circuitId }) ?? 0
        }
        
        reloadPicker.toggle()
    }
    
    private func showMessage(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
