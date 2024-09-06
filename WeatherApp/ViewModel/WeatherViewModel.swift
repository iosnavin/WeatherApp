//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import SwiftUI
import CoreLocation
import Combine

// MARK: - Weather View Model

@MainActor
class WeatherViewModel: ObservableObject {
    private let weatherService: WeatherService
    @Published var weatherData: WeatherData?
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async {
        do {
            let response = try await weatherService.fetchWeather(latitude: latitude, longitude: longitude)
            switch response {
            case .success(let weather):
                await buildWeatherData(weather: weather)
            case .failure(let failure):
                print("error")
            }
        }
        catch {
            
        }
        
    }
    func buildWeatherData(weather: WeatherResponse) async {
        let icon = await IconHandler().get(iconCode: weather.current.weather.first?.icon ?? "")
        self.weatherData = WeatherData(
            date: Date(timeIntervalSince1970: TimeInterval(weather.current.timestamp)),
            title: weather.current.weather.first?.description ?? "",
            imageData: icon,
            hourly: weather.hourly
        )
    }
}

enum APIState {
    case idle
    case loading
    case error(NetworkError)
    case success
}
