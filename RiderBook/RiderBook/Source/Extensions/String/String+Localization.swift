//
//  String+Localization.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

extension String {
    func localized() -> LocalizedStringKey {
        return LocalizedStringKey(stringLiteral: self)
    }
}
