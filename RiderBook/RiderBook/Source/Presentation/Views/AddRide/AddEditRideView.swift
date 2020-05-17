//
//  AddEditRideView.swift
//  RiderBook
//
//  Created by Pere Almendro on 19/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct AddEditRideView: View {
    @ObservedObject var viewModel: AddEditRideViewModel

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
                 
                Button("Save") {
                    self.viewModel.submitAction()
                }.buttonStyle(CustomButtonStyle())
            }
        }
        .alert(isPresented: $viewModel.showAlert) { () -> Alert in
            Alert(title: Text(viewModel.alertTitle.localized()),
                  message: Text(viewModel.alertMessage.localized()),
                  dismissButton: .default(Text("Ok")))
        }
    }
}
