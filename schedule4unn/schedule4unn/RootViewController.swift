//
//  ViewController.swift
//  schedule4unn
//
//  Created by Илья on 20.03.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private var current: UIViewController
    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(current)               // 1
        current.view.frame = view.bounds              // 2
        view.addSubview(current.view)                 // 3
        current.didMove(toParent: self) // 4
        // Do any additional setup after loading the view, typically from a nib.
    }

    func showLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "EnterViewController") as? EnterViewController
        //newVC?.loadView()
        //let new = UINavigationController(rootViewController: newVC ?? EnterViewController())                               // 1
        addChild(newVC!)                    // 2
        newVC?.view.frame = view.bounds                   // 3
        view.addSubview((newVC?.view)!)                      // 4
        newVC?.didMove(toParent: self)      // 5
        current.willMove(toParent: nil)  // 6
        current.view.removeFromSuperview()          // 7
        current.removeFromParent()       // 8
        current = newVC!                                  // 9
    }
    
    func switchToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let newVC = storyboard.instantiateViewController(withIdentifier: "tab")
        //let mainViewController = ScheduleViewController()
        //let mainScreen = UINavigationController(rootViewController:newVC)
        animateFadeTransition(to: newVC)
    }
    
    func switchToLogout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "EnterViewController") as? EnterViewController
        //let loginViewController = EnterViewController()
        //let logoutScreen = UINavigationController(rootViewController: newVC!)
        UserDefaults.standard.set(false, forKey: "logged in")
        animateFadeTransition(to: newVC!)
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { completed in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()  //1
        }
    }

}

