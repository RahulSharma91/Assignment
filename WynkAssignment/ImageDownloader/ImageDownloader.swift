//
//  ImageDownloader.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import UIKit
import Foundation

/*
 @abstract Block to handle the server response
 */
typealias completionBlock = (_ image: UIImage?,_ error:Error?, _ urlString:String?) -> Void

class ImageDownloader: NSObject {

    ///shared instance of the manager
    static let sharedInstance = ImageDownloader()
    
    ///cache that is used to cache the images
    var cache:NSCache<NSString, UIImage>!
    
    ///download operation queue
    var operationQueue:OperationQueue!
    
    ///reachability object to track network status
    var reachability: Reachability!
    
    private override init() {
        super.init()
        cache = NSCache()
        operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        reachability = Reachability()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    deinit {
        reachability.stopNotifier()
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        if reachability.connection != .none{
             self.resumeDownloadQueue()
        }else{
            self.suspendDownloadQueue()
        }
    }
    
    /*!
     * @brief this method is used to download images
     */
    func getImageFor(url:String, callBack:completionBlock?) -> Operation?{
        if let cachedImage = cache.object(forKey: url as NSString) {
            if let completionCallBack = callBack{
                completionCallBack(cachedImage, nil,url)
                return nil;
            }
        } else {
            let imageDownloadOperation = ImageDownloadOperation.init(url)
            imageDownloadOperation.onCompletion(onCompletion: {[unowned self] (image, error, urlString) in
                if let downloadedImage = image{
                    self.cache.setObject(downloadedImage, forKey: url as NSString)
                }
                if let completionCallBack = callBack{
                    completionCallBack(image, error,url)
                }
            })
            imageDownloadOperation.queuePriority = .high
            operationQueue.addOperation(imageDownloadOperation)
            return imageDownloadOperation
        }
        return nil
    }
    
    /*!
     * @brief this method is used to cancel all operations
     */
    func cancelAllOperation(){
        self.operationQueue.cancelAllOperations()
    }
    
    /*!
     * @brief this method is used to suspend the operation queue
     */
    func suspendDownloadQueue(){
        self.operationQueue.isSuspended = true
    }
    
    /*!
     * @brief this method is used to low the priority that are not visible
     */
    func resumeDownloadQueue(){
        self.operationQueue.isSuspended = false
    }
    
}
