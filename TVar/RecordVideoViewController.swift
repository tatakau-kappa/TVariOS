//
//  RecordVideoViewController.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import UIKit
import CameraManager
import AssetsLibrary

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
    
    // MARK: Send Video
    
    func sendVideo() {
        cameraManager.stopVideoRecording({ (videoURL, error) -> Void in
            ALAssetsLibrary().assetForURL(videoURL, resultBlock: {(asset: ALAsset!) -> Void in
                let rep = asset.defaultRepresentation() as ALAssetRepresentation
                self.url = rep.url()
                self.performSegueWithIdentifier("finishRecord", sender: self)
                let bufferSize = Int(rep.size())
                let buffer = UnsafeMutablePointer<UInt8>(malloc(bufferSize))
                let buffered = rep.getBytes(buffer, fromOffset: 0, length: Int(rep.size()), error: nil)
                var data = NSData(bytesNoCopy: buffer, length: buffered, freeWhenDone: true)
                print(data)
//                ManagerLocator.sharedInstance.videoManager.uploadVideo(data)
                }, failureBlock:nil)
        })
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
            sendVideo()
        }
    }
    
}
