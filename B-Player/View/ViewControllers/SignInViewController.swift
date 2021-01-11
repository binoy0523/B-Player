//
//  SignInViewController.swift
//  B-Player
//
//  Created by user on 08/01/21.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInDelegate , SignInViewProtocol {
   
    var viewModel:SignInViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel = SignInViewModel(withViewDelegate: self)
    }
    

    @IBAction func signInAction(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
       
    }
   
    
   private  func setRootToHome() {
    guard let window = self.currentWindow else {
            return
        }

      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeNavigation")

        // Set the new rootViewController of the window.
        // Calling "UIView.transition" below will animate the swap.
        window.rootViewController = vc

        // A mask of options indicating how you want to perform the animations.
        let options: UIView.AnimationOptions = .transitionCrossDissolve

        // The duration of the transition animation, measured in seconds.
        let duration: TimeInterval = 0.3

        // Creates a transition animation.
        // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
        { completed in
            //  do something on completion
        })

    }
    
    
    
    // MARK: - View Protocol
    
    func didSignIn() {
        self.removeSpinner()
        self.setRootToHome()
    }
    func failedToSignIn(withError error: Error) {
        self.showAlert(title: "Failed to Signin", message: error.localizedDescription)
        
    }
    
    func startSpinner() {
        self.showSpinner()
    }
    
    func ceaseSpinner() {
        self.removeSpinner()
    }
    
    func showAlertWith(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
}


extension SignInViewController {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // ...
         if let error = error {
           // ...
           return
         }

         guard let authentication = user.authentication else { return }
         let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
        self.viewModel?.authenticateUser(withCredentials: credential)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
}
