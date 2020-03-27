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
    
    var lasCalendarEvent: BehaviorSubject<CalendarEvent?> = BehaviorSubject<CalendarEvent?>(value: nil)
    
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
        homeInteractor
            .fetchLastEvent()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] calendarEvent in
                self?.lasCalendarEvent.onNext(calendarEvent)
            }) { error in
                // TODO: - Handle error
        }.disposed(by: disposeBag)
    }
}
