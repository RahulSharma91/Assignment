//
//  SearchImageViewInteractorMock.swift
//  WynkAssignmentTests
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation
@testable import WynkAssignment

class SearchImageViewInteractorMock {
    
    weak var presenter:SearchImageViewPresenterProtocol?
    
    init(presenter:SearchImageViewPresenterProtocol) {
        self.presenter = presenter
    }
}

extension SearchImageViewInteractorMock : SearchImagePresenterInteractorProtocol {
    
     func getImages(_ searchText:String,pageNo:Int, completionBlock:@escaping (SearchResult?,String ,Error?) -> Void){
        let recentSearch = RecentSearch(name: searchText)
        DBManager.shared.saveRecentSearch(recentsearch: recentSearch)
        completionBlock(self.getSearchResult(),searchText ,nil)
    }
    
    func getRecentSearches() -> [RecentSearch] {
        return DBManager.shared.getRecentSearches()
    }
    
    private func getSearchResult() -> SearchResult? {
        var searchImageArray = [SearchImage]()
        for _ in 0...10 {
            let searchObj = SearchImage(id: 1, pageURL: "", type: nil, tags: nil, previewURL: "https://ggogle.com", previewWidth: nil, previewHeight: nil, webformatURL: nil, webformatWidth: nil, webformatHeight: nil, largeImageURL: "https://ggogle.com", imageWidth: nil, imageHeight: nil, imageSize: nil, views: nil, downloads: nil, favorites: nil, likes: nil, comments: nil, user: nil, userImageURL: nil, userID: nil)
            searchImageArray.append(searchObj)
        }
        
       return SearchResult(total: 11, totalHits: 1, searchImagesArray: searchImageArray)
    }
}
