//
//  RecordVideoViewController.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import UIKit
import CameraManager

class RecordVideoViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var isRecording = false
    var url: NSURL!
    var cameraManager: CameraManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        wholeView.frame = view.bounds
        setupRecord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Setup record button
    func setupRecord(){
        self.cameraManager = CameraManager()
        cameraManager.cameraDevice = .Back
        cameraManager.cameraOutputMode = .VideoWithMic
        cameraManager.cameraOutputQuality = .Medium
        cameraManager.writeFilesToPhoneLibrary = true
        cameraManager.addPreviewLayerToView(self.wholeView)
    }
    
    // MARK:Transition
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "finishRecord"{
//            let postVC = segue.destinationViewController as! PostVideoTableViewController
//            postVC.videoURL = url
        }
    }
    
    // MARK: Button
    @IBAction func closeButtonPushed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func recordButtonPushed(sender: AnyObject) {
        if !isRecording {
            cameraManager.startRecordingVideo()
            self.isRecording = true
            closeButton.hidden = true
            let image = UIImage(named: "btn_record_on")
            recordButton.setImage(image, forState: .Normal)
        } else {
//            sendVideo()
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}
