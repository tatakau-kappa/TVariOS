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
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var selectedImage = ""
    var selectFlag = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        ManagerLocator.sharedInstance.videoManager.uploadFlag.afterChange.add(owner: self) {
            value in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
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
        setImage(image)
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    // MARK: Logic
    func setImage(image: UIImage) {
        selectFlag = true
        photoFlag.hidden = false
        chooseBox.hidden = true
        deleteButton.hidden = false
        selectImage.hidden = false
        selectImage.image = image
        selectImage.layer.cornerRadius = 5
        doneButton.enabled = true
        uploadImage(image)
    }
    
    func deleteImage() {
        photoFlag.hidden = true
        chooseBox.hidden = false
        selectImage.hidden = true
        deleteButton.hidden = true
        selectImage.image = nil
        doneButton.enabled = false
    }
    
    func uploadImage(image: UIImage) {
        let path = NSTemporaryDirectory().stringByAppendingString("image.jpeg")
        
        if let data = UIImageJPEGRepresentation(image, 0.8) {
            data.writeToFile(path, atomically: true)
        }
        
        let url = NSURL(fileURLWithPath: path)
        ManagerLocator.sharedInstance.videoManager.uploadImage(url)

    }
    
    // MARK: Design
    func setDesign() {
        deleteImage()
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
    
    @IBAction func deleteButtonPushed(sender: AnyObject) {
        deleteImage()
    }
    
    @IBAction func doneButtonPushed(sender: AnyObject) {
        ManagerLocator.sharedInstance.videoManager.finishProcess()
    }
}
