//
//  WeatherDetailResponse.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import Foundation

struct WeatherDetailResponse: Codable {
    let base: String
    let weather: Array<WeatherDetailInfo>
    let main: TempratureInfo
}
