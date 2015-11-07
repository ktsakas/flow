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
    
    func getSongsForId(id : String) -> Array<Song> {
        
        var songArray = Array<Song>()
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
                    
                    let songs: Array<JSON> = json.array!
                    
                    for songJson in songs {
                        songArray.append(Song(json: songJson))
                    }
                    
                }
        }
        
        return songArray;
    }
    
    //  func updateVoteForSong
    
}
