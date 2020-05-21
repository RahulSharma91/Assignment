//
//  SearchImageViewModel.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation
import UIKit

/**
 * This class acts as presenter for ViewController
 *
 */
class SearchImageViewPresenter:NSObject,SearchImageViewPresenterProtocol {
    
    /// object of view for which this class acts as presenter
    weak var view:SearchImagePresenterViewProtocol?
    
    var interactor:SearchImagePresenterInteractorProtocol!
    
    var router:SearchImagePresenterRouterProtocol!
    
    /// search text to be searched
    var searchText:String = ""
    
    /// data model which has to be populated on the view
    var searchImageArray:[SearchImage]?
    
    /// bool which indicates current api is in progress
    var callInProgress = false
    
    /// SuggestionsArray
    var suggestions:[RecentSearch]?
    
    /// bool to decide whether to load more data or not
    var shouldLoadMoreData: Bool = true
    
    var pageNo = 0
    
    init(with delegate:SearchImagePresenterViewProtocol) {
        self.view = delegate
        super.init()
    }
    
    /**
     * This method is used to get data from API
     *
     */
    func getPhotos(_ searchText:String?){
        
        guard let currentSearchText = searchText else {
            return
        }
        //if call is already in progress then simply return
        if callInProgress {
            return
        }
        //check if search text are not same then reset the view
        if self.searchText != currentSearchText  {
            self.reset()
        }
        self.searchText = currentSearchText
        
        if let searchArray = self.searchImageArray, !searchArray.isEmpty{
            self.pageNo = self.pageNo + 1
        } else {
            self.pageNo =  1
            self.view?.showLoader()
        }
        
        self.callInProgress = true
        
        self.interactor.getImages(currentSearchText,pageNo:pageNo ) { [weak self] (searchResult,searchString ,error) in
            guard let `self` = self else { return }
            if !self.shouldLoadMoreData{
                return
            }
            self.callInProgress = false
            self.view?.hideLoader()
            if self.searchText != searchString{
                return
            }
            if let searchError = error{
                self.shouldLoadMoreData = false
                self.view?.onErrorOccurred(errorMsg: searchError.localizedDescription, showAlert: (self.searchImageArray == nil))
            } else if let result = searchResult {
                if let photosArray = result.searchImagesArray {
                    if self.searchImageArray == nil{
                        self.searchImageArray = photosArray
                    }else{
                        self.searchImageArray?.append(contentsOf: photosArray)
                    }
                    self.view?.reloadView(self.searchImageArray)
                }
            } else {
                self.shouldLoadMoreData = false
                self.view?.onErrorOccurred(errorMsg: "Something went wrong", showAlert: (self.searchImageArray == nil))
            }
        }
    }
    
    /**
     * This method is used to reset the view
     *
     */
    func reset() {
        self.pageNo = 0
        self.searchImageArray = nil
        self.view?.reloadView(nil)
        self.suggestions = nil
        ImageDownloader.sharedInstance.cancelAllOperation()
    }
    
    func checkIfSuggestionsAvailable(_ searchText:String) {
        let suggestions = self.interactor.getRecentSearches()
        if searchText.isEmpty {
            self.suggestions = suggestions
        } else {
            self.suggestions = suggestions.filter( { $0.searchText.lowercased().contains(searchText.lowercased())})
        }
        self.view?.reloadSuggestions()
    }
    
    func canShowSuggestions() -> Bool {
        guard  let suggestions = self.suggestions else {
            return false
        }
        
        return !suggestions.isEmpty
    }
    
    func callBackOnImageSelection(index:Int) {
        if let viewCtrl = self.view as? UIViewController, let imagesArray = self.searchImageArray {
            self.router.pushToFullScreenImageViewController(sourceView: viewCtrl, searchData: imagesArray, index: index)
        }
    }
}
