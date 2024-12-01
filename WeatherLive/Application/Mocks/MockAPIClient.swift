//
//  MockAPIClient.swift
//  WeatherLive
//
//  Created by Prashant Gautam on 01/12/24.
//

import Foundation
import Combine

public class MockAPIClient: APIClientInterface {
    
    var mockURL: String?
    
    func request<T: Decodable>(url:String, type: T.Type, decoder: JSONDecoder) -> AnyPublisher<T,Error> {
        guard let url = URL(string: mockURL ?? url) else { return Fail(error: NetworkError.badRequest).eraseToAnyPublisher() }
        
        var request = URLRequest(url: url)
        request.addValue("no-store", forHTTPHeaderField: "Cache-Control")
        
        return URLSession.mock.dataTaskPublisher(for: request)
            .tryMap({ data, response in
                print("Mock Api called")
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
                }
                return data
            })
            .decode(type: type.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func clean() {
        mockURL = nil
        MockURL.mockResponses.removeAll()
    }
}
