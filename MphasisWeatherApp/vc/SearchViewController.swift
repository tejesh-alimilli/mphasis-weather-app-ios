//
//  SearchViewController.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showError(error: nil)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchClicked()
    }
    
    @IBAction func searchClicked() {
        Task {
            let cityInfo = await WebService.shared.getGeoCodingInfo(cityName: "Old Bridge")
            Task { @MainActor [weak self] in
                self?.cityInfoCallbackt(cityInfo:cityInfo)
            }
        }
    }
    
    @IBAction func currentLocationClicked(_ sender: UIButton) {
    }
    
    func showError(error: String?) {
        errorMessageLabel?.text = error ?? ""
        errorMessageLabel?.isHidden = (error?.count ?? 0) == 0
    }
    
    func cityInfoCallbackt(cityInfo: CityInfo?) {
        guard let cityInfo = cityInfo else {
            showError(error: "\(searchBar.text ?? "") not found")
            return
        }
        
        if cityInfo.country.capitalized != "US" {
            showError(error: "Please search for US city")
            return
        }
        
        showError(error: nil)
    }
}

