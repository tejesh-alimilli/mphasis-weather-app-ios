//
//  WeatherDetailInfo.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import Foundation

struct WeatherDetailInfo: Identifiable, Codable {
    let id: Double
    let main: String
    let description: String
    let icon: String
}
