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
//let apiUrl = "localhost:3000"

struct FlowNetwork {
    static func getPlaylistsForUserId(id : String, callback: Array<Playlist> -> Void) {
        let path = "\(apiUrl)/users/\(id)/playlists"
        Alamofire.request(.GET, path)
            .responseJSON(completionHandler: { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on \(path)")
                    return
                }
                
                if  let jsonObject = response.result.value {
                    
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
    
    static func getFakeSongs() -> Array<Song> {
        
        var songsArray = Array<Song>()
        
        for i in 0...5 {
            let song = Song(id: "id\(i)", name: "song\(i)", artist: "artist\(i)", votes: 5-i, imageLink: "link.com", songLink: "link.com")
            songsArray.append(song)
        }
        
        
        return songsArray
    }
    
    static func createPlaylist(playlist : Playlist, callback : Void -> Void) {
        
        let path = "\(apiUrl)/users/\(playlist.user.id)/playlists"
                
        let params:[String:AnyObject] = ["name": playlist.name, "songs": [], "userName": playlist.user.name]
        
        Alamofire.request(.POST, path, parameters: params).responseJSON(completionHandler: { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling POST on \(path)")
                return
            }
            
            if  let jsonObject = response.result.value {
                
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
                print("error getting updated playlist")
                return
            }

            if let jsonObject = response.result.value {
                
                playlist.getSongsFromJson(JSON(jsonObject))
                
                callback()
            }
        }
    }
    
    static func updatePlaylist(playlist : Playlist, callback : Void -> Void) {
        let path = "\(apiUrl)/users/\(playlist.user.id)/playlists/\(playlist.id)"
        Alamofire.request(.GET, path)
            .responseJSON(completionHandler: makePlaylistUpdateHandler(playlist, callback: callback))
    }
    
    static func incrementVoteForSong(songId : String, playlist : Playlist, callback : Void -> Void) {
        let path = "\(apiUrl)/users/\(playlist.user.id)/playlists/\(playlist.id)/songs/\(songId)"
        Alamofire.request(.PUT, path)
            .responseJSON(completionHandler: makePlaylistUpdateHandler(playlist, callback: callback))
        
    }
    
    static func addSong(song : Song, playlist : Playlist, callback : Void -> Void) {
        let path = "\(apiUrl)/users/\(playlist.user.id)/playlists/\(playlist.id)"
        
        Alamofire.request(.POST, path, parameters: song.toDictionary()).responseJSON(completionHandler: { response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling GET on /posts/1")
                return
            }
        
            if let jsonObject = response.result.value {
                
                playlist.getSongsFromJson(JSON(jsonObject))
                
                callback()
            }
        })
    }
}
