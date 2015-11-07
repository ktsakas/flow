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
  var voteCount:Int = 0
  var imageLink: String?
  var songLink: String?


  init(id: String, name: String, artist: String, voteCount: Int, imageLink: String?) {
    self.name = name
    self.artist = artist
    self.voteCount = voteCount
    self.imageLink = imageLink
    self.id = id;
  }
  
  init(json: JSON) {
      self.init(
        id: json["id"].stringValue,
        name: json["name"].stringValue,
        artist: json["artist"].stringValue,
        voteCount: json["voteCount"].intValue,
        imageLink: json["imageLink"].string)
      
      assert(name != "", "missing song name")
      assert(artist != "", "missing song artist")
  }
}