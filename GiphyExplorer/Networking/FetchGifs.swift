//
//  FetchGifs.swift
//  GiphyExplorer
//
//  Created by Edmund Trujillo on 11/17/17.
//  Copyright © 2017 Edmund Trujillo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// This routine does the bulk of the heavy lifting ... it includes the URL's, API key and number of images
// to fetch per web call.
// It makes use of Alamofire for networking along with SwiftyJSON for easy and clean access to the JSON data


// External entry points ... everything else here is private
func fetchTrendingGifs(_ completion:@escaping ([Gif]) -> Void) {
    let path = trendingUrlPath()
    fetchGifs(path, completion)
}

func fetchSearchedGifs(_ searchTerm: String?, _ completion:@escaping ([Gif]) -> Void) {
    let path = searchedUrlPath(searchTerm)
    fetchGifs(path, completion)
}

func fetchGifs(_ path:String, _ completion:@escaping ([Gif]) -> Void) {
    
    Alamofire.request(path, headers:nil).responseJSON { response in
        if let alamoJson = response.result.value {
            let swiftJson = JSON(alamoJson)
            
            let dataImages = swiftJson["data"].array!
            var gifImages = [Gif]()
            
            for dataImage in dataImages {
                let gif = parseImageDetails(imageJson: dataImage)
                if let gif = gif {
                    gifImages.append(gif)
                }
            }
            
            completion(gifImages)
        }
    }
}

// MARK: private helper functions

private func parseImageDetails(imageJson: JSON) -> Gif? {
    
    let titleText = imageJson["title"].stringValue
    let rating = imageJson["rating"].stringValue
    let source = imageJson["source"].stringValue
    
    // array of images
    let images = imageJson["images"]
    
    // within the array of images, select the preview_gif image
    let previewGif = images["preview_gif"]
    let url = previewGif["url"].stringValue
    
    let heightJson = previewGif["height"].doubleValue
    let widthJson = previewGif["width"].doubleValue
    let sizeJson = previewGif["size"].doubleValue
    
    let height = Double(heightJson)
    let width = Double(widthJson)
    let size = Double(sizeJson)
    
    let gif = Gif(title: titleText,
                  width: width,
                  height: height,
                  size: size,
                  imageUrl: url,
                  rating: rating,
                  source: source)
    
    // only return GIF images that have a non-blank URL!
    return url.count > 0 ? gif : nil
}



