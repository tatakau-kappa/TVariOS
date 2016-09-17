//
//  Viedo.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

public class Video:Mappable{
    dynamic var videoId = 103
    public dynamic var title = "素敵な番組"
    public dynamic var imgUrl = "https://prog-8.com/assets/landing/firstview-4877280ff41348d0481c044493e01c54.png"
    public dynamic var videoUrl = "https://d2nfxe3r64iwve.cloudfront.net/test/battlehack-video.mp4"
    public var author = User()
    dynamic var commentsCount = 90
    dynamic var viewCount = 1000
    var comments = [Comment]()
    public dynamic var createdAt = ""
    public dynamic var updatedAt = ""
    
    
    required convenience public init?(_ map: Map) {
        self.init()
        mapping(map)
    }
    
    public func mapping(map: Map) {
        videoId <- map["id"]
        title <- map["program_name"]
        author <- map["user"]
        imgUrl <- map["resource.thumbnail"]
        videoUrl <- map["resource.swapped"]
        commentsCount <- map["commentsCount"]
        viewCount <- map["view_count"]
        comments <- map["video_comments"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
    }
    
    
}