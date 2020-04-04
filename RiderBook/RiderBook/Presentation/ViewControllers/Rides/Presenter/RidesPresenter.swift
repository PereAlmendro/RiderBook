//
//  RidesPresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 29/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import RxSwift

class RidesPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let myRidesRouter: RidesRouter
    private let myRidesInteractor: RidesInteractor
    private var rides: [Ride] = []
    
    var screenTitle: String? {
        return "rides".localized()
    }
    
    // MARK: - Rx Properties
    
    var reloadTable: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
    // MARK: - Lyfecycle
    
    init(myRidesRouter: RidesRouter, myRidesInteractor: RidesInteractor) {
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
        myRidesRouter.showRide(ride:ride)
    }
    
    // MARK: - Private functions
    
    private func loadView() {
        myRidesInteractor
            .fetchRides()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .showLoader(view: view)
            .subscribe(onSuccess: { [weak self] rides in
                self?.rides = rides
                self?.reloadTable.onNext(rides.count > 0)
                }, onError: { [weak self] error in
                    self?.view?.showAlert(type: .error,
                                          title: "Error".localized(),
                                          message: error.localizedDescription,
                                          completion: nil)
            }).disposed(by: disposeBag)
    }
}
