//
//  MovieDetails.swift
//  YTS Movies
//
//  Created by yosef elbosaty on 5/29/20.
//  Copyright © 2020 yosef elbosaty. All rights reserved.
//

import Foundation
import SwiftyJSON

class Details{
    var id :Int?
    var title : String?
    var rating : String?
    var Genres : [String] = []
    var likes : String?
    var downloads : String?
    var desciption : String?
    var language : String?
    var movieURL : String?
    var imageURLs : [String] = []
    
    
    init?(dict: [String:JSON]){
        if let id = dict["id"]?.int, let title = dict["title_long"]?.toString, let rating = dict["rating"]?.float,  let likes = dict["like_count"]?.int, let downloads = dict["download_count"]?.int, let description = dict["description_full"]?.toString,let language = dict["language"]?.toString, let movieURL = dict["url"]?.toString{
            self.id = id
            self.title = title
            self.rating = String(rating)
            self.likes = String(likes)
            self.downloads = String(downloads)
            self.language = language
            self.desciption = description
            self.movieURL = movieURL}
        else{
            
        }
        if let genresJSON = dict["genres"]?.arrayValue{
            var genres : [String] = []
            for genre in genresJSON{
                genres.append(genre.stringValue)
                self.Genres = genres
                
            }
        }
        self.imageURLs.append(dict["large_cover_image"]?.string ?? "https://img.icons8.com/ios-filled/50/000000/no-image.png")
        self.imageURLs.append(dict["large_screenshot_image1"]?.string ?? "https://img.icons8.com/ios-filled/50/000000/no-image.png")
        self.imageURLs.append(dict["large_screenshot_image2"]?.string ?? "https://img.icons8.com/ios-filled/50/000000/no-image.png")
        self.imageURLs.append(dict["large_screenshot_image3"]?.string ?? "https://img.icons8.com/ios-filled/50/000000/no-image.png")
        self.imageURLs.append(dict["background_image"]?.string ?? "https://img.icons8.com/ios-filled/50/000000/no-image.png")
    }
   
}


 
