//
//  FullScreenImageCollectionViewCell.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import UIKit

class FullScreenImageCollectionViewCell: UICollectionViewCell {
    
    /// IBOutlet for Scroll View of type UIScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    /// IBOutlet for ImageVIew  of type UIImageView
    @IBOutlet weak var imageView: UIImageView!
        
    /// Reuse Idenitifer associated to this cell
    static let reuseIdentifier = "FullScreenImageCollectionViewCell"
    
    /// nib associated to this cell of type UINib
    static let nib = UINib(nibName: reuseIdentifier, bundle: nil)
    
    var image:UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.setNewImage(animated: false)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        scrollView.maximumZoomScale = 1.0
        addDoubleTapGesture()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: "placeHolderImage")
    }
    
    func configureCell(searchImage: SearchImage?) {
       
        imageView.image = UIImage(named: "placeHolderImage")
        
        guard let imageDetailObj = searchImage, let imageUrl = imageDetailObj.largeImageURL else {
            return
        }
        
        imageView.setImage(url: imageUrl,completionBlock: { [weak self] (image, error, urlString) in
            DispatchQueue.main.async {
                if let image = image {
                    self?.image = image
                    self?.scrollView.delegate = self
                    self?.scrollView.maximumZoomScale = 2.0
                }else{
                    self?.scrollView.delegate = nil
                }
            }
        })
    }
    
    func setNewImage(animated: Bool = true) {
        
        imageView.image = image
        setZoomScale()
        scrollViewDidZoom(scrollView)

        if animated {
            imageView.alpha = 0.0
            UIView.animate(withDuration: 0.5) {
                self.imageView.alpha = 1.0
            }
        }
    }
    
    // MARK: Private Methods
    private func addDoubleTapGesture() {
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(callBackOnDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
    
    @objc public func callBackOnDoubleTap(recognizer: UITapGestureRecognizer) {
        
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
    private func setZoomScale() {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.setZoomScale(scrollView.minimumZoomScale, animated: false)
    }
}

extension FullScreenImageCollectionViewCell: UIScrollViewDelegate {
    
   public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
           return imageView
   }
       
   public func scrollViewDidZoom(_ scrollView: UIScrollView) {
       
       let imageViewSize = imageView.frame.size
       let scrollViewSize = scrollView.bounds.size
       
       let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
       let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
       
       if verticalPadding >= 0 {
           scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
       } else {
           scrollView.contentSize = imageViewSize
       }
   }
}
