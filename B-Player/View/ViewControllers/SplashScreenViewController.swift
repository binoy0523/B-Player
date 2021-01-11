//
//  SplashScreenViewController.swift
//  B-Player
//
//  Created by user on 10/01/21.
//

import UIKit

class SplashScreenViewController: UIViewController {
    let userdefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        guard let window = self.currentWindow else {
            return
        }
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        if(true == userdefault.bool(forKey:Key.kUserAuthenticated)) {
            let HomeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeNavigation")
            window.rootViewController = HomeVC
          
            UIView.transition(with: window, duration: 0.5, options: options, animations: {
            }, completion:
                { completed in
                    //  do something on completion
                })
            
        }
        else{
            let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController")
            window.rootViewController = signInVC
            UIView.transition(with: window, duration: 0.5, options: options, animations: {
                
            }, completion:
                { completed in
                    //  do something on completion
                })
        }
    }
    
}
