//
//  FullScreenImageProtocols.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

public protocol FullScreenImageViewPresenterProtocol:class{
    var currentPage: Int { get set}
    var searchImageArray:[SearchImage]? {get set }
    func imagesCount() -> Int
    func getImageSearch(_ index : Int)  -> SearchImage?
}

public protocol FullScreenImagePresenterViewProtocol:class{
    func reloadView()
}

public protocol FullScreenImagePresenterInteractorProtocol:class{

}

public protocol FullScreenImagePresenterRouterProtocol:class{
    
}
