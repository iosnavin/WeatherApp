//
//  WeatherResponseTests.swift
//  WeatherAppTests
//
//  Created by Naveen Reddy on 06/09/24.
//

import XCTest
@testable import WeatherApp

final class WeatherResponse: XCTestCase {
    
    func testWeatherResponseDecoding() throws {
        // Given
        let jsonData = """
            {
                "lat": 37.7749,
                "lon": -122.4194,
                "timezone": "America/Los_Angeles",
                "timezone_offset": -28800,
                "current": {
                    "dt": 1618317040,
                    "sunrise": 1618282134,
                    "sunset": 1618333901,
                    "temp": 284.55,
                    "feels_like": 281.86,
                    "pressure": 1016,
                    "humidity": 76,
                    "dew_point": 280.39,
                    "uvi": 0.89,
                    "clouds": 100,
                    "visibility": 10000,
                    "wind_speed": 1.34,
                    "wind_deg": 269,
                    "wind_gust": 3.58,
                    "weather": [
                        {
                            "id": 500,
                            "main": "Rain",
                            "description": "light rain",
                            "icon": "10n"
                        }
                    ],
                    "pop": 0.2,
                    "rain": {
                        "1h": 0.21
                    }
                },
                "hourly": [
                    {
                        "dt": 1618317040,
                        "temp": 284.55,
                        "feels_like": 281.86,
                        "pressure": 1016,
                        "humidity": 76,
                        "dew_point": 280.39,
                        "uvi": 0.89,
                        "clouds": 100,
                        "visibility": 10000,
                        "wind_speed": 1.34,
                        "wind_deg": 269,
                        "wind_gust": 3.58,
                        "weather": [
                            {
                                "id": 500,
                                "main": "Rain",
                                "description": "light rain",
                                "icon": "10n"
                            }
                        ],
                        "pop": 0.2
                    }
                ],
                "daily": [
                    {
                        "dt": 1618317040,
                        "sunrise": 1618282134,
                        "sunset": 1618333901,
                        "moonrise": 1618282134,
                        "moonset": 1618333901,
                        "moon_phase": 0.5,
                        "temp": {
                            "day": 284.55,
                            "min": 283.15,
                            "max": 285.15,
                            "night": 283.55,
                            "eve": 284.15,
                            "morn": 283.25
                        },
                        "feels_like": {
                            "day": 281.86,
                            "night": 280.86,
                            "eve": 282.86,
                            "morn": 281.25
                        },
                        "pressure": 1016,
                        "humidity": 76,
                        "dew_point": 280.39,
                        "wind_speed": 1.34,
                        "wind_deg": 269,
                        "wind_gust": 3.58,
                        "weather": [
                            {
                                "id": 500,
                                "main": "Rain",
                                "description": "light rain",
                                "icon": "10n"
                            }
                        ],
                        "clouds": 100,
                        "pop": 0.2,
                        "rain": 0.21,
                        "uvi": 0.89
                    }
                ]
            }
            """.data(using: .utf8)!
        
        // When
        let weatherResponse = try JSONDecoder().decode(WeatherResonse.self, from: jsonData)
        
        // Then
        XCTAssertEqual(weatherResponse.lat, 37.7749)
        XCTAssertEqual(weatherResponse.lon, -122.4194)
        XCTAssertEqual(weatherResponse.timezone, "America/Los_Angeles")
        XCTAssertEqual(weatherResponse.timezoneOffset, -28800)
        
        XCTAssertEqual(weatherResponse.current.dt, 1618317040)
        XCTAssertEqual(weatherResponse.current.temp, 284.55)
        XCTAssertEqual(weatherResponse.current.weather.first?.main.rawValue, "Rain")
        XCTAssertEqual(weatherResponse.current.weather.first?.description, "light rain")
        
        XCTAssertEqual(weatherResponse.hourly.count, 1)
        XCTAssertEqual(weatherResponse.daily.count, 1)
    }
}

func tearDownError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

func testPerformance() throws {
    // This is an example of a performance test case.
}

