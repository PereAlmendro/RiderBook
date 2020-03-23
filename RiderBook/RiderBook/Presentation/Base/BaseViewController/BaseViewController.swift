//
//  BaseViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 22/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController<P: BasePresenter>: UIViewController, BaseView {
    
    typealias Presenter = P
    var presenter: Presenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
}

class BasePresenter: NSObject {
    
    var disposeBag: DisposeBag
    weak var view: BaseView?
    
    override init() {
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

protocol BaseView: AnyObject { }
