//
//  ApiServiceError.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum RiderBookApiServiceError: Error {
    case invalidUrl(error: RiderBookServiceError)
    case generic(error: RiderBookServiceError)
    case parse(error: RiderBookServiceError)
    
    func getError() -> RiderBookServiceError {
        switch self {
        case .invalidUrl(let error),
             .generic(let error),
             .parse(let error):
            return error
        }
    }
}

struct RiderBookServiceError: Decodable {
    let status: String?
    let message: String?
    let code: Int?
    var requestPath: String?
    
    func printError() {
        print("""
            
            HTTP RESPONSE ERROR - REQUEST : \(requestPath ?? "Unknown request"):
            
            Code : \(NSNumber(integerLiteral: code ?? 0).stringValue)
            Description: \(message ?? "Unknown message")
            
            """)
    }
}
