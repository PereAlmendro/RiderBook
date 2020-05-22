//
//  UploadImageRequest.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

struct UploadImageRequest: Encodable, RequestableProtocol {
    let image: String
    let authorization: String
    
    func toJsonData() -> Data? {
        return ["image" : image].toJsonData()
    }
}
