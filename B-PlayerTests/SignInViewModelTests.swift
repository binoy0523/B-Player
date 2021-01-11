//
//  SignInViewModelTests.swift
//  B-PlayerTests
//
//  Created by user on 11/01/21.
//

import XCTest
import FirebaseAuth
@testable import B_Player
class SignInViewModelTests: XCTestCase {
    var mockModel:MockSignInModel!
    var mockDelegate:MockSignInViewDelegate!
    var viewModel : SignInViewModel!
    var mockAuthCredential :AuthCredential!
    override func setUp()  {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      mockAuthCredential = GoogleAuthProvider.credential(withIDToken: "testId", accessToken: "testtoken")
      mockModel = MockSignInModel()
      mockDelegate = MockSignInViewDelegate()
      viewModel = .init(withModel:mockModel , withViewDelegate: mockDelegate)
    }

    override func tearDown()  {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockModel = nil
        mockDelegate = nil
        viewModel = nil
        mockAuthCredential =  nil
    }

    func testProperAuthentication() {
        viewModel?.authenticateUser(withCredentials: mockAuthCredential)
        XCTAssertTrue(mockDelegate.startSpinnerCalled, "Spinner start called")
        XCTAssertTrue(mockModel.authenticateCalled)
        XCTAssertTrue(mockDelegate.didSignInCalled)
        XCTAssertNil(mockDelegate.error)
    }
    
    func testFailedAuthentication() {
        mockModel.authResult = .failure(NSError(domain: "", code: 1, userInfo: nil))
        viewModel?.authenticateUser(withCredentials: mockAuthCredential)
        XCTAssertTrue(mockDelegate.startSpinnerCalled, "Spinner start called")
        XCTAssertTrue(mockModel.authenticateCalled)
        XCTAssertTrue(mockDelegate.failedSignInCalled)
        XCTAssertNotNil(mockDelegate.error)
        XCTAssertEqual(mockDelegate.error.code, 1)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
