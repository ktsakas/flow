//
//  FlowNetwork.swift
//  Flow
//
//  Created by Valentin Perez on 11/7/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import Alamofire
import SwiftyJSON

func isSortedByVoteCount(songs : Array<Song>) -> Bool {
    for var i = 0; i < songs.count - 1; i++ {
        if (songs[i].voteCount < songs[i + 1].voteCount) {
            return false
        }
    }
    return true
}

func containsDuplicates(songs : Array<Song>) -> Bool {
    var names = Set<String>()
    
    for song in songs {
        if (names.contains(song.name)) {
            return true
        }
        names.insert(song.name)
    }
    
    return false;
}

func songsFromJson(songsJson : AnyObject) -> Array<Song> {
    var songs = Array<Song>()
    //from swiftyJson's github example
    let json = JSON(songsJson);
    
    if let songJsons = json.array {
        for songJson in songJsons {
            songs.append(Song(json: songJson))
        }
        assert(isSortedByVoteCount(songs), "songs array is not sorted by vote count")
        assert(!containsDuplicates(songs), "songs array contains duplicate songs")
        return songs
    } else {
        assert(false, "json object is not an array")
    }
}

struct FlowNetwork {
    
    //!! assumes backend gives array sorted by votecount
    func getSongsForId(id : String) -> Array<Song> {
        
        var songs = Array<Song>()
        
        //taken from alamofire's github example
        Alamofire.request(.GET, "/playlists/:playlistId", parameters: ["playlistId": id])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let jsonObject = response.result.value {
                    
                    print("JSON: \(jsonObject)")
                    
                    songs = songsFromJson(jsonObject)
                    
                }
        }
        
        return songs;
    }
    
    //running time O(n), but we can probably assume the playlist will be small enough for it not to matter
    //might be better suited to backend
    func incrementVoteForSong(songName : String, playlistID : String) -> Array<Song> {
        var songs = Array<Song>()
        
        Alamofire.request(.POST, "/", parameters: ["playlistId": playlistID, "name": songName])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let jsonObject = response.result.value {
                    
                    print("JSON: \(jsonObject)")
                    
                    //from swiftyJson's github example
                    let json = JSON(jsonObject);
                    
                    let songJsons: Array<JSON> = json.array!
                    
                    for songJson in songJsons {
                        songs.append(Song(json: songJson))
                    }
                    
                    assert(isSortedByVoteCount(songs), "songs array is not sorted by vote count")
                    assert(!containsDuplicates(songs), "songs array contains duplicate songs")
                    
                }
        }
        
        return songs;
    }
    
}
