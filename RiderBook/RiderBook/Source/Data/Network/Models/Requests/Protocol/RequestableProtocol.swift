//
//  RequestableProtocol.swift
//  RiderBook
//
//  Created by Pere Almendro on 13/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

protocol RequestableProtocol {
    func toJsonData() -> Data?
}
