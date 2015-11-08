//
//  FlowMusicPlayer.swift
//  Flow
//
//  Created by Valentin Perez on 11/7/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import Alamofire


class FlowMusicPlayer: NSObject {

  let sc_client_id = "13b22a8bb1ae990b8a3bbf4c2086aacc"


  func playSong(songName : String) {

    let url = "https://api.soundcloud.com/tracks?client_id=\(sc_client_id)&q=\(songName)"


    print("want to request query song\n")

    Alamofire.request(.GET, url, parameters: ["foo": "bar"])
      .responseJSON { response in

        print("RESPONSE:: \n")
        print(response.request)  // original URL request
        print(response.response) // URL response
        print(response.data)     // server data
        print(response.result)   // result of response serialization

        if let JSON = response.result.value {
          print("JSON: \(JSON)")
        }
    }

  }

}
