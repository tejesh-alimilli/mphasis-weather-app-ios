//
//  BaseViewController.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var activityIndicator: UIActivityIndicatorView? = nil
    
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
    
    // basic progress indicator, for complex progress indicator we can use third party library or create custom component
    func showProgressIndicator() -> Void {
        if activityIndicator != nil {
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.color = UIColor.accent
        activityIndicator.startAnimating()
        self.view.bringSubviewToFront(activityIndicator)
        self.activityIndicator = activityIndicator
        self.view.isUserInteractionEnabled = false
    }
    
    func hideProgresssIndicator() -> Void {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
        self.view.isUserInteractionEnabled = true
    }
}
