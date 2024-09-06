//
//  Weather.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import UIKit

// MARK: - Weather

struct WeatherCondition: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherData {
    let date: Date?
    let title: String
    let imageData: Data?
    let hourly: [CurrentWeather]?
}

