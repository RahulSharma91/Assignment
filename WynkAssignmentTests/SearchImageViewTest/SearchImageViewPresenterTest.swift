//
//  SearchImageViewPresenterTest.swift
//  WynkAssignmentTests
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import XCTest

@testable import WynkAssignment

class SearchImageViewPresenterTest: XCTestCase {

    private var sut: SearchImageViewPresenter!
    
    override func setUp() {
       sut =  SearchImageViewPresenter(with: SearchImageViewMock())
       sut.interactor = SearchImageViewInteractorMock(presenter: sut)
       sut.router = SearchImageViewRouter(presenter: sut)
    }

    override func tearDown() {
        sut = nil
    }

    func testGetPhotosForImagesCount() {
        sut.getPhotos("test")
        XCTAssertEqual(sut.searchImageArray?.count,11)
    }
   
    func testGetPhotosForLoader() {
        sut.getPhotos("test")
        XCTAssert(!sut.callInProgress)
    }
    
    func testReset() {
        sut.getPhotos("test")
        XCTAssertEqual(sut.searchImageArray?.count,11)
        sut.reset()
        XCTAssertNil(sut.searchImageArray)
    }
    
    func testCanShowSuggesstions() {
        sut.getPhotos("test")
        sut.checkIfSuggestionsAvailable("test")
        XCTAssert(sut.canShowSuggestions())
        sut.reset()
        XCTAssert(!sut.canShowSuggestions())
    }
    
    func testCallBackOnImageSelection() {
        sut.callBackOnImageSelection(index: 0)
    }

}
