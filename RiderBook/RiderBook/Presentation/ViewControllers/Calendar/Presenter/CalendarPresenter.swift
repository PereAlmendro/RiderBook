//
//  CalendarPresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class CalendarPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let calendarRouter: CalendarRouter
    private let calendarInteractor: CalendarInteractor
    private var rides: [Ride] = []
    
    var screenTitle: String? {
        return "Calendar".localized()
    }
    
    // MARK: - Rx Properties
    
    var reloadCalendar: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    var selectedDayRides: BehaviorSubject<[Ride]> = BehaviorSubject<[Ride]>(value: [])
    
    // MARK: - Lifecycle
    
    init(calendarRouter: CalendarRouter, calendarInteractor: CalendarInteractor) {
        self.calendarRouter = calendarRouter
        self.calendarInteractor = calendarInteractor
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        loadView()
    }
    
    // MARK: - Public functions
    
    func numberOfRides(for date: Date) -> Int {
        return rides.filter({
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }).count
    }
    
    func hasRides() -> Bool {
        return rides.count > .zero ? true : false
    }
    
    // MARK: - User Actions
    
    func addButtonAction() {
        calendarRouter.showAddRide()
    }
    
    func didSelectDate(date: Date) {
        let ridesInDate = rides.filter { $0.date.toString(style: .short) == date.toString(style: .short) }
        self.selectedDayRides.onNext(ridesInDate)
    }
    
    func didSelectRide(ride: Ride) {
        // TODO: Open ride detail
    }
    
    // MARK: - Private functions
    
    private func loadView() {
        calendarInteractor
            .fetchRides()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .showLoader(view: view)
            .subscribe(onSuccess: { [weak self] rides in
                self?.rides = rides
                self?.reloadCalendar.onNext(rides.count > 0)
                }, onError: { [weak self] error in
                    self?.view?.showAlert(type: .error,
                                          title: "Error".localized(),
                                          message: error.localizedDescription,
                                          completion: nil)
            }).disposed(by: disposeBag)
    }
}
