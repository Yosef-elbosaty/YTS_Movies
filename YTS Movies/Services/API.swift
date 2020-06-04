//
//  API.swift
//  YTS Movies
//
//  Created by yosef elbosaty on 5/29/20.
//  Copyright © 2020 yosef elbosaty. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API: NSObject {

    class func Movies(page:Int = 1,Completion: @escaping(_ error:Error?,_ Movies: [Movie]?)->Void){
        let url = URLs.moviesURl+"?page="+"\(page)"
        let params = ["page_number" : page]
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (response) in
            switch response.result{
            case .failure(let error): print(error); Completion(error,nil)
            case .success(let value):
                let json = JSON(value)
                guard let movies = json["data"]["movies"].array else{
                    Completion(nil,nil)
                    return
                }
                var films = [Movie]()
                for movie in movies{
                    if let data = movie.dictionary, let movie = Movie.init(dict: data){
                        films.append(movie)
                    }
                }
              
                
                Completion(nil,films)
            }
        }
    }
}
