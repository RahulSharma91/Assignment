//
//  FullScreenImageViewPresenter.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation
import UIKit

/**
 * This class acts as presenter for ViewController
 *
 */
class FullScreenImageViewPresenter:NSObject,FullScreenImageViewPresenterProtocol {
    
    var interactor:FullScreenImagePresenterInteractorProtocol!
    
    var router:FullScreenImagePresenterRouterProtocol!
    
    /// object of view for which this class acts as presenter
    weak var view:FullScreenImagePresenterViewProtocol?
        
    /// data model which has to be populated on the view
    var searchImageArray:[SearchImage]?

    ///current index of the image to be scrolled
    var currentPage: Int = 0
    
    init(with delegate:FullScreenImagePresenterViewProtocol) {
        self.view = delegate
        super.init()
    }
    
    func getImageSearch(_ index : Int)  -> SearchImage? {
        guard let imagesArray = self.searchImageArray else { return nil }
        if imagesArray.indices.contains(index) {
            return imagesArray[index]
        }
        return nil
    }
    
    func imagesCount() -> Int {
        guard let imagesArray = self.searchImageArray else { return 0 }
        return imagesArray.count
    }
    
}
