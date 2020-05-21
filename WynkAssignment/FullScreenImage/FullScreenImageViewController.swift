//
//  FullScreenImageViewController.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    
    class func instantiateViewController(imagesArray: [SearchImage], currentImageIndex: Int) -> FullScreenImageViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewCtrl = storyboard.instantiateViewController(withIdentifier: "FullScreenImageViewController") as! FullScreenImageViewController
        let presenter = FullScreenImageViewPresenter(with: viewCtrl)
        presenter.interactor = FullScreenImageViewInteractor(presenter: presenter)
        presenter.router = FullScreenImageViewRouter(presenter: presenter)
        presenter.searchImageArray = imagesArray
        presenter.currentPage = currentImageIndex
        viewCtrl.presenter = presenter
        return viewCtrl
    }

    @IBOutlet weak var searchImageDetailCollectionView: UICollectionView!

    var presenter:FullScreenImageViewPresenterProtocol!
    
    var animateImageTransition = false
    
    public var numberOfImages: Int {
        return self.presenter.imagesCount()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        if self.presenter.currentPage != 0 {
            scrollToSelectedImage()
        }
    }
    
    private func initialSetup() {
        self.view.backgroundColor = UIColor.black
        registerNibs()
        searchImageDetailCollectionView.dataSource = self
        searchImageDetailCollectionView.delegate = self
    }
    
    private func registerNibs() {
        searchImageDetailCollectionView.register(FullScreenImageCollectionViewCell.nib, forCellWithReuseIdentifier: FullScreenImageCollectionViewCell.reuseIdentifier)
    }
    
    private func scrollToImage(withIndex: Int, animated: Bool = false) {
        searchImageDetailCollectionView.scrollToItem(at: IndexPath(item: withIndex, section: 0), at: .centeredHorizontally, animated: animated)
    }
    
    private func scrollToSelectedImage() {
        if self.presenter.currentPage < numberOfImages {
            scrollToImage(withIndex: self.presenter.currentPage, animated: false)
        } else {
            scrollToImage(withIndex: numberOfImages - 1, animated: false)
        }
    }

}

extension FullScreenImageViewController: FullScreenImagePresenterViewProtocol {
    
    func reloadView() {
        self.searchImageDetailCollectionView.reloadData()
    }
    
}


