//
//  UserRepositoryTestMocks.swift
//  RiderBookTests
//
//  Created by Pere Almendro on 18/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift
@testable import RiderBook

class UserRepoApiServiceMock: RiderBookApiServiceProtocol {
    func loadRequest<ResponseModel>(_ target: ApiTargetProtocol, responseModel: ResponseModel.Type) -> Observable<Result<ResponseModel?, RiderBookApiServiceError>> where ResponseModel : Decodable {
        return Observable<Result<ResponseModel?, RiderBookApiServiceError>>.create { observer in
            if let request = target.requestObject as? LoginRequest,
                request.email == "success" {
                let userResponseModel = UserResponse(id: 11, email: "",
                                                     auth: "", name: "success",
                                                     password: "", image: "",
                                                     expiryDate: nil)
                observer.onNext(.success(userResponseModel as? ResponseModel))
            } else {
                observer.onNext(.success(nil))
            }
            return Disposables.create()
        }
    }
}

