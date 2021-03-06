//
//  SearchImageProtocols.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation
import UIKit

public protocol SearchImageViewPresenterProtocol:class{
    
    var searchImageArray:[SearchImage]? { get set}
    
    var suggestions:[RecentSearch]? { get set }
    
    var shouldLoadMoreData: Bool { get set }
    
    func getPhotos(_ searchText:String?)
    
    func reset()
        
    func checkIfSuggestionsAvailable(_ searchText:String)
    
    func canShowSuggestions() -> Bool
    
    func callBackOnImageSelection(index:Int)
}

public protocol SearchImagePresenterViewProtocol:class{
    func reloadView(_ data:[SearchImage]?)
    
    func showLoader()
    
    func hideLoader()
    
    func reloadSuggestions()
    
    func onErrorOccurred(errorMsg: String, showAlert:Bool)
}

public protocol SearchImagePresenterInteractorProtocol:class{
    
    func getImages(_ searchText:String,pageNo:Int, completionBlock:@escaping (SearchResult?,String ,Error?) -> Void)
    
    func getRecentSearches() -> [RecentSearch]
}

public protocol SearchImagePresenterRouterProtocol:class{
    
    func pushToFullScreenImageViewController(sourceView: UIViewController,searchData: [SearchImage], index: Int)
}
