//
//  URLs.swift
//  YTS Movies
//
//  Created by yosef elbosaty on 5/29/20.
//  Copyright © 2020 yosef elbosaty. All rights reserved.
//

import Foundation

struct URLs {
    static let baseURL = "https://yts.mx/api/v2/"
    static let moviesURl = baseURL+"list_movies.json"
    static let movieDetailsURL = baseURL+"movie_details.json?"
}
