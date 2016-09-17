//
//  ChoosePhotoViewController.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import UIKit

class ChoosePhotoViewController: UIViewController {

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var photoFlag: UIImageView!
    @IBOutlet weak var chooseBox: UIView!
    @IBOutlet weak var selectImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setDesign()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func albumButtonPushed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
