//
//  GlobalClass.swift
//  PatientSmartTV
//
//  Created by Min on 2018/11/14.
//  Copyright © 2018 Min. All rights reserved.
//

import UIKit

class GlobalClass: NSObject {
    
    class func RGBA(r: Double, g: Double, b: Double, a: Double) -> UIColor {
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: CGFloat(a / 100.0))
    }
    
    class var avenirNext_Medium: String {
        return "AvenirNext-Medium"
    }
    
    class var avenirNext_Regular: String {
        return "AvenirNext-Regular"
    }
    
    class var avenirNext_Bold: String {
        return "AvenirNext-Bold"
    }
    
    class var pingFangTC_Medium: String {
        return "PingFangTC-Medium"
    }
    
    class var pingFangTC_Regular: String {
        return "PingFangTC-Regular"
    }
    
    class var btnDisabledColor: UIColor {
        return RGBA(r: 255, g: 255, b: 255, a: 50)
    }
    
    class func getTextframe(text: String) -> CGRect {
        let size = CGSize(width: 250, height: 100000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)     //計算文字高的
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
}
