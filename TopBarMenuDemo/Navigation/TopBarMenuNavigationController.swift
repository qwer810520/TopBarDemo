//
//  TopBarMenuNavigationController.swift
//  TopBarMenuDemo
//
//  Created by Min on 2018/12/2.
//  Copyright © 2018 Min. All rights reserved.
//

import UIKit

class TopBarMenuNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserInterface()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - private Method
    
    private func setUserInterface() {
        navigationBar.tintColor = .white
        navigationBar.setBackgroundImage(UIImage(named: "navi_bg_image")?.withRenderingMode(.alwaysOriginal), for: .default)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: GlobalClass.avenirNext_Regular, size: 10)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
