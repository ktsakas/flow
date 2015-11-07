//
//  FlowNetwork.swift
//  Flow
//
//  Created by Valentin Perez on 11/7/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import Alamofire
import SwiftyJSON


struct FlowNetwork {
    
    func getSongsForPlaylistId(id : String) -> Array<Song> {
        
        let songArray = Array<Song>()
        // TODO: actual networking with AlamoFire & Parsing with SwiftyJSON
        
        return songArray;
    }
    
    
    static func getSongsForPlaylistId(id : String) -> Array<Song> {
        
        let songArray = Array<Song>()
        // TODO: actual networking with AlamoFire & Parsing with SwiftyJSON
        
        
        return songArray;
    }
    
    static func getFakeSongs() -> Array<Song> {
        
        var songsArray = Array<Song>()
        
        for i in 0...5 {
            let song = Song(id: "id\(i)", name: "song\(i)", artist: "artist\(i)",
                voteCount: 5-i, imageLink: "link.com", songLink: "link.com")
            songsArray.append(song)
        }

        
        return songsArray
    }
    
    static func createPlaylist(playlist : Playlist) {
        Alamofire.request(.POST, "/users/\(playlist.user.id)/playlists",
            parameters: ["name": playlist.name, "songs": []])
            .responseJSON(completionHandler: { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if  let jsonObject = response.result.value {
                    print("JSONL \(jsonObject)")
                    
                    let json = JSON(jsonObject)
                    
                    if let id = json["_id"].string {
                        playlist.id = id
                    } else {
                        assert(false, "missing _id field in json")
                    }
                    
                }
            })
    }
    
    static func makePlaylistUpdateHandler(playlist : Playlist) -> Response<AnyObject, NSError> -> Void {
        return { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET on /posts/1")
                print(response.result.error!)
                return
            }
            
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let jsonObject = response.result.value {
                
                print("JSON: \(jsonObject)")
                
                playlist.getSongsFromJson(JSON(jsonObject))
                
                //todo update playlist in view
            }
        }
    }
    
    static func updatePlaylist(playlist : Playlist) {
        let path = "users/\(playlist.user.id)/playlists/\(playlist.id)"
        print("updatePlaylist path: \(path)")
        Alamofire.request(.GET, path)
            .responseJSON(completionHandler: makePlaylistUpdateHandler(playlist))
    }
    
    static func incrementVoteForSong(songId : String, playlist : Playlist) {
        Alamofire.request(.POST, "/users/\(playlist.user.id)/playlists/\(playlist.id)/songs/\(songId)")
            .responseJSON(completionHandler: makePlaylistUpdateHandler(playlist))
        
    }
}
