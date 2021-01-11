//
//  SignInViewProtocol.swift
//  B-Player
//
//  Created by user on 09/01/21.
//

import Foundation
protocol SignInViewProtocol:BaseViewProtocol {
    
    func didSignIn()
    
    func failedToSignIn(withError error:Error)
}
