//
//  FlowViewController.swift
//  Flow
//
//  Created by Valentin Perez on 11/6/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import UIKit

class FlowViewController: UIViewController {

  let flowNames = ["Join Valentin's Flow", "Create Flow"]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    print("selected FLOW brah")

    let vc = storyboard?.instantiateViewControllerWithIdentifier("flowMainController") as! FlowMainViewController

    self.navigationController?.pushViewController(vc, animated: true)

    //self.presentViewController(vc, animated: true, completion: nil)
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let flowCell : FlowNameTableViewCell = tableView.dequeueReusableCellWithIdentifier("flowCell", forIndexPath: indexPath) as! FlowNameTableViewCell

    flowCell.nameLabel.text = flowNames[indexPath.row]
    return flowCell

  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return flowNames.count
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
