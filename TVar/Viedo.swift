//
//  Viedo.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import Foundation

import ObjectMapper

public class Video:  Mappable{
    dynamic var id = ""
    public dynamic var imgUrl = "https://bh-uploader.claudetech.com/videos/205/thumbnail"
    public dynamic var videoUrl = "https://dl.dropboxusercontent.com/u/14222148/music-test.mp4"
    public dynamic var createdAt = ""
    public dynamic var updatedAt = ""
    
    
    required convenience public init?(_ map: Map) {
        self.init()
        mapping(map)
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        imgUrl <- map["imgUrl"]
        videoUrl <- map["videoUrl"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
    }
    
}