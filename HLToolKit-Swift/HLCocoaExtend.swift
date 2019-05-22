//
//  HLCocoaExtend.swift
//  HLToolKit-Swift
//
//  Created by Liang on 2019/5/22.
//

import UIKit

public extension String {
    /// 使用下标截取字符串 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
            if (r.lowerBound > count) || (r.upperBound > count) { return "截取超出范围" }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    var floatValue:CGFloat {
        get {
            let strDouble = Double(self)
            let strFloat = CGFloat(strDouble ?? 0.0)
            return strFloat
        }
    }
}

public extension UIButton {
    @objc enum HLButtonEdgeInsetsStyle:Int {
        case Top
        case Left
        case Bottom
        case Right
    }
    
    
    @objc final func layoutButton(_ insetsStyle:HLButtonEdgeInsetsStyle,_ imageTitleSpace:CGFloat) -> Void {
        let imageWidth:CGFloat = (self.imageView?.frame.size.width)!
        let imageHeigth:CGFloat = (self.imageView?.frame.size.height)!
        
        var labelWidth:CGFloat!
        var labelHeight:CGFloat!
        labelWidth = 0.0
        labelHeight = 0.0
        
        if UIDevice.current.systemVersion.floatValue >= 8.0 {
            labelWidth = self.titleLabel?.intrinsicContentSize.width
            labelHeight = self.titleLabel?.intrinsicContentSize.height
        } else {
            labelWidth = self.titleLabel?.frame.size.width
            labelHeight = self.titleLabel?.frame.size.height
        }
        
        var imageEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets:UIEdgeInsets = UIEdgeInsets.zero
        
        switch insetsStyle {
        case .Top:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - imageTitleSpace/2.0, 0, 0, -labelWidth)
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageWidth - imageTitleSpace/2.0, 0)
        case .Left:
            imageEdgeInsets = UIEdgeInsetsMake(0, -imageTitleSpace/2.0, 0, imageTitleSpace/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, imageTitleSpace/2.0, 0, -imageTitleSpace/2.0);
        case .Bottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-imageTitleSpace/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeigth-imageTitleSpace/2.0, -imageWidth, 0, 0);
        case .Right:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+imageTitleSpace/2.0, 0, -labelWidth-imageTitleSpace/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth-imageTitleSpace/2.0, 0, imageWidth+imageTitleSpace/2.0);
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}

public extension UIColor {
    
     var toHexString:String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format:"%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    convenience init(_ hex:String) {
        self.init(hex, 1.0)
    }
    
    convenience init(_ hex:String,_ alpha:CGFloat) {
        
        assert(hex.hasPrefix("#"), "hex must has '#' at the beginning")
        assert(hex.count == 7, "hex has 7 chars ,e.g. #efefef ")
        
        var red_:UInt32 = 0
        var green_:UInt32 = 0
        var blue_:UInt32 = 0
        
        
        let redStr = hex[1..<3]
        let greenStr = hex[3..<5]
        let blueStr = hex[5..<7]
        
        Scanner.init(string: redStr).scanHexInt32(&red_)
        Scanner.init(string: greenStr).scanHexInt32(&green_)
        Scanner.init(string: blueStr).scanHexInt32(&blue_)
        
        self.init(red: CGFloat(red_)/255.0, green: CGFloat(green_)/255.0, blue: CGFloat(blue_)/255.0, alpha: alpha)
    }
    
    @objc static func hex(_ hex:String) -> UIColor? {
        return UIColor(hex)
    }
    
    @objc static func hex(_ hex:String,_ alpha:CGFloat) -> UIColor? {
        return UIColor(hex,alpha)
    }
    
}


public extension UIImage {
//    convenience init(_ color:UIColor) {
//        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
//        UIGraphicsBeginImageContext(rect.size)
//        let context = UIGraphicsGetCurrentContext()
//        context!.setFillColor(color.cgColor)
//        context!.fill(rect)
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        let data = UIImageJPEGRepresentation(img!, 1.0)
//        self.init(data: data!)!
//    }
    
    @objc static func color(_ color:UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
}

