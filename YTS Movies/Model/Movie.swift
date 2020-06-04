//
//  Movie.swift
//  YTS Movies
//
//  Created by yosef elbosaty on 5/29/20.
//  Copyright © 2020 yosef elbosaty. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie{
    var id : Int?
    var title : String?
    var rating : String?
    var imageURL : String?
    var Genres : [String] = []
    
    init?(dict: [String:JSON]){
        guard let id = dict["id"]?.int, let title = dict["title_long"]?.toString, let rating = dict["rating"]?.float, let imageURL = dict["large_cover_image"]?.toString else{
            return
        }
        self.id = id
        self.title = title
        self.rating = String(rating)
        self.imageURL = imageURL
        if let genresJSON = dict["genres"]?.arrayValue{
            var genres : [String] = []
            for genre in genresJSON{
                genres.append(genre.stringValue)
                self.Genres = genres
            }
        }
    }
   
}
