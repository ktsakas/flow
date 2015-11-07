//
//  FlowMainViewController.swift
//  Flow
//
//  Created by Valentin Perez on 11/6/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import UIKit

class FlowMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


  let songCellID = "songCellID"
  var songsArray : Array<Song>?

  override func viewDidLoad() {
    super.viewDidLoad()

      // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }


  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {


  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let songCell : SongTableViewCell = tableView.dequeueReusableCellWithIdentifier(songCellID, forIndexPath: indexPath) as! SongTableViewCell

    return songCell

  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return 5;
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
