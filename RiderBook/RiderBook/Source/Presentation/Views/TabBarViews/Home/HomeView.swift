//
//  HomeView.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack {
            Text("Home View")
        }.navigationBarTitle("Rider_book".localized())
    }
}
