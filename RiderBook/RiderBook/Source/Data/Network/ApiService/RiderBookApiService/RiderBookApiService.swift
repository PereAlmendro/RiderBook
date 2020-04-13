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
    
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTarget,
                                               responseModel: ResponseModel.Type) -> Observable<Result<ResponseModel?, RiderBookApiServiceError>> {
        return Observable<Result<ResponseModel?, RiderBookApiServiceError>>.create { observer in
            
            guard let url = target.url else {
                let serviceError = RiderBookServiceErrorResponse(status: "error",
                                                                 message: "Empty URL", code: 0,
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
                    let serviceError = RiderBookServiceErrorResponse(status: "error",
                                                                     message: error.localizedDescription, code: 0,
                                                                     requestPath: request.url?.absoluteString)
                    observer.onError(
                        RiderBookApiServiceError.generic(error: serviceError)
                    )
                } else if let responseModel = try? JSONDecoder().decode(ResponseModel.self, from: data ?? Data()) {
                    // sucess. Return decoded object
                    observer.onNext(
                        .success(responseModel)
                    )
                } else {
                    do {
                        var error: RiderBookServiceErrorResponse = try JSONDecoder().decode(RiderBookServiceErrorResponse.self, from: data ?? Data())
                        error.requestPath = request.url?.absoluteString
                        // Backend returned and error
                        observer.onError(
                            RiderBookApiServiceError.generic(error: error)
                        )
                    } catch let decoderError {
                        let serviceError = RiderBookServiceErrorResponse(status: "error",
                                                                         message: decoderError.localizedDescription, code: 0,
                                                                         requestPath: request.url?.absoluteString)
                        // Unable to decode backend messge, this can be a server crash
                        observer.onError(
                            RiderBookApiServiceError.generic(error: serviceError)
                        )
                    }
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
