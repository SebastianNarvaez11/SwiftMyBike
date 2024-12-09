//
//  BaseRouter.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 5/11/24.
//

import Foundation
import SwiftUI

@Observable class BaseRouter<RouteType: Hashable>: RouterProtocol {
    var path: NavigationPath = NavigationPath()
    
    @ViewBuilder func view(route:RouteType) -> some View {
        fatalError("Implement `view(for:)` in subclass")
    }
    
    func navigateTo(route: RouteType) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
