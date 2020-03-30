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
    
    // MARK: - Rx Properties
    
    var lastCalendarEvent: BehaviorSubject<Ride?> = BehaviorSubject<Ride?>(value: nil)
    
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
        homeRouter.showCalendar()
    }
    
    // MARK: - Private
    
    func loadView() {
        view?.hideLoader()
        homeInteractor
            .fetchLastRide()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] calendarEvent in
                self?.lastCalendarEvent.onNext(calendarEvent)
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
