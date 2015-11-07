//
//  SongTableViewCell.swift
//  Flow
//
//  Created by Valentin Perez on 11/7/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

  @IBOutlet var songImageView: UIImageView!

  @IBOutlet var songTitleLabel: UILabel!

  @IBOutlet var songArtistLabel: UILabel!

  @IBOutlet var voteCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  @IBAction func tappedUpvote(sender: AnyObject) {
  }

}
