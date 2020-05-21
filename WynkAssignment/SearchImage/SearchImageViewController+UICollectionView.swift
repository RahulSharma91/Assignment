//
//  SearchImageViewController+UICollectionView.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import UIKit

//MARK:- Collection View FlowLayout Delegate Methods
extension SearchImageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return mininumInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return mininumInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isLoadingIndexPath(indexPath){
            let side = UIScreen.main.bounds.size.width - (2 * contentInset)
            return CGSize(width: side, height: 44)
        }else{
            return self.getImageCellSize()
        }
    }
    
    private func getImageCellSize() -> CGSize{
        let screenWidth = UIScreen.main.bounds.size.width
        let side = screenWidth - (2 * contentInset) - (mininumInterItemSpacing * (cellsPerRow - 1))
        return CGSize(width: side/cellsPerRow, height: side/cellsPerRow)
    }
}

//MARK:- Collection View DataSource Methods
extension SearchImageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let imagesDataArray = self.presenter.searchImageArray else {
            return 0
        }
        if imagesDataArray.count > 0{
            return shouldLoadMoreData ? imagesDataArray.count + 1 : imagesDataArray.count
        }else{
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isLoadingIndexPath(indexPath){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadMoreCollectionViewCellID", for: indexPath) as? LoadMoreCollectionViewCell else {
                fatalError("Failed to initialize LoadMoreCollectionViewCell")
            }
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCellID", for: indexPath) as? SearchImageCollectionViewCell else {
            fatalError("Failed to initialize ImageCollectionCell")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard  let imagesDataArray = self.presenter.searchImageArray else{
            return
        }
        if indexPath.item == imagesDataArray.count - 1 && self.shouldLoadMoreData  {
            self.presenter.getPhotos(self.searchString)
        } else if let photoArray = self.presenter.searchImageArray, let photoCell = cell as? SearchImageCollectionViewCell{
            let item = photoArray[indexPath.row]
            if let imageUrl = item.previewURL {
                photoCell.itemImageView.setImage(url: imageUrl)
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.callBackOnImageSelection(index:indexPath.item)
    }
}
