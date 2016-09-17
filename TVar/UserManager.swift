//
//  UserManager.swift
//  Veat
//
//  Created by yuya on 2015/11/15.
//  Copyright © 2015年 soneoka. All rights reserved.
//

import Foundation

import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import FBSDKCoreKit
import FBSDKLoginKit
import Observable

class UserManager{
    var currentUser: Observable<User?> = Observable(nil)
    dynamic var lastError: NSError?
    var paymentToken: String = ""
    
    func loginFacebook(authData: [String:String]){
        let req = APIRouter.FacebookLogin(authData)
        Alamofire.request(req).validate().responseObject{
            (response: Response<User, NSError>) in
            if response.result.error == nil {
                print(response.result.value!.fullName)
                self.saveLoginUser(response.result.value!)
            } else{
                print(response.result.error)
                self.lastError = response.result.error
            }
        }
    }
    
    func loginMock(){
        let user = User()
        saveLoginUser(user)
    }
    
    func saveLoginUser(user: User){
        let ud = NSUserDefaults.standardUserDefaults()
        let json = Mapper().toJSONString(user, prettyPrint: true)
        ud.setObject(json, forKey: "loginUser")
        self.currentUser <- user
//        APIRouter.token = self.currentUser.value!.authenticationToken
//        VideoRouter.token = self.currentUser.value!.authenticationToken
    }
    
    
    
    func didLogin() -> Bool{
        if let json = NSUserDefaults.standardUserDefaults().stringForKey("loginUser"){
            if let user = Mapper<User>().map(json){
                currentUser <- user
//                APIRouter.token = currentUser.value!.authenticationToken
//                VideoRouter.token = currentUser.value!.authenticationToken
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func logoutUser(){
        currentUser <- nil
        let ud = NSUserDefaults.standardUserDefaults()
        ud.removeObjectForKey("loginUser")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let rootController = storyBoard.instantiateViewControllerWithIdentifier("LoginViewController")
        UIView.transitionWithView(appDelegate.window!, duration: 1, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
            () -> Void in
            appDelegate.window!.rootViewController = rootController
            }, completion: nil)
    }
    
}