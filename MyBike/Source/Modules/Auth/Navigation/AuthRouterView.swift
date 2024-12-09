//
//  AuthRouterView.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 5/11/24.
//

import Foundation
import SwiftUI

struct AuthRouterView<Content: View>: View {
    @StateObject private var router: AuthRouter = AuthRouter()
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content){
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content.navigationDestination(for: AuthRouter.Route.self) { route in
                router.view(route: route)
            }
        }
        .environmentObject(router)
    }
}
