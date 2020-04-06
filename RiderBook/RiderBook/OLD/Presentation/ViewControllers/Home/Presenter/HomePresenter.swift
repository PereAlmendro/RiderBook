//
//  HomePresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class HomePresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let homeRouter: HomeRouter
    private let homeInteractor: HomeInteractor
    
    var screenTitle: String? {
        return "Rider_book".localized()
    }
    
    // MARK: - Rx Properties
    
    var lastRide: BehaviorSubject<Ride?> = BehaviorSubject<Ride?>(value: nil)
    private var lastRideValue: Ride? {
        return try? lastRide.value()
    }
    
    // MARK: - Lifecycle
    
    init(homeRouter: HomeRouter, homeInteractor: HomeInteractor) {
        self.homeRouter = homeRouter
        self.homeInteractor = homeInteractor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
    }
    
    // MARK: - User Actions
    
    func tapOnProfile() {
        homeRouter.showProfile()
    }
    
    func tapOnCalendar() {
        if let lastRide = lastRideValue {
            homeRouter.showLastRideDetail(lastRide)
        }
    }
    
    // MARK: - Private functions
    
    private func loadView() {
        homeInteractor
            .fetchLastRide()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .showLoader(view: view)
            .subscribe(onSuccess: { [weak self] lastRide in
                self?.lastRide.onNext(lastRide)
                self?.view?.hideLoader()
            }) { [weak self] error in
                self?.view?.showAlert(type: .error,
                                      title: "Error".localized(),
                                      message: error.localizedDescription,
                                      completion: nil)
                self?.view?.hideLoader()
        }.disposed(by: disposeBag)
    }
}
