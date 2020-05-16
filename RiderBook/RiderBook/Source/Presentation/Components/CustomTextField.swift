//
//  CustomTextField.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct CustomTextField: View {
    @State private var showPassword = false
    
    var text: Binding<String>
    var leftImageName: String = ""
    var textFieldPlaceholder: String = ""
    var secureField: Bool = false
    var keyboardType: UIKeyboardType = .default
    var onEditingChanged: (Bool) -> Void = { _ in }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                if !leftImageName.isEmpty {
                    Image(systemName: leftImageName)
                        .accentColor(.dlBlack)
                }
                
                if secureField {
                    
                    if showPassword {
                        TextField(textFieldPlaceholder.localized(), text: text, onEditingChanged: onEditingChanged)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .keyboardType(keyboardType)
                            .foregroundColor(.dlBlack)
                    } else {
                        SecureField(textFieldPlaceholder.localized(), text: text)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .keyboardType(keyboardType)
                            .foregroundColor(.dlBlack)
                    }
                    
                    Button(action: { self.showPassword.toggle() }) {
                        Image(systemName: "eye")
                            .foregroundColor(.dlBlack)
                    }
                } else {
                    
                    TextField(textFieldPlaceholder.localized(), text: text,
                              onEditingChanged: onEditingChanged)
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .keyboardType(keyboardType)
                        .foregroundColor(.dlBlack)
                    
                }
            }   .padding()
                .background(
                    CustomButtonBackground(shape: Capsule())
            )
        }
    }
}

#if DEBUG
struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""),
                        leftImageName: "",
                        secureField: true,
                        onEditingChanged: { _ in
                            print("Editing changed")
        })
    }
}
#endif
