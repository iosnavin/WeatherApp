//
//  WeatherContainerView.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import SwiftUI
import Combine
import CoreLocation

// MARK: - Weather Container View

struct WeatherContainer {
    @MainActor static func build() -> WeatherContainerView {
        WeatherContainerView(viewModel: .init(weatherService: .init()))
    }
}

struct WeatherContainerView: View {
    @StateObject var viewModel = WeatherViewModel()
    @State private var searchText = ""
    @State private var place = ""
    @State var bag = Set<AnyCancellable>()
    let locationManager = LocationManager()

    var body: some View {
        NavigationView {
            VStack {
                if let weatherData = viewModel.weatherData {
                    Text(place).font(.title2)
                        .padding(.vertical)
                    CurrentWeatherView(weatherData: weatherData)
                    if let hourly = weatherData.hourly {
                        HourlyWeatherView(hourly: hourly)
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .navigationTitle("Weather")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Search by city")
            .onSubmit(of: .search, handleSearch)
            .onAppear {
                locationManager.$location.sink { location in
                    if let location = location {
                        locationManager.stopUpdatingLocation()
                        Task {
                            await self.viewModel.fetchWeather(latitude: location.latitude, longitude: location.longitude)
                        }
                    }
                }.store(in: &bag)
                
                locationManager.$placeName.sink { placeName in
                    if let place = placeName {
                        self.place = place
                    }
                }.store(in: &bag)
            }
        }
    }
    
    private func handleSearch() {
        Task {
            if let coordinate = await geocodeCityName(searchText) {
                self.place = searchText
                await viewModel.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude)
            }
        }
    }
}


func geocodeCityName(_ cityName: String) async -> CLLocationCoordinate2D? {
   await withCheckedContinuation { continuation in
       let geocoder = CLGeocoder()
       geocoder.geocodeAddressString(cityName) { placemarks, error in
           if let placemark = placemarks?.first,
              let location = placemark.location {
               continuation.resume(returning: location.coordinate)
           } else {
               print("Geocoding error: \(error?.localizedDescription ?? "Unknown error")")
               continuation.resume(returning: nil)
           }
       }
   }
}
