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
    
    // MARK: - Private properties
    
    private var anyCancellables: [AnyCancellable] = []
    private let lapService: LapServiceProtocol
    private let coordinator: AppCoordinatorProtocol
    private let ride: Ride
    
    // MARK: - Lifecycle
    
    init(lapService: LapServiceProtocol,
         coordinator: AppCoordinatorProtocol,
         ride: Ride) {
        self.lapService = lapService
        self.coordinator = coordinator
        self.ride = ride
    }
    
    
}
