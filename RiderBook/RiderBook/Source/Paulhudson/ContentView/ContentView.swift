//
//  ContentView.swift
//  RiderBook
//
//  Created by Pere Almendro on 06/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
    
    var body: some View {
        NavigationView  {
            List {
                ForEach(menu, id: \.self) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items, id: \.self) { item in
                            ItemRow(item: item)
                        }
                    } }
            }
            .navigationBarTitle("Menu")
            .listStyle(GroupedListStyle())
        }
    }
}

struct contentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
