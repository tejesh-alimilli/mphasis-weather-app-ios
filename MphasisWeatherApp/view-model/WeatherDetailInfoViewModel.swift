//
//  WeatherDetailInfoViewModel.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import Foundation
import UIKit

struct WeatherDetailInfoViewModel: Identifiable {
    let id: Double
    let main: String
    let description: String
    let icon: String
    
    var iconImage: UIImage? = nil
    
    init(id: Double, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}
