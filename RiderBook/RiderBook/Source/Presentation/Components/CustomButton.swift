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
        Button(title.localized()) {
            self.action()
        }.frame(maxWidth: .infinity)
            .padding()
            .background(Color.init("emeraldGreen"))
            .cornerRadius(5)
            .foregroundColor(Color.white)
            .shadow(color: Color.black.opacity(0.2),
                    radius: 10, x: 10, y: 10)
            .padding()
    }
}

#if DEBUG
struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Button title", action: {
            
        })
    }
}
#endif
