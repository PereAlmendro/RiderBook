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
    
    func saveAction(selectedDate: Date, selectedCircuit: String) {
        addRideInteractor
            .attemptAddRide(selectedDate: selectedDate, selectedCircuit: selectedCircuit)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .showLoader(view: view)
            .subscribe(onSuccess: { [weak self] success in
                if success {
                    self?.view?.showAlert(type: .success,
                                          title: "ride_created".localized(),
                                          message: "good_luck".localized(),
                                          completion: {
                                            self?.addRideRouter.dismiss()
                    })
                } else {
                    self?.view?.showAlert(type: .error,
                                          title: "generic_error_title".localized(),
                                          message: "generic_error_message".localized(),
                                          completion: nil)
                }
            }) { [weak self] error in
                self?.view?.showAlert(type: .error,
                                      title: "generic_error_title".localized(),
                                      message: error.localizedDescription,
                                      completion: nil)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Private functions
    
    private func loadView() {
        addRideInteractor
            .fetchCircuits()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .showLoader(view: view)
            .subscribe(onSuccess: { [weak self] (circuits) in
                self?.circuitNames.onNext(circuits.compactMap { $0.name } )
            }) { [weak self] error in
                self?.view?.showAlert(type: .error,
                                      title: "Error".localized(),
                                      message: error.localizedDescription,
                                      completion: nil)
        }.disposed(by: disposeBag)
    }
    
}
