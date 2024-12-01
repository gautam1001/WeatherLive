//
//  NetworkError.swift
//  WeatherLive
//
//  Created by Prashant Gautam on 01/12/24.
//

import Foundation

// Define an enum to represent different HTTP errors
enum NetworkError: Error {
    case badRequest // 400
    case unauthorized // 401
    case forbidden // 403
    case notFound // 404
    case methodNotAllowed // 405
    case requestTimeout // 408
    case internalServerError // 500
    case notImplemented // 501
    case badGateway // 502
    case serviceUnavailable // 503
    case gatewayTimeout // 504
    case unknown(code: Int) // For unexpected status codes

    // Initialize the enum based on an HTTP status code
    init(statusCode: Int) {
        switch statusCode {
        case 400:
            self = .badRequest
        case 401:
            self = .unauthorized
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 405:
            self = .methodNotAllowed
        case 408:
            self = .requestTimeout
        case 500:
            self = .internalServerError
        case 501:
            self = .notImplemented
        case 502:
            self = .badGateway
        case 503:
            self = .serviceUnavailable
        case 504:
            self = .gatewayTimeout
        default:
            self = .unknown(code: statusCode)
        }
    }
}


