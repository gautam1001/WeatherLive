//
//  MockURLSession.swift
//  WeatherLive
//
//  Created by Prashant Gautam on 01/12/24.
//

import Foundation

class MockURL: URLProtocol {
    
    static var mockResponses: [URL: (response: HTTPURLResponse, data: Data?)] = [:]

    override class func canInit(with request: URLRequest) -> Bool {
        return true // Handle all requests
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let url = request.url else {
            client?.urlProtocol(self, didFailWithError: URLError(.badURL))
            return
        }

        if let mockResponse = MockURL.mockResponses[url] {
            client?.urlProtocol(self, didReceive: mockResponse.response, cacheStoragePolicy: .notAllowed)
            if let data = mockResponse.data {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        } else {
            client?.urlProtocol(self, didFailWithError: URLError(.unsupportedURL))
        }
    }

    override func stopLoading() {
        // No cleanup needed for mock
    }
    
    static func setupMockResponse(for url: String, statusCode: Int, data: Data?) {
        let mockURL = URL(string: url)!
        let response = HTTPURLResponse(url: mockURL, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        MockURL.mockResponses[mockURL] = (response, data)
    }
}


extension URLSession {
    
    static var mock: URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURL.self]
        return URLSession(configuration: configuration)
    }
}




