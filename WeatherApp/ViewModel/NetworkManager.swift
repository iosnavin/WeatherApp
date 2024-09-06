//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import UIKit

// MARK: - Network Manager

enum NetworkError: Error, LocalizedError {
    case networkError(String)
    case invalidData
    case decodingError(String)
    case serverError(statusCode: Int)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .networkError(let message):
            return "Network error: \(message)"
        case .invalidData:
            return "Invalid data received from the server."
        case .decodingError(let message):
            return "Decoding error: \(message)"
        case .serverError(let statusCode):
            return "Server error with status code \(statusCode)."
        case .unknown(let error):
            return "Unknown error"
        }
    }
}

protocol NetworkProtocol {
    static func request<T: Decodable>(request: URLRequest) async throws -> T
}

final class NetworkManager: NetworkProtocol {
    static func request<T: Decodable>(request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.serverError(statusCode: 0)
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            if let decodingError = error as? DecodingError {
                throw handleDecodingError(decodingError)
            } else {
                throw NetworkError.networkError(error.localizedDescription)
            }
        }
    }

    private static func handleDecodingError(_ error: DecodingError) -> NetworkError {
        switch error {
        case .dataCorrupted(let context):
            print("Data corrupted: \(context)")
            return NetworkError.decodingError("Data corrupted: \(context.debugDescription)")
        case .keyNotFound(let key, let context):
            print("Key not found: \(key), \(context)")
            return NetworkError.decodingError("Key not found: \(key), \(context.debugDescription)")
        case .typeMismatch(let type, let context):
            print("Type mismatch: \(type), \(context)")
            return NetworkError.decodingError("Type mismatch: \(type), \(context.debugDescription)")
        case .valueNotFound(let type, let context):
            print("Value not found: \(type), \(context)")
            return NetworkError.decodingError("Value not found: \(type), \(context.debugDescription)")
        @unknown default:
            print("Unknown decoding error: \(error)")
            return NetworkError.decodingError("Unknown decoding error: \(error.localizedDescription)")
        }
    }
}
