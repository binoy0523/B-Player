//
//  SignInViewModelProtocol.swift
//  B-Player
//
//  Created by user on 10/01/21.
//

import Foundation
import FirebaseAuth
protocol SignInViewModelProtocol {
    
    var model : SignInModelProtocol? { get set }
    
    var viewDelegate: SignInViewProtocol? { get set }
    
    func authenticateUser(withCredentials credentials:AuthCredential)
}
