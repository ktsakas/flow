//
//  FlowNetwork.swift
//  Flow
//
//  Created by Valentin Perez on 11/7/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import Alamofire
import SwiftyJSON

let apiUrl = "https://flow-backend-api.herokuapp.com"
//let apiUrl = "130.132.173.223:3000"

struct FlowNetwork {
    static func getPlaylistsForUserId(id : String, callback: Array<Playlist> -> Void) {
        let path = "\(apiUrl)/users/\(id)/playlists"
        print("path for getplaylists:\(path)")
        
        Alamofire.request(.GET, path)
            .responseJSON(completionHandler: { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on \(path)")
                    print(response.result.error!)
                    return
                }
                
                if  let jsonObject = response.result.value {
                    print("JSON for getPlaylists \(jsonObject)")
                    
                    let json = JSON(jsonObject)
                    
                    if let playlistJsons = json.array {
                        var playlists = Array<Playlist>()
                        for playlistJson in playlistJsons {
                            playlists.append(Playlist(json: playlistJson))
                        }
                        callback(playlists)
                    }
                }
            })
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
    
    static func createPlaylist(playlist : Playlist, callback : Void -> Void) {
        
        let path = "\(apiUrl)/users/\(playlist.user.email)/playlists"
        print("createPlaylist path: \(path)")

        Alamofire.request(.POST, path,
            parameters: ["name": playlist.name, "songs": [], "userName": playlist.user.name])
            .responseJSON(completionHandler: { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /posts/1")
                    print(response.result.error!)
                    return
                }
                
                if  let jsonObject = response.result.value {
                    print("JSON createplaylist \(jsonObject)")
                    
                    let json = JSON(jsonObject)
                    
                    if let id = json["_id"].string {
                        playlist.id = id
                    } else {
                        assert(false, "missing _id field in json")
                    }
                    
                    callback()
                    
                }
            })
    }
    
    static func makePlaylistUpdateHandler(playlist : Playlist, callback : Void -> Void) -> Response<AnyObject, NSError> -> Void {
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
                
                callback()
            }
        }
    }
    
    static func updatePlaylist(playlist : Playlist, callback : Void -> Void) {
        let path = "\(apiUrl)/users/\(playlist.user.email)/playlists/\(playlist.id)"
        print("updatePlaylist path: \(path)")
        Alamofire.request(.GET, path)
            .responseJSON(completionHandler: makePlaylistUpdateHandler(playlist, callback: callback))
    }
    
    static func incrementVoteForSong(songId : String, playlist : Playlist, callback : Void -> Void) {
        Alamofire.request(.POST, "\(apiUrl)/users/\(playlist.user.email)/playlists/\(playlist.id)/songs/\(songId)")
            .responseJSON(completionHandler: makePlaylistUpdateHandler(playlist, callback: callback))
        
    }
}
