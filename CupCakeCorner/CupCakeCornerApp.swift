//
//  CupCakeCornerApp.swift
//  CupCakeCorner
//
//  Created by Mark Perryman on 5/23/22.
//

import SwiftUI

@main
struct CupCakeCornerApp: App {
    @StateObject var order = Order()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(order)
        }
    }
}
