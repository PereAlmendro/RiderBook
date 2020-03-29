//
//  AddRidePresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 26/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

class AddRidePresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let addRideRouter: AddRideRouter
    private let addRideInteractor: AddRideInteractor
    
    // MARK: - Rx Properties

    var circuitNames: BehaviorSubject<[String]> = BehaviorSubject<[String]>(value:[])
    
    // MARK: - Lifecycle
    
    init(addRideRouter: AddRideRouter, addRideInteractor: AddRideInteractor) {
        self.addRideRouter = addRideRouter
        self.addRideInteractor = addRideInteractor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
    }
    
    // MARK: - User Actions
    
    func saveAction() {
        view?.showAlert(type: .info,
                        title: "Under Construction",
                        message: "This functionality is not developer yet", completion: { [weak self] in
            self?.addRideRouter.dismiss()
        })
    }
    
    // MARK: - Private functions
    
    private func loadView() {
        view?.showLoader()
        addRideInteractor
            .fetchCircuits()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (circuits) in
                self?.circuitNames.onNext(circuits)
                self?.view?.hideLoader()
            }) { [weak self] error in
                // TODO: Handle error
                self?.view?.hideLoader()
        }.disposed(by: disposeBag)
    }
    
}