//
//  Environment.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

enum Environments: String {
    case production = "production"
}

struct EnvironmentBaseUrl {
    private var environment: Environments
    private var resources: Dictionary<String, Any>?

    lazy var baseUrl: String = {
        guard let baseUrl = resources?["baseUrl"] as? String else {
            assertionFailure("Unable to read the base url for environment: \(environment.rawValue)")
            return ""
        }
        return baseUrl
    }()

    init(environment: Environments) {
        self.environment = environment
        resources = PlistFileReader.readPlist(fileName: environment.rawValue)
    }
}

struct EnvironmentController {
    lazy var urls: EnvironmentBaseUrl = {
        return EnvironmentBaseUrl(environment: .production)
    }()

    static var shared = EnvironmentController()
    private init() { }
}
