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
    public dynamic var imgUrl = "https://www.google.co.jp/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0ahUKEwjJs-_72JXPAhXBE5QKHarRC7kQjRwIBA&url=http%3A%2F%2Fswitch-box.net%2Fwallpaper-tiger-illustration.html&psig=AFQjCNHXLaB6X18zJRJRi6BajkuteCBRLg&ust=1474177417894068"
    public dynamic var videoUrl = "https://l.facebook.com/l.php?u=https%3A%2F%2Fd2nfxe3r64iwve.cloudfront.net%2Ftest%2Fbattlehack-video.mp4&h=wAQFDr85b"
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