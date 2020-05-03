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
    
    enum LapAction {
        case edit
        case add
        case delete
    }
    
    // MARK: - Private properties
    
    private var anyCancellables: [AnyCancellable] = []
    private let lapService: LapServiceProtocol
    private let coordinator: AppCoordinatorProtocol
    private var actualPage: Int = 1

    private enum Constants: Int {
        case minutesTextFieldTag = 0
        case secondsTextFieldTag = 1
    }
    
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
    
    // MARK: - Private functions
    
    private func addLap(with minutes: Double, seconds: Double) {
        let number = laps.sorted { (lap1, lap2) -> Bool in
            lap1.number > lap2.number
        }.first?.number ?? 0
        
        let timeInSeconds = (minutes * 60) + seconds
        
        let lapToAdd = Lap(rideId: ride.id, lapId: 0, number: number + 1, timeInSeconds: String(timeInSeconds))
        
        anyCancellables += [
            lapService
            .addLap(lap: lapToAdd)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error)
                    case .finished:
                        break
                    }
                }, receiveValue: { [weak self] (success) in
                    self?.refreshList()
                })
        ]
    }
    
    private func editLap(_ lap: Lap, with minutes: Double, seconds: Double) {
        // TODO: edit lap
    }
    
    private func deleteLap(_ lap: Lap) {
        // TODO: delete lap
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
    
    func lapAction(_ lapAction: LapAction, lap: Lap? = nil) {
        if lapAction == .delete {
            guard let lap = lap else { return }
            deleteLap(lap)
        } else {
            let alert = UIAlertController(title: "Add a new lap".localizedString(),
                                          message: nil,
                                          preferredStyle: .alert)
            
            alert.addTextField() { textField in
                textField.placeholder = "Minutes".localizedString()
                textField.keyboardType = .numberPad
                textField.tag = Constants.minutesTextFieldTag.rawValue
            }
            
            alert.addTextField() { textField in
                textField.placeholder = "Seconds".localizedString()
                textField.keyboardType = .numbersAndPunctuation
                textField.tag = Constants.secondsTextFieldTag.rawValue
            }
            
            alert.addAction(
                UIAlertAction(title: "Add".localizedString(), style: .default, handler: { [weak self] (action) in
                    
                    var minutes: Double = 0
                    var seconds: Double = 0
                    alert.textFields?.forEach { textField in
                        if textField.tag == Constants.minutesTextFieldTag.rawValue {
                            minutes = Double(textField.text ?? "0") ?? 0.0
                        } else if (textField.tag == Constants.secondsTextFieldTag.rawValue) {
                            seconds = Double(textField.text ?? "0") ?? 0.0
                        }
                    }
                    
                    switch lapAction {
                    case .add:
                        self?.addLap(with: minutes, seconds: seconds)
                    case .edit:
                        guard let lap = lap else { return }
                        self?.editLap(lap, with: minutes, seconds: seconds)
                        break
                    default:
                        break
                    }
                }))
            alert.addAction(UIAlertAction(title: "Cancel".localizedString(), style: .cancel))
            
            coordinator.showAlert(alert: alert)
        }
    }
    
    func closeAction() {
        coordinator.dismiss()
    }
}
