//
//  ApiResourceProtocol.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 6/11/24.
//

import Foundation

protocol ApiResourceProtocol {
    associatedtype ResponseType: Decodable
    var baseURL: String? { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension ApiResourceProtocol {
    
    var baseURL: String? {
        return nil
    }
    
    var resolvedBaseURL: String {
        return baseURL ?? ApiConfig.baseURL
    }
    
    var url: URL {
        var components = URLComponents(string: self.resolvedBaseURL)!
        components.path = self.path
        
        // Si hay queryItems, los añadimos
        if let queryItems = queryItems {
            components.queryItems = queryItems
        }
        
        // Intentamos obtener la URL de los componentes
        guard let url = components.url else {
            fatalError("Url no valida para la ruta: \(self.path)")
        }
        
        return url
    }
}
