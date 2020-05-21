//
//  FullScreenImageViewPresenterTest.swift
//  WynkAssignmentTests
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import XCTest
@testable import WynkAssignment

class FullScreenImageViewPresenterTest: XCTestCase {

    private var sut: FullScreenImageViewPresenter!
    
    override func setUp() {
        sut = FullScreenImageViewPresenter(with: FullScreenImageViewMock())
        sut.interactor = FullScreenImageViewInteractor(presenter: sut)
        sut.router = FullScreenImageViewRouter(presenter: sut)
    }

    override func tearDown() {
        sut = nil
    }
    
    func testGetImageSearch() {
        XCTAssertNil(sut.getImageSearch(5))
        sut.searchImageArray = self.getSearchImageList()
        XCTAssertNotNil(sut.getImageSearch(5))
    }

    func testImagesCount() {
        XCTAssertEqual(sut.imagesCount(),0)
        sut.searchImageArray = self.getSearchImageList()
        XCTAssertEqual(sut.imagesCount(),11)
        
    }
    
    private func getSearchImageList() -> [SearchImage] {
        var searchImageArray = [SearchImage]()
        for _ in 0...10 {
            let searchObj = SearchImage(id: 1, pageURL: "", type: nil, tags: nil, previewURL: "https://ggogle.com", previewWidth: nil, previewHeight: nil, webformatURL: nil, webformatWidth: nil, webformatHeight: nil, largeImageURL: "https://ggogle.com", imageWidth: nil, imageHeight: nil, imageSize: nil, views: nil, downloads: nil, favorites: nil, likes: nil, comments: nil, user: nil, userImageURL: nil, userID: nil)
            searchImageArray.append(searchObj)
        }
        
       return searchImageArray
    }

}
