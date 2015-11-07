//
//  PlaylistStruct.swift
//  Flow
//
//  Created by Filip Bystricky on 11/7/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import Foundation
import SwiftyJSON

class Playlist {
    var name : String
    var user : User
    var id : String
    var songs = Array<Song>()
    
    init(name : String, user : User, id : String) {
        self.name = name
        self.user = user
        self.id = id
    }
    
    func isSortedByVoteCount() -> Bool {
        for var i = 0; i < songs.count - 1; i++ {
            if (songs[i].voteCount < songs[i + 1].voteCount) {
                return false
            }
        }
        return true
    }
    
    func containsDuplicates() -> Bool {
        var names = Set<String>()
        
        for song in songs {
            if (names.contains(song.name)) {
                return true
            }
            names.insert(song.name)
        }
        
        return false;
    }
    
    func getSongsFromJson(json : JSON) {
        if let songJsons = json.array {
            songs.removeAll()

            for songJson in songJsons {
                songs.append(Song(json: songJson))
            }
            assert(isSortedByVoteCount(), "songs array is not sorted by vote count")
            assert(!containsDuplicates(), "songs array contains duplicate songs")
        } else {
            assert(false, "json object is not an array")
        }
    }
}