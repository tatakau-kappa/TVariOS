//
//  Comment.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import Foundation
import ObjectMapper

public class Comment :Mappable{
    dynamic var id = 0
    dynamic var contents = "すごいいい"
    var author = User()
    dynamic var createdAt = ""
    
    required convenience public init?(_ map: Map) {
        self.init()
        mapping(map)
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        contents <- map["contents"]
        author <- map["user"]
        createdAt <- map["createdAt"]
    }
}