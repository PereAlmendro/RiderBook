//
//  String+Localization.swift
//  RiderBook
//
//  Created by Pere Almendro on 25/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

public extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}