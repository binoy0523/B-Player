//
//  ManualMocks.swift
//  B-PlayerTests
//
//  Created by user on 11/01/21.
//

import Foundation
import Firebase
@testable import B_Player

class MockSignInModel : SignInModelProtocol {
    
    var authenticateCalled =  false
    var authResult: Result<Bool,Error> = .success(true)
    
    func authenticateUser(withCredential credential: AuthCredential, completion: @escaping (Result<Bool, Error>) -> Void) {
       authenticateCalled = true
        completion(authResult)
    }
    
    
}

class MockSignInViewDelegate : SignInViewProtocol {
    var didSignInCalled = false
    var startSpinnerCalled = false
    var stopSpinnerCalled = false
    var failedSignInCalled = false
    var error:NSError!
    
    func didSignIn() {
        didSignInCalled = true
    }
    
    func failedToSignIn(withError error: Error) {
        self.error = error as NSError
        failedSignInCalled = true
    }
    
    func startSpinner() {
        startSpinnerCalled = true
    }
    
    func ceaseSpinner() {
        stopSpinnerCalled = true
    }
    
    func showAlertWith(title: String, message: String) {
        
    }
    
    
}


class MockHomeListModel : HomeListModelProtocol {
    
    var fetchVideosCalled = false
    var fetchResult: Result<[Video],Error> = .success([Video()])
    func fetchVideos(completion: @escaping (Result<[Video], Error>) -> Void) {
        fetchVideosCalled = true
        completion(fetchResult)
    }
    
    func updateVideo() {
        
    }
    
    var videos: [Video]?
    
    
    
}

class MockHomeListViewDelegate : HomeListViewProtocol {
    
    
    
    var reloadCalled = false
    var startSpinnerCalled = false
    var stopSpinnerCalled = false
    var error:NSError!
    
    func reload() {
        reloadCalled = true
    }
    
    func selectedVideoWith(model: VideoDetailModelProtocol) {
        
    }
    
    func startSpinner() {
        startSpinnerCalled = true
    }
    
    func ceaseSpinner() {
        stopSpinnerCalled = true
    }
    
    func showAlertWith(title: String, message: String) {
        
    }
    
    func didLogoutUser() {
        
    }
    
    
}
