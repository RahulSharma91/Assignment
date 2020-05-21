//
//  SearchImageViewInteractor.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

class SearchImageViewInteractor {
    
    weak var presenter:SearchImageViewPresenterProtocol?
    
    init(presenter:SearchImageViewPresenterProtocol) {
        self.presenter = presenter
    }
}

extension SearchImageViewInteractor : SearchImagePresenterInteractorProtocol {
    
     func getImages(_ searchText:String,pageNo:Int, completionBlock:@escaping (SearchResult?,String ,Error?) -> Void){
        
        WebServiceManager.getImages(searchText,pageNo:pageNo ) { (searchResult,searchString ,error) in
                
             if let result = searchResult {
                if let photosArray = result.searchImagesArray,photosArray.count > 0  {
                    //Save recent searches
                    let recentSearch = RecentSearch(name: searchString)
                    DBManager.shared.saveRecentSearch(recentsearch: recentSearch)
                }
            }
            completionBlock(searchResult,searchString ,error)
        }
    }
    
    func getRecentSearches() -> [RecentSearch] {
        return DBManager.shared.getRecentSearches()
    }
}
