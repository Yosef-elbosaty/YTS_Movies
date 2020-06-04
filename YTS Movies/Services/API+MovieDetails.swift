//
//  API+MovieDetails.swift
//  YTS Movies
//
//  Created by yosef elbosaty on 5/29/20.
//  Copyright © 2020 yosef elbosaty. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension API{
    class func movieDetails(id: Int,completion: @escaping(_ error: Error?,_ details:Details?,_ cast: [Actor]?)->Void){
        let url = URLs.movieDetailsURL+"movie_id=\(id)&with_images=true&with_cast=true"
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { (response) in
            switch response.result{
            case .failure(let error): print(error); completion(error,nil,nil)
            case .success(let value):
                let json = JSON(value)
           
                guard let detailsJSON = json["data"]["movie"].dictionary, let data = Details.init(dict: detailsJSON) else{
                    completion(nil,nil,nil)
                    return
                }
               if let cast = detailsJSON["cast"]?.arrayValue {
               var actors = [Actor]()
               for actor in cast{
                let Actors  = Actor(name: actor["name"].stringValue , characterName: actor["character_name"].stringValue, imageURL: actor["url_small_image"].string ?? "https://img.icons8.com/ios-filled/50/000000/no-image.png")
                    actors.append(Actors)
                
                   }
                     completion(nil,data,actors)
               }else {
                      completion(nil,data,nil)
               }
                
            }
        }
    }
}

