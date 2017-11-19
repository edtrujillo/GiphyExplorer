//
//  ConstantUrls.swift
//  GiphyExplorer
//
//  Created by Edmund Trujillo on 11/18/17.
//  Copyright © 2017 Edmund Trujillo. All rights reserved.
//

import Foundation

fileprivate struct Constants {
    static let limitOfImages: Int = 200
    static let giphyAPIKey: String = "WhJR1a74kezphEzwzNs9tqz1rXhTdwNV"
    
    static let searchGif1: String = "https://api.giphy.com/v1/gifs/search?q="
    static let searchGif2: String = "&limit="
    static let trendingGif1: String = "https://api.giphy.com/v1/gifs/trending?limit="
    static let apiKeyPrefix: String = "&api_key="
}

func trendingUrlPath() -> String {
    return Constants.trendingGif1 + String(Constants.limitOfImages) +
        Constants.apiKeyPrefix + Constants.giphyAPIKey
}

func searchedUrlPath(_ searchTerm: String?) -> String {
    let sanitizedName = searchTerm?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    
    return Constants.searchGif1 + sanitizedName! +
        Constants.searchGif2 + String(Constants.limitOfImages) +
        Constants.apiKeyPrefix + Constants.giphyAPIKey
}
