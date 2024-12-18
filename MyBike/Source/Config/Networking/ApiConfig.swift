//
//  ApiConfig.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 8/12/24.
//

import Foundation

struct ApiConfig {
//    todo: por alguna razon cuando esta en release la app instalada no lees las variables de los esquemas,
//    hay que comprobar si cuando se instalandesde yiendas si las leen, aqui no deben quedar variable quemadas
    static var baseURL: String = ProcessInfo.processInfo.environment["BASE_URL"] ?? "https://lmalplciptyqoodqxvof.supabase.co"
    static let apiKeySupabase: String = ProcessInfo.processInfo.environment["SUPABASE_APIKEY"] ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxtYWxwbGNpcHR5cW9vZHF4dm9mIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM2MDYyMzQsImV4cCI6MjA0OTE4MjIzNH0.qfiOHo-wIItLI2vHjIgTa4KFKRtZplM70Hd30-k0zFg"
}
