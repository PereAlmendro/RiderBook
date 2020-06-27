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
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Button("Save") {
                            self.viewModel.submitAction()
                        }
                    }.padding(20)
                    
                    VStack(alignment: .center) {
                        Text("Select a date")
                            .font(.system(size: 20))
                            .padding(.horizontal)
                        
                        DatePicker("",
                                   selection: self.$viewModel.selectedDate, in: Date(timeIntervalSince1970: 0 )...,
                                   displayedComponents: .date).labelsHidden()
                        
                        // SWIFTUI BUG : PICKER DOES NOT REFRESH PROPERLY
                        // WORKAROUND : We show picker when flag is set to true
                        Text("Select a circuit")
                            .font(.system(size: 20))
                            .padding(.horizontal)
                        
                        if (self.viewModel.reloadPicker) {
                            Picker(selection: self.$viewModel.circuitIndex,
                                   label: Text("Select a circuit")) {
                                    ForEach(0 ..< self.viewModel.circuits.count) {
                                        Text(self.viewModel.circuits[$0].name)
                                    }
                            }
                            .labelsHidden()
                        }
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) { () -> Alert in
            Alert(title: Text(viewModel.alertTitle.localized()),
                  message: Text(viewModel.alertMessage.localized()),
                  dismissButton: .default(Text("Ok")))
        }
    }
}
