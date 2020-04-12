//
//  ApiServiceError.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum ApiServiceError: Error {
    case invalidUrl
    case generic(errorMessage: String)
    case parse(errorMessage: String)
}
