//
//  WeatherDetailView.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import SwiftUI

struct WeatherDetailView: View {
    @State var viewModal: WeatherDetailViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModal.weather) { item in
                HStack {
                    if item.iconImage != nil {
                        Image(uiImage: item.iconImage!)
                    }
                    Text("it is \(item.description) today")
                }
            }
            
            Text("the temprature is \(viewModal.main.tempString), but feels like \(viewModal.main.feelsLikeString)")
                .padding(50)
        }.task {
            for (i, w) in viewModal.weather.enumerated() {
                viewModal.weather[i].iconImage = await WebService.shared.getWeatherIcon(iconName: w.icon)
            }
        }
    }
}

#Preview {
    WeatherDetailView(viewModal: WeatherDetailViewModel(weather: [WeatherDetailInfoViewModel(id: 123, main: "clear", description: "clear sky", icon: "03d")], main: TempratureInfoViewModel(temp: 123.4, feels_like: 132.5)))
}
