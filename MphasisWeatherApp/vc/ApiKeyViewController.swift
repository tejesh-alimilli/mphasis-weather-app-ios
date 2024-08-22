//
//  ApiKeyViewController.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import UIKit

class ApiKeyViewController: UIViewController {

    @IBOutlet weak var apiKeyTextField: UITextField?
    @IBOutlet weak var errorMessageLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showError(error: nil)
    }
    
    @IBAction func goButtonClicked() {
        let apiKey = apiKeyTextField?.text ?? ""
        if apiKey.count == 0 {
            showError(error: "Api Key cannot be empty")
        } else if apiKey.count < 32 {
            showError(error: "Api Key is too short")
        } else if apiKey.rangeOfCharacter(from: CharacterSet.symbols) != nil {
            showError(error: "Invalid Api Key")
        } else {
            showError(error: nil)
            AppState.shared.apiKey = apiKey
            goToNextScreen()
        }
    }
    
    func showError(error: String?) {
        errorMessageLabel?.text = error ?? ""
        errorMessageLabel?.isHidden = (error?.count ?? 0) == 0
    }
    
    func goToNextScreen() {
        AppNavigationCoordinator.shared.launchSearchScreen(self.view.window!)
    }
}
