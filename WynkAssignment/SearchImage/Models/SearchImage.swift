//
//  SearchImage.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

enum SearchType: String, Codable {
    case photo = "photo"
}

public struct SearchImage: Codable {
    
    let id: Int?
    let pageURL: String?
    let type: SearchType?
    let tags: String?
    let previewURL: String?
    let previewWidth: Int?
    let previewHeight: Int?
    let webformatURL: String?
    let webformatWidth: Int?
    let webformatHeight: Int?
    let largeImageURL: String?
    let imageWidth: Int?
    let imageHeight: Int?
    let imageSize: Int?
    let views: Int?
    let downloads: Int?
    let favorites: Int?
    let likes: Int?
    let comments: Int?
    let user: String?
    let userImageURL: String?
    let userID: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, favorites, likes, comments,user, userImageURL
        case userID = "user_id"
    }
}
