//
//  RideDetailPresenter.swift
//  RiderBook
//
//  Created by Pere Almendro on 03/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

class RideDetailPresenter: BasePresenter {
    
    // MARK: - Properties
    
    private let rideDetailRouter: RideDetailRouter
    private let rideDetailInteractor: RideDetailInteractor
    
    // MARK: - Outcomming params
    
    var ride: Ride?
    
    // MARK: - Lyfecycle
    
    init(rideDetailRouter: RideDetailRouter, rideDetailInteractor: RideDetailInteractor) {
        self.rideDetailRouter = rideDetailRouter
        self.rideDetailInteractor = rideDetailInteractor
    }
    
    // MARK: - User actions
    
    func didSelect(lap: Lap) {
        // TODO : Show edit, delete or create Alert
    }
    
    func showRank() {
        guard let ride = ride else { return }
        rideDetailRouter.showRanking(for: ride)
    }
    
    func showRankInfo() {
        view?.showAlert(type: .info,
                        title: "Ranking",
                        message: """
        Podéis hacer un ranking entre companyeros moteros siguiendo estos 4 pasos

        - Registraros todos en la aplicacion. ¡es gratis!

        - Uno de vosotros debe crear el grupo desde Perfil/Grupos e invitar a los demás.

        - Agendar en el calendario la misma rodada.
        
        - Después de añadir cada uno sus tiempos por vuelta, se hará el ranking con los mejores tiempos de cada uno.

        El ranking lo podreis consultar a través del detalle de la rodada o desde el dashboard.
        
        """, completion: nil)
    }
}
