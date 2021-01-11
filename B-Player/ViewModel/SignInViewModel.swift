//
//  SignInViewModel.swift
//  B-Player
//
//  Created by user on 09/01/21.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

class SignInViewModel : SignInViewModelProtocol {

    var model : SignInModelProtocol?
    
    weak var viewDelegate: SignInViewProtocol?
    
    let userdefault = UserDefaults.standard
    
    init(withModel model:SignInModelProtocol? = SignInModel(), withViewDelegate viewDelegate: SignInViewProtocol?) {
        self.model = model
        self.viewDelegate = viewDelegate
    }
    
    
//    MARK:- Authenticate with Firebase Auth
    
    func authenticateUser(withCredentials credentials: AuthCredential) {
        self.viewDelegate?.startSpinner()
        self.model?.authenticateUser(withCredential: credentials, completion: { [weak self]  (result) in
            self?.viewDelegate?.ceaseSpinner()
            switch result {
            case .success(let status):
                if (status) {
                    /**
                     * Setting Auto login to app, Once Authenticated
                     */
                    self?.userdefault.set(true, forKey:Key.kUserAuthenticated)
                    self?.viewDelegate?.didSignIn()
                }
               
            case .failure(let error):
                print(error)
                self?.viewDelegate?.failedToSignIn(withError: error)
            }
        })
        
    }
    
    
    
    
}
