//
//  ProgressIndicatorVcProtocol.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/23/24.
//

import Foundation
import UIKit

protocol ProgressIndicatorVcProtocol: AnyObject {
    var activityIndicator: UIActivityIndicatorView? { get set }
}

extension ProgressIndicatorVcProtocol where Self:UIViewController {
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
