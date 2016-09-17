//
//  CustomImageView.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import Foundation
import Haneke

class CustomImageView: UIImageView {
    
    func setImageFromURL(url: String?){
        if let ImageURL = url{
            dispatch_async(dispatch_get_main_queue(),{
                self.hnk_setImageFromURL(NSURL(string: ImageURL)!, placeholder: nil,  success: nil,  failure: {(NSError) in
                    print("error")
                    print(NSError)
                    self.image = nil
                })
            })
        } else {
            self.image = nil
        }
    }
    
    func setImageFromAsset(name: String?){
        self.image = nil
        if let imageName = name{
            dispatch_async(dispatch_get_main_queue(), {
                if let image = UIImage(named: imageName){
                    self.hnk_setImage(image,animated: true, success: nil)
                } else {
                    self.image = nil
                }
            })
            
        } else {
            self.image = nil
        }
    }
    
}
