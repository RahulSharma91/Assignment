//
//  ImageDownloadOperation.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloadOperation: Operation {
    
    ///url string of the image to download
    let imageURL:String
    
    //response block
    var callBackBlock:completionBlock?
    
    init(_ imageURL:String) {
        self.imageURL = imageURL
    }
    
    override var isAsynchronous: Bool { return true }
    
    override var isExecuting: Bool { return state == .executing }
    
    override var isFinished: Bool { return state == .finished }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    enum State: String {
        case ready = "Ready"
        case executing = "Executing"
        case finished = "Finished"
        fileprivate var keyPath: String { return "is" + self.rawValue }
    }
    
    override func start() {
        if self.isCancelled {
            state = .finished
        } else {
            state = .ready
            main()
        }
    }
    
    override func main() {
        if self.isCancelled {
            state = .finished
        } else {
            state = .executing
            self.completeOperation()
        }
    }
    
    private func completeOperation(){
        let url = URL(string: imageURL)
        URLSession.shared.dataTask(with: url!, completionHandler: {[weak self] (data, response, error) in
            if let completionBlock = self?
                .callBackBlock{
                if error != nil {
                    completionBlock(nil,error,self?.imageURL)
                }else{
                    completionBlock(UIImage(data: data!),nil,self?.imageURL)
                }
            }
            self?.state = .finished
        }).resume()
        URLSession.shared.finishTasksAndInvalidate()
    }
    
    func onCompletion(onCompletion:@escaping completionBlock){
        self.callBackBlock = onCompletion
    }
}
