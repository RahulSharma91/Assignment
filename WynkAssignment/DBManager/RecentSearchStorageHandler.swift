//
//  ArchiveStorageHandler.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

class RecentSearchStorageHandler: NSObject {
    
    private var recentSeacrhArray: [RecentSearch] = []
    
    override init() {
        super.init()
        self.loadRecentSearches()
    }
    
    func saveSearchItem(recentSearch: RecentSearch) {
        
        if let firstIndex = self.getIndex(recentSearch: recentSearch) {
            self.recentSeacrhArray.remove(at: firstIndex)
            self.recentSeacrhArray.insert(recentSearch, at: 0)
        } else {
            self.recentSeacrhArray.insert(recentSearch, at: 0)
            if self.recentSeacrhArray.count >= 10 {
                _ = self.recentSeacrhArray.dropLast()
            }
        }
        self.sortRecentSearches()        
        self.saveRecentSearches()
    }
    
    func getRecentSearches() -> [RecentSearch] {
        return self.recentSeacrhArray
    }
    
    func clearSearches() {
        self.recentSeacrhArray.removeAll()
        self.saveRecentSearches()
    }
    
    private func loadRecentSearches() {
        
        if let data = UserDefaults.standard.data(forKey: UserDefaultConstants.recentSearches) {
            let result =  try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [RecentSearch]
            self.recentSeacrhArray = result ?? []
        }
    }
    
    private func saveRecentSearches() {
        do{
            let archive = try NSKeyedArchiver.archivedData(withRootObject: self.recentSeacrhArray, requiringSecureCoding: false)
            UserDefaults.standard.set(archive, forKey: UserDefaultConstants.recentSearches)
        } catch {
            print("Error occured \(error)")
        }
    }
    
    private func getIndex(recentSearch: RecentSearch) -> Int? {
        if let firstIndex = self.recentSeacrhArray.firstIndex(where: { (searchItem) -> Bool in
            return  recentSearch.searchText.lowercased() == searchItem.searchText.lowercased()
        }) {
            return firstIndex
        } else {
            return nil
        }
        
    }
    
    private func sortRecentSearches() {
        self.recentSeacrhArray.sort { (recent1, recent2) -> Bool in
            return recent1.searchDate > recent2.searchDate
        }
    }
    
}
