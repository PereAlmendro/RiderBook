//
//  ProfileViewModel.swift
//  RiderBook
//
//  Created by Pere Almendro on 15/05/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI
import Combine
import UIKit

protocol ProfileViewModelProtocol: AnyObject {
    
}

final class ProfileViewModel: ObservableObject, ProfileViewModelProtocol  {
    
    // MARK: - View Properties
    
    @Published var showAlert = false
    @Published var showImagePicker = false
    @Published var inputImage: UIImage?
    @Published var image: Image?
    
    // MARK: - Private properties
    
    private let userService: UserServiceProtocol
    private let loginService: LoginServiceProtocol
    private let coordinator: AppCoordinatorProtocol
    private var cancellables: [AnyCancellable?] = []
    
    // MARK: - Lifecycle
    
    init(loginService: LoginServiceProtocol,
         userService: UserServiceProtocol,
         coordinator: AppCoordinatorProtocol) {
        self.loginService = loginService
        self.userService = userService
        self.coordinator = coordinator
    }
    
    // MARK: - Public functions
    
    func onImagePickerDismiss() {
        guard let inputImage = inputImage else {
            return
        }
        
        if inputImage.isBiggerThan(megabytes: 5.0) {
            self.inputImage = nil
            image = nil
            showAlert.toggle()
        } else {
            image = Image(uiImage: inputImage)
        }
        
        // TODO: - Upload image to the server
    }
    
    func createAlert() -> Alert {
        return Alert(title: Text("T_Imagen demasiado grande".localizedString()),
                     message: Text("T_Por favor, selecciona una imagen inferior a 5MB".localizedString()),
                     dismissButton: .default(Text("T_Ok".localizedString())))
    }
    
    // MARK: - User Actions
    
    func logoutAction() {
        if loginService.logOut() {
            coordinator.start()
        } else {
            // TODO: - Logout failed
        }
    }
    
    func deleteAccountAction() {
        // TODO: - Delete account action
    }
    
    func uploadImageAction() {
        showImagePicker.toggle()
    }
}
