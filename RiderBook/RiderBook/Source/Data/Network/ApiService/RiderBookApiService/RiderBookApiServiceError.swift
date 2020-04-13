//
//  ApiServiceError.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum RiderBookApiServiceError: Error {
    case invalidUrl(error: RiderBookServiceErrorResponse)
    case generic(error: RiderBookServiceErrorResponse)
    case parse(error: RiderBookServiceErrorResponse)
    
    func getError() -> RiderBookServiceErrorResponse {
        switch self {
        case .invalidUrl(let error),
             .generic(let error),
             .parse(let error):
            return error
        }
    }
}
