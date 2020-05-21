//
//  SearchImageViewController+UITableView.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import UIKit


extension SearchImageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard  let suggestions = self.presenter.suggestions else {
            return 0
        }
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        
        if let suggestionsArray = self.presenter.suggestions, suggestionsArray.count > indexPath.row {
            let suggestion = suggestionsArray[indexPath.row]
            cell.textLabel?.text = suggestion.searchText
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let suggestionsArray = self.presenter.suggestions, suggestionsArray.count > indexPath.row {
            let suggestion = suggestionsArray[indexPath.row]
            self.searchBar.text = suggestion.searchText
            searchBar.resignFirstResponder()
            self.getPhotos(searchText: suggestion.searchText)
        }
    }
}
