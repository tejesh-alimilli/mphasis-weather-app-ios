//
//  BaseViewController.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showError(error: nil)
    }
    
    func showError(error: String?) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.errorMessageLabel?.text = error ?? ""
            self?.errorMessageLabel?.isHidden = (error?.count ?? 0) == 0
        }
    }
}
