//
//  ChoosePhotoViewController.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import UIKit

class ChoosePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var photoFlag: UIImageView!
    @IBOutlet weak var chooseBox: UIView!
    @IBOutlet weak var selectImage: UIImageView!
    
    var selectedImage = ""
    var selectFlag = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setDesign()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Delegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        selectImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    // MARK: Logic
    
    // MARK: Design
    func setDesign() {
        photoFlag.hidden = true
        
        chooseBox.layer.cornerRadius = 5
        videoImage.layer.cornerRadius = 5
        chooseBox.layer.borderWidth = 1.0
        chooseBox.layer.borderColor = UIColor.grayColor().CGColor
        selectImage.layer.cornerRadius = 5
    }
    
    // MARK: Button
    @IBAction func cameraButtonPushed(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }

    @IBAction func albumButtonPushed(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.allowsEditing = false
        presentViewController(picker, animated: true, completion: nil)
    }
    
}
