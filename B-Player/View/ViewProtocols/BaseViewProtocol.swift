//
//  BaseViewProtocol.swift
//  B-Player
//
//  Created by user on 10/01/21.
//

import Foundation

protocol BaseViewProtocol:AnyObject {
    
    func startSpinner()
    
    func ceaseSpinner()
    
    func showAlertWith(title:String,message:String)
}
