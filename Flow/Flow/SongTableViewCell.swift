//
//  SongTableViewCell.swift
//  Flow
//
//  Created by Valentin Perez on 11/7/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate {
  func upvotedSong(finalPlaylist: Int)
}

class SongTableViewCell: UITableViewCell {

  @IBOutlet var songImageView: UIImageView!
  @IBOutlet var songTitleLabel: UILabel!
  @IBOutlet var songArtistLabel: UILabel!
  @IBOutlet var voteCountLabel: UILabel!


  var songId : String?
  var playlist : Playlist?

//  init(songId: String, playlist : Playlist) {
//    self.songId = songId
//    self.playlist = playlist
//  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }


  @IBAction func tappedUpvote(sender: AnyObject) {
    print("tapped upvote")

    playlist!.print_self()
    print("song id: \(songId!)")

    var songUpvoted : Song = (playlist?.getSongById(songId!))!

    songUpvoted.votes++

    voteCountLabel.text = "\(songUpvoted.votes)"

    FlowNetwork.incrementVoteForSong(songId!, playlist: playlist!, callback: {
        print("done incrementing vote")
        self.playlist!.print_self()
    })
  }

}
