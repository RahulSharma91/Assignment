//
//  SearchImageViewController.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import UIKit

class SearchImageViewController: UIViewController {
        
    /// UICollectionView to populate images.
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    /// activityIndicator to show loading of data
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    /// placeholder imageview
    @IBOutlet weak var placeholderImageView: UIImageView!

    //tableview showing last searches
    @IBOutlet weak var suggestionTableView: UITableView!
    
    /// presenter of view
    var presenter:SearchImageViewPresenter!
    
    /// bool to decide whether to load more data or not
    var shouldLoadMoreData: Bool = true
    
    /// searchString contains text to be searched.
    var searchString = ""
    
    /// it decides no of cells in a row of UICollectionView
    var cellsPerRow: CGFloat = 2.0{
        didSet{
            self.imagesCollectionView.reloadData()
        }
    }
    
    let searchBar = UISearchBar()
    let mininumInterItemSpacing: CGFloat = 10.0
    let contentInset: CGFloat = 12
    
    //MARK:- Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Private Methods
    private func setupViews(){
        self.configureNavBar()
        self.configureCollectionView()
        activityIndicatorView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0);
        self.hideLoader()
        self.reloadView(nil)
        self.presenter = SearchImageViewPresenter(with: self)
        self.presenter.interactor = SearchImageViewInteractor(presenter: self.presenter)
        self.presenter.router = SearchImageViewRouter(presenter: self.presenter)
        self.suggestionTableView.isHidden = true
    }

    private func configureNavBar(){
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        addNavBarItems()
    }
        
    private func addNavBarItems() {
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    }
    
    @objc  func cancelButtonTapped(_ sender: UIBarButtonItem) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.resetSearch()
    }
    
    private func configureCollectionView(){
        self.registerCollectionView()
    }
    
    private func registerCollectionView(){
        let cellNib = UINib(nibName: "SearchImageCollectionViewCell", bundle: nil)
        imagesCollectionView.register(cellNib, forCellWithReuseIdentifier: "ImageCollectionCellID")
        
        let loadMoreNib = UINib(nibName: "LoadMoreCollectionViewCell", bundle: nil)
        imagesCollectionView.register(loadMoreNib, forCellWithReuseIdentifier: "LoadMoreCollectionViewCellID")
        
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
    }
    
    private func hideImageCollectionView(hide: Bool) {
        imagesCollectionView.isHidden = hide
        placeholderImageView.isHidden = !hide
    }
    
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldLoadMoreData, let imagesArray = self.presenter.searchImageArray else { return false}
        return indexPath.row == imagesArray.count
    }
}

// MARK:- Presenter Delegate Methods

/**
 * This extension contains all the protocol methods of the presenter.
 *
 */
extension SearchImageViewController: SearchImagePresenterViewProtocol{
    
    func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func reloadView(_ data: [SearchImage]?) {
        DispatchQueue.main.async {
            self.imagesCollectionView.reloadData()
            if let _ = data {
                self.hideImageCollectionView(hide: false)
            } else {
                self.hideImageCollectionView(hide: true)
            }
        }
    }
    
    func reloadSuggestions() {
        DispatchQueue.main.async {
            self.suggestionTableView.reloadData()
        }
    }
    
    func onErrorOccurred(errorMsg: String) {
        DispatchQueue.main.async {
            self.showAlert(with: "Error", message: errorMsg)
        }
    }
}

/**
 * This extension contains UITextfield delegate methods.
 *
 */
extension SearchImageViewController: UITextFieldDelegate{

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.resetSearch()
        textField.resignFirstResponder()
        return true
    }
}
