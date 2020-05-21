//
//  APIHandler.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

typealias serviceArrayResponse = (_ data: [Any]?,_ error:Error?) -> Void

typealias serviceDictResponse = (_ data: [String:Any]?,_ error:Error?) -> Void

class APIHandler {
    static func GET(urlRequest : URLRequest, completionBlock:@escaping serviceDictResponse) {
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if let _ = error {
                completionBlock(nil, error)
                return
            }
            
            guard let _ = response as? HTTPURLResponse,
                let data = data else {
                    completionBlock(nil, WebServiceUtility .getUnknownError())
                    return
            }
            
            do {
                
                guard let resultsDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] else {
                        completionBlock(nil, WebServiceUtility .getUnknownError())
                        return
                }
                
                completionBlock(resultsDictionary,nil)
            }catch _ {
                completionBlock(nil, WebServiceUtility .getUnknownError())
                return
            }
        }) .resume()
    }

}
