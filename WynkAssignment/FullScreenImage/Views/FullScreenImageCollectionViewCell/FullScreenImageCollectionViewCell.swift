//
//  FullScreenImageCollectionViewCell.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import UIKit

class FullScreenImageCollectionViewCell: UICollectionViewCell {
    
    var image:UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.setNewImage(animated: false)
            }
        }
    }
    
    let scrollView: UIScrollView
    let imageView: UIImageView
    
    override init(frame: CGRect) {
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView = UIScrollView(frame: frame)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        var scrollViewConstraints: [NSLayoutConstraint] = []
        var imageViewConstraints: [NSLayoutConstraint] = []
        
        scrollViewConstraints.append(NSLayoutConstraint(item: scrollView,
                                                        attribute: .leading,
                                                        relatedBy: .equal,
                                                        toItem: contentView,
                                                        attribute: .leading,
                                                        multiplier: 1,
                                                        constant: 0))
        
        scrollViewConstraints.append(NSLayoutConstraint(item: scrollView,
                                                        attribute: .top,
                                                        relatedBy: .equal,
                                                        toItem: contentView,
                                                        attribute: .top,
                                                        multiplier: 1,
                                                        constant: 0))
        
        scrollViewConstraints.append(NSLayoutConstraint(item: scrollView,
                                                        attribute: .trailing,
                                                        relatedBy: .equal,
                                                        toItem: contentView,
                                                        attribute: .trailing,
                                                        multiplier: 1,
                                                        constant: 0))
        
        scrollViewConstraints.append(NSLayoutConstraint(item: scrollView,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: contentView,
                                                        attribute: .bottom,
                                                        multiplier: 1,
                                                        constant: 0))
        
        contentView.addSubview(scrollView)
        contentView.addConstraints(scrollViewConstraints)
        
        imageViewConstraints.append(NSLayoutConstraint(item: imageView,
                                                       attribute: .leading,
                                                       relatedBy: .equal,
                                                       toItem: scrollView,
                                                       attribute: .leading,
                                                       multiplier: 1,
                                                       constant: 0))
        
        imageViewConstraints.append(NSLayoutConstraint(item: imageView,
                                                       attribute: .top,
                                                       relatedBy: .equal,
                                                       toItem: scrollView,
                                                       attribute: .top,
                                                       multiplier: 1,
                                                       constant: 0))
        
        imageViewConstraints.append(NSLayoutConstraint(item: imageView,
                                                       attribute: .trailing,
                                                       relatedBy: .equal,
                                                       toItem: scrollView,
                                                       attribute: .trailing,
                                                       multiplier: 1,
                                                       constant: 0))
        
        imageViewConstraints.append(NSLayoutConstraint(item: imageView,
                                                       attribute: .bottom,
                                                       relatedBy: .equal,
                                                       toItem: scrollView,
                                                       attribute: .bottom,
                                                       multiplier: 1,
                                                       constant: 0))
        
        scrollView.addSubview(imageView)
        scrollView.addConstraints(imageViewConstraints)
        imageView.image = UIImage(named: "placeHolderImage")
        scrollView.delegate = self
        scrollView.maximumZoomScale = 1.0
        addDoubleTapGesture()
    }
    
    override func prepareForReuse() {
        imageView.image = UIImage(named: "placeHolderImage")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNewImage(animated: Bool = true) {
        imageView.image = image
        imageView.sizeToFit()
        
        setZoomScale()
        scrollViewDidZoom(scrollView)
        
        if animated {
            imageView.alpha = 0.0
            UIView.animate(withDuration: 0.5) {
                self.imageView.alpha = 1.0
            }
        }
    }
    
    func configureCell(searchImage: SearchImage?) {
        guard let imageDetailObj = searchImage, let imageUrl = imageDetailObj.largeImageURL else {
            return
        }
        
        imageView.setImage(url: imageUrl,completionBlock: { [weak self] (image, error, urlString) in
            DispatchQueue.main.async {
                if let image = image{
                    self?.image = image
                    self?.scrollView.delegate = self
                    self?.scrollView.maximumZoomScale = 2.0
                }else{
                    self?.scrollView.delegate = nil
                }
            }
            
        })
    }
    
    
    // MARK: Private Methods
    
    private func addDoubleTapGesture() {
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(callBackOnDoubleTap(recognizer:)))
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

