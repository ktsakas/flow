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
    var votes:Int = 0
    var imageLink: String?
    var songLink: String?
    
    
    init(id: String, name: String, artist: String, votes: Int, imageLink: String?, songLink: String?) {
        self.name = name
        self.artist = artist
        self.votes = votes
        self.id = id;
        self.imageLink = imageLink
        self.songLink = songLink;
    }
    
    init(json: JSON) {
        self.init(
            id: json["_id"].stringValue,
            name: json["name"].stringValue,
            artist: json["artist"].stringValue,
            votes: json["votes"].intValue,
            imageLink: json["imageLink"].string,
            songLink: json["songLink"].string)
        
        assert(id != "", "missing song id")
        assert(name != "", "missing song name")
        assert(artist != "", "missing song artist")
    }

    func toDictionary() -> [String:AnyObject] {
        let dict: [String:AnyObject] = [
            "name": name,
            "artist": artist,
            "votes": votes,
            "_id": id,
            "imageLink": imageLink!,
            "songLink": songLink!
        ]
        
        return dict
        
    }
    
}