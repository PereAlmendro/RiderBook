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
                    DatePicker("Select a date",
                               selection: .constant(Date()), in: ...Date(),
                               displayedComponents: .date)
                }
                
                Spacer()
                 
                CustomButton(title: "Add_ride" , action: {
                    self.viewModel.addRideAction()
                })
            }
        }
        .alert(isPresented: .constant(false)) { () -> Alert in
            Alert(title: Text("viewModel.errorTitle.localized()"),
                  message: Text("viewModel.errorMessage"),
                  dismissButton: .default(Text("Ok")))
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
