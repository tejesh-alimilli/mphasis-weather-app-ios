//
//  CityInfo.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import Foundation

struct CityInfo: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let state: String
    let country: String
}
