//
//  HourlyWeatherView.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import SwiftUI

// MARK: - Hourly Weather

struct HourlyWeatherView: View {
    let hourly: [CurrentWeather]
    @State private var imageCache: [String: UIImage] = [:]  // Cache images to avoid redundant network calls
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 1) {
                ForEach(hourly, id: \.timestamp) { hrs in
                    HourlyWeatherCardView(currentWeather: hrs, imageCache: $imageCache)
                }
            }
        }
    }
}

struct HourlyWeatherCardView: View {
    let currentWeather: CurrentWeather
    @Binding var imageCache: [String: UIImage]
    
    var body: some View {
        let date = Date(timeIntervalSince1970: TimeInterval(currentWeather.timestamp))
        VStack {
            Text(date.formatted(date: .omitted, time: .standard))
                .font(.headline)
            Text(currentWeather.weather.first?.description.capitalized ?? "")
                .font(.subheadline)
            if let icon = currentWeather.weather.first?.icon, let img = imageCache[icon] {
                Image(uiImage: img)
                    .resizable()
                    .frame(width: 120, height: 120)
            }
            
            Text(currentWeather.weather.first?.main ?? "")
                .font(.subheadline)
                .foregroundStyle(Color(.secondaryLabel))
            
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
        .padding(.horizontal, 4)
        .onAppear {
            fetchWeatherIcon()
        }
    }
    
    private func fetchWeatherIcon() {
        guard let iconCode = currentWeather.weather.first?.icon else { return }
        
        if imageCache[iconCode] == nil {
            Task {
                if let iconData = await IconHandler().get(iconCode: iconCode),
                   let iconImage = UIImage(data: iconData) {
                    imageCache[iconCode] = iconImage
                }
            }
        }
    }
}
