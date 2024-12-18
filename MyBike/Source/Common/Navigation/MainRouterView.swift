//
//  MainRouterView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/11/24.
//

import Foundation
import SwiftUI

struct MainRouterView<Content: View>: View {
    @StateObject private var router: MainRouter = MainRouter()
    
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content){
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: MainRouter.Route.self) { route in
                router.view(route: route)
            }
        }
        .environmentObject(router)
    }
}
