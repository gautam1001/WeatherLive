//
//  MockJSON.swift
//  WeatherLive
//
//  Created by Prashant Gautam on 01/12/24.
//

import Foundation

class MockJSON {
    
    static func citySearchData() -> Data {
        "[{\"id\":9005075,\"name\":\"Indira Gandhi International Airport\",\"region\":\"Delhi\",\"country\":\"India\",\"lat\":28.57,\"lon\":77.1,\"url\":\"indira-gandhi-international-airport-delhi-india\"}]".data(using: .utf8)!
    }
}
