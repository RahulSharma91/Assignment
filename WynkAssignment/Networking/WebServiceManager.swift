//
//  WebserviceManager.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

class WebServiceManager {
    
    static func getImages(_ searchText:String,pageNo:Int, completionBlock:@escaping (SearchResult?,String ,Error?) -> Void){
        
        guard let searchURL = WebServiceUtility.searchImageURLForSearchText(searchText,pageNo:pageNo ) else {
            completionBlock(nil,searchText, WebServiceUtility .getUnknownError())
            return
        }
        let searchRequest = URLRequest(url: searchURL)

        APIHandler.request(urlRequest: searchRequest) { (responseDict, error) in
                if let _ = error{
                    completionBlock(nil,searchText, error)
                } else {
                 completionBlock(ResponseParser.parsePhotoSearchApiResponse(responseDataDict: responseDict),searchText,nil)
            }
        }
    }

    
    
}
