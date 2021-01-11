//
//  HomeListViewModelTests.swift
//  B-PlayerTests
//
//  Created by user on 11/01/21.
//

import XCTest
@testable import B_Player
class HomeListViewModelTests: XCTestCase {

    var mockModel: MockHomeListModel!
    var mockDelegate:MockHomeListViewDelegate!
    var viewModel:HomeListViewModel!
    override func setUp() {
        mockModel = MockHomeListModel()
        mockDelegate = MockHomeListViewDelegate()
        viewModel =  HomeListViewModel(withViewDelegate: mockDelegate, withModel: mockModel)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOnSuccessfulFetchVideos() {
        viewModel.fetchVideos()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            XCTAssertTrue(self.mockDelegate.startSpinnerCalled)
            XCTAssertTrue(self.mockModel.fetchVideosCalled)
            XCTAssertTrue(self.mockDelegate.stopSpinnerCalled)
            XCTAssertTrue(self.mockDelegate.reloadCalled)
        }

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
