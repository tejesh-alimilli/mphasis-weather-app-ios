//
//  AppNavigationCoordinator.swift
//  MphasisWeatherApp
//
//  Created by user267483 on 8/22/24.
//

import Foundation
import UIKit
import SwiftUI

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
        launch(screen: "SearchViewController", window, vcClass: SearchViewController.self)
    }
    
    func showDetailView(viewModal: WeatherDetailViewModel, _ parentVc: UIViewController) {
        let vc = UIHostingController(rootView: WeatherDetailView(viewModal: viewModal))
        parentVc.navigationController?.pushViewController(vc, animated: true)
    }
}
