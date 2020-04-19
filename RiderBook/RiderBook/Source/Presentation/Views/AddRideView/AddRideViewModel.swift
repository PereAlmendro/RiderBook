//
//  AddRideViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

class AddRideViewModel: ObservableObject  {

    // MARK: - View properties
    
    @Published var loading: Bool = false
    @Published var circuits: [Circuit] = []
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let rideService: RideServiceProtocol
    private var circuitService: CircuitServiceProtocol
    private var coordinator: AppCoordinatorProtocol
    
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
        circuitService
            .getCircuits()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (circuits) in
                self?.circuits = circuits
                self?.loading = false
            }) { [weak self] (error) in
                self?.loading = false
                // TODO: Show error
                print(error)
        }.disposed(by: disposeBag)
    }
}
