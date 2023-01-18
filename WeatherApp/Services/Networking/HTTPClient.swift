//
//  HTTPClient.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

protocol HTTPClient {
    func dispatch(request: URLRequest) async -> Result<Data, RequestError>
}

struct URLSessionHTTPClient: HTTPClient {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func dispatch(request: URLRequest) async -> Result<Data, RequestError> {
        do {
            let (data, response) = try await urlSession.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                return .failure(.errorCode(httpResponse.statusCode))
            }
            
            return .success(data)
        } catch {
            return .failure(.networkError(error))
        }
    }
}
