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
    
    //todo: ansynchronous, need a callback type of thing
    func updatePlaylist(playlist : Playlist) {
        Alamofire.request(.GET, "users/:userId/playlists/:playlistId",
            parameters: ["userId": playlist.user, "playlistId": playlist.name])
            .responseJSON { response in
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
    
    func incrementVoteForSong(songName : String, playlist : Playlist) {
        Alamofire.request(.POST, "/users/:userId/playlists/:playlistId",
            parameters: ["playlistId": playlist.name, "name": songName], encoding: .JSON)
            .responseJSON { response in
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
    
}
