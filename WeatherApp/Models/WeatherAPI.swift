//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import UIKit

// MARK: - Weather API

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String] { get }
    var parameters: [String: String] { get }
    var urlRequest: URLRequest { get }
}

extension Endpoint {
    var urlRequest: URLRequest {
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            return request
        }
        
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components.url else {
            return request
        }
        
        request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        return request
    }
}

struct WeatherAPI: Endpoint {
    let baseURL: URL
    let path: String
    let method: String = "GET"
    let headers: [String: String] = [:]
    let parameters: [String: String]
    private static let apiKey = Constants.Strings.keyAPI
    private static let baseAPIURL = Constants.Strings.url

    enum Endpoints {
        case currentWeather(latitude: Double, longitude: Double)
    }

    init(endpoint: Endpoints) {
        self.baseURL = URL(string: WeatherAPI.baseAPIURL)!
        switch endpoint {
        case .currentWeather(let latitude, let longitude):
            self.path = "/onecall"
            self.parameters = [
                "lat": "\(latitude)",
                "lon": "\(longitude)",
                "appid": WeatherAPI.apiKey,
                "exclude": "minutely",
                "units": "metric"
            ]
        }
    }
}
