//
//  HomeListView.swift
//  B-Player
//
//  Created by user on 10/01/21.
//

import Foundation

protocol HomeListViewProtocol :BaseViewProtocol {
    
    func reload()
    
    func selectedVideoWith(model:VideoDetailModelProtocol)
    
    func didLogoutUser()
}
