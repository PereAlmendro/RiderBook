//
//  UserDefaults+Storage.swift
//  RiderBook
//
//  Created by Pere Almendro on 18/12/20.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

extension UserDefaults {

    static var userName: String? {
        get {
            return standard.value(forKey: "name") as? String
        }
        set {
            standard.setValue(newValue, forKey: "name")
        }
    }

    static var userSessionToken: String? {
        get {
            return standard.value(forKey: "userSessionToken") as? String
        }
        set {
            standard.setValue(newValue, forKey: "userSessionToken")
        }
    }

    static var userEmail: String? {
        get {
            return standard.value(forKey: "userEmail") as? String
        }
        set {
            standard.setValue(newValue, forKey: "userEmail")
        }
    }

    static var userPhotoUrl: String? {
        get {
            return standard.value(forKey: "userPhotoUrl") as? String
        }
        set {
            standard.setValue(newValue, forKey: "userPhotoUrl")
        }
    }

    static var userId: Int? {
        get {
            return standard.value(forKey: "userId") as? Int
        }
        set {
            standard.setValue(newValue, forKey: "userId")
        }
    }

    static var userPassword: String? {
        get {
            return standard.value(forKey: "userPassword") as? String
        }
        set {
            standard.setValue(newValue, forKey: "userPassword")
        }
    }

    static func clear() {
        UserDefaults.userId = nil
        UserDefaults.userName = nil
        UserDefaults.userPhotoUrl = nil
        UserDefaults.userEmail = nil
        UserDefaults.userSessionToken = nil
        UserDefaults.userPassword = nil
    }
}
