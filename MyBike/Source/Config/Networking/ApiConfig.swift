//
//  ApiConfig.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 8/12/24.
//

import Foundation

struct ApiConfig {
    static var baseURL: String = ProcessInfo.processInfo.environment["BASE_URL"] ?? ""
    static let apiKeySupabase: String = ProcessInfo.processInfo.environment["SUPABASE_APIKEY"] ?? ""
}
