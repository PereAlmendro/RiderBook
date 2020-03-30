//
//  MyRidesPresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

class MyRidesPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let myRidesRouter: MyRidesRouter
    private let myRidesInteractor: MyRidesInteractor
    private var rides: [Ride] = []
    
    // MARK: - Rx Properties
    
    var reloadTable: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
    // MARK: - Lyfecycle
    
    init(myRidesRouter: MyRidesRouter, myRidesInteractor: MyRidesInteractor) {
        self.myRidesRouter = myRidesRouter
        self.myRidesInteractor = myRidesInteractor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
    }
    
    // MARK: - Public functions
    
    func numberOfRows() -> Int {
        return rides.count
    }
    
    func ride(indexPath: IndexPath) -> Ride {
        return rides[indexPath.row]
    }
    
    // MARK: - User Actions
    
    func didSelectRow(at indexPath: IndexPath) {
        let ride = rides[indexPath.row]
        // TODO: open ride detail
        view?.showAlert(type: .info,
                        title: "Ride selected",
                        message: "\(ride.circuit) - \(ride.date.toString(style: .short))",
                        completion: nil)
    }
    
    // MARK: - Private functions
    
    private func loadView() {
        view?.showLoader()
        myRidesInteractor
            .fetchRides()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] rides in
                self?.rides = rides
                self?.reloadTable.onNext(rides.count > 0)
                self?.view?.hideLoader()
                }, onError: { [weak self] error in
                    self?.view?.showAlert(type: .error,
                                          title: "Error".localized(),
                                          message: error.localizedDescription,
                                          completion: nil)
                    self?.view?.hideLoader()
            }).disposed(by: disposeBag)
    }
}
