//
//  ApiEndPoint.swift
//  WeatherLive
//
//  Created by Prashant Gautam on 01/12/24.
//

import Foundation

enum ApiEndPoint {
    
    case searchCity(String)
    case forecast(String)
    
   private var endpoint: String {
        switch self {
        case .searchCity(let text): return "/search.json?key=\(AppEnvironment.apikey)&q=\(text)"
        case .forecast(let city): return "/forecast.json?key=\(AppEnvironment.apikey)&q=\(city)"
        }
    }
    
    var url: String {
        return "\(AppEnvironment.baseURL)\(endpoint)"
    }
}
