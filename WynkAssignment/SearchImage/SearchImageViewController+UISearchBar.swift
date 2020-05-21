//
//  SearchImageViewController+UISearchBar.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import UIKit

// MARK:- UISearchBarDelegate Methods

/**
 * This extension contains code related search controller.
 *
 */
extension SearchImageViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()

        guard let term = searchBar.text , !term.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        self.getPhotos(searchText: term)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetSearch()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func resetSearch() {
        self.searchString = ""
        self.presenter.reset()
    }

    func getPhotos(searchText: String){
        self.searchString = searchText
        self.presenter.getPhotos(searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.resetSearch()
        checkIfSuggestionAvailable(searchText: searchBar.text ?? "")
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        suggestionTableView.isHidden = true
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        checkIfSuggestionAvailable(searchText: searchText)
    }
    
    /*
     check if there is any suggestion to show for corresponding search
     */
    func checkIfSuggestionAvailable(searchText: String) {
        self.presenter.checkIfSuggestionsAvailable(searchText)
        suggestionTableView.isHidden = !self.presenter.canShowSuggestions()
    }

}
