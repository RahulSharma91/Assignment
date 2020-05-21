//
//  DBManager.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

class DBManager {
    
    static let shared = DBManager()
    
    lazy var storageHandler = RecentSearchStorageHandler()
    
    private init() {}
    
    func getRecentSearches() -> [RecentSearch] {
        storageHandler.getRecentSearches()
    }

    func saveRecentSearch(recentsearch:RecentSearch) {
        storageHandler.saveSearchItem(recentSearch: recentsearch)
    }
    
    func clearRecentSearches() {
        storageHandler.clearSearches()
    }
     
 }
