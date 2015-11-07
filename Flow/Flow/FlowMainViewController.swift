//
//  FlowMainViewController.swift
//  Flow
//
//  Created by Valentin Perez on 11/6/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import UIKit

class FlowMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
<<<<<<< HEAD

=======
    
    
>>>>>>> 8dbdb8969f29dc19c5a8e528efe707ce8dcab7c6
    let songCellID = "songCell"
    
    var playlist = Playlist(name: "playlist1", user: User(name: "user1", id: "user1"), id: "playlist1")
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
<<<<<<< HEAD

      //http tests

      // create playlist broaugh
      playlist = Playlist(name: "Valentin's Flow", user: User(name: "Valentin", id:"userIdValentin"), id: "playlistId1")



      playlist.songs = FlowNetwork.getFakeSongs()

      playlist.print_self()
      
      tableView.delegate = self
      tableView.dataSource = self
      tableView.reloadData()
      
      FlowNetwork.updatePlaylist(playlist)
      
      playlist.print_self()
=======
        //http tests
        
        playlist.songs = FlowNetwork.getFakeSongs()
        
        playlist.print_self()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        FlowNetwork.createPlaylist(playlist, callback: {
            print("done creating playlist")
            FlowNetwork.updatePlaylist(self.playlist, callback: {
                print("done updating playlist")
            })
        })
>>>>>>> 8dbdb8969f29dc19c5a8e528efe707ce8dcab7c6
        
        
        
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
      //songCell.setHighlighted(false, animated: false)

      print("selected song brah")
    }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let songCell : SongTableViewCell = tableView.dequeueReusableCellWithIdentifier(songCellID, forIndexPath: indexPath) as! SongTableViewCell
    
    
    let song : Song = playlist.songs[indexPath.row]
    songCell.songTitleLabel.text = song.name
    songCell.songArtistLabel.text = song.artist
    let votes = playlist.songs.count - indexPath.row
    songCell.voteCountLabel.text = "\(votes)"
    
    songCell.songId = song.id
    songCell.playlist = playlist
    songCell.selectionStyle = .None

    return songCell
  }

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2 // we have one for currently playing and the other for songs coming up next.
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (section == 0) {
      return 1 // the one currently playing
    } else {
      return playlist.songs.count - 1 // all the others.
    }
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if (section == 0) {
      return "Now Playing"
    }
    return "Next"
  }

  func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
    header.contentView.backgroundColor =  UIColor.lightGrayColor()//UIColor.clearColor()//UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.0) //make the background color light blue

    header.textLabel!.textColor = UIColor.whiteColor() //make the text white
    header.alpha = 1 //make the header transparent
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
