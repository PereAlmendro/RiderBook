//
//  ProfileView.swift
//  RiderBook
//
//  Created by Pere Almendro on 11/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack(alignment: .center, spacing: 20) {
                        VStack(alignment: .center, spacing: 5) {
                            if viewModel.image != nil {
                                viewModel.image!
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .frame(width: 100, height: 100, alignment: .center)
                            } else {
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .frame(width: 100, height: 100, alignment: .center)
                            }
                            
                            Button("Upload_image".localized()) {
                                self.viewModel.uploadImageAction()
                            }
                        }
                        Text("Pere Almendro").foregroundColor(Color.dlBlack)
                    }
                }
                
                Section {
                    Button("Logout".localized()) {
                        self.viewModel.logoutAction()
                    }
                }
                
                Section(header: Text("Leave_biker_comunity".localized()).foregroundColor(Color.dlBlack)) {
                    Button("Delete_account".localized()) {
                        self.viewModel.deleteAccountAction()
                    }.foregroundColor(Color.red)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Profile".localized())
        }
        .sheet(isPresented: $viewModel.showImagePicker,
               onDismiss: viewModel.onImagePickerDismiss) {
            ImagePicker(image: self.$viewModel.inputImage)
        }
        .alert(isPresented: $viewModel.showAlert) { () -> Alert in
            viewModel.createAlert()
        }
    }
}
