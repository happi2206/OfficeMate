//
//  Weather.swift
//  OfficeMate
//
//  Created by Happiness Adeboye on 10/05/2025.
//

import SwiftUI

struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}
