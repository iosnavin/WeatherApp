//
//  Daily.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import UIKit

// MARK: - Daily

struct DailyForecast: Decodable {
    let timestamp: Int
    let temperature: Temp
    let feelsLike: FeelsLike
    let humidity: Int
    let weather: [WeatherCondition]

    enum CodingKeys: String, CodingKey {
        case timestamp = "dt"
        case temperature = "temp"
        case feelsLike = "feels_like"
        case humidity
        case weather
    }
}


// MARK: - FeelsLike
struct FeelsLike: Decodable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Decodable {
    let day, min, max, night: Double
    let eve, morn: Double
}
