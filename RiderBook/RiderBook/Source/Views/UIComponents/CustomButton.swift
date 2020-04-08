//
//  CustomButton.swift
//  RiderBook
//
//  Created by Pere Almendro on 07/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Text(title)
                .foregroundColor(Color.white)
        })
            .padding(20)
            .frame(width: UIScreen.main.bounds.size.width - 40,
                   alignment: .center)
            .background(Color.init("emeraldGreen"))
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.2),
                    radius: 10, x: 10, y: 10)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Button title", action: {
            
        })
    }
}
