//
//  SplashViewController.swift
//  schedule4unn
//
//  Created by Илья on 08.05.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        makeServiceCall()
        // Do any additional setup after loading the view.
    }
    

    
    private func makeServiceCall() {
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.activityIndicator.stopAnimating()
            
            if UserDefaults.standard.bool(forKey: "logged in") {
                AppDelegate.shared.rootViewController.switchToMainScreen()
            } else {
                // navigate to login screen
                AppDelegate.shared.rootViewController.showLoginScreen()
            }
        }
    }
    

}
