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
    var email : String
    
    init(name : String, email : String) {
        self.name = name
        self.email = email
    }
    
    init (json : JSON) {
        print("making user out of json:\(json)")
        
        self.name = json["name"].stringValue
        self.email = json["email"].stringValue
        
        assert(self.name != "", "empty name")
        assert(self.email != "", "empty email")
    }
}