//
//  TableViewController.swift
//  Meme
//
//  Created by Ahmed Shehata on 7/21/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit
class TableViewController:UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let applicationDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = applicationDelegate.memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeCell")!
        let meme = self.memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText + "..." + meme.buttomText
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("ImageViewController") as! ImageViewController
        detailController.memes = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}
