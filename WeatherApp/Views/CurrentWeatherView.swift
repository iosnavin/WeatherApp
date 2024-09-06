//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import SwiftUI
import Combine

// MARK: - Current Weather

struct CurrentWeatherView: View {
    let weatherData: WeatherData
    
    var body: some View {
        VStack(alignment: .center) {
            Text(weatherData.date?.formatted(date: .complete, time: .omitted) ?? "")
                .font(.subheadline)
            Text(weatherData.date?.formatted(date: .omitted, time: .standard) ?? "")
                .font(.subheadline)
                .padding(.top, 2)
        }
        .foregroundStyle(Color(.lightGray))
        .padding(.vertical)
        
        Text(weatherData.title.capitalized)
            .font(.headline)
            .foregroundStyle(Color(.systemBlue))
        
        if let data = weatherData.imageData,
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 120, height: 120)
        }
    }
}

struct Metric {
    let title: String
    let value: String
}
