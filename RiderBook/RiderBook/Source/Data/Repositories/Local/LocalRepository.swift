//
//  LocalRepository.swift
//  RiderBook
//
//  Created by Pere Almendro on 16/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import CoreData

fileprivate enum EntityName: String {
    case UserEntity
}

protocol LocalRepositoryProtocol {
    func getUser() -> User?
    func deleteSavedUser()
    func saveUser(_ user: User)
}

final class LocalRepository: LocalRepositoryProtocol {
    
    // MARK: - Private properties
    
    private var context: NSManagedObjectContext!
    
    // MARK: - Lifecycle
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - LocalRepositoryProtocol
    
    func getUser() -> User? {
        guard
            let userId = UserDefaults.userId,
            let name = UserDefaults.userName,
            let photoUrl = UserDefaults.userPhotoUrl,
            let email = UserDefaults.userEmail,
            let password = UserDefaults.userPassword,
            let authorization = UserDefaults.userSessionToken
        else {
            return nil
        }

        return User(userId: userId,
                    name: name,
                    photoUrl: photoUrl,
                    email: email,
                    password: password,
                    authorization: authorization)
    }

    func saveUser(_ user: User) {
        UserDefaults.userId = user.userId
        UserDefaults.userName = user.name
        UserDefaults.userPhotoUrl = user.photoUrl
        UserDefaults.userEmail = user.email
        UserDefaults.userSessionToken = user.authorization
        UserDefaults.userPassword = user.password
    }
    
    func deleteSavedUser() {
        UserDefaults.clear()
    }
}
