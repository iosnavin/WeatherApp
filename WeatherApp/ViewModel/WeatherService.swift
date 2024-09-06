//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import UIKit

// MARK: - Weather Service

class WeatherService {
    func fetchWeather(latitude: Double, longitude: Double) async throws -> Result<WeatherResponse, Error> {
        let request = WeatherAPI(endpoint: .currentWeather(latitude: latitude, longitude: longitude)).urlRequest
        let weather: WeatherResponse = try await NetworkManager.request(request: request)
        return .success(weather)
    }
}
