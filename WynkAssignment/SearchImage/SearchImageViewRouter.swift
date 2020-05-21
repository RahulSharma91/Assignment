//
//  SearchImageViewRouter.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation
import UIKit

class SearchImageViewRouter {
    
    weak var presenter:SearchImageViewPresenterProtocol?
    
    init(presenter:SearchImageViewPresenterProtocol) {
        self.presenter = presenter
    }
}

extension SearchImageViewRouter : SearchImagePresenterRouterProtocol {
    
    func pushToFullScreenImageViewController(sourceView: UIViewController,searchData: [SearchImage], index: Int) {
        let viewCtrl = FullScreenImageViewController.instantiateViewController(imagesArray: searchData, currentImageIndex: index)
        viewCtrl.backgroundColor = UIColor.black
        sourceView.navigationController?.pushViewController(viewCtrl, animated: true)
    }
    
}
