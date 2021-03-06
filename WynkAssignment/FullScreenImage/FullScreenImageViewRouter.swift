//
//  FullScreenImageViewRouter.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

class FullScreenImageViewRouter {
    
    weak var presenter:FullScreenImageViewPresenterProtocol?
    
    init(presenter:FullScreenImageViewPresenterProtocol) {
        self.presenter = presenter
    }
}

extension FullScreenImageViewRouter :FullScreenImagePresenterRouterProtocol {
    
}
