//
//  User.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import Foundation


import ObjectMapper

public class User: Mappable{
    dynamic var id = 0
    public dynamic var fullName = "Tanaka Yohachi"
    public dynamic var authenticationToken = ""
    public dynamic var imgUrl = "http://images.claudetech.com/convert?quality=100&source=http%3A%2F%2Fwww.gizmodo.jp%2Fimages%2F2015%2F05%2F150325orangepeeler.jpg"
    public dynamic var createdAt = ""
    public dynamic var updatedAt = ""
    
    
    required convenience public init?(_ map: Map) {
        self.init()
        mapping(map)
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        fullName <- map["fullName"]
        authenticationToken <- map["authenticationToken"]
        imgUrl <- map["avatarUrl"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
    }
    
}