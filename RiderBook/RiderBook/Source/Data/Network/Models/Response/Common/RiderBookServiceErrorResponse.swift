//
//  RiderBookServiceErrorResponse.swift
//  RiderBook
//
//  Created by Pere Almendro on 13/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct RiderBookServiceErrorResponse: Decodable {
    var code: Int?
    var message: String?
    var requestPath: String?
    
    func printError() {
        print("""
            
            HTTP RESPONSE ERROR - REQUEST : \(requestPath ?? "Unknown request"):
            
            Code : \(NSNumber(integerLiteral: code ?? 0).stringValue)
            Description: \(message ?? "Unknown message")
            
            """)
    }
}
