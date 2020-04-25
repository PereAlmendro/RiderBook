//
//  AddRideView.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct AddRideView: View {
    @ObservedObject var viewModel: AddRideViewModel

    var body: some View {
        LoadingView(isShowing: $viewModel.loading) {
            VStack(alignment: .center) {
                Form {
                    Text("Select a date").font(.headline).padding()
                    DatePicker("", selection: self.$viewModel.selectedDate, in: Date()...,
                               displayedComponents: .date)
                        .labelsHidden()
                    
                    // SWIFTUI BUG : PICKER DOES NOT REFRESH PROPERLY
                    // WORKAROUND : We show picker when flag is set to true
                    Text("Select a circuit").font(.headline).padding()
                    if (self.viewModel.reloadPicker) {
                        Picker(selection: self.$viewModel.circuitIndex,
                               label: Text("Select a circuit")) {
                                ForEach(0 ..< self.viewModel.circuits.count) {
                                    Text(self.viewModel.circuits[$0].name)
                                }
                        }.labelsHidden()
                        .pickerStyle(WheelPickerStyle())
                    }
                }.listStyle(GroupedListStyle())
                 
                CustomButton(title: "Add_ride" , action: {
                    self.viewModel.addRideAction()
                })
            }
        }
    }
}

struct AddRideView_Previews: PreviewProvider {
    static let fakeCoordinator = AppCoordinator(window: UIWindow())
    static let addRideAssembly = AddRideAssembly(coordinator: fakeCoordinator)
    
    static var previews: some View {
        addRideAssembly.getView()
    }
}
