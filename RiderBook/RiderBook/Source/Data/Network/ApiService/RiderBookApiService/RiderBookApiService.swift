//
//  RiderBookApiService.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

final class RiderBookApiService {
    
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTargetProtocol,
                                               responseModel: ResponseModel.Type) -> Observable<Result<ResponseModel?, RiderBookApiServiceError>> {
        return Observable<Result<ResponseModel?, RiderBookApiServiceError>>.create { observer in
            
            guard let url = target.url else {
                let serviceError = RiderBookServiceErrorResponse(code: 0,
                                                                 message: "Empty URL",
                                                                 requestPath: "")
                observer.onError(
                    RiderBookApiServiceError.invalidUrl(error: serviceError)
                )
                observer.onCompleted()
                return Disposables.create()
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = target.method.rawValue
            request.allHTTPHeaderFields = target.headers
            
            if let requestJsonData = target.requestObject?.toJsonData() {
                request.httpBody = requestJsonData
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
                if let error = error {
                    let serviceError = RiderBookServiceErrorResponse(code: 0,
                                                                     message: error.localizedDescription,
                                                                     requestPath: request.url?.absoluteString)
                    observer.onError(
                        RiderBookApiServiceError.generic(error: serviceError)
                    )
                } else if let data = data,
                    let responseModel = try? JSONDecoder().decode(ResponseModel.self, from: data) {
                    // sucess. Return decoded object
                    observer.onNext(
                        .success(responseModel)
                    )
                } else if let data = data,
                    var error: RiderBookServiceErrorResponse = try? JSONDecoder().decode(RiderBookServiceErrorResponse.self, from: data) {
                    error.requestPath = request.url?.absoluteString
                    
                    if error.code == nil && error.message == nil {
                        // Unable to decode backend error message, this can be a server crash
                        error.code = 0
                        error.message = "Unable to decode the response"
                    }
                    
                    observer.onError(
                        RiderBookApiServiceError.generic(error: error)
                    )
                } else {
                    observer.onNext(
                        .success(nil)
                    )
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
