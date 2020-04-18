//
//  CustomTextField.swift
//  RiderBook
//
//  Created by Pere Almendro on 17/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    var text: Binding<String>
    var textFieldPlaceholder: String = ""
    var secureField: Bool = false
    var keyboardType: UIKeyboardType = .default
    var onEditingChanged: (Bool) -> Void = { _ in }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title.localized())
                .font(.system(size: 20, weight: .bold, design: .rounded))
            
            if secureField {
                SecureField(textFieldPlaceholder.localized(), text: text)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color.black)
                    .lineLimit(0)
                    .keyboardType(keyboardType)
                    .shadow(color: Color.black.opacity(0.2),
                            radius: 10, x: 10, y: 10)
            } else {
                TextField(textFieldPlaceholder.localized(), text: text,
                          onEditingChanged: onEditingChanged)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color.black)
                    .lineLimit(0)
                    .keyboardType(keyboardType)
                    .shadow(color: Color.black.opacity(0.2),
                            radius: 10, x: 10, y: 10)
            }
        }.padding()
    }
}

#if DEBUG
struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(title: "TextFieldTitle",
                        text: .constant(""),
                        secureField: true,
                        onEditingChanged: { _ in
                            print("Editing chang[ed")
        })
    }
}
#endif