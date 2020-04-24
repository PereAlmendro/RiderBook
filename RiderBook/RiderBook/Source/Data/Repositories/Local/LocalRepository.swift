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
    @discardableResult func saveUser(_ user: User) -> Bool
}

final class LocalRepository: LocalRepositoryProtocol {
    
    private var context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getUser() -> User? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName.UserEntity.rawValue)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request) as? [NSManagedObject] ?? []
            var user: User?
            for data in result  {
                let email = data.value(forKey: "email") as! String
                let password = data.value(forKey: "password") as! String
                
                user = User(userId: 0, name: "", photoUrl: "", email: email, password: password, authorization: "")
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
        userObject.setValue(user.email, forKey: "email")
        userObject.setValue(user.password, forKey: "password")
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
}
