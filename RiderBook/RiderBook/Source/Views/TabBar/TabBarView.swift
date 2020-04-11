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
    let homeView: HomeView
    let ridesView: RidesView
    let profileView: ProfileView
    
    var body: some View {
        TabView {
            homeView
                .tabItem {
                    Image("home_off")
            }
            ridesView
                .tabItem {
                    Image("road_off")
            }
            profileView
                .tabItem {
                    Image("profile_off")
            }
        }
    }
}

#if DEBUG
struct TabBarView_Previews: PreviewProvider {
    static let homeView = HomeView()
    static let ridesView = RidesView()
    static let profileView = ProfileView()
    
    static var previews: some View {
        TabBarView(homeView: homeView, ridesView: ridesView, profileView: profileView)
    }
}
#endif
