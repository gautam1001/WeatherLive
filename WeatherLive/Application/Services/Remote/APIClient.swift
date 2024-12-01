//
//  APIClient.swift
//  WeatherLive
//
//  Created by Prashant Gautam on 01/12/24.
//

import Foundation
import Combine

protocol APIClientInterface {
    func request<T: Decodable>(url:String, type: T.Type, decoder: JSONDecoder) -> AnyPublisher<T,Error>
}

public class APIClient: APIClientInterface {

    func request<T:Decodable>(url:String, type: T.Type, decoder: JSONDecoder) -> AnyPublisher<T,Error> {
        
        guard let url = URL(string: url) else { return Fail(error: NetworkError.badRequest).eraseToAnyPublisher() }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ data, response in
                print("Api called")
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
                }
                return data
            })
            .retry(1)
            .decode(type: type.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

