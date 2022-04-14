//
//  unitTestingDemoTests.swift
//  unitTestingDemoTests
//
//  Created by M_AMBIN05643 on 13/04/22.
//

import XCTest
@testable import unitTestingDemo

class unitTestingDemoTests: XCTestCase {

    var viewModel: MovieViewModel?
    var mockServiceManager: MockServiceManager!
    var delegate: cellTappedDelegate?
    var selectedIndex: Int?
    var expectation: XCTestExpectation?
    
    override func setUpWithError() throws {
        delegate.self = self
        mockServiceManager = MockServiceManager()
        viewModel = MovieViewModel(manager: mockServiceManager)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        mockServiceManager = nil
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPICalling(){
        let expectation = expectation(description: "Load service data")
        viewModel?.getAPIResponseData {[weak self]  in
            guard let strongSelf = self else {return}
            XCTAssertEqual("Lil Durk", strongSelf.viewModel?.movieResponse?.feed?.results?[0].artistName ?? "")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 60, handler: nil)
    }

    func testProtocolDelegate() throws{
         expectation = expectation(description: "testing the protocol value")
        delegate?.cellIsTapped(at: 2)
        waitForExpectations(timeout: 10, handler: nil)
        
        let value = try XCTUnwrap(selectedIndex)
        XCTAssertEqual(value, 2, "value i sent is not matching")
    }
    
    func testEnumAssociatedCheckEqual(){
        let res1 = SocialPlatForm.twitter(subscribeCount: 20)
        let res2 = SocialPlatForm.twitter(subscribeCount: 20)
        XCTAssertEqual(res1, res2)
    }
    
    func testEnumAssociatedValue(){
        let res = viewModel?.getPlatform(index: 1, count: 20)
        if case res = SocialPlatForm.facebook(friendCount: 20){
            XCTAssert(true)
        }else {
            XCTAssert(false)
        }
    }
}

extension unitTestingDemoTests: cellTappedDelegate{
    func cellIsTapped(at row: Int) {
        selectedIndex = row
        expectation?.fulfill()
    }
}

