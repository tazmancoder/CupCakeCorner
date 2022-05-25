//
//  ContentView.swift
//  CupCakeCorner
//
//  Created by Mark Perryman on 5/23/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var order: Order

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes \(order.quantity)", value: $order.quantity, in: 3...20)
                }

                Section {
                    Toggle("Any Special Requests", isOn: $order.specialRequestEnable.animation())

                    if order.specialRequestEnable {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }

                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
