//
//  CustomButton.swift
//  RiderBook
//
//  Created by Pere Almendro on 07/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct CustomButtonBackground<S: Shape>: View {
    var shape: S
    var body: some View {
        ZStack {
            shape
                .fill(Color.dlBackgroundWhite)
                .shadow(color: Color.dlShadowBlack.opacity(0.2),
                        radius: 10, x: 10, y: 10)
                .shadow(color: Color.dlShadowWhite.opacity(0.7),
                        radius: 10, x: -5, y: -5)
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                CustomButtonBackground(shape: RoundedRectangle(cornerRadius: 10))
        )
    }
}
