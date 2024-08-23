//
//  SearchViewController.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import UIKit

class SearchViewController: BaseViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = AppState.shared.cityName
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchClicked()
    }
    
    @IBAction func searchClicked() {
        if searchBar.text == nil || searchBar.text?.count == 0 {
            showError(error: "Please enter a city name")
            return
        }
        
        showError(error: nil)
        
        showProgressIndicator()
        AppState.shared.cityName = searchBar.text
        Task {
            let cityInfo = await WebService.shared.getGeoCodingInfo(cityName: searchBar.text ?? "")
            Task { @MainActor [weak self] in
                self?.hideProgresssIndicator()
                self?.cityInfoCallbackt(cityInfo:cityInfo)
            }
        }
    }
    
    @IBAction func currentLocationClicked(_ sender: UIButton) {
    }
    
    func cityInfoCallbackt(cityInfo: CityInfo?) {
        guard let cityInfo = cityInfo else {
            showError(error: "\(searchBar.text ?? "") not found")
            return
        }
        
        if cityInfo.country.uppercased() != "US" {
            showError(error: "Please search for US city")
            return
        }
        
        showError(error: nil)
        Task {
            let weatherInfo = await WebService.shared.getWeatherDetail(lat: cityInfo.lat, lon: cityInfo.lon)
            if let weatherInfo = weatherInfo {
                var weatherDetailInfoViewModelList = Array<WeatherDetailInfoViewModel>()
                for weatherDetail in weatherInfo.weather {
                    let weatherDetailInfoViewModel = WeatherDetailInfoViewModel(id: weatherDetail.id, main: weatherDetail.main, description: weatherDetail.description, icon: weatherDetail.icon)
                    weatherDetailInfoViewModelList.append(weatherDetailInfoViewModel)
                }
                let weatherDetailViewModal = WeatherDetailViewModel(weather: weatherDetailInfoViewModelList, main: TempratureInfoViewModel(temp: weatherInfo.main.temp, feels_like: weatherInfo.main.feels_like))
            }
        }
    }
}

