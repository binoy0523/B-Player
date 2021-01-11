//
//  SignInModel.swift
//  B-Player
//
//  Created by user on 09/01/21.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
class SignInModel:SignInModelProtocol {
    
    func authenticateUser(withCredential credential: AuthCredential, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                // User is signed in
                // ...
                completion(.success(true))
            }
        }
    }
    
}
