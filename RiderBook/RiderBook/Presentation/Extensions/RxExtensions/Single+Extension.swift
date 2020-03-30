//
//  Single+Extension.swift
//  RiderBook
//
//  Created by Pere Almendro on 30/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

extension PrimitiveSequence where Trait == SingleTrait {
    func showLoader(view: Loadable?) -> Single<Element> {
        view?.showLoader()
        return self.do(onSuccess: { _ in view?.hideLoader()},
                       onError: { _ in view?.hideLoader()})
    }
}
