//
//  User.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

public class User:Mappable{
    dynamic var id = 0
    public dynamic var fullName = "Tanaka Yohachi"
    public dynamic var authenticationToken = ""
    public dynamic var imgUrl = "https://graph.facebook.com/100000686899395/picture?type=square"
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