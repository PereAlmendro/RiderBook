//
//  LoginInteractor.swift
//  RiderBook
//
//  Created by Pere Almendro on 27/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

protocol LoginInteractor {
    func attemptLogin(username: String?, password: String?) -> Single<Bool>
}

class LoginInteractorImpl: LoginInteractor {
    func attemptLogin(username: String?, password: String?) -> Single<Bool> {
        // TODO: Validate credentials and perform login
        return Single.just(true)
    }
}
