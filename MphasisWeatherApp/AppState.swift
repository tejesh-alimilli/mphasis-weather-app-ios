//
//  AppState.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import Foundation

class AppState {
    static let shared = AppState()
    
    var apiKey: String? {
        get { UserDefaults.standard.string(forKey: "ApiKey") }
        set { UserDefaults.standard.setValue(newValue, forKey: "ApiKey") }
    }
}
