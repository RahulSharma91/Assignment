//
//  FullScreenImageViewController+UICollectionView.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import UIKit

extension FullScreenImageViewController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.imagesCount()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullScreenImageCollectionViewCell", for: indexPath) as? FullScreenImageCollectionViewCell {
            cell.configureCell(searchImage: self.presenter.getImageSearch(indexPath.row))
            return cell
        }
        return  UICollectionViewCell()
    }
}

extension FullScreenImageViewController: UICollectionViewDelegate {
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        animateImageTransition = true
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        animateImageTransition = false
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? FullScreenImageCollectionViewCell {
            cell.setNewImage(animated: animateImageTransition)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if let cell = view as? FullScreenImageCollectionViewCell {
            collectionView.layoutIfNeeded()
            cell.setNewImage(animated: animateImageTransition)
        }
    }
}
