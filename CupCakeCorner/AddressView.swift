//
//  AddressView.swift
//  CupCakeCorner
//
//  Created by Mark Perryman on 5/25/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Place Order")
                }
            }
            .disabled(!order.hasValidAddress)
        }
        .navigationTitle("Address")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct AddressView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddressView()
//    }
//}
