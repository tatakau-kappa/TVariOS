//
//  LoginViewController.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate  {

    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginButton.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //delegate
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        if error == nil{
            let token = FBSDKAccessToken.currentAccessToken()
            let authData = ["id":token.userID as String, "accessToken":token.tokenString as String ,
                            "provider": "facebook" as String]
            print(authData)
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
//            ManagerLocator.sharedInstance.userManager.loginFacebook(authData)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                self.performSegueWithIdentifier("loginSucceeded", sender: self)
            })

        } else {
            // TODO: 失敗のモーダル表示
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        print("User logged out...")
    }
    
    @IBAction func mockButton(sender: AnyObject) {
        ManagerLocator.sharedInstance.userManager.loginMock()
        self.performSegueWithIdentifier("loginSucceeded", sender: self)
    }
    

}
