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
    @discardableResult func deleteSavedUser() -> Bool
    @discardableResult func saveUser(_ user: User) -> Bool
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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.UserEntity.rawValue)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request) as? [NSManagedObject] ?? []
            var user: User?
            for data in result  {
                guard
                    let userId = data.value(forKey: "userId") as? Int,
                    let name = data.value(forKey: "name") as? String,
                    let photoUrl = data.value(forKey: "photoUrl") as? String,
                    let email = data.value(forKey: "email") as? String,
                    let password = data.value(forKey: "password") as? String,
                    let authorization = data.value(forKey: "authorization") as? String
                     else {
                        return nil
                }
                
                user = User(userId: userId,
                            name: name,
                            photoUrl: photoUrl,
                            email: email,
                            password: password,
                            authorization: authorization)
            }
            return user
        } catch {
            return nil
        }
    }
    
    @discardableResult func saveUser(_ user: User) -> Bool {
        guard let entity = NSEntityDescription.entity(forEntityName: EntityName.UserEntity.rawValue, in: context) else {
            return false
        }
        
        let userObject = NSManagedObject(entity: entity, insertInto: context)
        userObject.setValue(user.userId, forKey: "userId")
        userObject.setValue(user.name, forKey: "name")
        userObject.setValue(user.photoUrl, forKey: "photoUrl")
        userObject.setValue(user.email, forKey: "email")
        userObject.setValue(user.password, forKey: "password")
        userObject.setValue(user.authorization, forKey: "authorization")
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func deleteSavedUser() -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.UserEntity.rawValue)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request) as? [NSManagedObject] ?? []
            for data in result  {
                context.delete(data)
            }
            return true
        } catch {
            return false
        }
    }
}
