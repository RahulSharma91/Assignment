//
//  AppConstants.swift
//  WynkAssignment
//
//  Created by Rahul Sharma on 21/05/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

public struct UserDefaultConstants {
    static let recentSearches = "recentSearches"
}

public struct APIConstants {
    static let baseUrl = "https://pixabay.com/api/"
    static let apiKey = "16657112-59d5ba88bcc2cb8e7a2eb4bd2"
    static let searchImageURLEndPoint = "%@?key=\(APIConstants.apiKey)&q=%@&page=%d&image_type=photo"
    static let perPage = "20"
}
