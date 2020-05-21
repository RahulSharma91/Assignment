//
//  SearchImageViewRouter.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

class SearchImageViewRouter {
    
    weak var presenter:SearchImageViewPresenterProtocol?
    
    init(presenter:SearchImageViewPresenterProtocol) {
        self.presenter = presenter
    }
}
