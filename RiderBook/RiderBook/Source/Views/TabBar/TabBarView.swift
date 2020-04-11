//
//  TabBarView.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import Foundation

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image("home_off")
            }
            RidesView()
                .tabItem {
                    Image("road_off")
            }
            ProfileView()
                .tabItem {
                    Image("profile_off")
            }
        }
    }
}

#if DEBUG
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
#endif
