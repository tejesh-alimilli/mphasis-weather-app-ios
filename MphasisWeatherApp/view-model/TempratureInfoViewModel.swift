//
//  TempratureInfoViewModel.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/23/24.
//

import Foundation

struct TempratureInfoViewModel {
    let temp: Double
    let feels_like: Double
    
    let formatter = MeasurementFormatter()
    
    var tempString: String {
        let m = Measurement<UnitTemperature>(value: temp, unit: .fahrenheit)
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter.string(from: m)
    }
    
    var feelsLikeString: String {
        let m = Measurement<UnitTemperature>(value: feels_like, unit: .fahrenheit)
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 1
        return formatter.string(from: m)
    }
}
