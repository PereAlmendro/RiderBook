//
//  BasePresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 23/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

class BasePresenter: NSObject {
    
    var disposeBag: DisposeBag
    var router: Router
    weak var view: BaseView?
    
    init(router: Router) {
        self.router = router
        disposeBag = DisposeBag()
        super.init()
    }
    
    func attachView<T: BaseView>(view: T) {
        self.view = view
    }
    
    func viewDidLoad() { }
    func viewWillAppear() { }
    func viewDidAppear() { }
    func viewWillDisappear() { }
    func viewDidDisappear() { }
}
