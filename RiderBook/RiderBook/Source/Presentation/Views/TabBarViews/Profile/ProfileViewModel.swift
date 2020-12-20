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
    @Published var userName: String = ""
    
    // MARK: - Private properties
    
    private var alertTitle: String = ""
    private var alertMessage: String = ""
    private let userService: UserServiceProtocol
    private let loginService: LoginServiceProtocol
    private var cancellables: [AnyCancellable?] = []
    
    // MARK: - Lifecycle
    
    init(loginService: LoginServiceProtocol,
         userService: UserServiceProtocol) {
        self.loginService = loginService
        self.userService = userService
    }
    
    // MARK: - Private functions
    
    private func uploadImage(image: UIImage) {
        cancellables += [
            userService
                .uploadImage(image: image)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .failure(let error):
                        self?.alertTitle = "Error".localizedString()
                        self?.alertMessage = "\(error.description()), \(error.localizedDescription)"
                        self?.showAlert.toggle()
                        break
                    case .finished:
                        break
                    }
                    }, receiveValue: { [weak self] (success) in
                        if !success {
                            self?.inputImage = nil
                            self?.image = nil
                            self?.alertTitle = "Error".localizedString()
                            self?.alertMessage = "image upload failed, please try again later or choose another image".localizedString()
                            self?.showAlert.toggle()
                        }
                })
        ]
    }
    
    // MARK: - Public functions
    
    func loadUserData() {
        guard let user = userService.getUser() else { return }
        userName = user.name
        
        DispatchQueue.global().async {
            if let url = URL(string: user.photoUrl),
                let data = try? Data(contentsOf: url),
                let uiImage = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = Image(uiImage: uiImage)
                }
            }
        }
    }
    
    func onImagePickerDismiss() {
        guard let inputImage = inputImage else {
            return
        }
        
        if inputImage.isBiggerThan(megabytes: 5.0) {
            self.inputImage = nil
            image = nil
            alertTitle = "T_Imagen demasiado grande".localizedString()
            alertMessage = "T_Por favor, selecciona una imagen inferior a 5MB".localizedString()
            showAlert.toggle()
        } else {
            image = Image(uiImage: inputImage)
            uploadImage(image: inputImage)
        }
    }
    
    func createAlert() -> Alert {
        return Alert(title: Text(alertTitle),
                     message: Text(alertMessage),
                     dismissButton: .default(Text("T_Ok".localizedString())))
    }
    
    // MARK: - User Actions
    
    func logoutAction() {
        loginService.logOut()
//        coordinator.start()
    }
    
    func deleteAccountAction() {
        guard let user = userService.getUser() else { return }
        cancellables += [
            userService
                .deleteUser(user)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] (completion) in
                    switch completion {
                    case .failure(let error):
                        self?.alertTitle = "Error".localizedString()
                        self?.alertMessage = "\(error.description()), \(error.localizedDescription)"
                        self?.showAlert.toggle()
                        break
                    case .finished:
                        break
                    }
                    }, receiveValue: { [weak self] (success) in
                        if success {
//                            self?.coordinator.start()
                        } else {
                            self?.inputImage = nil
                            self?.image = nil
                            self?.alertTitle = "T_Oops".localizedString()
                            self?.alertMessage = "T_algo a ido mal, por favor, prueba mas tarde".localizedString()
                            self?.showAlert.toggle()
                        }
                })
        ]
    }
    
    func uploadImageAction() {
        showImagePicker.toggle()
    }
}
