//
//  AppState.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import Foundation

@MainActor
class AppState {
    static let shared = AppState()
    
//    can use swift property wrappers to reduce code duplication
    var apiKey: String? {
        get { UserDefaults.standard.string(forKey: "ApiKey") }
        set { UserDefaults.standard.setValue(newValue, forKey: "ApiKey") }
    }
    
    var cityName: String? {
        get { UserDefaults.standard.string(forKey: "CityName") }
        set { UserDefaults.standard.setValue(newValue, forKey: "CityName") }
    }
}
