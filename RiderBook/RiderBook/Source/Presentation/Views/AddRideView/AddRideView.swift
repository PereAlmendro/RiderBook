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
                List {
                    
                    Text("Select a date").font(.headline).padding()
                    
                    DatePicker("", selection: .constant(Date()), in: Date()...,
                               displayedComponents: .date)
                        .labelsHidden()
                    
                    Text("Select a circuit").font(.headline).padding()
                    
                    // SWIFT UI BUG : PICKER DOES NOT REFRESH
                    Picker(selection: self.$viewModel.selectedCircuit,
                           label: Text("Select a circuit")) {
                            ForEach(self.viewModel.circuits, id: \.self) { circuit in
                                Text(circuit.name)
                            }
                    }.labelsHidden()
                }
                
                Spacer()
                 
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
