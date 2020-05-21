//
//  SearchResult.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 20/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

public struct SearchResult: Codable {
    let total: Int?
    let totalHits: Int?
    let searchImagesArray: [SearchImage]?
    
    enum CodingKeys: String, CodingKey {
        case total, totalHits
        case searchImagesArray = "hits"
    }
}
