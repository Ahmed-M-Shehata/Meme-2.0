//
//  CollectionViewController.swift
//  Meme
//
//  Created by Ahmed Shehata on 7/22/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

class collectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayOut: UICollectionViewFlowLayout!
    
    
    var memes: [Meme]! {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension1 = (view.frame.size.width - (2 * space)) / 3.0
        let dimension2 = (view.frame.size.height - (2 * space)) / 3.0
        
        flowLayOut.minimumLineSpacing = space
        flowLayOut.minimumInteritemSpacing = space
        flowLayOut.itemSize = CGSizeMake(dimension1, dimension2)

    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionMemeCell", forIndexPath: indexPath) as! CustomMemeCell
        let meme = memes[indexPath.item]
        cell.setCustomCell(meme.memedImage, top: meme.topText, buttom: meme.buttomText)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("ImageViewController") as! ImageViewController
        detailController.memes = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
