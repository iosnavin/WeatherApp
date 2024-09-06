//
//  Rain.swift
//  WeatherApp
//
//  Created by Naveen Reddy on 06/09/24.
//

import Foundation
import UIKit

// MARK: - Rain

struct Rain: Decodable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}
