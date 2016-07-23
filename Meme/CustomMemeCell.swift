//
//  CustomMemeCell.swift
//  Meme
//
//  Created by Ahmed Shehata on 7/22/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

class CustomMemeCell: UICollectionViewCell {
    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var buttomText: UILabel!
    
    func setCustomCell(image:UIImage, top: String, buttom: String) {
        viewImage.image = image
        topText.text = top
        buttomText.text = buttom
    }
    
}
