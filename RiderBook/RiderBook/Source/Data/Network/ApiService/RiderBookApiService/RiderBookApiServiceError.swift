//
//  ApiServiceError.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum RiderBookApiServiceError: Error {
    case responseError(Error)
    case badRequest(Error)
    
    func description() -> String {
        switch self {
        case .responseError:
            return "Response error"
        case . badRequest:
            return "Malformed URL"
        }
    }
}
