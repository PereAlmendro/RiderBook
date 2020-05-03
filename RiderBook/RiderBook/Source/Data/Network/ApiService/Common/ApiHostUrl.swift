//
//  ApiHostUrl.swift
//  RiderBook
//
//  Created by Pere Almendro on 13/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum ApiHostUrl: String {
    case noHost = ""
    case invalidHost = "www.fakeHostToTestApiService.com"
    case riderBook = "http://192.168.0.19"
}

enum ApiBasePathUrl: String {
    case noBasePath = ""
    case riderBook = "/RiderBookBackend/symfony/web"
}
