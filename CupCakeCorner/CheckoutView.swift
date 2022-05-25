//
//  CheckoutView.swift
//  CupCakeCorner
//
//  Created by Mark Perryman on 5/25/22.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingAlert = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button(action: {
                    Task {
                        await placeOrder()
                    }
                }, label: {
                    Text("Place Order")
                })
            }
            .navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you!", isPresented: $showingAlert) {
                Button(action: {}, label: {
                    Text("OK")
                })
            } message: {
                Text(confirmationMessage)
            }
        }
    }

    func placeOrder() async {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(order) else {
            print("Failed to encode")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)

            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way."
            showingAlert.toggle()
        } catch {
            print("Checkout failed")
            confirmationMessage = "No Internet Connection Found"
            showingAlert.toggle()
        }
    }
}

//struct CheckoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckoutView()
//    }
//}
