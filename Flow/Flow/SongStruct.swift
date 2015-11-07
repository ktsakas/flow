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
    var id: String
    var name: String
    var artist: String
    var voteCount:Int = 0
    var imageLink: String?
    var songLink: String?
    
    
    init(id: String, name: String, artist: String, voteCount: Int, imageLink: String?, songLink: String?) {
        self.name = name
        self.artist = artist
        self.voteCount = voteCount
        self.id = id;
        self.imageLink = imageLink
        self.songLink = songLink;
    }
    
    init(json: JSON) {
        self.init(
            id: json["id"].stringValue,
            name: json["name"].stringValue,
            artist: json["artist"].stringValue,
            voteCount: json["voteCount"].intValue,
            imageLink: json["imageLink"].string,
            songLink: json["songLink"].string)
        
        assert(name != "", "missing song name")
        assert(artist != "", "missing song artist")
    }

    func toDictionary() -> [String:AnyObject] {
        let dict: [String:AnyObject] = [
            "name": name,
            "artist": artist,
            "voteCount": voteCount,
            "id": id,
            "imageLink": imageLink!,
            "songLink": songLink!
        ]
        
        return dict
        
    }
    
}