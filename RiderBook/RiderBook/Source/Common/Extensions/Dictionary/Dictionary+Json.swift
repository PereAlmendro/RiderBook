//
//  Dictionary+Json.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

extension Dictionary {
    var toJsonData: Data? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: [.withoutEscapingSlashes]) else {
            return nil
        }
        return theJSONData
    }
}
