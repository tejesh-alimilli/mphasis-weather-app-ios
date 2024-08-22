//
//  AppNavigationCoordinator.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import Foundation
import UIKit

class AppNavigationCoordinator {
    static let shared = AppNavigationCoordinator()
    
    func getVc<T:UIViewController>(name: String) -> T? {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: name)
        return vc as? T
    }
    
    func launch<T:UIViewController>(screen: String, _ window: UIWindow, vcClass: T.Type) {
        let navVc = window.rootViewController as! UINavigationController
        if let newVc: T = getVc(name: screen) {
            navVc.setViewControllers([newVc], animated: false)
        }
    }
    
    func launchApiKeyScreen(_ window: UIWindow) {
        launch(screen: "ApiKeyViewController", window, vcClass: ApiKeyViewController.self)
    }
    
    func launchSearchScreen(_ window: UIWindow) {
        launch(screen: "ViewController", window, vcClass: ViewController.self)
    }
}
