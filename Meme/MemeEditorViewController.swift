//
//  ViewController.swift
//  Meme
//
//  Created by Ahmed Shehata on 7/15/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var album: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var buttomTextField: UITextField!
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    let textFieldDelegate = TextFieldDelegate()
    var memedImage: UIImage?
    var memes: [Meme]!
    
    func setUpTextField(textField: UITextField, defaultText: String) {
        textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
        textField.text = defaultText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextField(topTextField, defaultText: "TOP")
        setUpTextField(buttomTextField, defaultText: "BUTTOM")
        
        share.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func activityController(sender: AnyObject){
        let memedImage = generateMemedImage()
        let nextController2 = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        nextController2.completionWithItemsHandler = {(activity: String?, completed: Bool, items: [AnyObject]?, error: NSError?) -> Void in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(nextController2, animated: true, completion: nil)
    }
    
    func presentImage(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        presentImage(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    @IBAction func picAnImageFromCamera(sender: AnyObject) {
        presentImage(UIImagePickerControllerSourceType.Camera)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .ScaleAspectFit
            dismissViewControllerAnimated(true, completion: nil)
            share.enabled = true
        }
    }
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -2
    ]
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)

    }
    
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y = getKeyboardHeight(notification) * (-1)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        if buttomTextField.isFirstResponder() {
            return keyboardSize.CGRectValue().height
        } else {
            return 0
        }
    }
    
    func generateMemedImage() -> UIImage {
        // TODO: Hide toolbar and navbar
        navBar.hidden = true
        toolBar.hidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // TODO:  Show toolbar and navbar 
        navBar.hidden = false
        toolBar.hidden = false
        return memedImage
    }
    
    func save(){
        let topText = topTextField.text!
        let buttomText = buttomTextField.text!
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topText, buttomText: buttomText, originalImage:
            imagePickerView.image!, memedImage: memedImage)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
}



