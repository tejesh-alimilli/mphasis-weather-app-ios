//
//  WebService.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import Foundation

class WebService {
    static let shared = WebService()
    
    private let apiBaseUrl = "https://api.openweathermap.org/"
    private let imageBaseUrl = "https://openweathermap.org/"
    private let jsonDecoder = JSONDecoder()

    func getGeoCodingInfo(cityName: String) async -> CityInfo? {
        do {
            guard let apiKey = await AppState.shared.apiKey else {
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
}
