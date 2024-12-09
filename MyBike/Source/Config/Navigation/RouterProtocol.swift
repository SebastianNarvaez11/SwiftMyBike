//
//  RouterProtocol.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 5/11/24.
//

import Foundation
import SwiftUI

protocol RouterProtocol: ObservableObject {
    var path: NavigationPath { get set }
    
    associatedtype Route: Hashable
    associatedtype ViewType: View
    
    @ViewBuilder func view(route:Route) -> ViewType
    
    func navigateTo(route:Route)
    func navigateBack()
    func popToRoot()
}
