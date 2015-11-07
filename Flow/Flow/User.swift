//
//  User.swift
//  Flow
//
//  Created by Filip Bystricky on 11/7/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    var name : String
    var id : String
    
    init(name : String, id : String) {
        self.name = name
        self.id = id
    }
    
    init (json : JSON) {
        print("making user out of json:\(json)")
        
        self.name = json["name"].stringValue
        self.id = json["id"].stringValue
        
        assert(self.name != "", "empty name")
        assert(self.id != "", "empty id")
    }
}