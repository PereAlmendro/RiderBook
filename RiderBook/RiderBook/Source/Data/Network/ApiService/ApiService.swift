//
//  ApiService.swift
//  RiderBook
//
//  Created by Pere Almendro on 12/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

final class ApiService {
    func loadRequest<ResponseModel: Decodable>(_ target: ApiTarget,
                                               responseModel: ResponseModel.Type) -> Observable<Result<ResponseModel?, ApiServiceError>> {
        
        return Observable<Result<ResponseModel?, ApiServiceError>>.create { observer in
        
            guard let url = target.url else {
                observer.onError(ApiServiceError.invalidUrl)
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
                    observer.onError(ApiServiceError.generic(errorMessage: error.localizedDescription))
                
                } else if let data = data {
                
                    do {
                        let responseModel: ResponseModel = try JSONDecoder().decode(ResponseModel.self, from: data)
                        observer.onNext(.success(responseModel))
                    } catch let decoderError {
                        observer.onError(ApiServiceError.parse(errorMessage: decoderError.localizedDescription))
                    }
                
                } else {
                    observer.onNext(.success(nil))
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
