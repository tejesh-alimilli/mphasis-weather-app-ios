//
//  WebService.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import Foundation
import UIKit

class WebService {
    static let shared = WebService()
    
    private let apiBaseUrl = "https://api.openweathermap.org/"
    private let imageBaseUrl = "https://openweathermap.org/"
    private let jsonDecoder = JSONDecoder()

    func getGeoCodingInfo(cityName: String) async -> CityInfo? {
        do {
            guard let apiKey = AppState.shared.apiKey else {
                print("api key is missing")
                return nil
            }
            
//            can use enum constants for urls to avoid spelling errors, also to keep all urls in one place
            let url = URL(string: "\(apiBaseUrl)geo/1.0/direct?q=\(cityName)&limit=1&appid=\(apiKey)")!
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let cityInfoList = try jsonDecoder.decode((Array<CityInfo>).self, from: data)
                    return cityInfoList.first
                } else {
                    let jsonString = String(data: data, encoding: .utf8)
                    print("invalid http response code \(httpResponse)")
                    print("response msg \(jsonString ?? "")")
                }
            }
        } catch {
            print("error in geo coding service \(error)")
        }
        return nil
    }
    
    // can use a common method to avoid duplication of boilerplate code here
    func getWeatherDetail(lat: Double, lon: Double) async -> WeatherDetailResponse? {
        do {
            guard let apiKey = AppState.shared.apiKey else {
                print("api key is missing")
                return nil
            }
            
//            can use enum constants for urls to avoid spelling errors, also to keep all urls in one place
            let url = URL(string: "\(apiBaseUrl)data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)")!
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let weatherInfo = try jsonDecoder.decode(WeatherDetailResponse.self, from: data)
                    return weatherInfo
                } else {
                    let jsonString = String(data: data, encoding: .utf8)
                    print("invalid http response code \(httpResponse)")
                    print("response msg \(jsonString ?? "")")
                }
            }
        } catch {
            print("error in weather info service \(error)")
        }
        return nil
    }
    
    func getWeatherIcon(iconName: String) async -> UIImage? {
        do {
            guard let apiKey = AppState.shared.apiKey else {
                print("api key is missing")
                return nil
            }
            
            let url = URL(string: "\(imageBaseUrl)img/wn/\(iconName)@2x.png")!
            let (data, response) = try await URLSession.shared.data(from: url)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let image = UIImage(data: data)
                    return image
                } else {
                    print("invalid http response code \(httpResponse)")
                }
            }
        } catch {
            print("error in image service \(error)")
        }
        return nil
    }
}
