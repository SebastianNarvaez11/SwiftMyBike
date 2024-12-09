//
//  AuthRouter.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 5/11/24.
//

import Foundation
import SwiftUI

enum AuthPath: Hashable {
    case login
    case register
}

class AuthRouter: BaseRouter<AuthPath> {
    
    @ViewBuilder func view(route: AuthPath) -> some View {
        switch route {
        case .login:
            LoginScreen()
        case .register:
            RegisterScreen()
        }
    }
}
