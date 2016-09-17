//
//  VideoTableViewCell.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import UIKit

class VideoViewCell: UITableViewCell {
    
    @IBOutlet weak var videoImage: CustomImageView!
    @IBOutlet weak var programTitle: UILabel!
    @IBOutlet weak var userImage: CustomImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    var cellData: Video?{
        didSet{
            renderCell(cellData!)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setDegin()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDegin () {
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func renderCell(video: Video){
        videoImage.setImageFromURL(video.imgUrl)
        programTitle.text = video.title
        userImage.setImageFromURL(video.author.imgUrl)
        userName.text = video.author.fullName
        commentCount.text = "\(video.comments.count)"
    }
    
}
