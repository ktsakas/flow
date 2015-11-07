//
//  FlowMainViewController.swift
//  Flow
//
//  Created by Valentin Perez on 11/6/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import UIKit

class FlowMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//<<<<<<< HEAD
//=======
//
//
//  let songCellID = "songCell"
//  var songsArray : Array<Song>?
//  var playlist : Playlist?
//
//  @IBOutlet var tableView: UITableView!
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    songsArray = FlowNetwork.getFakeSongs()
//    tableView.delegate = self
//    tableView.dataSource = self
//    tableView.reloadData()
//>>>>>>> origin/master
    
    
    let songCellID = "songCell"
    
    var playlist = Playlist(name: "playlist1", user: User(name: "user1", id: "user1"), id: "playlist1")
    
//    var songsArray : Array<Song>?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //http tests
        
        playlist.songs = FlowNetwork.getFakeSongs()
        
        playlist.print_self()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        FlowNetwork.updatePlaylist(playlist)
        
        playlist.print_self()
        
        
        
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
        
        
        let song : Song = playlist.songs[indexPath.row]
        songCell.songTitleLabel.text = song.name
        songCell.songArtistLabel.text = song.artist
        let votes = playlist.songs.count - indexPath.row
        songCell.voteCountLabel.text = "\(votes)"
        
        songCell.songId = song.id
        songCell.playlist = playlist
        
        return songCell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.songs.count
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
