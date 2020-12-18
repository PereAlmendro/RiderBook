//
//  PlistFileReader.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct PlistFileReader {
    static func readPlist(fileName: String) -> Dictionary<String, Any>? {
        guard
            let filePath = Bundle.main.path(forResource: fileName, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: filePath) as? Dictionary<String, Any>
        else {
            assertionFailure("\n\n\nUnable to load environment \(fileName)\n\n\n")
            return nil
        }
        return dict
    }
}
