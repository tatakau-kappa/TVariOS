//
//  ManagerLocator.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import Foundation

class ManagerLocator: NSObject{
    
    class var sharedInstance : ManagerLocator{
        struct Singleton{
            static var instance = ManagerLocator()
        }
        return Singleton.instance
    }
    
    let userManager = UserManager()
    let videoManager = VideoManager()
}