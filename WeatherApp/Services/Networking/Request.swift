//
//  Request.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

protocol Request {
    associatedtype ResponseType: Codable
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [HTTPHeader]? { get }
    var queries: [String: String]? { get }
    var body: [String: Any]? { get }
}

extension Request {
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        
        if method == .GET, let queries = queries {
            urlComponents.queryItems = queries.map { URLQueryItem(name: $0, value: $1) }
        }
        
        urlComponents.path = "\(urlComponents.path)\(path)"
        
        guard let finalURL = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = method.rawValue
        headers?.forEach { header in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.field.rawValue)
        }
        if method == .POST, let body = body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return urlRequest
    }
}
