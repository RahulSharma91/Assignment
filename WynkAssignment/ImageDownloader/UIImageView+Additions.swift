//
//  UIImageView+Additions.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation
import UIKit

struct AssociatedKeys {
    static var associatedOperations: String = "associatedOperations"
    static var lastActiveUrl: String = "lastActiveUrl"
}

extension UIImageView {
    
    /// associatedOperations dictionary contains url as key and value as operation corresponding to the url
    var associatedOperations:[String:Operation]?{
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.associatedOperations) as? [String:Operation] else {
                return nil
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.associatedOperations, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// lastActiveUrl will have the value of the url that is used to set image last time as in case of collection view and table view same imageview can be reused multiple times
    var lastActiveUrl:String{
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.lastActiveUrl) as? String else {
                return ""
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.lastActiveUrl, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    
    func setImage(url:String, completionBlock:completionBlock? = nil ){
        self.lastActiveUrl = url
        if let associatedOperations = self.associatedOperations, let addedOperation = associatedOperations[url]{
            addedOperation.queuePriority = .high
            //lower others priority
            for urlKey in associatedOperations.keys {
                if urlKey != url{
                    associatedOperations[urlKey]?.queuePriority = .low
                }
            }
        }else{
            /// if new image is required to download then ImageDownloadManager's method will return operation corresponding to downloading image, which is then added to associated operations dictionary, else download operation will be nil when image is in cache and completion block is used to set downloaded image after downloading image.
            if let downloadOperation = ImageDownloader.sharedInstance.getImageFor(url: url, callBack: { [weak self] (image, error, urlString) in
                if let lastActiveURL = self?.lastActiveUrl, let downloadedImage = image, let downloadedUrl = urlString{
                    self?.associatedOperations?.removeValue(forKey: downloadedUrl)
                    if lastActiveURL == urlString {
                        if let completionCallBack = completionBlock{
                            completionCallBack(image, error,url)
                        } else {
                            DispatchQueue.main.async {
                               self?.image = downloadedImage
                            }
                        }
                    }
                }
            }){
                if self.associatedOperations == nil{
                    self.associatedOperations = [String:Operation]()
                }
                self.associatedOperations?[url] = downloadOperation
            }
        }
    }
    
}
