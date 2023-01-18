//
//  APIClient.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation


class APIClient {
    private let baseURL: String
    private let httpClient: HTTPClient
    private let jsonDecoder: JSONDecoder = .init()
    
    init(baseURL: String = Constants.WeatherAPI.baseURL,
         httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.baseURL = baseURL
        self.httpClient = httpClient
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func getWeather(lat: Double, lon: Double, units: WeatherUnits) async -> Result<WeatherResponse, RequestError> {
        let request = WeatherRequest(lat: lat, lon: lon, units: units.rawValue)
        
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            return .failure(.invalidRequest)
        }
        let result = await httpClient.dispatch(request: urlRequest)
        return decode(from: result)
    }
    
    private func decode<Response:Decodable>(from result: Result<Data, RequestError>) -> Result<Response, RequestError> {
        do {
            let data = try result.get()
            let decoded = try jsonDecoder.decode(Response.self, from: data)
            return .success(decoded)
        } catch let error as RequestError {
            return .failure(error)
        } catch is DecodingError {
            return .failure(RequestError.decodingError)
        } catch {
            return .failure(RequestError.unknownError)
        }
    }
}
