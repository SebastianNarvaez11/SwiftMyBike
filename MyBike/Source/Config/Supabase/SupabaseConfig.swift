//
//  SupabaseConfig.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 15/12/24.
//

import Foundation
import Supabase

let supabaseClient = SupabaseClient(supabaseURL: URL(string: ApiConfig.baseURL)!, supabaseKey: ApiConfig.apiKeySupabase)
