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
        self.navigationBar.barTintColor = UIColor(hexString: "#2979FF")
        self.navigationBar.tintColor = UIColor(hexString: "#FFFFFF")
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(hexString: "#FFFFFF")!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
