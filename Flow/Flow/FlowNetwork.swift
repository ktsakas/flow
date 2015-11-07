//
//  FlowNetwork.swift
//  Flow
//
//  Created by Valentin Perez on 11/7/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

struct FlowNetwork {

  func getSongsForPlaylistId(id : String) -> Array<Song> {

    let songArray = Array<Song>()
    // TODO: actual networking with AlamoFire & Parsing with SwiftyJSON


    return songArray;
  }

  func getFakeSongs() -> Array<Song> {

    var songsArray = Array<Song>()

    for i in 0...5 {
      var song = Song()
      song.songName = "song\(i)"
      song.songArtist = "artist\(i)"
      song.imageLink = "https://link.com"
      songsArray.append(song)
    }

    return songsArray
  }

  func upvoteSongForPlaylist(songId: String, playlistId : String) {

  }


}
