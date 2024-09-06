//
//  Current.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import UIKit

// MARK: - Current

struct CurrentWeather: Decodable {
    let timestamp: Int
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [WeatherCondition]

    enum CodingKeys: String, CodingKey {
        case timestamp = "dt"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

