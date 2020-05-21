//
//  SeacrhImageViewMock.swift
//  WynkAssignmentTests
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation
import UIKit

@testable import WynkAssignment

class SearchImageViewMock:UIViewController, SearchImagePresenterViewProtocol {
        
    func reloadView(_ data:[SearchImage]?) {
        
    }
    
    func showLoader() {
        
    }
    
    func hideLoader() {
        
    }
    
    func reloadSuggestions() {
        
    }
    
     func onErrorOccurred(errorMsg: String, showAlert:Bool) {
        
    }
}
