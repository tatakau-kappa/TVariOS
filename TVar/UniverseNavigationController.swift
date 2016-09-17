//
//  UniverseNavigationController.swift
//  TVar
//
//  Created by yuya on 2016/09/17.
//  Copyright © 2016年 soneoka. All rights reserved.
//

import UIKit

class UniverseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor(hexString: "#ffffff")
        self.navigationBar.tintColor = UIColor(hexString: "##4F595E")
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(hexString: "#4F595E")!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
