//
//  JSON+Extension.swift
//  YTS Movies
//
//  Created by yosef elbosaty on 5/29/20.
//  Copyright © 2020 yosef elbosaty. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON{
    var toString : String?{
        if let string = self.string{return string}
        if let int = self.int {
            let string = String(int)
            return string
        }
        if let float = self.float{
            let string = String(float)
            return string
        }
       
    return nil
    }
   
}
