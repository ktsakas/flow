//
//  SongStruct.swift
//  Flow
//
//  Created by Valentin Perez on 11/7/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

//why are the strings Optionals?

struct Song {
    var name: String
    var artist: String
    var voteCount:Int = 0
    var imageLink: String?
    var songLink: String?


    init(name: String, artist: String, voteCount: Int, imageLink: String?) {
        self.name = name
        self.artist = artist
        self.voteCount = voteCount
        self.imageLink = imageLink
    }
    
    init(json: JSON) {
        self.init(
            name: json["name"].stringValue,
            artist: json["artist"].stringValue,
            voteCount: json["voteCount"].intValue,
            imageLink: json["imageLink"].string)
        
        assert(name != "", "missing song name")
        assert(artist != "", "missing song artist")
    }
}