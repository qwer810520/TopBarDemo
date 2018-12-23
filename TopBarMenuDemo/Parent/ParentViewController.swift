//
//  ParentViewController.swift
//  TopBarMenuDemo
//
//  Created by Min on 2018/12/2.
//  Copyright © 2018 Min. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    
    var naviHeight: CGFloat = 0
    var statusBarHeigth: CGFloat = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        naviHeight = (navigationController?.navigationBar.frame.height)!
        statusBarHeigth = UIApplication.shared.statusBarFrame.height
    }
    
}
