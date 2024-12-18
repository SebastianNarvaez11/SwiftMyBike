
//  ApiError.swift
//  MyBike
//
//  Created by Sebastian on 2/09/24.
//

import Foundation

enum APIError: LocalizedError {
    case serverError(message: String)
    case decodingError
    case encodingError
    case unauthorized
    case unknownError

    var errorDescription: String? {
        switch self {
        case .serverError(let message):
            return message
        case .decodingError:
            return "Ocurrio un error al decodificar la respuesta."
        case .encodingError:
            return "Ocurrio un error al codificar el cuerpo de la solicitud."
        case .unauthorized:
            return "Error de autorizacion en la solicitud"
        case .unknownError:
            return "Error desconocido."
        }
    }
}
