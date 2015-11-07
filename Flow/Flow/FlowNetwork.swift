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
    
    //!! assumes backend gives array sorted by votecount
    func getSongsForId(id : String) -> Array<Song> {
        
        var songs = Array<Song>()
        // TODO: actual networking with AlamoFire & Parsing with SwiftyJSON
        
        //taken from alamofire's github example
        Alamofire.request(.GET, "/playlists/:playlistId", parameters: ["playlistId": id])
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
                    
                }
        }
        
        return songs;
    }
    
    //running time O(n), but we can probably assume the playlist will be small enough for it not to matter
    func incrementVoteForSong(songName : String, var songs : Array<Song>) {
        for var i = 0; i < songs.count; i++ {
            if (songs[i].name == songName) {
                songs[i].incrementVoteCount()
                
                //ensure sort is preserved
                while (i > 0) {
                    if (songs[i - 1].voteCount >= songs[i].voteCount) {
                        //then the array is properly sorted
                        return
                    }
                    //otherwise swap the songs so that they are in the right order
                    swap(&songs[i], &songs[i - 1])
                    i--
                }

                return
            }
        }
    }
    
    //  func updateVoteForSong
    
}
