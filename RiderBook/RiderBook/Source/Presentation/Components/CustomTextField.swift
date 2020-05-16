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
    var textFieldPlaceholder: String = ""
    var secureField: Bool = false
    var keyboardType: UIKeyboardType = .default
    var onEditingChanged: (Bool) -> Void = { _ in }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if secureField {
                    Image(systemName: "lock")
                        .accentColor(.dlBlack)
                    if showPassword {
                        TextField("", text: text, onEditingChanged: onEditingChanged)
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
                    Image(systemName: "person")
                        .accentColor(.dlBlack)
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
                        secureField: true,
                        onEditingChanged: { _ in
                            print("Editing changed")
        })
    }
}
#endif
