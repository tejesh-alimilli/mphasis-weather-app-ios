//
//  SearchViewController.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import UIKit
import CoreLocation

class SearchViewController: BaseViewController, UISearchBarDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = AppState.shared.cityName
        locationManager.requestWhenInUseAuthorization()
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
        // instead of checking everytime use delegate to save the changes in status
        if !CLLocationManager.locationServicesEnabled() {
            showError(error: "Please enable location services")
            return
        }
        
        if locationManager.authorizationStatus != .authorizedWhenInUse && locationManager.authorizationStatus != .authorizedAlways {
            showError(error: "Please allow location access")
            return
        }
        
        if locationManager.location == nil {
            showError(error: "Currnet location not known yet")
            return
        }
        
        showError(error: nil)
        Task {
            await loadWeatherInfoForLocation(lat: locationManager.location!.coordinate.latitude, lon: locationManager.location!.coordinate.longitude)
        }
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
            await loadWeatherInfoForLocation(lat: cityInfo.lat, lon:cityInfo.lon)
        }
    }
    
    func loadWeatherInfoForLocation(lat: Double, lon: Double) async {
        let weatherInfo = await WebService.shared.getWeatherDetail(lat: lat, lon: lon)
        if let weatherInfo = weatherInfo {
            var weatherDetailInfoViewModelList = Array<WeatherDetailInfoViewModel>()
            for weatherDetail in weatherInfo.weather {
                let weatherDetailInfoViewModel = WeatherDetailInfoViewModel(id: weatherDetail.id, main: weatherDetail.main, description: weatherDetail.description, icon: weatherDetail.icon)
                weatherDetailInfoViewModelList.append(weatherDetailInfoViewModel)
            }
            let weatherDetailViewModal = WeatherDetailViewModel(weather: weatherDetailInfoViewModelList, main: TempratureInfoViewModel(temp: weatherInfo.main.temp, feels_like: weatherInfo.main.feels_like))
            AppNavigationCoordinator.shared.showDetailView(viewModal: weatherDetailViewModal, self)
        }
    }
}

