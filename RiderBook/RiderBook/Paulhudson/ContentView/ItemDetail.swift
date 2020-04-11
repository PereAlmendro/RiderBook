//
//  ItemDetail.swift
//  RiderBook
//
//  Created by Pere Almendro on 06/04/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import SwiftUI

struct ItemDetail: View {
    @EnvironmentObject var order: Order
    var item: MenuItem
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }
            
            Text(item.description)
                .padding()
            
            
            HStack(alignment: .center, spacing: 30) {
                
                Button("Order this") {
                    self.order.add(item: self.item)
                }.padding()
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                
                Button("Add to favourites") {

                }.padding()
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                
            }.frame(width: UIScreen.main.bounds.size.width,
                    alignment: .center)
            .padding()
            
        }.navigationBarTitle(Text(item.name), displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: FavouritesView()) {
                    Text("Favourites")
            })
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        ItemDetail(item: MenuItem.example).environmentObject(order)
    }
}
