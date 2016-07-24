//
//  ImageViewController.swift
//  Meme
//
//  Created by Ahmed Shehata on 7/21/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

class ImageViewController: UIViewController{
    @IBOutlet weak var viewImage: UIImageView!
    var memes: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = true
        
        viewImage.image = memes.memedImage
        viewImage.contentMode = .ScaleAspectFit
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
}