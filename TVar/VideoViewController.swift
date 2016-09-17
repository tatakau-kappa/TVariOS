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

    var video: Video!
    private var moviePlayer: MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureImage.setImageFromURL(video.imgUrl)
        setPlayer()
        setDesign()
        setData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: For player
    func setPlayer(){
        self.moviePlayer = MPMoviePlayerController(contentURL: NSURL(string:video.videoUrl))
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
    }
    
    func setDesign() {
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.layer.borderColor = UIColor.whiteColor().CGColor
        userImage.layer.borderWidth = 1.0
    }
    
}
