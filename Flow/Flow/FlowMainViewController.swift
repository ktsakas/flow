//
//  FlowMainViewController.swift
//  Flow
//
//  Created by Valentin Perez on 11/6/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import UIKit

class FlowMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


  let songCellID = "songCell"
  var songsArray : Array<Song>?

  @IBOutlet var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    songsArray = FlowNetwork.getFakeSongs()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.reloadData()
    
    //http tests
    let p = Playlist(name: "playlist1", user: User(name: "user1", id: "user1"), id: "playlist1")
    
    p.songs = songsArray!
    
    p.print_self()
    
    FlowNetwork.updatePlaylist(p)
    
    p.print_self()
    
    
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }


  /**
   *  //MARK: - TableView Delegate
   * TableView Delegate Methods
   */

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("selected song brah")
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let songCell : SongTableViewCell = tableView.dequeueReusableCellWithIdentifier(songCellID, forIndexPath: indexPath) as! SongTableViewCell


    let song : Song = songsArray![indexPath.row]
    songCell.songTitleLabel.text = song.name
    songCell.songArtistLabel.text = song.artist
    let votes = (songsArray?.count)! - indexPath.row
    songCell.voteCountLabel.text = "\(votes)"


    return songCell

  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    if let count = songsArray?.count {
      return count
    } else {
      return 0
    }
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
