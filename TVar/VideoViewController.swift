//
//  VideoViewController.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import UIKit
import MediaPlayer

class VideoViewController: UIViewController {

    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var captureImage: CustomImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var playButton: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var programTitle: UILabel!
    @IBOutlet weak var userImage: CustomImageView!
    @IBOutlet weak var viewCount: UILabel!

    var video: Video!
    private var moviePlayer: MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(video)
        setPlayer()
        setDesign()
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.moviePlayer.stop()
    }
    
    // MARK: For player
    func setPlayer(){
        let urlString = "https://d2nfxe3r64iwve.cloudfront.net/\(video.videoId)/video.mp4"
        self.moviePlayer = MPMoviePlayerController(contentURL: NSURL(string: urlString))
        self.moviePlayer.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: videoView.frame.height)
        self.videoView.addSubview(moviePlayer.view)
        
        self.moviePlayer.fullscreen = true
        self.moviePlayer.controlStyle = MPMovieControlStyle.Embedded
        self.moviePlayer.shouldAutoplay = true
        self.moviePlayer.scalingMode = MPMovieScalingMode.AspectFit
        self.moviePlayer.repeatMode = MPMovieRepeatMode.None
    }
    
    // MARK: Design
    func setData(){
        captureImage.setImageFromURL(video.imgUrl)
        userName.text = video.author.fullName
        userImage.setImageFromURL(video.author.imgUrl)
        programTitle.text = video.title
        viewCount.text = "\(video.viewCount)"
    }
    
    func setDesign() {
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.layer.borderColor = UIColor.whiteColor().CGColor
        userImage.layer.borderWidth = 1.0
    }

    @IBAction func shareButtonClick(sender: AnyObject) {
        let shareText = "「\(video.title)」に出演しました？！#TVar #tvhackday"
        let shareWebsite = NSURL(string: video.videoUrl)
        var shareImage = UIImage(named: "loginBack")
        if let url = NSURL(string: video.imgUrl) {
            if let data = NSData(contentsOfURL: url) {
                shareImage = UIImage(data: data)
            }        
        }

        let activityItems = [shareText,shareWebsite!, shareImage!]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
}
