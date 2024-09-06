//
//  WindSpeedTemperatureView.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import SwiftUI

struct WindSpeedTemperatureView: View {
    let windSpeed: String
    let temp: String
    let humidity: Int
    
    var body: some View {
        let metrics: [Metric] = [
            Metric(title: "Wind speed", value: windSpeed),
            Metric(title: "Temperature", value: temp),
            Metric(title: "Humidity", value: "\(humidity) %")
        ]
        
        return HStack(spacing: 16 ) {
            ForEach(metrics, id: \.title) { metric in
                CardView {
                    VStack(alignment: .center) {
                        Text(metric.title)
                            .font(.caption)
                            .foregroundStyle(Color(.secondaryLabel))
                        Divider()
                            .foregroundStyle(Color(.label))
                            .padding(.horizontal)
                        Text(metric.value)
                    }
                    .background(Image("sub-group", bundle: .main))
                }
            }
        }
        .padding()
    }
}
