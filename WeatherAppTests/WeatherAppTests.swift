//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Naveen Reddy on 06/09/24.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {

    func testWeatherAPIURLRequest() throws {
        // Given
        let latitude: Double = 37.7749
        let longitude: Double = -122.4194
        let apiKey = Constants.Strings.keyAPI
        let baseAPIURL = Constants.Strings.url
        let weatherAPI = WeatherAPI(endpoint: .currentWeather(latitude: latitude, longitude: longitude))
        
        // When
        let urlRequest = weatherAPI.urlRequest

        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL is nil")
            return
        }
        XCTAssertEqual(url.host, "api.openweathermap.org")
        XCTAssertEqual(url.path, "/data/2.5/onecall")
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems
        
        XCTAssertNotNil(queryItems?.first(where: { $0.name == "lat" && $0.value == "\(latitude)" }))
        XCTAssertNotNil(queryItems?.first(where: { $0.name == "lon" && $0.value == "\(longitude)" }))
        XCTAssertNotNil(queryItems?.first(where: { $0.name == "appid" && $0.value == apiKey }))
        XCTAssertNotNil(queryItems?.first(where: { $0.name == "units" && $0.value == "metric" }))
    }
}


func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // Any test you write for XCTest can be annotated as throws and async.
    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
}

func testPerformanceExample() throws {
    // This is an example of a performance test case.
}

