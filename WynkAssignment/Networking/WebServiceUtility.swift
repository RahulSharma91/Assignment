//
//  WebServiceUtility.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

/**
 * This class acts as utility for network operation
 *
 */
class WebServiceUtility {
    
    static func searchImageURLForSearchText(_ searchText:String, pageNo:Int) -> URL? {
        
        guard let urlString =  String.init(format: APIConstants.searchImageURLEndPoint,APIConstants.baseUrl,searchText,pageNo).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        guard let url = URL(string:urlString) else {
            return nil
        }
        
        return url
    }
    
    static func getUnknownError() -> Error{
        return NSError(domain: "UnknownError", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
    }
}

