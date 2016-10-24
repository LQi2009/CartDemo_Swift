//
//  LZColorTool.swift
//  CartDemo_Swift
//
//  Created by Artron_LQQ on 16/6/27.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

class LZColorTool: NSObject {

    static func colorFromRGB(_ R: CGFloat,G: CGFloat,B: CGFloat) -> (UIColor) {
        
        return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: 1.0)
    }
    
    static  func colorFromHex(_ hexString: UInt32) ->(UIColor) {
        let red     = CGFloat((hexString & 0xFF0000) >> 16) / 255.0
        let green   = CGFloat((hexString & 0x00FF00) >> 8 ) / 255.0
        let blue    = CGFloat((hexString & 0x0000FF)      ) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    static func redColor() -> (UIColor) {
        
       return self.colorFromHex(0xED5565)
    }
}

