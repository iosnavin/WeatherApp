//
//  IconHandler.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation

// MARK: - Icon Handler

struct IconHandler {
    func get(iconCode: String) async -> Data? {
        let iconURL = URL(string: "http://openweathermap.org/img/wn/\(iconCode)@2x.png")!
        do {
            let (data, _) = try await URLSession.shared.data(from: iconURL)
            return data
        } catch {
            print("Error fetching icon: \(error)")
            return nil
        }
    }
}
