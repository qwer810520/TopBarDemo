//
//  TestViewModel.swift
//  TopBarMenuDemo
//
//  Created by Min on 2018/12/23.
//  Copyright © 2018 Min. All rights reserved.
//

import Foundation

enum DemoTestViewModel {
    case red
    case green
    case colorForBlue
    case orange
    case lightGray
}

extension DemoTestViewModel {
    var title: String {
        return String(describing: self)
    }
}

