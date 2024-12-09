//
//  MainRouter.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 7/11/24.
//

import Foundation
import SwiftUI

enum MainPath: Hashable {
    case home
}

class MainRouter: BaseRouter<MainPath> {
    @ViewBuilder func view(route: MainPath) -> some View {
        switch route {
        case .home:
            HomeScreen()
        }
    }
}
