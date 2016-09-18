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
import Photos

class RecordVideoViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var isRecording = false
    var url: NSURL!
    var cameraManager: CameraManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        wholeView.frame = view.bounds
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        setupRecord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Setup record button
    func setupRecord(){
        isRecording = false
        closeButton.hidden = false
        let image = UIImage(named: "btn_record")
        recordButton.setImage(image, forState: .Normal)
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
            self.performSegueWithIdentifier("finishRecord", sender: self)
            let fetchResult = PHAsset.fetchAssetsWithALAssetURLs([videoURL!], options: nil)
            if let phAsset = fetchResult.firstObject as? PHAsset {
                PHImageManager.defaultManager().requestAVAssetForVideo(phAsset, options: PHVideoRequestOptions(), resultHandler: { (asset, audioMix, info) -> Void in
                    if let asset = asset as? AVURLAsset {
                        let videoData = NSData(contentsOfURL: asset.URL)
                        let videoSaveURL = self.getTempURL()
                        let writeResult = videoData?.writeToURL(videoSaveURL, atomically: true)
                        if let writeResult = writeResult where writeResult {
                            ManagerLocator.sharedInstance.videoManager.uploadVideo(videoSaveURL)
                        }
                        else {
                            print("failure")
                        }
                    }
                })
            }
        })
    }
    
    func getTempURL() -> NSURL{
        let videoPath = NSTemporaryDirectory() + "tmpMovie.MOV"
        let videoSaveURL = NSURL(fileURLWithPath: videoPath)
        return videoSaveURL
    }
    
    // MARK:Transition
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "finishRecord"{
            let ChooseVC = segue.destinationViewController as! ChoosePhotoViewController
            ChooseVC.videoURL = getTempURL()
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
