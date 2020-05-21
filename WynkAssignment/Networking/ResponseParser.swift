//
//  ResponseParser.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

/**
 * This class is responsible for parsing api response
 *
 */
class ResponseParser {

    static func parsePhotoSearchApiResponse(responseDataDict: [String:Any]?) -> SearchResult?{

        guard let responseDict = responseDataDict else {
            return nil
        }
        
        if let data = try? JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted) , let searchResponse = try? JSONDecoder().decode(SearchResult.self, from: data) {
            return searchResponse
        } else {
            return nil
        }
        
    }
}
