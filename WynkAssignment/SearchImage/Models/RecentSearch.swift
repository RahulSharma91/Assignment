//
//  RecentSearch.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

public class RecentSearch: NSObject, NSCoding {
    
    var searchText: String
    var searchDate: Date = Date()
    
    
    required init(name: String) {
        self.searchText = name
    }
    
    required public init(coder decoder: NSCoder) {
        searchText = decoder.decodeObject(forKey: Constants.searchText) as? String ?? ""
        searchDate = decoder.decodeObject(forKey: Constants.searchDate) as? Date ?? Date()
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(searchText, forKey: Constants.searchText)
        coder.encode(searchDate, forKey: Constants.searchDate)
    }
    
}

fileprivate struct Constants {
    static let searchText = "searchText"
    static let searchDate = "searchDate"
}
