//
//  MyBikeApp.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 8/12/24.
//

import SwiftUI

@main
struct MyBikeApp: App {
    
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ApplicationSwitcher()
                .environmentObject(authViewModel)
        }
    }
}
