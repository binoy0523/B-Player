//
//  SignInModelProtocol.swift
//  B-Player
//
//  Created by user on 09/01/21.
//

import Foundation
import FirebaseAuth
protocol SignInModelProtocol {
    
    func authenticateUser(withCredential credential:AuthCredential, completion: @escaping (Result<Bool, Error>) -> Void)
}
