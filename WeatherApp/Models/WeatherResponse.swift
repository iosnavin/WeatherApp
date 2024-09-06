//
//  ViewController.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import UIKit

// MARK: - Weather Response

struct WeatherResponse: Decodable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentWeather
    let hourly: [CurrentWeather]

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case hourly = "hourly"
        case timezone
        case timezoneOffset = "timezone_offset"
        case current
    }
}

