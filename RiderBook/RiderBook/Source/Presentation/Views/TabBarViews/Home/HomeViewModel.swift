//
//  HomeViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import Combine

protocol HomeViewModelProtocol: AnyObject {
    
}

final class HomeViewModel: ObservableObject, HomeViewModelProtocol  {
    @Published var title: String

    init(title: String) {
        self.title = title
    }
    
}
