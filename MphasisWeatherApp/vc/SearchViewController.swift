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
        
        Task {
            let cityInfo = await WebService.shared.getGeoCodingInfo(cityName: searchBar.text ?? "")
            Task { @MainActor [weak self] in
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
        print("city \(cityInfo)")
    }
}

