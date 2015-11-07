//
//  SongStruct.swift
//  Flow
//
//  Created by Valentin Perez on 11/7/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Song {
    var name: String?
    var artist: String?
    var voteCount:Int = 0
    var imageLink: String?
    
    init(name: String?, artist: String?, voteCount: Int, imageLink: String?) {
        self.name = name
        self.artist = artist
        self.voteCount = voteCount
        self.imageLink = imageLink
    }
    
    init(json: JSON) {
        self.init(
            name: json["name"].string,
            artist: json["artist"].string,
            voteCount: json["voteCount"].intValue,
            imageLink: json["imageLink"].string)
    }
}